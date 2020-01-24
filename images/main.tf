resource "openstack_images_image_v2" "img" {
  name             = "stress_test_cloudimg"
  image_source_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2"
  container_format = "bare"
  disk_format      = "qcow2"
}

output "id" {
  value       = openstack_images_image_v2.img.id
}