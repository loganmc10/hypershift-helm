# Prerequisites
* OpenShift GitOps Operator v1.8+
* MetalLB Operator
* ACM 2.7+ or MCE 2.2+
* Enable the Hosted Control Plane feature: [RHACM Docs - Enable Hypershift Add-On](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.7/html-single/clusters/index#hypershift-addon-intro)
* Enable CIM: [RHACM Docs - Enable CIM](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.7/html-single/clusters/index#enable-cim)

I have written an Ansible Playbook that can set up the management cluster as required, see [here](https://github.com/loganmc10/openshift-edge-installer/tree/main/provisioning)
# Example
Example ArgoCD application:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: hypershift-cluster
  namespace: openshift-gitops
spec:
  sources:
  - repoURL: 'oci://quay.io/loganmc10'
    chart: hypershift-helm
    targetRevision: 0.1.4
    helm:
      valueFiles:
      - $values/install-config.yaml
  - repoURL: 'https://git.example.gom/org/install-configs.git'
    targetRevision: main
    ref: values
```
