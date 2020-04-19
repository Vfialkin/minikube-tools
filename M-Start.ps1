#Requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# garantee that we work with mimikube
kubectl config use-context minikube

Write-Host "Checking kube status..."
$status = minikube status
Write-Host $status
if ($status -like '*Misconfigured*' -Or $status -like '*Stopped*' -Or $status -like '*minikube start*') {
    
    Write-Host "Need to restart kube. Grab a coffee, it might take some time.."
    
    #Stop
    minikube stop; 

    #Start
    Write-Host "Starting..."
    minikube start --vm-driver hyperv --memory=8000m --cpus=4 --disk-size=8000m;

    Write-Host "Installing MasterHost.shared with dns forward to host ip"
    invoke-expression -Command $PSScriptRoot'.\M-Publish-Masterhost.ps1'

    Write-Host "Setup Minikube.Host dns to be able to access kube by 'minikube.host' on localhost (ip changes on restart)"
    txeh add (minikube ip) minikube.host;     
    
    Write-Host "fixing something that might be already fixed but who knows...wait a sec"
    #fixing https://github.com/kubernetes/minikube/issues/1568
    minikube ssh "sudo ip link set docker0 promisc on"

    #clean logs 
    #minikube ssh "sudo sh -c 'truncate -s 0 /var/lib/docker/containers/*/*-json.log'"    

    Write-Host "Done!"
}
else
{
    Write-Host "Already running"    
    Write-Host $status
}

#minikube dashboard