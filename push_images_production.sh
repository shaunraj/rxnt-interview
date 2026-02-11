#!/usr/bin/env bash

ACR_REGISTRY_NAME=acrrxnt
ACR_REGISTRY_URL=ACR_URL=$(az acr show --name acrrxnt --query loginServer --output tsv)

az login
az acr login --name $ACR_REGISTRY_NAME
az acr import --name $ACR_REGISTRY_NAME --source $ACR_REGISTRY_NAME/internal/marketing-site:latest --image releases/marketing-site:latest
az acr import --name $ACR_REGISTRY_NAME --source $ACR_REGISTRY_NAME/internal/marketing-api:latest --image releases/marketing-api:latest