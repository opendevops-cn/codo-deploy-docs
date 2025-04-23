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


{{- define "frontend.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.frontendServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "frontend.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "frontendServiceName is required" .Values.frontendServiceName }}
app.kubernetes.io/instance: {{ required "frontendServiceName is required" .Values.frontendServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "frontend.labels" -}}
{{ include "frontend.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "gateway.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.gatewayServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "gateway.innerApi" -}}
{{- printf "%s-gateway" .Release.Name  | trunc 63 | trimSuffix "-" -}}:{{ required "gatewayListenPort is required" .Values.gatewayListenPort }}
{{- end }}

{{- define "gateway.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "gatewayServiceName is required" .Values.gatewayServiceName }}
app.kubernetes.io/instance: {{ required "gatewayServiceName is required" .Values.gatewayServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "gateway.labels" -}}
{{ include "gateway.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "gatewayExternal.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.gatewayExternalServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "gatewayExternal.innerApi" -}}
{{- printf "%s-gatewayExternal" .Release.Name  | trunc 63 | trimSuffix "-" -}}:{{ required "gatewayExternalListenPort is required" .Values.gatewayExternalListenPort }}
{{- end }}

{{- define "gatewayExternal.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "gatewayExternalServiceName is required" .Values.gatewayExternalServiceName }}
app.kubernetes.io/instance: {{ required "gatewayExternalServiceName is required" .Values.gatewayExternalServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "gatewayExternal.labels" -}}
{{ include "gatewayExternal.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "adminv4.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.adminv4ServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "adminv4.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "adminv4ServiceName is required" .Values.adminv4ServiceName }}
app.kubernetes.io/instance: {{ required "adminv4ServiceName is required" .Values.adminv4ServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "adminv4.labels" -}}
{{ include "adminv4.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "cmdb.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.cmdbServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "cmdb.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "cmdbServiceName is required" .Values.cmdbServiceName }}
app.kubernetes.io/instance: {{ required "cmdbServiceName is required" .Values.cmdbServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "cmdb.labels" -}}
{{ include "cmdb.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "k2.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.k2ServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "k2.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "k2ServiceName is required" .Values.k2ServiceName }}
app.kubernetes.io/instance: {{ required "k2ServiceName is required" .Values.k2ServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "k2.labels" -}}
{{ include "k2.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}




{{- define "flowAgentLog.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowAgentLogServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowAgentLog.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowAgentLogServiceName is required" .Values.flowAgentLogServiceName }}
app.kubernetes.io/instance: {{ required "flowAgentLogServiceName is required" .Values.flowAgentLogServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowAgentLog.labels" -}}
{{ include "flowAgentLog.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "flowCronjob.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowCronjobServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowCronjob.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowCronjobServiceName is required" .Values.flowCronjobServiceName }}
app.kubernetes.io/instance: {{ required "flowCronjobServiceName is required" .Values.flowCronjobServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowCronjob.labels" -}}
{{ include "flowCronjob.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "taskScheduler.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowTaskSchedulerServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "taskScheduler.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "taskSchedulerServiceName is required" .Values.flowTaskSchedulerServiceName }}
app.kubernetes.io/instance: {{ required "taskSchedulerServiceName is required" .Values.flowTaskSchedulerServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "taskScheduler.labels" -}}
{{ include "taskScheduler.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "flowControl.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowControlServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowControl.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowControlServiceName is required" .Values.flowControlServiceName }}
app.kubernetes.io/instance: {{ required "flowControlServiceName is required" .Values.flowControlServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowControl.labels" -}}
{{ include "flowControl.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{- define "flowExecTask.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowExecTaskServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowExecTask.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowExecTaskServiceName is required" .Values.flowExecTaskServiceName }}
app.kubernetes.io/instance: {{ required "flowExecTaskServiceName is required" .Values.flowExecTaskServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowExecTask.labels" -}}
{{ include "flowExecTask.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "flowLoop.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowLoopServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowLoop.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowLoopServiceName is required" .Values.flowLoopServiceName }}
app.kubernetes.io/instance: {{ required "flowLoopServiceName is required" .Values.flowLoopServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowLoop.labels" -}}
{{ include "flowLoop.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "flowTaskLog.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowTaskLogServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowTaskLog.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowTaskLogServiceName is required" .Values.flowTaskLogServiceName }}
app.kubernetes.io/instance: {{ required "flowTaskLogServiceName is required" .Values.flowTaskLogServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "flowTaskLog.labels" -}}
{{ include "flowTaskLog.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "flowQueue.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.flowQueueServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "flowQueue.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "flowQueueServiceName is required" .Values.flowQueueServiceName }}
app.kubernetes.io/instance: {{ required "flowQueueServiceName is required" .Values.flowQueueServiceName }}-{{ .Release.Name }}

{{- end }}

{{- define "flowQueue.labels" -}}
{{ include "flowQueue.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "agentServer.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.agentServerServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "agentServer.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "agentServerServiceName is required" .Values.agentServerServiceName }}
app.kubernetes.io/instance: {{ required "agentServerServiceName is required" .Values.agentServerServiceName }}-{{ .Release.Name }}
prometheus.io/scrape: 'true'
prometheus.io/port: '8083'
{{- end }}

{{- define "agentServer.labels" -}}
{{ include "agentServer.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}



{{- define "cnmp.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.cnmpServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "cnmp.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "cnmpServiceName is required" .Values.cnmpServiceName }}
app.kubernetes.io/instance: {{ required "cnmpServiceName is required" .Values.cnmpServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "cnmp.labels" -}}
{{ include "cnmp.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "notice.uname" -}}
{{- printf "%s-%s" .Release.Name .Values.noticeServiceName | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "notice.selectorLabels" -}}
{{ include "label.common" . }}
app.kubernetes.io/service: {{ required "noticeServiceName is required" .Values.noticeServiceName }}
app.kubernetes.io/instance: {{ required "noticeServiceName is required" .Values.noticeServiceName }}-{{ .Release.Name }}
{{- end }}

{{- define "notice.labels" -}}
{{ include "notice.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

