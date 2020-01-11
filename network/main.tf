resource "openstack_networking_network_v2" "test_network" {
  name           = "test_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "test_subnet" {
  name       = "test_subnet"
  network_id = openstack_networking_network_v2.test_network.id
  cidr       = "10.10.0.0/20"
  ip_version = 4
  allocation_pool {
    start = "10.10.10.5"
    end = "10.10.15.250"
  }
}

resource "openstack_networking_router_v2" "test_router" {
  name                = "test_router"
  admin_state_up      = true
  external_network_id = var.external_network_id
}

resource "openstack_networking_router_interface_v2" "test_router_interface_1" {
  router_id = openstack_networking_router_v2.test_router.id
  subnet_id = openstack_networking_subnet_v2.test_subnet.id
}

output "network" {
  value       = openstack_networking_network_v2.test_network.name
}

