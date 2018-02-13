##############################################################################9
## (C) Copyright 2017-2018 Hewlett Packard Enterprise Development LP 
##############################################################################
<#
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
#>

[CmdletBinding()]
Param
(
    [Parameter(Mandatory)]
    [string]$Portal,

    [Parameter(Mandatory)]
    [string]$Username,

    [Parameter(Mandatory)]
    [string]$Password,
    
    [Parameter(Mandatory=$False)]
    [switch]$Short

)

$ErrorActionPreference = 'Continue'

#remove-module hpeonesphere
import-module ./hpeonesphere.psm1


$secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
$Global:mycreds = New-Object System.Management.Automation.PSCredential ($Username, $secpasswd)


Connect-HPEOS -portal $Portal  -credentials $mycreds -verbose 
get-HPEOSstatus -verbose
write-host "This is my identity: " 
get-hpeossession

# Count things

write-host "Providers discovered: " @(Get-HPEOSProvider).count
write-host "ProviderTypes discovered: " @(Get-HPEOSProviderType).count
write-host "Regions discovered: " @(Get-HPEOSRegion).count
write-host "Zones discovered: " @(Get-HPEOSZone).count
write-host "ZoneTypes discovered: " @(Get-HPEOSZoneType).count
write-host "CatalogTypes discovered: " @(Get-HPEOSCatalogType).count
write-host "Catalog discovered: " @(Get-HPEOSCatalog).count
write-host "Services discovered: " @(Get-HPEOSService).count
write-host "ServiceTypes discovered: " @(Get-HPEOSServiceType).count
write-host "VirtualMachineProfiles discovered: " @(Get-HPEOSVirtualMachineProfile).count
write-host "Deployments discovered: " @(Get-HPEOSDeployment).count
write-host "Projects discovered: " @(Get-HPEOSProject).count
write-host "Memberships discovered: " @(Get-HPEOSMembership).count 
write-host "MembershipRoles discovered: " @(Get-HPEOSMembershipRole).count 
write-host "Roles discovered: " @(Get-HPEOSRole).count 
write-host "Users discovered: " @(Get-HPEOSUser).count 
write-host "Volumes discovered: " @(Get-HPEOSVolume).count
write-host "TagKeys discovered: " @(Get-HPEOSTagKey).count
write-host "Tags discovered: " @(Get-HPEOSTag).count
write-host "Rates discovered: " @(Get-HPEOSRate).count
write-host "Appliances discovered: " @(Get-HPEOSAppliance).count

if ($Short) { return }

write-host "Getting Providers by Id"
$myStuff = get-HPEOSProvider
Foreach ($item in $myStuff) {
    $p = get-HPEOSprovider -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Regions by Id"
$myStuff = get-HPEOSRegion
Foreach ($item in $myStuff) {
    $p = get-HPEOSRegion -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Zones by Id"
$myStuff = get-HPEOSZone
Foreach ($item in $myStuff) {
    $p = get-HPEOSZone -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Zones Appliance images"
Foreach ($item in $myStuff) {
    if ($item.zoneTypeUri -eq "/rest/zone-types/vcenter") {   
        $p = get-HPEOSZoneApplianceImage $item
        write-host "`t-" $p
        }
}
write-host "Getting catalogs by Id"
$myStuff = get-HPEOSCatalog
Foreach ($item in $myStuff) {
    $p = get-HPEOSCatalog -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Service Types by Id"
$myStuff = get-HPEOSServiceType
Foreach ($item in $myStuff) {
    $p = get-HPEOSServiceType -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Services by Id"
$myStuff = get-HPEOSService
Foreach ($item in $myStuff) {
    $p = get-HPEOSService -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting VirtualMachine Profiles by Id"
$myStuff = Get-HPEOSVirtualMachineProfile
Foreach ($item in $myStuff) {
    $p = Get-HPEOSVirtualMachineProfile -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Networks for each zone"
$myZones = get-HPEOSZone
Foreach ($zone in $myZones) {
    $myStuff = get-HPEOSNetwork -zone $zone
    Foreach ($item in $myStuff) {
        $p = get-HPEOSNetwork -id $item.id
        write-host "`t-" $p.uri
    }
}
write-host "Getting Projects by Id"
$myStuff = get-HPEOSProject
Foreach ($item in $myStuff) {
    $p = get-HPEOSProject -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Deployments by Id"
$myStuff = get-HPEOSDeployment
Foreach ($item in $myStuff) {
    $p = get-HPEOSDeployment -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Users by Id"
$myStuff = get-HPEOSUser
Foreach ($item in $myStuff) {
    $p = get-HPEOSUser -id $item.id
    write-host "`t-" $p.uri
}
write-host "Getting Volumes by Id"
$myStuff = get-HPEOSVolume
Foreach ($item in $myStuff) {
    $p = get-HPEOSVolume -id $item.id
    write-host "`t-" $p.uri
}

write-host "Creating a Project"
$myProject = add-HPEOSProject -name "TestingAPI" 
get-HPEOSProject -id $myProject.id | fl
write-host "Deleting a Project"
remove-HPEOSProject $myProject
write-host "Creating a user"
$myuser = add-HPEOSuser -username "TestingAPI" -userpassword "P@ssw0rd!" -useremail "didier@lalli.fr" -userrole "administrator" 
get-HPEOSuser -id $myuser.id | fl
write-host "Deleting a user"
remove-HPEOSuser $myuser
write-host "Creating a TagKey"
$mytagkey= add-HPEOStagkey -tagkeyname TagKeyTestAPI
get-HPEOStagkey -id $mytagkey.id | fl
write-host "Creating a Tag"
$mytag = add-HPEOStag -tagname TagTestAPI -tagkey $mytagkey
get-HPEOStag -id $mytag.id | fl
write-host "Deleting tag"
remove-HPEOStag $mytag
write-host "Deleting tagkey"
remove-HPEOStag $mytagkey
write-host "Creating a volume"
$myzone = @(get-hpeoszone)[0]
$myproject = @(get-hpeosproject)[0]
#$myvolume = add-HPEOSvolume -name "TestingAPIVolume"  -size 2  -zone $myzone -project $myproject
#sleep 10
#get-HPEOSvolume -id $myvolume.id | fl
#write-host "Deleting a volume"
#remove-HPEOSvolume $myvolume
write-host "Creating a Catalog"
$myCatalogType=get-hpeoscatalogtype | where id -eq docker-hub
$mycatalog= add-HPEOScatalog -name "TestingAPI" -url http://www.hpe.com -type $myCatalogType
get-HPEOScatalog -filter "API" | fl
write-host "Patching a Catalog"
set-hpeoscatalog -catalog $mycatalog -state Disabled
write-host "Deleting a Catalog"
remove-HPEOSCatalog $mycatalog

write-host "Creating a provider"
$myProvidertype = get-hpeosprovidertype -id ncs
$myProvider = Add-HPEOSProvider -Name ProviderAPITesting -type $myProviderType
get-HPEOSProvider -id $myProvider.id | fl
write-host "Creating a region"
$myRegion = Add-HPEOSRegion -Name RegionAPITesting -Provider $myProvider -latitude 60 -longitude 0 
get-HPEOSRegion -id $myRegion.id | fl
write-host "Creating a zone"
$myzonetype = get-hpeoszonetype -id vcenter
$myZone = Add-HPEOSZone -Name ZoneAPITesting -Provider $myProvider -Region $myRegion -Zonetype $myzonetype
$enabled=wait-hpeosobjectenabled $myZone 3600
if (!$enabled){
    write-host "Zone creation failed"
}
get-HPEOSZone -id $myZone.id | fl
write-host "Deleting a zone"
remove-HPEOSZone $myZone -force
write-host "Deleting a region"
remove-HPEOSRegion $myRegion
write-host "Deleting a provider"
remove-HPEOSProvider $myProvider

# Disconnect
disconnect-hpeos


