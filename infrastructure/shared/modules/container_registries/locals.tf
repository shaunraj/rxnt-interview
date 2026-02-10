locals {
  role_assignments = [
    {
        ad_group_name = "Container Registry Contributors"
        role_definition_name = "Container Registry Repository Contributor"
    },
    {
        ad_group_name = "Container Registry Writers"
        role_definition_name = "Container Registry Repository Writer"
    },
    {
        ad_group_name = "Container Registry Readers"
        role_definition_name = "Container Registry Repository Reader"
    }
  ]
}