provider "openstack" {
}

resource "openstack_identity_project_v3" "project_1" {
  name        = "stress-test-prj"
  description = "stress test project"
  domain_id = var.domain_id
}

resource "openstack_identity_user_v3" "user_1" {
  default_project_id = openstack_identity_project_v3.project_1.id
  name               = "stress_test_user"
  description        = "stress_test_prj admin"
  password = var.user_pssswd
  enabled = true
  domain_id = var.domain_id
  ignore_change_password_upon_first_use = true
  multi_factor_auth_enabled = false
}

resource "openstack_identity_role_assignment_v3" "role_assignment_admin_admin" {
  user_id    = var.user_id
  project_id = openstack_identity_project_v3.project_1.id
  role_id    = data.openstack_identity_role_v3.admin.id
}

resource "openstack_identity_role_assignment_v3" "role_assignment_admin_member" {
  user_id    = var.user_id
  project_id = openstack_identity_project_v3.project_1.id
  role_id    = data.openstack_identity_role_v3.member.id
}

resource "openstack_identity_role_assignment_v3" "role_assignment_admin_user_1" {
  user_id    = openstack_identity_user_v3.user_1.id
  project_id = openstack_identity_project_v3.project_1.id
  role_id    = data.openstack_identity_role_v3.admin.id
}

resource "openstack_identity_role_assignment_v3" "role_assignment_member_user_1" {
  user_id    = openstack_identity_user_v3.user_1.id
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

resource "openstack_networking_quota_v2" "quota_1" {
  project_id          = openstack_identity_project_v3.project_1.id
  floatingip          = 90
  network             = 4
  port                = 1000
  rbac_policy         = 10
  router              = 4
  security_group      = 100
  security_group_rule = 1000
  subnet              = 8
  subnetpool          = 2
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