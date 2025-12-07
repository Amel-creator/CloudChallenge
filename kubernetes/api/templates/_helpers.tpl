{{- define "main-api.fullname" -}}
{{- printf "%s-%s" .Release.Name "main-api" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "main-api.name" -}}
{{- printf "%s-main-api" .Release.Name -}}
{{- end -}}

