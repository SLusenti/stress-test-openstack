#!/bin/bash

. openstackrc
cd project
terraform init -var "domain_id=$1" -var "user_id=$2"
terraform apply -var "domain_id=$1" -var "user_id=$2" <<< yes
P_ID=$(terraform output proj_id)
cd ..
echo "p_id: $P_ID"
unset OS_TENANT_ID
export OS_TENANT_ID="${P_ID}"
terraform init
terraform apply <<< yes
# hear the part for vms backup
for vm_id in $(terraform output vms | grep '"id"' | sed 's;.*= "\([a-z0-9\-]*\)".*;\1;g')
do 
  host_src=$( openstack server show $vm_id -c 'OS-EXT-SRV-ATTR:host' -f value )
  host_dst_n=$( openstack compute service list -c "Host" -c "Zone" -f value  | grep nova | cut  -f1 -d " " | grep -v "$host_src" | wc -l)
  host_dst=$( openstack compute service list -c "Host" -c "Zone" -f value  | grep nova | cut  -f1 -d " " | grep -v "$host_src" | sed -n "$((1 + RANDOM % ${host_dst_n}))p"  )
  echo "live-migrating $(openstack server show ${vm_id} -c name -f value) from $host_src to $host_dst"
  [[ "$(openstack server show "${vm_id}" -c 'OS-EXT-STS:vm_state' -f value)" == error ]] && {
    echo "vm state ERROR!"
  } || {
    openstack server migrate --live "$host_dst" "$vm_id"
  }
done