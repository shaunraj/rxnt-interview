inject tenant id and resource_group_name and storage_account_name via environment variables

terraform init -backend=false

ARM_SUBSCRIPTION_ID=""
ARM_ACCESS_KEY=""
ARM_TENANT_ID=""
TF_VAR_registry_subscription_id=""
need a certificate in key vault

## Modified docker compose to automatically tag image and created profiles