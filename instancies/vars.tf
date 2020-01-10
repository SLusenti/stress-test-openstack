variable "nvm" {
  type        = number
  default     = 10
  description = "number of vms to instance"
}

variable "vol_size" {
  type        = number
  default     = 40
  description = "default volume size"
}

variable "image" {
  type        = string
  description = "image name"
}

variable "network" {
  type        = string
  description = "network name"
}

variable "vol_type" {
  type        = string
  description = "volume type"
}

variable "floating_ip_pool" {
  type        = string
}