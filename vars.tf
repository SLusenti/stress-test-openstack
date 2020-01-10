variable "nvm" {
    default = 10
}

variable "vol_size" {
  type        = number
  default     = 40
  description = "default volume size"
}

variable "vol_type" {
  type        = string
  description = "volume type"
}

variable "external_network_id" {
  type        = string
}