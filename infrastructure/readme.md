# Purpose

This codebase details the infrastructure necessary to run the marketing department's new site

## How to deploy shared
The following environment variables need to be set:

```
export ARM_ACCESS_KEY=<Access key of storage container where state file should be stored>
export
```

## How to deploy site infrastructure
inject tenant id and resource_group_name and storage_account_name via environment variables

terraform init -backend=false

ARM_SUBSCRIPTION_ID=""
ARM_ACCESS_KEY=""
ARM_TENANT_ID=""
TF_VAR_registry_subscription_id=""
need a certificate in key vault

## Modified docker compose to automatically tag image and created profiles