{{/*
Expand the name of the chart.
*/}}
{{- define "brigade-cron-event-source.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 58 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 58 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "brigade-cron-event-source.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 58 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 58 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 58 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "brigade-cron-event-source.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 58 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "brigade-cron-gateway.labels" -}}
helm.sh/chart: {{ include "brigade-cron-gateway.chart" . }}
{{ include "brigade-cron-gateway.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "brigade-cron-gateway.selectorLabels" -}}
app.kubernetes.io/name: {{ include "brigade-cron-gateway.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "brigade-cron-gateway.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "brigade-cron-gateway.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}