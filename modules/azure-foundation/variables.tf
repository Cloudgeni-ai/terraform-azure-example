# Common Variables
variable "environment" {
  description = "Environment name (e.g., staging, prod)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Virtual Network Variables
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

# Network Security Group Variables
variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "nsg_custom_security_rules" {
  description = "Map of custom security rules for the NSG"
  type = map(object({
    name                                       = string
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
    description                                = optional(string)
  }))
  default = {}
}

# Key Vault Variables
variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string
}

variable "key_vault_sku" {
  description = "SKU name for the key vault"
  type        = string
  default     = "standard"
}

variable "key_vault_enabled_for_deployment" {
  description = "Whether Azure Virtual Machines are permitted to retrieve certificates"
  type        = bool
  default     = false
}

variable "key_vault_enabled_for_disk_encryption" {
  description = "Whether Azure Disk Encryption is permitted to retrieve secrets"
  type        = bool
  default     = false
}

variable "key_vault_enabled_for_template_deployment" {
  description = "Whether Azure Resource Manager is permitted to retrieve secrets"
  type        = bool
  default     = false
}

variable "key_vault_purge_protection_enabled" {
  description = "Whether purge protection is enabled for the key vault"
  type        = bool
  default     = true
}

variable "key_vault_soft_delete_retention_days" {
  description = "Number of days to retain deleted key vault"
  type        = number
  default     = 90
}

# Storage Account Variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "storage_account_tier" {
  description = "Tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "storage_account_kind" {
  description = "Kind of storage account"
  type        = string
  default     = "StorageV2"
}

variable "storage_enable_https_traffic_only" {
  description = "Whether to enable HTTPS traffic only"
  type        = bool
  default     = true
}

variable "storage_min_tls_version" {
  description = "Minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "storage_blob_soft_delete_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "storage_container_soft_delete_retention_days" {
  description = "Number of days to retain deleted containers"
  type        = number
  default     = 7
} 