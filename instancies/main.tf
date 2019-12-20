resource "openstack_blockstorage_volume_v1" "vol" {
  count = var.nvm
  name        = "stress-test-vol${count.index}"
  description = "stress test volume"
  size        = var.vol_size
  volume_type = var.vol_type
  image_id = data.openstack_images_image_v2.img.id
}

resource "openstack_compute_instance_v2" "vms" {
  count = var.nvm
  name            = "stress-test${count.index}"
  image_name       = var.image
  flavor_name       = var.flavor

  network {
    name = var.network
  }
  
  block_device {
    uuid                  = openstack_blockstorage_volume_v1.vol[count.index].id
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}