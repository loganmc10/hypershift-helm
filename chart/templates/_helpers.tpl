{{- define "ocp_client" -}}
{{- $imageName := "quay.io/openshift-release-dev/ocp-v4.0-art-dev@sha256:1fc458ece66c8d4184b45b5c495a372a96b47432ae5a39844cd5837e3981685b # 4.12.0-x86_64-cli" -}}
{{- printf "%s" $imageName -}}
{{- end -}}
