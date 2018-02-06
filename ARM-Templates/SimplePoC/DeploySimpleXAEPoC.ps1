<#
 .SYNOPSIS
        Deploys a simple XenApp Essentials PoC template to Azure

 .DESCRIPTION
        Deploys a simple XenApp Essentials PoC Azure Resource Manager template with three VM's to Azure

 .PARAMETER SubscriptionId (Mandatory)
        The subscription id where the template will be deployed.

 .PARAMETER ResourceGroupName (Mandatory)
        The resource group where the template will be deployed. Can be the name of an existing or a new resource group. 
  
 .PARAMETER ResourceGroupLocation (Optional)   
        A resource group location. If specified, will try to create a new resource group in this location. If not specified, assumes resource group is existing.

 .PARAMETER DeploymentName (Mandatory)
        The deployment name.

 .PARAMETER TemplateFilePath (Optional)
        Path to the template file. Defaults to azuredeploy.json in my GitHub account.

 .PARAMETER ParametersFilePath (Optional)
        Path to the parameters file. Defaults to azuredeploy.parameters.json. If file is not found, it will prompt for parameter values based on template.

 .EXAMPLE
        DeploySimpleXAEPoC.ps1 -SubscriptionID "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -ResourceGroupName "XAE-RG" -ResourceGroupLocation "Northeurope" -DeploymentName "MyDeployment"

 .LINK
        https://github.com/thomaskrampe/CitrixCloud/raw/master/ARM-Templates/SimplePoC 
                 
 .NOTES
        Author        : Thomas Krampe | t.krampe@loginconsultants.de
        Version       : 1.0
        Creation date : 12.09.2017 | v0.1 | Initial script
        Last change   : 10.10.2017 | v1.0 | Release it to GitHub
#>

param (
    [Parameter(Mandatory)]
    [string]$SubscriptionId,  

    [Parameter(Mandatory)]
    [string]$ResourceGroupName, 
    
    [string]$ResourceGroupLocation = "Northeurope", 
 
    [Parameter(Mandatory)]
    [string]$DeploymentName,    

    [string]$TemplateFilePath = "https://github.com/thomaskrampe/CitrixCloud/raw/master/ARM-Templates/SimplePoC/azuredeploy.json",  
 
    [string]$ParametersFilePath = "https://github.com/thomaskrampe/CitrixCloud/raw/master/ARM-Templates/SimplePoC/azuredeploy.parameters.json"
)

$ErrorActionPreference = "Stop"

# Login to Azure and select subscription
Write-Output "Logging in"
Login-AzureRmAccount
Write-Output "Selecting subscription '$SubscriptionId'"
Select-AzureRmSubscription -SubscriptionID $SubscriptionId

# Create or check for existing resource group
$resourceGroup = Get-AzureRmResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if ( -not $ResourceGroup ) {
    Write-Output "Could not find resource group '$ResourceGroupName' - will create it"
    if ( -not $ResourceGroupLocation ) {
        $ResourceGroupLocation = Read-Host -Prompt 'Enter location for resource group'
    }
    Write-Output "Creating resource group '$ResourceGroupName' in location '$ResourceGroupLocation'"
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation
}
else {
    Write-Output "Using existing resource group '$ResourceGroupName'"
}

# Start the deployment
Write-Output "Starting deployment"
if ( Test-Path $ParametersFilePath ) {
    New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFilePath -TemplateParameterFile $ParametersFilePath
}
else {
    New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFilePath
}