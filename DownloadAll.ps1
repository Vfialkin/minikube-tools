Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Function Download ($url) {
    # create temp with zip extention (or Expand will complain)
    $tmp = New-TemporaryFile | Rename-Item -NewName { $_ -replace 'tmp$', 'zip' } –PassThru
    #download
    Write-Output "downloading:" $url
    Invoke-WebRequest -OutFile $tmp $url
    #exract to same folder 
    Write-Output "extracting to:" $PSScriptRoot
    $tmp | Expand-Archive -DestinationPath $PSScriptRoot -Force
    # remove temporary file
    $tmp | Remove-Item
    Write-Output "done"
}

#txeh, makes it easy to work with hots file
Download("https://github.com/txn2/txeh/releases/download/v1.3.0/txeh_windows_amd64.zip")

#kubeFwd
Download("https://github.com/txn2/kubefwd/releases/download/1.13.0/kubefwd_windows_amd64.zip")


#optional:

#k9s, console dashboard and more
#scoop install k9s

#octant, dashboard 
#choco install octant --confirm
