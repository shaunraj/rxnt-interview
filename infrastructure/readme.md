# Purpose

This codebase details the infrastructure necessary to run the marketing department's new site. Two sets of infrastructure was needed to stand up this project:

* `infrastructure/shared` - the collection of infrastructure needed across the entire organization to support the instantiation of the site's infrastructure
* `infrastructure/site-mkt` - the collection of infrastructure needed to actually spin up the site for execution

Furthermore, a development container `Dockerfile.infrastructure` was created to allow for anyone to develop infrastructure without the need for specific machine setup. The environment is a ubuntu 24.04 image and comes with:

* docker
* docker-compose
* Terraform
* Azure CLI

## Shared Infrastructure
Here, an organization wide container registry is stood up. Within this container registry the images for both test and production releases are stored via a tagging system on the containers themselves. The reason why one doesn't exist per environment is that container registries have a pretty hefty cost when stood up idle. Container registries already support the concept of repositories. For this simple situation, a single container registry makes sense
`docker-compose.yaml` was modified to add an "image" declaration that specified a push to the internals:latest tag. This push is facilitated by the script `push_images_test.sh`. Once images are pushed, tested, and validated, the script `push_images_production.sh` is executed to copy the latest image over to the releases repository. The docker-compose.yaml file was also modified to add profiles so that the database and redis images would not be pulled on a simple `docker compose build`. If these are needed, then a `docker compose --profile development build` will pull them.

## Marketing Site
The marketing site contains several pieces of infrastructure:

* 2 Azure Container Apps containing both the api and the frontend
* 1 Azure Container App Environment to host the api and frontend containers
* 1 Application Gateway acting as the reverse proxy for both the container apps
* 1 Log Analytics Workspace to act as log storage
* 1 Azure Key Vault to store certificates and other application secrets
* 1 certificate for application gateway registration (Self-signed for now).
* 1 Redis cache
* 1 Azure Sql Server with an elastic pool

The container apps are currently set to scale with the amount of http requests received. Once the number of concurrent requests exceeds 50 (arbitrarily chosen), a new replica will spin up (to a max of 10). These container apps reference the container registry located within the shared space and automatically update once the `latest` image is rebuilt. These apps create a system assigned managed identity and can access resources via their identity to their key vaults and the container registry.

The elastic pool enables the sql server to exert more resource in case of resource spikes. 4 DTU's (an admittedly low number) has been allocated to the pool. All dbs in the pool are allowed 0.25 DTU's as a baseline and can each individually spike to the max of 4

Both of these processes should allow for more scalable infrastructure regardless of the time of spike.

## How to deploy shared
The following environment variables need to be set:

```
export ARM_ACCESS_KEY=<Access key of storage container where state file should be stored>
export ARM_TENANT_ID=<Tenant where terraform should spin up resources>
export ARM_SUBSCRIPTION_ID=<Subscription where terraform should spin up resources>
```

The state file is stored in a blob storage container. This is so multiple people can work on the state file and it isn't lost in case of accidental deletion. The chosen storage container should have soft delete enabled so recovery of the state file is possible in case of accident. The terraform backend will have to be configured so that the container of the engineer's choosing can store the state

* `terraform init -backend-config=``"resource_group_name=<resource group name>" -backend-config=``"storage_account_name=<storage account name>" -backend-config=``"container_name=<container name>" -backend-config=``"key=<blob key name>"`

A plan should then be run

* `terraform plan -out=tfplan`

Then a deployment should be performed:

* `terraform apply`

### Entra Groups

Three groups in Entra will need to be created for access to the container repository:

* Container Registry Contributors
* Container Registry Writers
* Container Registry Readers

These will need to be populated with the correct service principals as per organziation requirements. It is necessary so that the market infrastructure can appropriately assign permissions to the correct groups and can successfully pull down images and access key vault values

## Tests

Tests can be run by navigating to `./infrastructure/shared` and executing the following:

* `terraform init -backend=false`
* `terraform test`

There are some additional tests in `./modules/container_registries` that can be executed the same way

## How to deploy site infrastructure
The following environment variables need to be set:

```
export ARM_ACCESS_KEY=<Access key of storage container where state file should be stored>
export ARM_TENANT_ID=<Tenant where terraform should spin up resources>
export ARM_SUBSCRIPTION_ID=<Subscription where terraform should spin up resources>
export TF_VAR_environment=<name of environment that we are spinning up: dev, prod, etc.>
export TF_VAR_registry_repository=<name of repository in container registry we want to look at for the environment: internals, releases, etc.>
```

The state file is stored in a blob storage container. This is so multiple people can work on the state file and it isn't lost in case of accidental deletion. The chosen storage container should have soft delete enabled so recovery of the state file is possible in case of accident. The terraform backend will have to be configured so that the container of the engineer's choosing can store the state

* `terraform init -backend-config=``"resource_group_name=<resource group name>" -backend-config=``"storage_account_name=<storage account name>" -backend-config=``"container_name=<container name>" -backend-config=``"key=<blob key name>"`

A plan should then be run

* `terraform plan -out=tfplan`

Then a deployment should be performed:

* `terraform apply`
