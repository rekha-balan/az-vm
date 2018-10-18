#!/bin/bash

resource_group=vm-us-west2
vnet_name=vnet-us-west2
location=westus2
vm_name=vm-02

echo
echo
echo 'Define the deployment variables used by the subsequent Azure CLI commands'
echo
echo "resource_group=$resource_group"
echo "vnet_name=$vnet_name"
echo "location=$location"
echo "vm_name=$vm_name"
read -n1 -r -p 'Press Enter...' key

echo
echo
echo 'Show the current virtual machine size'
echo
echo 'az vm show --resource-group $resource_group --name $vm_name --query hardwareProfile.vmSize'
read -n1 -r -p 'Press Enter...' key

az vm show --resource-group $resource_group --name $vm_name --query hardwareProfile.vmSize

echo
echo
echo 'Show the available sizes for the running virtual machine'
echo
echo 'az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name'
read -n1 -r -p 'Press Enter...' key

az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name

echo
echo
echo 'Resize the running virtual machine'
echo
echo 'az vm resize --resource-group $resource_group --name $vm_name --size Standard_DS2_v2'
read -n1 -r -p 'Press Enter...' key

az vm resize --resource-group $resource_group --name $vm_name --size Standard_DS2_v2

echo
echo
echo 'Deallocate the virtual machine'
echo
echo 'az vm deallocate --resource-group $resource_group --name $vm_name'
read -n1 -r -p 'Press Enter...' key

az vm deallocate --resource-group $resource_group --name $vm_name

echo
echo
echo 'Get the power state of the virtual machine'
echo
echo 'az vm deallocate --resource-group $resource_group --name $vm_name'
read -n1 -r -p 'Press Enter...' key

az vm get-instance-view --name $vm_name --resource-group $resource_group --query instanceView.statuses[1]

echo
echo
echo 'Show the available sizes for the deallocated virtual machine'
echo
echo 'az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name'
read -n1 -r -p 'Press Enter...' key

az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name

echo
echo
echo 'Resize the deallocated virtual machine'
echo
echo 'az vm resize --resource-group $resource_group --name $vm_name --size Standard_GS1'
read -n1 -r -p 'Press Enter...' key

az vm resize --resource-group $resource_group --name $vm_name --size Standard_GS1

echo
echo
echo 'Start the virtual machine'
echo
echo 'az vm start --resource-group $resource_group --name $vm_name'
read -n1 -r -p 'Press Enter...' key

az vm start --resource-group $resource_group --name $vm_name

echo
echo
echo 'Get the power state of the virtual machine'
echo
echo 'az vm get-instance-view --name $vm_name --resource-group $resource_group --query instanceView.statuses[1]'
read -n1 -r -p 'Press Enter...' key

az vm get-instance-view --name $vm_name --resource-group $resource_group --query instanceView.statuses[1]

echo
echo
echo 'Show the NEW available sizes for the running virtual machine'
echo
echo 'az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name'
read -n1 -r -p 'Press Enter...' key

az vm list-vm-resize-options --resource-group $resource_group --name $vm_name --query [].name