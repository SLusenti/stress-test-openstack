resource "openstack_blockstorage_volume_v2" "vol" {
  count = var.nvm
  name        = "stress-test-vol${count.index}"
  description = "stress test volume"
  size        = var.vol_size
  volume_type = var.vol_type
  image_id = data.openstack_images_image_v2.img.id
}

resource "openstack_compute_flavor_v2" "test_flavor" {
  name  = "test_flavor"
  ram   = "1024"
  vcpus = "2"
  disk  = "20"
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = var.floating_ip_pool
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
  image_id       = var.image
  flavor_name       = openstack_compute_flavor_v2.test_flavor.name
  security_groups = openstack_compute_secgroup_v2.test_scurity.id
  key_pair = openstack_compute_keypair_v2.test_keypair.name

  network {
    name = var.network
  }
  
  block_device {
    uuid                  = openstack_blockstorage_volume_v2.vol[count.index].id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

output "private_key" {
  value       = openstack_compute_keypair_v2.test_keypair.private_key
}