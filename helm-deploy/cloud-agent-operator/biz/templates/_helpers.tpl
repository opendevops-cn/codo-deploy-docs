{{- define "label.common" -}}
app.kubernetes.io/name: {{ required "app is required" .Values.app }}
app.kubernetes.io/env: {{ required "env is required" .Values.env }}
{{- end -}}

{{- define "imagepullsecret.uname" -}}
{{- printf "imagepullsecret-%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}


{{- define "imagepullsecret.define" -}}
{{- if ne .Values.imagePullSecret "" -}}
imagePullSecrets:
- name: {{ template "imagepullsecret.uname" . }}
{{- end -}}
{{- end }}
