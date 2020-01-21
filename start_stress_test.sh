#!/bin/bash
cd /home/selu/MEGA/cisco_workspace/repos/terraform/openstack-stress-test
. .terraform/openrc
cd project
terraform init
terraform apply
P_ID=$(terraform output proj_id)
cd ..
echo "p_id: $P_ID"
unset OS_TENANT_ID
export OS_TENANT_ID="${P_ID}"
terraform init
terraform apply
# hear the part for vms backup
for vm_id in $(terraform output vms | grep '"id"' | sed 's;.*= "\([a-z0-9\-]*\)".*;\1;g')
do 
  host_src=$( openstack server show $vm_id -c 'OS-EXT-SRV-ATTR:host' -f value )
  host_dst=$( openstack compute service list -c "Host" -c "Zone" -f value  | grep nova | cut  -f1 -d " " | grep -v "$host_src" | head -1 )
  echo "live-migrating $vm_id from $host_src to $host_dst"
  openstack server migrate --live "$host_dst" "$vm_id"
done