provider "openstack" {}

module "network" {
    source = "./network"
    external_network_id = var.external_network_id
}

module "images"{ 
    source = "./images"
}

module "instancies" {
    source = "./instancies"
    nvm = var.nvm
    vol_size = var.vol_size
    image = module.images.id
    network = module.network.network
    vol_type = var.vol_type
    floating_ip_pool = var.floating_ip_pool
}

output "image_id" {
  value       = module.images.id
}

output "private_key" {
  value       = module.instancies.private_key
  description = ""
}

output "vms" {
  value       = module.instancies.vms
}