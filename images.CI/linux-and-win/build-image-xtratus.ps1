param(
    [String] [Parameter (Mandatory = $true)] $TenantId,
    [String] [Parameter (Mandatory = $false)] $ClientId = "",
    [String] [Parameter (Mandatory = $false)] $ClientSecret = "",
    [Boolean] [Parameter (Mandatory = $false)] $UseAcureCliAuth = $false,
    [String] [Parameter (Mandatory = $true)] $SubscriptionId,
    [String] [Parameter (Mandatory = $true)] $ResourceGroup,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkName,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkRG,
    [String] [Parameter (Mandatory = $false)] $VirtualNetworkSubnet,
    [String] [Parameter (Mandatory = $true)] $ManagedImageName,
    [String] [Parameter (Mandatory = $true)] $ManagedImageVersion,
    [String] [Parameter (Mandatory = $true)] $TemplatePath
)

if (-not (Test-Path $TemplatePath)) {
    Write-Error "'-TemplatePath' parameter is not valid. You have to specify correct Template Path"
    exit 1
}

$Image = [io.path]::GetFileName($TemplatePath).Split(".")[0]
$InstallPassword = [System.GUID]::NewGuid().ToString().ToUpper()

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

Write-Host "Download packer plugins"
packer init $TemplatePath

Write-Host "Validate packer template"
packer validate -syntax-only $TemplatePath

Write-Host "Build $Image VM"
if ($UseAcureCliAuth) {
    packer build -var "tenant_id=$TenantId" `
        -var "use_azure_cli_auth=true" `
        -var "subscription_id=$SubscriptionId" `
        -var "build_resource_group_name=$ResourceGroup" `
        -var "virtual_network_name=$VirtualNetworkName" `
        -var "virtual_network_resource_group_name=$VirtualNetworkRG" `
        -var "virtual_network_subnet_name=$VirtualNetworkSubnet" `
        -var "managed_image_name=$($ManagedImageName)_$($ManagedImageVersion)" `
        -var "install_password=$InstallPassword" `
        -color=false `
        $TemplatePath `
    | Where-Object {
        #Filter sensitive data from Packer logs
        $currentString = $_
        $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
        $sensitiveString -eq $null
    }
} else {
    packer build -var "tenant_id=$TenantId" `
        -var "client_id=$ClientId" `
        -var "client_secret=$ClientSecret" `
        -var "subscription_id=$SubscriptionId" `
        -var "build_resource_group_name=$ResourceGroup" `
        -var "virtual_network_name=$VirtualNetworkName" `
        -var "virtual_network_resource_group_name=$VirtualNetworkRG" `
        -var "virtual_network_subnet_name=$VirtualNetworkSubnet" `
        -var "managed_image_name=$($ManagedImageName)_$($ManagedImageVersion)" `
        -var "install_password=$InstallPassword" `
        -color=false `
        $TemplatePath `
    | Where-Object {
        #Filter sensitive data from Packer logs
        $currentString = $_
        $sensitiveString = $SensitiveData | Where-Object { $currentString -match $_ }
        $sensitiveString -eq $null
    }
}
