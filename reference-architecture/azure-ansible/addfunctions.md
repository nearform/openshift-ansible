# Red Hat OpenShift Container Platform on Azure


## Experimental Functions
These additional templates are untested and unverified at this time.

### Add Additional Nodes
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fopenshift%2Fopenshift-ansible-contrib%2Fmaster%2Freference-architecture%2Fazure-ansible%2Fazureexpand.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### Add Test Single Node
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fopenshift%2Fopenshift-ansible-contrib%2Fmaster%2Freference-architecture%2Fazure-ansible%2Fonenode.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### Create the cluster with powershell

```powershell
New-AzureRmResourceGroupDeployment -Name <DeploymentName> -ResourceGroupName <RessourceGroupName> -TemplateUri https://raw.githubusercontent.com/openshift/openshift-ansible-contrib/master/reference-architecture/azure-ansible/azuredeploy.json
```
