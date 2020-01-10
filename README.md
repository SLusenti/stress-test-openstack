# usage
```bash
source ./openstackrc
terraform init
terraform plan -var 'external_network_id=[external_network_id]' -var 'vol_type=[volume_type]' -var 'vol_size=[vol_size_Gb]' -var 'nvm=[number_of_istancies]'
terraform apply  -var 'external_network_id=[external_network_id]' -var 'vol_type=[volume_type]' -var 'vol_size=[vol_size_Gb]' -var 'nvm=[number_of_istancies]'
```

