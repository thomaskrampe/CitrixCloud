# Site to Site VPN Connection
This template will create a Site-to-Site VPN containing a Virtual Network, a subnet for your Azure resources (like your XenApp Essentials VM's), a virtual gateway subnet, a Virtual Network Gateway and a Connection to your on-premise network. This could be anything such as your on-premises network gateway or any other cloud network gateway.

![Azure Site-to-Site VPN](http://thomas-krampe.com/wp-content/uploads/2017/11/Azure_Site2Site_VPN.png)

**Important:** You must have a valid public IP address for your on-prem VPN gateway, this cannot be behind an NAT.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthomaskrampe%2FCitrixCloud%2Fmaster%2FXenApp%20Essentials%2FARM-Templates%2FS2S-VPN%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fthomaskrampe%2FCitrixCloud%2Fmaster%2FXenApp%20Essentials%2FARM-Templates%2FS2S-VPN%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

