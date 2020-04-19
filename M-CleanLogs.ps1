Write-Output "Cleaning up logs"
minikube ssh "sudo sh -c 'du -ch /var/lib/docker/containers/*/*-json.log | grep total before'"
minikube ssh "sudo sh -c 'truncate -s 0 /var/lib/docker/containers/*/*-json.log'"