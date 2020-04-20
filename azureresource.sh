#!/bin/bash

echo "create resource-group"
az group create -l Eastus -n chandragroup
az network vnet create -g chandragroup -n chandraVnet --address-prefix 10.0.0.0/16 \
    --subnet-name firstSubnet --subnet-prefix 10.0.0.0/24
echo "create Vnet"
az network vnet subnet create -g chandragroup --vnet-name chandraVnet -n secondSubnet \
    --address-prefixes 10.0.1.0/24 
echo "create NSG"
az network nsg create -g chandragroup -n chandraNsg --tags super_secure no_80 no_22
echo "create first virtual machine"
az vm create --resource-group chandragroup --name chandravm1 --image UbuntuLTS --vnet-name chandraVnet\
		  --subnet firstSubnet --admin-username chandra --admin-password Chandrashekhar@1234
      
      az group delete -n chandragroup
