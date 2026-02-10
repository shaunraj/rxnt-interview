#!/usr/bin/env bash

ACR_REGISTRY_URL=$(az keyvault secret show --vault-name "kv-rxnt" --name "container-registry-url" --query "value" -o tsv)
ACR_REGISTRY_NAME=$(az keyvault secret show --vault-name "kv-rxnt" --name "container-registry-name" --query "value" -o tsv)

az login
az acr login --name $ACR_REGISTRY_NAME
docker compose build
docker compose push