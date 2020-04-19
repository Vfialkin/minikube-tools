# :zap: Tools to work with minikube 

Contains set of tools and scripts that make work with minikube less painful

#### Initialize tools:
```powershell
.\Init.ps1
```
It will download *kubefwd* and other tools and add this folder to PATH :boom:


#####  Start minikube  :rocket:: 
```powershell
.\M-Start.ps1
```
Checks if minikube is stale\stopped or misconfigured and starts it with following addons:

- Deploys service **masterhost.shared** and setups forwarding to host ip 
Not 127.0.0.1 but your VM host machine IP that changes on restart. This way services inside the cluster can access resources running on your machine, like sql server, just use masterhost.shared as an endpoint name and make sure port in firewall is open to internal network (1433 for sql)

- Adds dns names to localhost:
    1. **masterhost.shared** and **masterhost.shared.svc.cluster.local** - as 127.0.0.1, to make it easier for debug without changing configs
    2. **minikube.host** - to access exposed services by host name (ex. http://minikube.host:30562 for kibana)
    3. Anything else you need, just checkout the file ;)


##### Restart minikube: 
```powershell
.\M-Restart.ps1
```
Forces restart even if kube is running

##### Clean k8s logs:
If you are running out of space 
```powershell
.\M-CleanLogs.ps1
```

