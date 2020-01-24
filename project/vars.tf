variable "domain_id" {
  type        = string
}

variable "user_id" {
  type        = string
}

data "openstack_identity_role_v3" "admin" {
  name = "admin"
}

data "openstack_identity_role_v3" "member" {
  name = "member"
}
