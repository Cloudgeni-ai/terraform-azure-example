# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = module.resource_group.location
}

# Virtual Network Outputs
output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = module.virtual_network.name
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = module.virtual_network.id
}

output "virtual_network_address_space" {
  description = "Address space of the virtual network"
  value       = module.virtual_network.address_space
}

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = module.virtual_network.subnet_ids
}

# Network Security Group Outputs
output "network_security_group_name" {
  description = "Name of the network security group"
  value       = module.network_security_group.nsg_name
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = module.network_security_group.nsg_id
}

# Key Vault Outputs
output "key_vault_name" {
  description = "Name of the key vault"
  value       = module.key_vault.name
}

output "key_vault_id" {
  description = "ID of the key vault"
  value       = module.key_vault.id
}

output "key_vault_uri" {
  description = "URI of the key vault"
  value       = module.key_vault.vault_uri
}

# Storage Account Outputs
output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage_account.id
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = module.storage_account.primary_blob_endpoint
}

output "storage_account_primary_access_key" {
  description = "Primary access key of the storage account"
  value       = module.storage_account.primary_access_key
  sensitive   = true
} 