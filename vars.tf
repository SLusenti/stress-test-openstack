variable "nvm" {
    default = 80
}

variable "vol_size" {
  type        = number
  default     = 40
  description = "default volume size"
}

variable "vol_type" {
  type        = string
  default = "Standard"
}

variable "external_network_id" {
  type        = string
  default = "08762b26-c70c-4705-9155-ef424bbfa4f4"
}

variable "floating_ip_pool" {
  type        = string
  default = "ext-net"
}