# PowerShell library for HPE OneSphere
This is a PowerShell module to manage HPE OneSphere from PowerShell or from a PowerShell Script.
In addition to PowerShell 5.1, module was updated to work with PowerShell Core 6.2 Preview, tested on Windows 10 and on MacOS.

Install Module from PowerShell Gallery and import before using: 
````
Install-Module hpeonesphere
import-module hpeonesphere
````
or clone from github and import from local disk:
````
git clone https://github.com/HewlettPackard/hpe-onesphere-powershell.git
import-module ./hpeonesphere
````
List available commands: 
````
get-command -module hpeonesphere
````
Check **samples\hpeonesphere-tests.ps1** for examples of calls:
````
.\samples\hpeonesphere-tests.ps1 -portal $YourOneSpherePortal -username $YourOneSphereUsername -password $YourOneSpherePassword -short
````

Please open Issues on repo for us to fix.

Thanks.
