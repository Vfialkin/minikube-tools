#create or update service ServiceHostFWD that will forward requests to actuall host

#Requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "Setting context to minikube to garantee that we deploy to minikube"
kubectl config use-context minikube

# minikube talks with host via IP address
# lets grab it:
$hostIp = minikube ssh 'route -n | grep ^0.0.0.0 | awk \"{ print \$2 }\"'
Write-Host $hostIp

#replace IP in template 
(Get-Content $PSScriptRoot'\masterhost.template.yaml').replace('{IP}', $hostIp) | Set-Content $PSScriptRoot'\masterhost.yaml'

Write-Host "Publishing Masterhost service"
kubectl apply -f $PSScriptRoot'\masterhost.yaml'

#to avoid adding it to source control
Remove-Item $PSScriptRoot'\masterhost.yaml'

Write-Host "creating dns entries in hosts for debugging from local"
txeh add 127.0.0.1 masterhost.shared masterhost.shared.svc.cluster.local;

Write-Host "Masterhost published and masterhost.shared added to dns"