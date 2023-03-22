#############
## fcloud365.com
## IA-CORP-CORE-COMMONSERV
#############
#Deployment global variables
$tenantId = "a9a8e375-fac1-4ec2-820a-cfb6eb5cf01b"
$subscriptionId = "d7a8fe02-cc0e-4c0a-8a4d-9afd9061d5de"

#security context using user credentials (adm for production tenant, standard for test tenant)
#NOTE: only needed the first time, to allow to read SP credentials
az login --tenant $tenantId -o none
az account set --subscription $subscriptionId

#read SP credentials and perform non-interactive login
$clientId = "9c3a6ec0-64bc-4c68-adc8-711402467f33" #SPN_IA-CORP-CORE-COMMONSERV_SelfhostedBuild
$vault_name = "kv-we-p-management-001"
$secret_name = "sp-$clientId-secret" 
$clientKey = (az keyvault secret show --vault-name $vault_name -n $secret_name --query "value" -o tsv)
az login --service-principal --username $clientId --password $clientKey --tenant $tenantId
az account set --subscription $subscriptionId

##terraform authentication env variables
$Env:ARM_CLIENT_ID = $clientId
$Env:ARM_CLIENT_SECRET = $clientKey
$Env:ARM_SUBSCRIPTION_ID = $subscriptionId
$Env:ARM_TENANT_ID = $tenantId
$Env:ARM_RESOURCE_GROUP = "RG-WE-P-IMAGES-SELFHOSTED-BUILD-001"
$Env:BUILD_RESOURCE_GROUP_NAME = "RG-WE-P-IMAGES-SELFHOSTED-BUILD-001"
$Env:VNET_NAME = "vnet-we-p-imagesbuild-001"
$Env:VNET_RESOURCE_GROUP = "RG-WE-P-IMAGES-SELFHOSTED-BUILD-001"
$Env:VNET_SUBNET = "snet-we-p-imagesbuild-001"
$Env:PRIVATE_VIRTUAL_NETWORK_WITH_PUBLIC_IP = "true"
$Env:RUN_VALIDATION_FLAG = "true"
$Env:DOCKERHUB_LOGIN = ""
$Env:DOCKERHUB_PASSWORD = ""

##build Ubuntu 20.04
$Env:MANAGED_IMAGE_NAME = "SelfHosted_Ubuntu2004"
$Env:MANAGED_IMAGE_VERSION = "$(gitversion /showvariable SemVer)"
packer build -on-error="ask" -force `
    -var "client_id=$($clientId)" `
    -var "client_secret=$($clientKey)" `
    C:\code\cross_zone\EUR\runner-images\images\linux\ubuntu2004.pkr.hcl

##PUBLISH Ubuntu 20.04
$Env:IMAGE_GALLERY_SUBSCRIPTION = "d7a8fe02-cc0e-4c0a-8a4d-9afd9061d5de"
$Env:IMAGE_GALLERY_RESOURCE_GROUP = "RG-WE-P-IMAGES-SELFHOSTED-001"
$Env:IMAGE_GALLERY_NAME = "acgwepselfhostedimages01"
$Env:IMAGE_REPLICATION_REGIONS = """West Europe"" eastus2"
$Env:IMAGE_GALLERY_REPLICATION = "Premium_LRS"
$Env:MANAGED_IMAGE_STORAGE_ACCOUNT_TYPE = "Premium_LRS"
$publishVersion = $(gitversion /showvariable MajorMinorPatch)
$imageResourceId = "/subscriptions/$Env:IMAGE_GALLERY_SUBSCRIPTION/resourceGroups/$Env:BUILD_RESOURCE_GROUP_NAME/providers/Microsoft.Compute/images/$($Env:MANAGED_IMAGE_NAME)_$($Env:MANAGED_IMAGE_VERSION)"
az sig image-version create --gallery-name "$Env:IMAGE_GALLERY_NAME" `
    --resource-group "$Env:IMAGE_GALLERY_RESOURCE_GROUP" `
    --gallery-image-definition "$Env:MANAGED_IMAGE_NAME" `
    --gallery-image-version "$publishVersion" `
    --subscription "$Env:IMAGE_GALLERY_SUBSCRIPTION" `
    --replica-count 1 `
    --storage-account-type "$Env:IMAGE_GALLERY_REPLICATION" `
    --target-regions "West Europe" eastus2 `
    --managed-image "$imageResourceId" `
    --tags "SourceImage=$imageResourceId" `
    --no-wait

##build Windows 2019
$Env:MANAGED_IMAGE_NAME = "SelfHosted_Windows2019"
$Env:MANAGED_IMAGE_VERSION = "2.0.0-20230312.1"
$installPassword = [System.GUID]::NewGuid().ToString().ToUpper()
packer build -on-error="ask" -force `
    -var "client_id=$($clientId)" `
    -var "client_secret=$($clientKey)" `
    -var "install_password=$($installPassword)" `
    C:\code\cross_zone\EUR\runner-images\images\win\windows2019.pkr.hcl





########################## OTHER IMAGES #############################
##### NOTE: The image definition in gallery must have created #######
#####################################################################
##build Ubuntu 18.04
$Env:MANAGED_IMAGE_NAME = "SelfHosted_Ubuntu1804"
$Env:MANAGED_IMAGE_version = "2.0.0-20230311.2" #don"t publish
packer build -on-error="ask" -force `
    -var "client_id=$($clientId)" `
    -var "client_secret=$($clientKey)" `
    C:\code\cross_zone\EUR\runner-images\images\linux\ubuntu1804.pkr.hcl

##build Ubuntu 22.04
$Env:MANAGED_IMAGE_NAME = "SelfHosted_Ubuntu2204"
$Env:MANAGED_IMAGE_version = "2.0.0-20230311.2"
packer build -on-error="ask" -force `
    -var "client_id=$($clientId)" `
    -var "client_secret=$($clientKey)" `
    C:\code\cross_zone\EUR\runner-images\images\linux\ubuntu2204.pkr.hcl

##build Windows 2022
$Env:MANAGED_IMAGE_NAME = "SelfHosted_Windows2022"
$Env:MANAGED_IMAGE_version = "2.0.0-20230312.1"
$installPassword = [System.GUID]::NewGuid().ToString().ToUpper()
packer build -on-error="ask" -force `
    -var "client_id=$($clientId)" `
    -var "client_secret=$($clientKey)" `
    -var "install_password=$($installPassword)" `
    C:\code\cross_zone\EUR\runner-images\images\win\windows2022.pkr.hcl


