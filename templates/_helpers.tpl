{{/* vim: set filetype=mustache: */}}

{{/*
Renders the image considering appVersion as default
*/}}
{{- define "surrealdb.image" -}}
{{- $registryName := .Values.image.registry | default "docker.io" -}}
{{- $repositoryName := .Values.image.repository | default "surrealdb/surrealdb" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- end -}}

{{/*
Renders the imagePullPolicy which is set to Always if image tag is latest
*/}}
{{- define "surrealdb.imagePullPolicy" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- if eq $tag "latest" -}}
{{- printf "Always" -}}
{{- else -}}
{{- ternary "IsNotPresent" .Values.image.pullPolicy (eq .Values.image.pullPolicy "") -}}
{{- end -}}
{{- end -}}

{{- define "surrealdb.database" -}}
{{- if .Values.persistence.enabled -}}
{{- printf "%s" "file:/data" -}}
{{- else -}}
{{ default "memory" .Values.database }}
{{- end -}}
{{- end -}}

{{- define "surrealdb.username" -}}
{{ default "root" .Values.username }}
{{- end -}}

{{- define "surrealdb.password" -}}
{{ default "root" .Values.username }}
{{- end -}}

{{- define "surrealdb.loglevel" -}}
{{ default "info" .Values.loglevel }}
{{- end -}}
