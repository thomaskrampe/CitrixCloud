# Site to Site VPN Connection
This template will create a Site-to-Site VPN containing a Virtual Network, a subnet for your Azure resources (like your XenApp Essentials VM's), a virtual gateway subnet, a Virtual Network Gateway and a Connection to your on-premise network. This could be anything such as your on-premises network gateway or any other cloud network gateway.

![Azure Site-to-Site VPN](http://thomas-krampe.com/wp-content/uploads/2017/11/Azure_Site2Site_VPN.png)

**Important:** You must have a valid public IP address for your on-premise VPN gateway, this cannot be behind a NAT device. There is a workaround available, but for now - no NAT possible. 

This template will create the following resources:

- Virtual Network in an existing or new resource group
- Virtual Frontend subnet for your other VM's (eg. the Citrix workloads)
- Virtual Gateway subnet
- Virtual network gateway
- Virtual local network gateway
- Connection to your on-premise network

You can use this template as is by simply clicking on the deployment button below, but you can also change the values by editing the variables in the main template "azuredeploy.json" before deploying if you don't like my pre-defined values.

Please do not be restless the deployment takes a while (approx. 20 minutes).

Want to try it? All you have to do is clicking the **Deploy to Azure** button below.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthomaskrampe%2FCitrixCloud%2Fmaster%2FXenApp%20Essentials%2FARM-Templates%2FS2S-VPN%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fthomaskrampe%2FCitrixCloud%2Fmaster%2FXenApp%20Essentials%2FARM-Templates%2FS2S-VPN%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Something about the parameters

| Parameter                | Description                                                                                                                                                                        |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| VPN Type                 | This can be either Policy based (which is a static Gateway) or Route based (which is dynamic). Normally you should use the static gateway but it's up to you.                      |
| Local Gateway Name       | This is the name for your local gateway (eg. OnPremGW)                                                                                                                             |
| Local Gateway IP Address | This is the public IP address of your on premise VPN device (as mentioned before, no NAT device)                                                                                   |
| Local Address Prefix     | This is the CIDR block representing your on premise IP adress space (eg. 192.168.0.0/24)                                                                                           |
| Virtual Network Name     | This is the name for your Azure virtual network (eg. MyAzureVNet)                                                                                                                  |
| Virtual Network Prefix   | This is the address space for your Azure virtual network. It should be big enough for your needs (eg. 10.0.1.0/16).                                                                |
| Virtual Subnet Name      | This is the name for your resources subnet (eg. FrontendSN).                                                                                                                       |
| Virtual Subnet Prefix    | This is the CIDR block representing your Azure resources. It must be within the virtual network range above (eg. 10.0.1.0/24).                                                     |
| Gateway Subnet Prefix    | This is the CIDR block for your gateway subnet. We don't need a big range but it must be within the virtual network range as well (eg. 10.0.255.0/27 should give you enough space) |
| Gateway Public IP Name   | This is the name for the public IP address (e.g AzureGWPIP)                                                                                                                        |
| Gateway Name             | This is the name for the gateway (eg. AzureGW)                                                                                                                                     |
| Gateway SKU              | This is the SKU for your gateway (eg. Basic)                                                                                                                                       |
| Connection Name          | This is the name for the connection to your on premise resources (eg. Azure2local).                                                                                                |
| PSK                      | This is the Pre Shared Key from your on premise VPN device.                                                                                                                        |

If you use the SimplePoC or AdvancedPoC template later, make sure you use the same values for virtual network and virtual subnet.
