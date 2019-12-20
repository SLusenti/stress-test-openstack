# usage
```bash
source ./openstackrc
terraform init
terraform plan -var 'image=[image_name] flavor=[flavor] network=[network_name] vol_type=[volume_type]'
terraform apply -var 'image=[image_name] flavor=[flavor] network=[network_name] vol_type=[volume_type]'
```

