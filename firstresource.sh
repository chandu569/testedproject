#!/bin/bash

echo "creating Azure Resource Group AZUREB8"
az group create -l eastus -n AZUREB8

echo "creating Azure virtual network"
az network vnet create -g AZUREB8 -n AZUREB8-vNET1 --address-prefix 10.1.0.0/16
--subnet-name AZUREB8-Subnet-1 --subnet-prefix 10.1.1.0/24 -l eastus

az network vnet create -g AZUREB8 -n AZUREB8-CENTRAL-vNET1 --address-prefix 10.2.0.0/16
--subnet-name AZUREB8-CENTRAL-Subnet-1 --subnet-prefix 10.2.1.0/24 centralus

echo "creating azure subnets"
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZURE-Subnet-1 --address-prefix 10.1.2.0/24
az network vnet subnet create -g AZUREB8 --vnet-name AZUREB8-vNET1 -n AZUREB8-Subnet-1 --address-prefixes 10.1.3.0/24

echo "creating Azure NSG & Rules"
az network nsg create -g AZUREB8 -n AZUREB8_NSG1
az network nsg rule create -g AZUREB8 --nsg-name AZUREB8_NSG1_RULE1 --priority 100 \ --source-address-prefixes '*' --source-port-ranges '*'  --destination-address-prefixes '*' --destination-port-ranges '*' --access Allow --protocol Tcp --description "Allowing All Traffic For Now"

echo "creating azure availiability set"
az vm availability-set create --name EAST-AVSET1 -g AZUREB8 --loaction eastus \ 
--platform-fault-domain-count 3 --platform-update-domain-count 5
