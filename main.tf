provider "openstack" {
    tenant_id = "b289ad57d6a74b7b8d9dfefbcee272bd"
}

module "instancies" {
    source = "./instancies"
    nvm = "${var.nvm}"
    vol_size = "${var.vol_size}" 
    image = "${var.image}" 
    flavor = "${var.flavor}" 
    network = "${var.network}"
    vol_type = "${var.vol_type}"
}

/*
module "snapshots" {
    depends_on = ["module.instancies"]
}

module "restore" {
    depends_on = ["module.instancies", "module.snapshots"]

}
*/
