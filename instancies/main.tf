resource "openstack_blockstorage_volume_v3" "vol" {
  count = var.nvm
  name        = "stress-test-vol${count.index}"
  description = "stress test volume"
  size        = var.vol_size
  volume_type = var.vol_type
  image_id = var.image
}

resource "openstack_compute_secgroup_v2" "test_scurity" {
  name        = "test_scurity"
  description = "my test security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_keypair_v2" "test_keypair" {
  name = "test_keypair"
}

resource "openstack_compute_instance_v2" "vms" {
  count = var.nvm
  name            = "stress-test${count.index}"
  flavor_name       = "stress_test_flavor"
  security_groups = [ openstack_compute_secgroup_v2.test_scurity.name ]
  key_pair = openstack_compute_keypair_v2.test_keypair.name

  network {
    name = var.network
  }
  
  block_device {
    uuid                  = openstack_blockstorage_volume_v3.vol[count.index].id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = false
  }
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  count = var.nvm
  pool = var.floating_ip_pool
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  count = var.nvm
  floating_ip = openstack_compute_floatingip_v2.floatip_1[count.index].address
  instance_id = openstack_compute_instance_v2.vms[count.index].id
}

output "private_key" {
  value       = openstack_compute_keypair_v2.test_keypair.private_key
}

output "vms" {
  value       = openstack_compute_instance_v2.vms
}