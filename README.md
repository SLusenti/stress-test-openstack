# usage
```bash
source ./openstackrc
cd project
terraform init
terraform apply
P_ID=$(terraform output proj_id)
cd ..
echo "p_id: $P_ID"
export OS_TENANT_ID="${P_ID}"
terraform init
terraform apply
```
