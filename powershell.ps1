# Variables
$resourceGroupName = "MyResourceGroup"
$location = "East US"
$storageAccountName = "mystorageaccountname" # Must be globally unique
$skuName = "Standard_LRS" # Standard Locally Redundant Storage

# Login to Azure (Uncomment if needed)
# Connect-AzAccount

# Create a new resource group if it doesn't exist
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    $resourceGroup = New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Resource group '$resourceGroupName' created in '$location'."
} else {
    Write-Host "Resource group '$resourceGroupName' already exists in '$location'."
}

# Create the storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                                       -Name $storageAccountName `
                                       -Location $location `
                                       -SkuName $skuName `
                                       -Kind "StorageV2" `
                                       -EnableHttpsTrafficOnly $true

Write-Host "Storage account '$storageAccountName' created."

# Retrieve and display the primary storage account key
$key = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName)[0].Value
Write-Host "Primary storage account key: $key"