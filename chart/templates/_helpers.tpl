{{- define "ocp_client" -}}
{{- $imageName := .Values.hypershift.cliImage | default "registry.redhat.io/openshift4/ose-cli:latest" -}}
{{- printf "%s" $imageName -}}
{{- end -}}
