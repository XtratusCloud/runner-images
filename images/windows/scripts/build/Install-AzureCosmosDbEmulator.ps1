####################################################################################
##  File:  Install-AzureCosmosDbEmulator.ps1
##  Desc:  Install Azure CosmosDb Emulator
####################################################################################

Install-Binary -Type MSI `
    -Url "https://cdbemulator-dmhwaeevbhd3e9f8.b02.azurefd.net/msi/pipeline/azure-cosmosdb-emulator-2.14.23-fc82dff5.msi" ##XTRATUS Last version (2.14.24) from aka.ms url don't download correctly due to a network issue. 

Invoke-PesterTests -TestFile "Tools" -TestName "Azure Cosmos DB Emulator"
