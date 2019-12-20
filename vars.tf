variable "nvm" {
    default = 10
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

variable "flavor" {
  type        = string
  description = "flavor name"
}

variable "network" {
  type        = string
  description = "network name"
}

variable "vol_type" {
  type        = string
  description = "volume type"
}