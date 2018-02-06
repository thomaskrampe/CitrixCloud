# XenApp / XenDesktop Services Proof of Concept
Before you start a Xenapp / XenDesktop Services Proof of Concept you have to prepare your Azure Account. Part of this preparation is to create a Resource Group within your valid subscription and some virtual machines like one or more domain controller (if you prefer to use a dedicated forest in Azure), a Citrix Cloud Connector VM (better two) and, of corse, a Golden Image VM. Visit the [Wiki Pages](https://github.com/thomaskrampe/CitrixCloud/wiki) to learn more about Xenapp / XenDesktop Services on Azure.

![Xenapp / XenDesktop Services Architecture](http://thomas-krampe.com/wp-content/uploads/2018/02/XenDesktopServices.png)

This ARM template covers the environment within the red frame in the architecture diagram above. It creates three VM's in your resource group. The first VM acts as a domain controller and creates a new AD forest. It creates a Availability Group and a Loadbalancer for this Domain Controller VM as well (in case you will add more Domain Controller later).
The remaining VM's are used as Cloud Connector and a golden image master server, both VM's are joined to the previously created domain. Keep in mind that I use Windows 2016 Server and Standard D2v2 instances for all VM's in this template. 

If you don't like the D2v2 instances I choose, just change it. There is a good overview at [Azure Compute Info](http://computeinfo.azurewebsites.net) regarding all available instances.

You can use this template as is by simply clicking on the deployment button below, but you can also change hostnames, IP-Addresses and so on by editing the variables in the main template "azuredeploy.json" before deploying if you don't like my pre-defined values. 

Please do not be restless the deployment takes a while (approx. 20 minutes) because the forest creation is done via DSC and we have to copy some stuff before. 

Want to try it?
All you have to do is clicking the button below.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2Fthomaskrampe%2FCitrixCloud%2Fraw%2Fmaster%2FARM-Templates%2FAdvancedPoC%2Fazuredeploy.json" target="_blank"><img src="http://azuredeploy.net/deploybutton.png"/></a>
<a href="http://armviz.io/#/?load=https%3A%2f%2Fgithub.com%2Fthomaskrampe%2FCitrixCloud%2Fraw%2Fmaster%2FARM-Templates%2FAdvancedPoC%2Fazuredeploy.json" target="_blank"><img src="http://armviz.io/visualizebutton.png"/></a>

## PowerShell
Just clicking on a Azure Deploy Button is fine so far but in my opion it's far away from automation. So if you prefer PowerShell for deploying this template please use the DeploySimpleXAEPoC.ps1 PowerShell script.

**Example:**

```
DeployAdvancedXDSPoC.ps1 -SubscriptionID "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -ResourceGroupName "XAE-RG" -ResourceGroupLocation "Northeurope" -DeploymentName "MyDeployment"
```

There are currently some template parameters not covered by the PowerShell script, after running the script you have to provide additional template parameters like administrator account informations, Domain name etc. manually. I will add those later (see open issues), but for now it's all you get. The script is well documented so use it or just change it to your own needs.
