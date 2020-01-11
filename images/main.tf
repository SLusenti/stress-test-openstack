resource "openstack_images_image_v2" "ubuntu_1804_minimal" {
  name             = "ubuntu_1804_minimal"
  image_source_url = "http://cloud-images.ubuntu.com/minimal/releases/bionic/release-20180705/ubuntu-18.04-minimal-cloudimg-amd64.img"
  container_format = "bare"
  disk_format      = "raw"
}

output "id" {
  value       = openstack_images_image_v2.ubuntu_1804_minimal.id
}