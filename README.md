# Intro
See a blog post about this solution [here](https://cloud.redhat.com/blog/using-gitops-to-deploy-bare-metal-openshift-hosted-control-plane-clusters).

# Prerequisites
* OpenShift GitOps Operator v1.8+
* MetalLB Operator
* ACM 2.7+ or MCE 2.2+
* Enable the Hosted Control Plane feature: [RHACM Docs - Enable Hypershift Add-On](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.7/html-single/clusters/index#hypershift-addon-intro)
* Enable CIM: [RHACM Docs - Enable CIM](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/2.7/html-single/clusters/index#enable-cim)

I have written an Ansible Playbook that can set up the management cluster as required, see [here](https://github.com/loganmc10/openshift-edge-installer/tree/main/provisioning).

# DNS for the Hosted Cluster
You need to create DNS entries for `api.<hosted-cluster-name>.<domain>` and `*.apps.<hosted-cluster-name>.<domain>`, just like you would for a standalone cluster.
## API
This Helm chart utilizes MetalLB (layer 2) on the **management** cluster in order to serve the API for the hosted cluster. This means that the IP address you choose for the Hosted Cluster API needs to be in the same subnet as the management cluster.
## Ingress
This Helm chart utilizes MetalLB (layer 2) on the **hosted** cluster for the Ingress. This means that the IP address you choose for the Hosted Cluster Ingress needs to be in the same subnet as the hosted cluster workers.
# Configuration
The Values file for the Helm chart is an OpenShift [Install Config](https://docs.openshift.com/container-platform/latest/installing/installing_bare_metal_ipi/ipi-install-installation-workflow.html#additional-resources_config) with an extra `hypershift` section. See [the example](install-config-example.yaml). Hosted Control Plane (HyperShift) clusters do not have any control plane nodes, therefore only worker nodes should be specified in the Install Config.
# Example
Example ArgoCD application:
```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: hypershift-cluster
  namespace: openshift-gitops
spec:
  destination:
    server: https://kubernetes.default.svc
  project: default
  sources:
  - repoURL: 'https://loganmc10.github.io/hypershift-helm'
    chart: deploy-cluster
    targetRevision: 0.1.17
    helm:
      valueFiles:
      - $values/install-config.yaml
  - repoURL: 'https://git.example.com/org/install-configs.git'
    targetRevision: main
    ref: values
```
