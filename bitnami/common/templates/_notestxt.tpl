{{/* vim: set filetype=mustache: */}}
{{/*
Print instructions to get a secret value.
Usage:
{{ include "common.notetxt.secret.getvalue" (dict "secret" "secret-name" "field" "secret-value-field" "context" $) }}
*/}}
{{- define "common.notetxt.secret.getvalue" -}}
{{- $varname := include "common.notetxt.fieldToEnvVar" . -}}
export {{ $varname }}=$(kubectl get secret --namespace {{ .context.Release.Namespace }} {{ .secret }} -o jsonpath="{.data.{{ .field }}}" | base64 --decode)
{{- end -}}

{{/*
Build env var name given a field
Usage:
{{ include "common.notetxt.fieldToEnvVar" dict "field" "my-password" }}
*/}}
{{- define "common.notetxt.fieldToEnvVar" -}}
  {{- $fieldNameSplit := splitList "-" .field -}}
  {{- $upperCaseFieldNameSplit := list -}}

  {{- range $fieldNameSplit -}}
    {{- $upperCaseFieldNameSplit = append $upperCaseFieldNameSplit ( upper . ) -}}
  {{- end -}}

  {{ join "_" $upperCaseFieldNameSplit }}
{{- end -}}
