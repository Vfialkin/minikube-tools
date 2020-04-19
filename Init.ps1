#Requires -RunAsAdministrator
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

#Downloads tools from external sources 
invoke-expression -Command $PSScriptRoot'.\DownloadAll.ps1'

Function Add-ToSystemPath {            
    Param($Path)
    
   if($env:Path -like "*$Path*") {    
       Write-Host "'$Path' already exists in Path statement" }
   else {     
       $VerifiedPathsToAdd += ";$Path"
       Write-Host "Adding '$Path' to Path statement now..."
       [Environment]::SetEnvironmentVariable("Path",$env:Path + $VerifiedPathsToAdd,"Process")
       }
   }

#Add this folder to Systems Math
Add-ToSystemPath($PSScriptRoot);