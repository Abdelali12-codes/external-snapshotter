/*
Copyright 2018 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package common_controller

import (
	"testing"

	crdv1 "github.com/kubernetes-csi/external-snapshotter/client/v6/apis/volumesnapshot/v1"
	"github.com/kubernetes-csi/external-snapshotter/v6/pkg/utils"
	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/labels"
	"k8s.io/client-go/tools/cache"
)

var deletionPolicy = crdv1.VolumeSnapshotContentDelete

type FakeNodeLister struct {
	NodeList []*v1.Node
}

// List lists all Nodes in the indexer.
// Objects returned here must be treated as read-only.
func (l FakeNodeLister) List(selector labels.Selector) (ret []*v1.Node, err error) {
	return l.NodeList, nil
}

func (l FakeNodeLister) Get(name string) (*v1.Node, error) {
	return nil, nil
}

func storeVersion(t *testing.T, prefix string, c cache.Store, version string, expectedReturn bool) {
	content := newContent("contentName", "snapuid1-1", "snap1-1", "sid1-1", classGold, "", "pv-handle-1-1", deletionPolicy, nil, nil, false, true)
	content.ResourceVersion = version
	ret, err := utils.StoreObjectUpdate(c, content, "content")
	if err != nil {
		t.Errorf("%s: expected storeObjectUpdate to succeed, got: %v", prefix, err)
	}
	if expectedReturn != ret {
		t.Errorf("%s: expected storeObjectUpdate to return %v, got: %v", prefix, expectedReturn, ret)
	}

	// find the stored version

	contentObj, found, err := c.GetByKey("contentName")
	if err != nil {
		t.Errorf("expected content 'contentName' in the cache, got error instead: %v", err)
	}
	if !found {
		t.Errorf("expected content 'contentName' in the cache but it was not found")
	}
	content, ok := contentObj.(*crdv1.VolumeSnapshotContent)
	if !ok {
		t.Errorf("expected content in the cache, got different object instead: %#v", contentObj)
	}

	if ret {
		if content.ResourceVersion != version {
			t.Errorf("expected content with version %s in the cache, got %s instead", version, content.ResourceVersion)
		}
	} else {
		if content.ResourceVersion == version {
			t.Errorf("expected content with version other than %s in the cache, got %s instead", version, content.ResourceVersion)
		}
	}
}

// TestControllerCache tests func storeObjectUpdate()
func TestControllerCache(t *testing.T) {
	// Cache under test
	c := cache.NewStore(cache.DeletionHandlingMetaNamespaceKeyFunc)

	// Store new PV
	storeVersion(t, "Step1", c, "1", true)
	// Store the same PV
	storeVersion(t, "Step2", c, "1", true)
	// Store newer PV
	storeVersion(t, "Step3", c, "2", true)
	// Store older PV - simulating old "PV updated" event or periodic sync with
	// old data
	storeVersion(t, "Step4", c, "1", false)
	// Store newer PV - test integer parsing ("2" > "10" as string,
	// while 2 < 10 as integers)
	storeVersion(t, "Step5", c, "10", true)
}

func TestControllerCacheParsingError(t *testing.T) {
	c := cache.NewStore(cache.DeletionHandlingMetaNamespaceKeyFunc)
	// There must be something in the cache to compare with
	storeVersion(t, "Step1", c, "1", true)
	content := newContent("contentName", "snapuid1-1", "snap1-1", "sid1-1", classGold, "", "pv-handle-1-1", deletionPolicy, nil, nil, false, true)
	content.ResourceVersion = "xxx"
	_, err := utils.StoreObjectUpdate(c, content, "content")
	if err == nil {
		t.Errorf("Expected parsing error, got nil instead")
	}
}

func TestGetManagedByNode(t *testing.T) {

	// Test that a matching node is found

	node1 := &v1.Node{
		ObjectMeta: metav1.ObjectMeta{
			Name:   "node1",
			Labels: map[string]string{"key1": "value1"},
		},
	}

	node2 := &v1.Node{
		ObjectMeta: metav1.ObjectMeta{
			Name:   "node2",
			Labels: map[string]string{"key2": "value2"},
		},
	}

	ctrl := &csiSnapshotCommonController{
		nodeLister: FakeNodeLister{NodeList: []*v1.Node{node1, node2}},
	}

	pv := &v1.PersistentVolume{
		Spec: v1.PersistentVolumeSpec{
			NodeAffinity: &v1.VolumeNodeAffinity{
				Required: &v1.NodeSelector{
					NodeSelectorTerms: []v1.NodeSelectorTerm{
						{
							MatchExpressions: []v1.NodeSelectorRequirement{
								{
									Key:      "key1",
									Operator: v1.NodeSelectorOpIn,
									Values:   []string{"value1"},
								},
							},
						},
					},
				},
			},
		},
	}

	nodeName, err := ctrl.getManagedByNode(pv)
	if err != nil {
		t.Errorf("Unexpected error occurred: %v", err)
	}
	if nodeName != "node1" {
		t.Errorf("Expected node:%s , Found node: %s instead", "node1", nodeName)
	}

	// Test that no matching node is found

	node1 = &v1.Node{
		ObjectMeta: metav1.ObjectMeta{
			Name: "node1",
		},
	}

	ctrl = &csiSnapshotCommonController{
		nodeLister: FakeNodeLister{NodeList: []*v1.Node{node1}},
	}

	nodeName, _ = ctrl.getManagedByNode(pv)
	if nodeName != "" {
		t.Errorf("Expected no node, Found node(%s)", nodeName)
	}
}
