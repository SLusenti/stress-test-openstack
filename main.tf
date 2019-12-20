provider "openstack" {}

module "instancies" {
    nvm = "${var.nvm}"
}

module "snapshots" {
    depends_on = ["module.instancies"]
}

module "restore" {
    depends_on = ["module.instancies", "module.snapshots"]

}
