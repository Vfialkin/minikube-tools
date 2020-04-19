Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

#Stop
Write-Host "Forcing minikube to restart"
minikube stop; 

#Start with M-Start
invoke-expression -Command $PSScriptRoot'.\M-Start.ps1'
