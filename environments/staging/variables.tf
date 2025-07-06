# Common Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "eastus"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "myproject"
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

# Virtual Network Variables
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name           = string
    address_prefix = string
  }))
  default = [
    {
      name           = "web"
      address_prefix = "10.0.1.0/24"
    },
    {
      name           = "app"
      address_prefix = "10.0.2.0/24"
    },
    {
      name           = "data"
      address_prefix = "10.0.3.0/24"
    }
  ]
}

# Network Security Group Variables
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
  default = {
    "HTTP" = {
      name                       = "HTTP"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTP traffic"
    },
    "HTTPS" = {
      name                       = "HTTPS"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTPS traffic"
    },
    "SSH" = {
      name                       = "SSH"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow SSH traffic"
    }
  }
}

# Key Vault Variables
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
  default     = false  # Disabled for staging to allow easier cleanup
}

variable "key_vault_soft_delete_retention_days" {
  description = "Number of days to retain deleted key vault"
  type        = number
  default     = 7  # Shorter retention for staging
}

# Storage Account Variables
variable "storage_account_tier" {
  description = "Tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"  # Local redundancy for cost optimization in staging
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