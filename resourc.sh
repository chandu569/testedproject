
#!/bin/bash

echo "create resource group red-rg"
 az group create -l eastus -n RED-RG

echo "created vnet red-rg-vnet1 location:eastus && one subnet 10 range" 
 az network vnet create -g RED-RG -n RED-RG-vNET1 --address-prefix 10.1.0.0/16 \
 --subnet-name RED-RG-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

 echo "network nsg"
az network nsg create -g RED-RG -n RED-RG_NSG1 

echo "availability-set RED-RG EAST-AVSET1"
az vm availability-set create --name EAST-AVSET1 -g RED-RG --location eastus \
--platform-fault-domain-count 3 --platform-update-domain-count 5

echo "vm installation"
sh vmmachine.sh
#!/bin/bash

echo "first vm"
az vm create --resource-group RED-RG --name RED-RGTestVM1 --image UbuntuLTS --vnet-name RED-RG-vNET1 \
--subnet RED-RG-Subnet-1 --admin-username chandra --admin-password "chandrashekhar@1234" --size Standard_B1s \
--availability-set EAST-AVSET1 

echo "second vm"
az vm create --resource-group RED-RG --name RED-RGTestVM2 --image UbuntuLTS --vnet-name RED-RG-vNET1 \
--subnet RED-RG-Subnet-1 --admin-username chandra --admin-password "chandrashekhar@1234" --size Standard_B1s \
--availability-set EAST-AVSET1 

echo "third vm"
az vm create --resource-group RED-RG --name RED-RGTestVM3 --image UbuntuLTS --vnet-name RED-RG-vNET1 \
--subnet RED-RG-Subnet-1 --admin-username chandra --admin-password "chandrashekhar@1234" --size Standard_B1s \
--availability-set EAST-AVSET1 
