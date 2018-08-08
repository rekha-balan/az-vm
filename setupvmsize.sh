#!/bin/bash

echo
echo
echo 'Define the deployment variables used by the subsequent Azure CLI commands'
echo
echo 'resource_group=app-us-west2'
echo 'location=westus2'
read -n1 -r -p 'Press any key...' key

resource_group=app-us-west2
vnet_name=vnet-us-west2
location=westus2
vm_name=vm-02
pip_name=vm-02-pip
nsg_name=vm-02-nsg


#resize
az vm show --resource-group $resource_group --name $vm_name --query hardwareProfile.vmSize

az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name

az vm resize --resource-group $resource_group --name $vm_name --size Standard_DS4_v2

az vm deallocate --resource-group $resource_group --name $vm_name

az vm get-instance-view --name $vm_name --resource-group $resource_group --query instanceView.statuses[1]