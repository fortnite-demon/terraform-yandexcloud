variable "folder_id" {
  description = "(Optional) - Yandex Cloud folder id, if not provided, then will be get from: client_config"
  type        = string
  default     = null
}

variable "zone" {
  description = "(Optional) - Yandex Cloud default availability zone, if not provided, then will be get from: client_config"
  type        = string
  default     = null
}

variable "create_network" {
  description = <<EOF
  (Optional) - Whether create network. Default: true, 
  if set false, then exists_network_id is REQUIRED!
  EOF
  type        = bool
  default     = true
}

variable "network_name" {
  description = "(Optional) - Network name. Default: default-network"
  type        = string
  default     = "default-network"
}

variable "exists_network_id" {
  description = "(Optional) - Exists network id. If create_network is false, then REQUIRED!"
  type        = string
  default     = null
}

variable "public_subnets" {
  description = "(Optional) - List of the public subnets. Default: null"
  type = list(object({
    v4_cidr_blocks = list(string)
    zone           = optional(string)
    name           = optional(string)
    folder_id      = optional(string)
  }))
  default = null
}

variable "create_nat_gw" {
  description = "(Optional) - Wether create nat gateway for private subnets. Default: false"
  type        = bool
  default     = false
}

variable "nat_gw" {
  description = "(Optional) - Specific settings of the nat gateway."
  type = object({
    name      = optional(string, "default-nat-gateway")
    folder_id = optional(string)
  })
  default = {}
}

variable "private_subnets" {
  description = "(Optional) - List of the private subnets. Default: null"
  type = list(object({
    v4_cidr_blocks = list(string)
    zone           = optional(string)
    name           = optional(string)
    folder_id      = optional(string)
  }))
  default = null
}

variable "private_route_table_name" {
  description = "(Optional) - Name of the private route table."
  type        = string
  default     = "default-private-route-table"
}

variable "private_subnets_route_table" {
  description = "(Optional) - Route table of the private subnets. Default: null"
  type = list(object({
    destination_prefix = string
    next_hop_address   = string
  }))
  default = null
}

variable "public_route_table_name" {
  description = "(Optional) - Name of the public route table."
  type        = string
  default     = "default-public-route-table"
}

variable "public_subnets_route_table" {
  description = "(Optional) - Route table of the public subnets. Default: null"
  type = list(object({
    destination_prefix = string
    next_hop_address   = string
  }))
  default = null
}
