module github.com/kubernetes-csi/external-snapshotter/v6

go 1.17

require (
	github.com/container-storage-interface/spec v1.5.0
	github.com/evanphx/json-patch v4.12.0+incompatible
	github.com/fsnotify/fsnotify v1.4.9
	github.com/golang/mock v1.5.0
	github.com/golang/protobuf v1.5.2
	github.com/google/gofuzz v1.2.0
	github.com/kubernetes-csi/csi-lib-utils v0.10.0
	github.com/kubernetes-csi/csi-test/v4 v4.0.2
	github.com/kubernetes-csi/external-snapshotter/client/v6 v6.0.0
	github.com/prometheus/client_golang v1.11.1
	github.com/prometheus/client_model v0.2.0
	github.com/prometheus/common v0.28.0
	github.com/spf13/cobra v1.2.1
	google.golang.org/grpc v1.40.0
	k8s.io/api v0.23.0
	k8s.io/apimachinery v0.23.0
	k8s.io/client-go v0.23.0
	k8s.io/component-base v0.23.0
	k8s.io/component-helpers v0.23.0
	k8s.io/klog/v2 v2.30.0
	k8s.io/kubernetes v1.23.0
)

require (
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/blang/semver v3.5.1+incompatible // indirect
	github.com/cespare/xxhash/v2 v2.1.1 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/go-logr/logr v1.2.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/google/go-cmp v0.5.6 // indirect
	github.com/googleapis/gnostic v0.5.5 // indirect
	github.com/imdario/mergo v0.3.11 // indirect
	github.com/inconshreveable/mousetrap v1.0.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.2-0.20181231171920-c182affec369 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/nxadm/tail v1.4.8 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/prometheus/procfs v0.6.0 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	golang.org/x/net v0.0.0-20210825183410-e898025ed96a // indirect
	golang.org/x/oauth2 v0.0.0-20210819190943-2bc19b11175f // indirect
	golang.org/x/sys v0.0.0-20210831042530-f4d43177bf5e // indirect
	golang.org/x/term v0.0.0-20210615171337-6886f2dfbf5b // indirect
	golang.org/x/text v0.3.7 // indirect
	golang.org/x/time v0.0.0-20210723032227-1f47c861a9ac // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/genproto v0.0.0-20210831024726-fe130286e0e2 // indirect
	google.golang.org/protobuf v1.27.1 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b // indirect
	k8s.io/klog v1.0.0 // indirect
	k8s.io/kube-openapi v0.0.0-20211115234752-e816edb12b65 // indirect
	k8s.io/utils v0.0.0-20210930125809-cb0fa318a74b // indirect
	sigs.k8s.io/json v0.0.0-20211020170558-c049b76a60c6 // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.1.2 // indirect
	sigs.k8s.io/yaml v1.3.0 // indirect
)

replace (
	github.com/kubernetes-csi/external-snapshotter/client/v6 => ./client
	k8s.io/api => k8s.io/api v0.23.0
	k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.23.0
	k8s.io/apimachinery => k8s.io/apimachinery v0.23.0
	k8s.io/apiserver => k8s.io/apiserver v0.23.0
	k8s.io/cli-runtime => k8s.io/cli-runtime v0.23.0
	k8s.io/client-go => k8s.io/client-go v0.23.0
	k8s.io/cloud-provider => k8s.io/cloud-provider v0.23.0
	k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.23.0
	k8s.io/code-generator => k8s.io/code-generator v0.23.0
	k8s.io/component-base => k8s.io/component-base v0.23.0
	k8s.io/component-helpers => k8s.io/component-helpers v0.23.0
	k8s.io/controller-manager => k8s.io/controller-manager v0.23.0
	k8s.io/cri-api => k8s.io/cri-api v0.23.0
	k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.23.0
	k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.23.0
	k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.23.0
	k8s.io/kube-proxy => k8s.io/kube-proxy v0.23.0
	k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.23.0
	k8s.io/kubectl => k8s.io/kubectl v0.23.0
	k8s.io/kubelet => k8s.io/kubelet v0.23.0
	k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.23.0
	k8s.io/metrics => k8s.io/metrics v0.23.0
	k8s.io/mount-utils => k8s.io/mount-utils v0.23.0
	k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.23.0
)

replace k8s.io/pod-security-admission => k8s.io/pod-security-admission v0.23.0

replace k8s.io/sample-cli-plugin => k8s.io/sample-cli-plugin v0.23.0

replace k8s.io/sample-controller => k8s.io/sample-controller v0.23.0
