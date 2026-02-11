#!/usr/bin/env bash

ACR_REGISTRY_NAME=acrrxnt
ACR_REGISTRY_URL=ACR_URL=$(az acr show --name acrrxnt --query loginServer --output tsv)

az login
az acr login --name $ACR_REGISTRY_NAME

docker compose build
docker compose push