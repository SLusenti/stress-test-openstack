data "openstack_images_image_v2" "img" {
  name        = var.image
  most_recent = true
}

