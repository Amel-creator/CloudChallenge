{{- define "auxiliary.fullname" -}}
{{- printf "%s-%s" .Release.Name "auxiliary" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "auxiliary.name" -}}
{{- printf "%s-auxiliary" .Release.Name -}}
{{- end -}}

