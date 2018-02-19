    $HOLProjName = "DidierProj"
    $HOLuserName = "Didier Lalli"
    $HOLprojObj = Get-HPEOSProject | where Name -match $HOLProjName
    $VMname = "VMdeployed"
    $HOLservice = get-hpeosservice | where Name -match "Windows2016-CTS"
    $VMprofile = get-hpeosvirtualmachineprofile | where Name -match "m1.large"
    $HOLprivZone = get-hpeoszone -ZoneId (get-hpeoszone | where Name -match "SVT-CorkVC" | select -ExpandProperty Id)
    $HOLnetworkObj = Get-HPEOSNetwork -zone $HOLprivZone | where Name -match "VM Network"
    $HOLsetNetwork = Set-HPEOSNetwork -Network $HOLnetworkObj -Project $HOLprojObj
    $PubKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDoPXa4QQBbwys16A9zLZsNvi2MWX58GXg8POZ5UywTmO/S5daGc1HUL+TddR+zMxnKe6+WLxUvKIBbnMtACGWb/E1KiLBL5st+P/WfRsA8CrJpJhaib6mBIrQW4hOXiXHgFL2eJWFG7CxrY4pfo+WQBsnb5XW6/YZg03eoP/5ma/Mj5e5LGl/g6hrI6WLlHHKiCJvAoTCR6kRoaj+Bb+//LvmbznEpni4oMCIqSXT5RTAIQWcn4tEI37l+jP5OjeWF9EV/32nKudJozhJctgl62UhLpvPYE53L96kPJtmKTULaOsBS1kKzj+qW+88fVnLLqU9hyRHY99AawUhBPoel root@localhost.localdomain"
    $HOLRegionObj = Get-hpeosregion | where Name -match "AMR-Boston" 
    try {
        $HOLVMdeployed = Add-HPEOSDeployment -DeploymentName $VMname -Project $HOLProjObj -Service $HOLservice `
             -VirtualMachineProfile $VMprofile -Zone $HOLprivZone -Networks $HOLnetworkObj `
             -PublicKey $PubKey -Region $HOLRegionObj 
    } catch {
        write-output $Error[0]
    }
