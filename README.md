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
