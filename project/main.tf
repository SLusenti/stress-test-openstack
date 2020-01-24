provider "openstack" {
}

resource "openstack_identity_project_v3" "project_1" {
  name        = "stress-test-prj"
  description = "stress test project"
  domain_id = var.domain_id
}

resource "openstack_identity_role_assignment_v3" "role_assignment_admin" {
  user_id    = var.user_id
  project_id = openstack_identity_project_v3.project_1.id
  role_id    = data.openstack_identity_role_v3.admin.id
}

resource "openstack_identity_role_assignment_v3" "role_assignment_member" {
  user_id    = var.user_id
  project_id = openstack_identity_project_v3.project_1.id
  role_id    = data.openstack_identity_role_v3.member.id
}

resource "openstack_blockstorage_quotaset_v2" "quotaset_1" {
  project_id = openstack_identity_project_v3.project_1.id
  volumes   = 100
  snapshots = 100
  gigabytes = 10000
  per_volume_gigabytes = 100
  backups = 4000
  backup_gigabytes = 1000
  groups = 100
}

resource "openstack_compute_quotaset_v2" "quotaset_1" {
  project_id           = openstack_identity_project_v3.project_1.id
  cores                       = 320
  fixed_ips                   = 200
  floating_ips                = 2000
  instances                   = 200
  key_pairs                   = 10
  ram                         = 409600
  security_group_rules        = 1000
  security_groups             = 100
  server_group_members        = 8
  server_groups               = 4
}

resource "openstack_compute_flavor_v2" "test_flavor" {
  name  = "stress_test_flavor"
  ram   = "4096"
  vcpus = "4"
  disk  = "40"
}

resource "openstack_compute_flavor_access_v2" "access_1" {
  tenant_id = openstack_identity_project_v3.project_1.id
  flavor_id = openstack_compute_flavor_v2.test_flavor.id
}

output "proj_id" {
  value       = openstack_identity_project_v3.project_1.id
}