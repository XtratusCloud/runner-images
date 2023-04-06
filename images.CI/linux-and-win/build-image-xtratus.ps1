param(
    [String] [Parameter (Mandatory = $true)] $TenantId,
    [String] [Parameter (Mandatory = $true)] $ClientId,
    [String] [Parameter (Mandatory = $true)] $ClientSecret,
    [String] [Parameter (Mandatory = $true)] $SubscriptionId,
    [String] [Parameter (Mandatory = $true)] $ResourceGroup,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkName,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkRG,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkSubnet,
    [String] [Parameter (Mandatory = $true)] $ManagedImageName,
    [String] [Parameter (Mandatory = $true)] $ManagedImageVersion,
    [String] [Parameter (Mandatory = $true)] $ResourcesNamePrefix,
    [String] [Parameter (Mandatory = $true)] $TemplatePath
)

if (-not (Test-Path $TemplatePath)) {
    Write-Error "'-TemplatePath' parameter is not valid. You have to specify correct Template Path"
    exit 1
}

$Image = [io.path]::GetFileName($TemplatePath).Split(".")[0]
$InstallPassword = [System.GUID]::NewGuid().ToString().ToUpper()

packer validate -syntax-only $TemplatePath

$SensitiveData = @(
    'OSType',
    'StorageAccountLocation',
    'OSDiskUri',
    'OSDiskUriReadOnlySas',
    'TemplateUri',
    'TemplateUriReadOnlySas',
    ':  ->'
)

Write-Host "Show Packer Version"
packer --version

Write-Host "Build $Image VM"
packer build    -var "tenant_id=$TenantId" `
    -var "client_id=$ClientId" `
    -var "client_secret=$ClientSecret" `
    -var "build_subscription_id=$SubscriptionId" `
    -var "build_resource_group_name=$ResourceGroup" `
    -var "virtual_network_name=$VirtualNetworkName" `
    -var "virtual_network_resource_group_name=$VirtualNetworkRG" `
    -var "virtual_network_subnet_name=$VirtualNetworkSubnet" `
    -var "run_validation_diskspace=$env:RUN_VALIDATION_FLAG" `
    -var "managed_image_name=$ManagedImageName" `
    -var "managed_image_version=$ManagedImageVersion" `
    -var "capture_name_prefix=$ResourcesNamePrefix" `
    -var "install_password=$InstallPassword" `
    -color=false `
    $TemplatePath `
| Where-Object {
    #Filter sensitive data from Packer logs
    $currentString = $_
    $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
    $sensitiveString -eq $null
}
