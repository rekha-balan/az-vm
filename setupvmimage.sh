#!/bin/bash

resource_group=vm-us-west2
vnet_name=vnet-us-west2
location=westus2
vm_name=vm-02
pip_name=vm-02-pip
nsg_name=vm-02-nsg

echo
echo
echo 'Define the deployment variables used by the subsequent Azure CLI commands'
echo
echo "resource_group=$resource_group"
echo "vnet_name=$vnet_name"
echo "location=$location"
echo "vm_name=$vm_name"
echo "pip_name=$pip_name"
echo "nsg_name=$nsg_name"
read -n1 -r -p 'Press any key...' key

echo
echo
echo 'Show all virtual machine images'
echo
echo 'az vm image list'
read -n1 -r -p 'Press any key...' key

az vm image list

echo
echo
echo 'Show all publishers'
echo
echo 'az vm image list-publishers -l $location --query "[?starts_with(name, Open)]"'
read -n1 -r -p 'Press any key...' key

az vm image list-publishers -l $location --query "[?starts_with(name, 'Open')]"

echo
echo
echo 'Show all offers from OpenLogic'
echo
echo 'az vm image list-offers --location $location -p OpenLogic'
read -n1 -r -p 'Press any key...' key

az vm image list-offers --location $location -p OpenLogic

echo
echo
echo 'Show all skus from OpenLogic based on CentOS'
echo
echo 'az vm image list-skus --location $location -p OpenLogic -f CentOS'
read -n1 -r -p 'Press any key...' key

az vm image list-skus --location $location -p OpenLogic -f CentOS

echo
echo
echo 'Show all virtual machine sizes available in a region'
echo
echo 'az vm list-sizes --location $location'
read -n1 -r -p 'Press any key...' key

az vm list-sizes --location $location

echo
echo
echo 'Create a virtual machine with a specific sku'
echo
echo 'az network nsg create --resource-group $resource_group --name $nsg_name'
echo 
echo 'az network nic create \'
echo '  --resource-group $resource_group \'
echo '  --name $vm_name-nic1 \'
echo '  --vnet-name $vnet_name \'
echo '  --subnet ServerSubnet \'
echo '  --network-security-group $nsg_name \'
echo '  --public-ip-address ""'
echo   
echo 'az vm create \'
echo '  --resource-group $resource_group \'
echo '  --name $vm_name \'
echo '  --nics $vm_name-nic1 \'
echo '  --os-disk-name $vm_name-boot.vhd \'
echo '  --image CentOS \'
echo '  --generate-ssh-keys'
read -n1 -r -p 'Press any key...' key

az group create --name $resource_group --location $location

az network nsg create --resource-group $resource_group --name $nsg_name

az network nic create \
  --resource-group $resource_group \
  --name $vm_name-nic1 \
  --vnet-name $vnet_name \
  --subnet ServerSubnet \
  --network-security-group $nsg_name \
  --public-ip-address ""
  
az vm create \
  --resource-group $resource_group \
  --name $vm_name \
  --nics $vm_name-nic1 \
  --os-disk-name $vm_name-boot.vhd \
  --image CentOS \
  --generate-ssh-keys