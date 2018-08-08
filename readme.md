# Azure Virtual Machine Demo

## Working with Azure Images

Define the deployment variables used by the subsequent Azure CLI commands'

```bash
resource_group=app-us-west2
location=westus2
vm_name=vm-01
```

Show all virtual machine images

```bash
az vm image list
```

Show all publishers

```bash
az vm image list-publishers -l $location --query "[?starts_with(name, 'Open')]"
```

Show all offers from OpenLogic

```bash
az vm image list-offers --location $location -p OpenLogic
```

Show all skus from OpenLogic based on CentOS'

```bash
az vm image list-skus --location $location -p OpenLogic -f CentOS
```

Show all virtual machine sizes available in a region

```bash
az vm list-sizes --location $location
```

Create a virtual machine with a specific sku

```bash
az group create --name $resource_group --location $location

az vm create --resource-group $resource_group --name $vm_name --image OpenLogic:CentOS:7.5:latest --generate-ssh-keys
```

## Deploying a CentOS Virtual Machine with httpd

Define the deployment variables used by the subsequent Azure CLI commands

```bash
resource_group=app-us-west2
vnet_name=vnet-us-west2
location=westus2
vm_name=vm-02
pip_name=vm-02-pip
nsg_name=vm-02-nsg
```

Create a resource group

```bash
az group create --name $resource_group --location $location
```

Create a virtual network

```bash
az network vnet create --resource-group $resource_group --name $vnet_name --subnet-name ServerSubnet
```

Create a public IP address

```bash
az network public-ip create --resource-group $resource_group --name $pip_name
```

Create a network security group

```bash
az network nsg create --resource-group $resource_group --name $nsg_name
```

Create a virtual network card and associate with public IP address and NSG

```bash
az network nic create \
  --resource-group $resource_group \
  --name $vm_name-nic1 \
  --vnet-name $vnet_name \
  --subnet ServerSubnet \
  --network-security-group $nsg_name \
  --public-ip-address $pip_name
```

Create a new virtual machine, this creates SSH keys if not present

```bash
az vm create \
  -resource-group $resource_group \
  --name $vm_name \
  --nics $vm_name-nic1 \
  --os-disk-name $vm_name-boot.vhd \
  --image CentOS \
  --generate-ssh-keys
```

Open port 22 to allow SSH traffic to host

```bash
az vm open-port --port 22 --resource-group $resource_group --name $vm_name
```

Use the Azure Virtual Machine Custom Script Extension to install httpd

```bash
az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name $vm_name \
  --resource-group $resource_group \
  --settings '{"commandToExecute":"yum -y install httpd && systemctl start httpd && systemctl enable httpd"}'
```

Open port 80 to allow http traffic to host

```bash
az vm open-port --port 80 --resource-group $resource_group --name $vm_name --priority 901
```