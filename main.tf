provider "openstack" {
    tenant_id = "b289ad57d6a74b7b8d9dfefbcee272bd"
}

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
}