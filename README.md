# usage
```bash
source ./openstackrc
terraform init
terraform plan -var 'image=[image_name]' -var 'flavor=[flavor]' -var 'network=[network_name]' -var 'vol_type=[volume_type]'
terraform apply -var 'image=[image_name]' -var 'flavor=[flavor]' -var 'network=[network_name]' -var 'vol_type=[volume_type]' 
```

