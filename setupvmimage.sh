#!/bin/bash

echo
echo
echo 'Define the deployment variables used by the subsequent Azure CLI commands'
echo
echo 'resource_group=vm-us-west2'
echo 'location=westus2'
read -n1 -r -p 'Press any key...' key

resource_group=vm-us-west2
location=westus2
vm_name=vm-01

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
echo 'az group create --name $resource_group --location $location'
echo
echo 'az vm create --resource-group $resource_group --name $vm_name --image OpenLogic:CentOS:7.5:latest --generate-ssh-keys'
read -n1 -r -p 'Press any key...' key

az group create --name $resource_group --location $location

az vm create --resource-group $resource_group --name $vm_name --image OpenLogic:CentOS:7.5:latest --generate-ssh-keys