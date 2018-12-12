##############################################################################
# HPE OneSphere PowerShell Library
##############################################################################
##############################################################################
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
OUT OF OR IN CONNECTION WITH THE ShOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

#>

<#
 Note: This library requires the following installed:
 Microsoft .NET Framework 4.6: http://go.microsoft.com/fwlink/?LinkId=528259
 Windows Management Framework (aka PowerShell) 4: https://www.microsoft.com/en-us/download/details.aspx?id=40855
#>

[Version]$ModuleVersion = '1.1'

# Import-Module Text
$_WelcomeTitle = "Welcome to the HPE OneSphere POSH Library, v{0}" -f $ModuleVersion.ToString()
write-host ("        {0}" -f $_WelcomeTitle)
write-host ("        {0}" -f (New-Object System.String('-',$_WelcomeTitle.Length)))
write-host ""
write-host " To get a list of available CMDLETs in this library, type :  " -NoNewline
write-host "Get-Command -module hpeos" -foregroundcolor yellow
write-host " To get help for a specific command, type:                   " -NoNewLine
write-host "get-help " -NoNewLine -foregroundcolor yellow
write-host "[verb]" -NoNewLine -foregroundcolor red
write-host "-HPEOS" -NoNewLine -foregroundcolor yellow
write-host "[noun]" -foregroundcolor red
write-host " To get extEnded help for a specific command, type:          " -NoNewLine
write-host "get-help " -NoNewLine -foregroundcolor yellow
write-host "[verb]" -NoNewLine -foregroundcolor red
write-host "-HPEOS" -NoNewLine -foregroundcolor yellow
write-host "[noun]" -NoNewLine -foregroundcolor red
write-host " -full" -foregroundcolor yellow
write-host " To update the offline help for this module, type:           " -NoNewLine
write-host "Update-Help -module hpeos" -foregroundcolor yellow
write-host ""
write-host " Module sample scripts are located at: " -NoNewLine
write-host "$(split-path -parent $MyInvocation.MyCommand.Path)\Samples" -ForegroundColor yellow
write-host ""
write-host " (C) Copyright 2017-2018 Hewlett Packard Enterprise Development LP "
if ((Get-Host).UI.RawUI.MaxWindowSize.width -lt 150) 
{
	write-host ""
	write-host " Note: Set your PowerShell console width to 150 to properly view report output. (Current Max Width: $((Get-Host).UI.RawUI.MaxWindowSize.width))" -ForegroundColor Green
}
write-host ""

$Global:FormatEnumerationLimit=64
$debugMode = $false

#Note: Set $debugPreference to control debug logging
If ($debugmode) 
{

	$debugPreference   = "Continue"         # Display requests and responses
	$VerbosePreference = "Continue" 

}
#Else{ $debugPreference = "SilentlyContinue" } # Hide debug messages

#region URIs and Enums
[String]$script:AuthProviderSetting = "LOCAL"
#${Global:ConnectedSessions}         = New-Object System.Collections.ArrayList
#${Global:ResponseErrorObject}       = New-Object System.Collections.ArrayList
[TimeSpan]$script:defaultTimeout    = New-TimeSpan -Minutes 20
$script:FSOpenMode                  = [System.IO.FileMode]::Open
$script:FSRead                      = [System.IO.FileAccess]::Read
[MidpointRounding]$script:MathMode  = 'AwayFromZero' 
[String]$MinXAPIVersion             = "100"
[String]$MaxXAPIVersion             = "100"
[String]$Repository                 = ""


$Script:ConnectAppOS                = ("mac", "windows")
$Script:ResetZoneAction             = "reset"
$Script:AddCapacityZoneAction       = "add-capacity"
$Script:ReduceCapacityZoneAction    = "reduce-capacity"
$Script:ZoneActionCompute           = "compute"
$Script:ZoneActionStorage           = "storage"

$Script:DeploymentStopAction        = "stop"
$Script:DeploymentStartAction       = "start"
$Script:DeploymentRestartAction     = "restart"
$Script:DeploymentResumeAction      = "resume"
$Script:DeploymentSuspendAction     = "suspend"
$Script:PatchOperationAdd           = "add"
$Script:PatchOperationRemove        = "remove"
$Script:PatchOperationReplace       = "replace"

#------------------------------------
# Resource Management
#------------------------------------
[String]$script:StatusUri                           = "/rest/status"
[String]$script:ConnectAppUri                       = "/rest/connect-app/"
[String]$script:SessionUri                          = "/rest/session"
[String]$script:AccountUri                          = "/rest/account"
[String]$script:ProviderTypeUri                     = "/rest/provider-types"
[String]$script:ProviderUri                         = "/rest/providers"
[String]$script:RegionUri                           = "/rest/regions"
[String]$script:ZoneTypeUri                         = "/rest/zone-types"
[String]$script:ZoneUri                             = "/rest/zones"
[String]$script:CatalogUri                          = "/rest/catalogs"
[String]$script:CatalogTypeUri                      = "/rest/catalog-types"
[String]$script:ServiceTypeUri                      = "/rest/service-types"
[String]$script:ServiceUri                          = "/rest/services"
[String]$script:VirtualMachineProfileUri            = "/rest/virtual-machine-profiles"
[String]$script:NetworkUri                          = "/rest/networks"
[String]$script:ProjectUri                          = "/rest/projects"
[String]$script:DeploymentUri                       = "/rest/deployments"
[String]$script:MembershipUri                       = "/rest/memberships"
[String]$script:MembershipRoleUri                   = "/rest/membership-roles"
[String]$script:RoleUri                             = "/rest/roles"
[String]$script:UserUri                             = "/rest/users"
[String]$script:MetricUri                           = "/rest/metrics"
[String]$script:RateUri                             = "/rest/rates"
[String]$script:EventUri                            = "/rest/events"
[String]$script:VolumeUri                           = "/rest/volumes"
[String]$script:portalUri                           = "/rest/portals"
[String]$script:TagKeyUri                           = "/rest/tag-keys"
[String]$script:TagUri                              = "/rest/tags"
[String]$script:KeypairUri                          = "/rest/keypairs"
[String]$script:ApplianceUri                        = "/rest/appliances"
[String]$script:PasswordResetUri                    = "/rest/password-reset"
[String]$script:PasswordChangeUri                   = "/rest/password-reset/change"
[String]$script:VersionUri                          = "/rest/about/versions"
[String]$script:BillingAccountUri                   = "/rest/billing-accounts"




[string]$script:IPSubnetAddressPattern     = '^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' +
											 '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' +
											 '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.' +
											 '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)' +
											 '(/0*([1-9]|[12][0-9]|3[0-2]))?$'

$Global:HPEOSHeaders = @{}
$Global:HPEOSHeadersXHpeMediaType = "X-Hpe-Media-Type"

[string]$Global:HPEOSHostname
[boolean]$Global:HPEOSPortalConnected  = $false

function cleanup_url { Param ([string] $portal) 
    if ($portal.endswith('/')) { $portal = $portal.substring(0,$portal.length - 1)}
    if (! $portal.startswith("http")) { $portal="https://" + $portal}

    return $Portal
}

function set_securityprotocols {  
    $AllProtocols = [System.Net.SecurityProtocolType]'Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
}

<#
.SYNOPSIS
Retrieves status from OneSphere Management portal
.PARAMETER portal
Optional: The URL to the OneSphere Portal (Required if not already connected)
.DESCRIPTION
Retrieves status from OneSphere Management portal
.EXAMPLE
GET-HPEOSstatus
.EXAMPLE
GET-HPEOSstatus -portal https://myonesphereportal.hpe.com
.Notes
    NAME:  GET-HPEOSstatus
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSstatus
{
    [CmdletBinding()]
    Param
	(
		[Parameter(Mandatory=$False)]
		[string]$portal
	)
    Process        
        {
        if (!$Global:HPEOSPortalConnected  -and !$portal)
            {
            Throw "Not connected to any OneSphere portal"
        }

        if (!$portal) {
            $portal = $Global:HPEOSHostname
        } else {
            # Cleanup $Portal
            $Portal=cleanup_url($Portal)
        }

        set_securityprotocols

        $FullUri = $portal + $script:StatusUri 
        write-debug "FullUri is $FullUri"

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            $res.service
            #Write-Output "Status of HPE OneSphere is: $status"
            }
        catch 
        {
            $PSCmdlet.ThrowTerminatingError($_) 
        }
    }		
}
<#
.SYNOPSIS
Retrieves version from OneSphere Management portal API
.PARAMETER portal
Optional: The URL to the OneSphere Portal (Required if not already connected)
.DESCRIPTION
Retrieves API version from OneSphere Management portal
.EXAMPLE
GET-HPEOSversion
.EXAMPLE
GET-HPEOSversion -portal https://myonesphereportal.hpe.com
.Notes
    NAME:  GET-HPEOSversion
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSversion
{
    [CmdletBinding()]
    Param
	(
		[Parameter(Mandatory=$False)]
		[string]$portal
	)
    Process        
        {
        if (!$Global:HPEOSPortalConnected  -and !$portal)
            {
            Throw "Not connected to any OneSphere portal"
        }
        
        if (!$portal) {
            $portal = $Global:HPEOSHostname
        } else {
            # Cleanup $Portal
            $Portal=cleanup_url($Portal)
        }

        set_securityprotocols
        
        $FullUri = $portal + $script:VersionUri 
        write-debug "FullUri is $FullUri"

        try {
            # use WebResquest here as WebMethod doesn't allow to get the response headers
            $res = invoke-WebRequest -Uri $FullUri -Headers $Global:HPEOSHeaders  -Method GET

            ($res.Headers.'X-Hpe-Media-Type').split(";")[1].split("=")[1]
            #Write-Output "Version of HPE OneSphere API is: $version"
            }
        catch 
        {
        $PSCmdlet.ThrowTerminatingError($_) 
        }
    }		
}
<#
.SYNOPSIS
Connects to OneSphere Management Portal
.PARAMETER portal
The URL to the OneSphere Portal
.PARAMETER Credentials
Credentials to the OneSphere Management Portal
.DESCRIPTION
Connects to OneSphere Management Portal and retrieves a token
.EXAMPLE
Connect-HPEOS  https://myportal.hpe.net
.EXAMPLE
Connect-HPEOS -portal https://myportal.hpe.net 
.Notes
    NAME:  Connect-HPEOS
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Connect-HPEOS 
{
    [CmdletBinding()]
    Param
	(
		[Parameter(Mandatory=$True)]
		[string]$Portal,

		[Parameter(Mandatory=$True, ValueFromPipeline=$True)]
		[pscredential]$Credentials

	)

    Process
    {
        $Global:HPEOSHeaders["Accept"] = "application/json"
        $Global:HPEOSHeaders["Content-Type"] = "application/json"

        # Cleanup $Portal
        $Portal=cleanup_url($Portal)

        set_securityprotocols
        
                
        $password = $Credentials.GetNetworkCredential().Password
        $user = $Credentials.Username
        $Global:HPEOSHostname = $Portal

        $FullUri = $Global:HPEOSHostname + $script:SessionUri 
        $body = @{
            userName=$user
            password=$password
        }
        $jsonbody = ConvertTo-Json -InputObject $body
        write-debug "Connecting to OneSphere SaaS Platform using $user and $password"
        write-debug "FullUri is $FullUri"
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            write-debug "Response from API call: $res"    
        }
        catch
        {
                        $PSCmdlet.ThrowTerminatingError($_) 
        }
        $token = $res.token
        write-verbose "Connected to OneSphere portal !"
        $Global:HPEOSHeaders["Authorization"] = "Bearer " + $token
        $Global:HPEOSPortalConnected  = $true
    }
}

<#
.SYNOPSIS
Disconnects from OneSphere Management Portal
.DESCRIPTION
Disconnects from OneSphere Management Portal and invalides current session token
.EXAMPLE
Disconnect-HPEOS  
.Notes
    NAME:  Disconnect-HPEOS
    LASTEDIT: 
    KEYWORDS: OneSphere 
 
.Link
     http://www.hpe.com/onesphere
#>
function Disconnect-HPEOS 
{
    [CmdletBinding()]
    Param
	(
    )
   
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere Portal"
        } 
    }

    Process
    {
        $FullUri = $Global:HPEOSHostname + $script:SessionUri 
        write-debug "FullUri is $FullUri"
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method DELETE
            write-debug "Response from API call: $res"    
        }
        catch
        {
                        $PSCmdlet.ThrowTerminatingError($_) 
        }
        write-verbose "Disconnected from OneSphere portal !"
        $Global:HPEOSHeaders["Authorization"] = ""
        $Global:HPEOSHeaders["Accept"] = ""
        $Global:HPEOSHeaders["Content-Type"] = ""
        
        $Global:HPEOSHostname = "" 
        $Global:HPEOSPortalConnected  = $False
    }
}

<#
.SYNOPSIS
Retrieves current session from OneSphere Management Portal
.DESCRIPTION
Retrieves session from OneSphere Management Portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSSession
.Notes
    NAME:  GET-HPEOSSession
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSSession
{
    [CmdletBinding()]
    Param
	(
    )

    Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere Portal"
            } 
        }

    Process
        {

        $UrlFilter="?view=full"    
        $ResultType="Session"

        $FullUri = $Global:HPEOSHostname + $Script:SessionUri + $UrlFilter 
        write-debug "FullUri is $FullUri"  
 
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        
    }
    End
        {
        $res.user
        }
}

function EncodeQuery
{
    Param
	(
        [string]$QueryLeft,
        [string]$QueryRight
    )
    "query=%22" + $QueryLeft + "%20EQ%20" + $QueryRight + "%22"
}


<#
.SYNOPSIS
Retrieves Providers from OneSphere Management portal
.PARAMETER ProviderId
Optional: Provider id to retrieve
.PARAMETER MasterProvider
Optional: The master provider object to filter providers by
.PARAMETER ProviderType
Optional: The provider type object to filter providers by
.PARAMETER Full 
Optional: Shows related content
.PARAMETER Discover
Optional: Returns child providers (AWS)
.DESCRIPTION
Retrieves Providers from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSprovider
.EXAMPLE
GET-HPEOSprovider -id $myProviderId
.Notes
    NAME:  GET-HPEOSProvider
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSProvider
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$ProviderId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
		[switch]$Full,
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
		[switch]$Discover,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$MasterProvider,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$ProviderType
	)

    Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }

    Process
        {
        $FullUriSuffix = ""
        $SuffixChar = "?"

        if ($ProviderId) 
            {
            $FullUri = $Global:HPEOSHostname + $Script:ProviderUri + "/" + $ProviderId 

            if ($Full) {
                    $FullUriSuffix = "?view=full"  
                }

            if ($Discover) {       
                    $FullUriSuffix = "?view=full&discover=true" 
                }
            }
        else 
            {
            # Seems Ignored 
            $FullUri = $Global:HPEOSHostname + $Script:ProviderUri 
            if ($MasterProvider){
                $FullUriSuffix = $FullUriSuffix + $SuffixChar + (EncodeQuery "masterProviderUri" $MasterProvider.uri)
                $SuffixChar = "&"
                }

            if ($ProviderType){
                    $FullUriSuffix = $FullUriSuffix + $SuffixChar  + (EncodeQuery "providerTypeUri" $ProviderType.uri)
                }
            }     
        
        $FullUri = $FullUri + $FullUriSuffix 
        write-debug "FullUri is $FullUri"  
 
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        
        If ($ProviderId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }

        If ($Full -or $Discover) {
            $ResultType = 'hpeonesphere.ProviderFull'

        } else {
            $ResultType = 'hpeonesphere.Provider'
        }
        
    }
    End
        {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
        }
}

<#
.SYNOPSIS
Retrieves Provider types from OneSphere Management portal
.PARAMETER ProviderTypeId
Optional: ProviderType id to retrieve
.DESCRIPTION
Retrieves Provider types from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSprovidertype
.EXAMPLE
GET-HPEOSprovidertype -id $myProviderTYpeId
.Notes
    NAME:  GET-HPEOSProviderType
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSProviderType
{
    [CmdletBinding()]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
        [alias ('id')]
		[string]$ProviderTypeId
	)

    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
    
        if ($ProviderTypeId){
            $FullUri = $Global:HPEOSHostname + $Script:ProviderTypeUri + "/" + $ProviderTypeId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ProviderTypeUri 
        }
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($ProviderTypeId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.ProviderType'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}


<#
.SYNOPSIS
Retrieves Regions from OneSphere Management portal
.PARAMETER RegionId
Optional: Region id to retrieve
.PARAMETER Full 
Optional: Shows related content
.PARAMETER Provider
Optional: The provider object to prune regions by
.PARAMETER Discover
Optional: Returns child providers (AWS)
.DESCRIPTION
Retrieves Regions from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSregion
.EXAMPLE
GET-HPEOSregion -id $MyRegionId
.Notes
    NAME:  GET-HPEOSRegion
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSRegion
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$RegionId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [Parameter(Mandatory=$False, ParameterSetName = "List")]		
        [switch]$Full,
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
		[switch]$Discover,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Provider  
    )
    
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        $FullUriSuffix = ""
        $SuffixChar = "?"

        if ($RegionId){
            $FullUri = $Global:HPEOSHostname + $Script:RegionUri + "/" + $RegionId 

            if ($Full) {
                    $FullUriSuffix = "?view=full"  
                }

            if ($Discover) {       
                    $FullUriSuffix = "?view=full&discover=true" 
                }
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:RegionUri 
            if ($Provider) {
                $FullUriSuffix =  $FullUriSuffix + $SuffixChar + (EncodeQuery "providerUri" $Provider.uri)
            }
        }

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($RegionId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.Region'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves Zone from OneSphere Management portal
.PARAMETER ZoneId
Optional: Zone id to retrieve
.PARAMETER Provider
Optional: Provider object to prune zones by
.PARAMETER Region
Optional: The region to prune zones by
.PARAMETER Appliance
Optional: The appliance to prune zones by
.PARAMETER Full
Optional: Whether to return related content
.DESCRIPTION
Retrieves Zones from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZone 
.EXAMPLE
GET-HPEOSZone -name $MyZone
.Notes
    NAME:  GET-HPEOSZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZone
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
	   [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$ZoneId,
     
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('filter')]
		[Object]$Provider,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Region,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Appliance,
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]		
        [switch]$Full
    )

        Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
        {
            $FullUriSuffix = ""
            $SuffixChar ="?"

            if ($ZoneId){
                $FullUri = $Global:HPEOSHostname + $Script:ZoneUri + "/" + $ZoneId 

                if ($Full) {
                    $FullUriSuffix = "?view=full"  
                }

            }
            else {
                $FullUri = $Global:HPEOSHostname + $Script:ZoneUri 
                if ($Region) {
                    $FullUriSuffix = $FullUriSuffix + $SuffixChar + (EncodeQuery "regionUri" $Region.uri)
                    $SuffixChar="&"
                }

                if ($Appliance) {
                    $FullUriSuffix = $FullUriSuffix + $SuffixChar + (EncodeQuery "applianceUri" $Appliance.uri)
                    $SuffixChar="&"
                }

                if ($Provider) {
                    $FullUriSuffix = $FullUriSuffix + $SuffixChar + (EncodeQuery "providerUri" $Provider.uri)
                }
            }        
            
            $FullUri = $FullUri + $FullUriSuffix
            write-debug "FullUri is $FullUri"  
    
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            } 
        
            If ($ZoneId) {
                $ResultSet = $res
            }
            else {
                $ResultSet = $res.members
            }
            
            $ResultType = 'hpeonesphere.Zone'
        }
        
        End
        {
            # return full list from ResultSet 
            foreach ($Result in $ResultSet)
                {
                $Result.PSObject.TypeNames.Insert(0,$ResultType)
                write-output $Result         
                }
        }
}

<#
.SYNOPSIS
Retrieves Zone task status from OneSphere Management portal
.PARAMETER Zone
Optional: Zone object to query
.DESCRIPTION
Retrieves Zones connection status from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZoneTaskStatus -zone $MyZone
.Notes
    NAME:  GET-HPEOSZoneTaskStatus
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZoneTaskStatus
{
    Param
	(
        [Parameter(Mandatory, ValueFromPipeline=$True)]
        [ValidateNotNullorEmpty()]
        [Object]$Zone
    )

        Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
        {

            $FullUri = $Global:HPEOSHostname + $Zone.uri + "/task-status"
            write-debug "FullUri is $FullUri"  
    
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            } 
        
            $ResultSet = $res
            $ResultType = 'hpeonesphere.ZoneTaskStatus'
        }
        
        End
        {
            # return full list from ResultSet 
            foreach ($Result in $ResultSet)
                {
                $Result.PSObject.TypeNames.Insert(0,$ResultType)
                write-output $Result         
                }
        }
}

<#
.SYNOPSIS
Retrieves Zone connections from OneSphere Management portal
.PARAMETER Zone
Optional: Zone object to query
.DESCRIPTION
Retrieves Zones connections from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZoneConnection
.Notes
    NAME:  GET-HPEOSZoneConnection -zone $MyZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZoneConnection
{
    Param
	(
        [Parameter(Mandatory, ValueFromPipeline=$True)]
        [ValidateNotNullorEmpty()]
        [Object]$Zone
    )

        Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
        {

            $FullUri = $Global:HPEOSHostname + $Zone.uri + "/connections"
            write-debug "FullUri is $FullUri"  
    
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            } 
        
            $ResultSet = $res
            $ResultType = 'hpeonesphere.ZoneConnections'
        }
        
        End
        {
            # return full list from ResultSet 
            foreach ($Result in $ResultSet)
                {
                $Result.PSObject.TypeNames.Insert(0,$ResultType)
                write-output $Result         
                }
        }
}

<#
.SYNOPSIS
Retrieves ZoneApplianceImage from OneSphere Management portal
.PARAMETER Zone
Zone to retrieve image for
.DESCRIPTION
Retrieves appliance image of Zone from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZoneApplianceImage -zone $MyZone
.Notes
    NAME:  GET-HPEOSZoneApplianceImage
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZoneApplianceImage
{
    [CmdletBinding()]
    Param
	(
        [Parameter(Mandatory, ValueFromPipeline=$True)]
        [ValidateNotNullorEmpty()]
	    [Object]$Zone
    )

        Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
        {
        
            $FullUri = $Global:HPEOSHostname + $Script:ZoneUri + "/" + $Zone.id + "/appliance-image" 
            write-debug "FullUri is $FullUri"  
    
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                write-verbose "Error retrieving portal Image from OneSphere portal"
                $PSCmdlet.ThrowTerminatingError($_)
            } 
        
            write-output $res
        
        }
        
        End
        {
        }
}

<#
.SYNOPSIS
Retrieves zone os endpoints from OneSphere Management portal
.PARAMETER Zone
Optional: zone object to query
.DESCRIPTION
Retrieves zones os endpoints from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZoneOsEndPoint $myzone
.EXAMPLE
GET-HPEOSZoneOsEndPoint $myzone -osrc
.EXAMPLE
GET-HPEOSZoneOsEndPoint $myzone -osendpoints
.Notes
    NAME:  GET-HPEOSZoneOsEndPoint -zone $MyZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZoneOsEndPoint
{
    Param
	(
        [Parameter(Mandatory, ValueFromPipeline=$True)]
        [ValidateNotNullorEmpty()]
        [Object]$Zone,
        
        [Parameter(Mandatory=$False)]
        [switch]$osrc,

        [Parameter(Mandatory=$False)]
        [switch]$osendpoints

    )

        Begin
        {
        if (!$Global:HPEOSPortalConnected  )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
        {

            $FullUri = $Global:HPEOSHostname + $Zone.uri + "/os-endpoints"
            write-debug "FullUri is $FullUri"  
    
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            } 
            $ResultSet = $res
            $ResultType = 'hpeonesphere.ZoneOSEndPoint'

            if ($osrc)
                { $ResultSet = $res.'os-rc'}
            elseif ($osendpoints)
                { $ResultSet = $res.'os-endpoints'}
        }
        End
        {
            # return full list from ResultSet 
            foreach ($Result in $ResultSet)
                {
                $Result.PSObject.TypeNames.Insert(0,$ResultType)
                write-output $Result         
                }
        }
}


<#
.SYNOPSIS
Reduce compute capacity to Zone in OneSphere Management portal
.PARAMETER Zone
Zone 
.PARAMETER Decrement
Capacity to reduce
.DESCRIPTION
Reduces compute capacity to Zone in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
COMPRESS-HPEOSZoneCompute -zone MyNewZone -decrement 5
.Notes
    NAME:  COMPRESS-HPEOSZoneCompute
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Compress-HPEOSZoneCompute
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Zone,
        
        [Parameter (Mandatory=$False)]
		[Int]$Decrement = 1
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "type" = $Script:ReduceCapacityZoneAction
        "resourceOps" = @{
            "resourceType" = $Script:ZoneActionCompute
            "resourceCapacity" = $Decrement 
            }
        }
 
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone was reduced successfully"
        }
        catch
        {
            write-verbose  "Failed to reduce Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}
<#
.SYNOPSIS
Reduce storage capacity to Zone in OneSphere Management portal
.PARAMETER Zone
Zone 
.PARAMETER Decrement
Capacity to reduce
.DESCRIPTION
Reduces storage capacity to Zone in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
COMPRESS-HPEOSZoneStorage -zone MyNewZone -decrement 5
.Notes
    NAME:  COMPRESS-HPEOSZoneStorage
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Compress-HPEOSZoneStorage
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Zone,
        
        [Parameter (Mandatory=$False)]
		[Int]$Decrement = 1
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "type" = $Script:ReduceCapacityZoneAction
        "resourceOps" = @{
            "resourceType" = $Script:ZoneActionStorage
            "resourceCapacity" = $Decrement 
            }
        }
 
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone was Reduced successfully"
        }
        catch
        {
            write-verbose  "Failed to reduce Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Reset Password for email in OneSphere Management portal
.PARAMETER Email
Email of user to initiate password reset for
.DESCRIPTION
Reset password for user in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
RESET-HPEOSPassword -email foo@bar.com
.Notes
    NAME:  RESET-HPEOSPassword
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Reset-HPEOSPassword
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
		[string]$Email
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "email" = $Email
        }

           
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $script:PasswordResetUri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Password reset initiated successful: mail sent to $Email"
        }
        catch
        {
            write-verbose  "Failed to initiate password reset"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Set Password for email in OneSphere Management portal
.PARAMETER Email
Email of user to initiate password reset for
.DESCRIPTION
Reset password for user in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
RESET-HPEOSPassword -email foo@bar.com
.Notes
    NAME:  RESET-HPEOSPassword
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSPassword
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [string]$Password,
        
        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [string]$Token
        
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "token" = $Token
        "password" = $Password
        }

           
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $script:PasswordChangeUri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Password reset initiated successfully"
            Write-Output $res
        }
        catch
        {
            write-verbose  "Failed to initiate password reset"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Reset Zone in OneSphere Management portal
.PARAMETER Zone
Zone 
.DESCRIPTION
Reset Zone in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
RESET-HPEOSZone -zone MyNewZone 
.Notes
    NAME:  RESET-HPEOSZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Reset-HPEOSZone
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
		[Object]$Zone
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "type" = $Script:ResetZoneAction
        }

           
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone reset successfully"
        }
        catch
        {
            write-verbose  "Failed to reset Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}
<#
.SYNOPSIS
Add compute capacity to Zone in OneSphere Management portal
.PARAMETER Zone
Zone 
.PARAMETER Increment
Capacity to add
.DESCRIPTION
Adds compute capacity to Zone in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
EXPAND-HPEOSZoneCompute -zone MyNewZone -increment 5
.Notes
    NAME:  EXPAND-HPEOSZoneCompute
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Expand-HPEOSZoneCompute
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Zone,
        
        [Parameter (Mandatory=$False)]
		[Int]$Increment = 1
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "type" = $Script:AddCapacityZoneAction
        "resourceOps" = @{
            "resourceType" = $Script:ZoneActionCompute
            "resourceCapacity" = $Increment 
            }
        }
 
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone was expanded successfully"
        }
        catch
        {
            write-verbose  "Failed to expand Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Add storage capacity to Zone in OneSphere Management portal
.PARAMETER Zone
Zone 
.PARAMETER Increment
Capacity to add
.DESCRIPTION
Adds storage capacity to Zone in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
EXPAND-HPEOSZoneStorage -zone MyNewZone -increment 5
.Notes
    NAME:  EXPAND-HPEOSZoneStorage
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Expand-HPEOSZoneStorage
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Zone,
        
        [Parameter (Mandatory=$False)]
		[Int]$Increment = 1
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @{
        "type" = $Script:AddCapacityZoneAction
        "resourceOps" = @{
            "resourceType" = $Script:ZoneActionStorage
            "resourceCapacity" = $Increment 
            }
        }
 
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone was expanded successfully"
        }
        catch
        {
            write-verbose  "Failed to expand Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Retrieves ZoneTypes from OneSphere Management portal
.PARAMETER ZoneTypeId
Optional: ZoneType id to retrieve
.DESCRIPTION
Retrieves ZoneTypes from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSZoneType
.EXAMPLE
GET-HPEOSZoneType -id $MyZoneType
.Notes
    NAME:  GET-HPEOSZoneType
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSZoneType
{
    [CmdletBinding()]
    Param
	(        
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
        [alias ('id')]
		[string]$ZoneTypeId
    )
    
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
    
        if ($ZoneTypeId){
            $FullUri = $Global:HPEOSHostname + $Script:ZoneTypeUri + "/" + $ZoneTypeId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ZoneTypeUri 
        }
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($ZoneTypeId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.ZoneType'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves Catalogs from OneSphere Management portal
.PARAMETER CatalogId
Optional: Catalog id to retrieve
.PARAMETER UserQuery
Optional: Query string to prune catalogs by (query on name)
.DESCRIPTION
Retrieves Catalogs from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSCatalog
.EXAMPLE
GET-HPEOSCatalog -id $myId -full
.Notes
    NAME:  GET-HPEOSCatalog
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSCatalog
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(   
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$CatalogId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('name')]
        [string]$UserQuery,	
        
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [Parameter(Mandatory=$False, ParameterSetName = "List")]		
        [switch]$Full
    )
    
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = ""   
        $SuffixChar = "?"

        if ($CatalogId){
            $FullUri = $Global:HPEOSHostname + $Script:CatalogUri + "/" + $CatalogId 
            }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:CatalogUri 
            }

        if ($Full) {
            $FullUriSuffix = "?view=full"  
            $SuffixChar = "&"
            }

        if ($UserQuery){
            $FullUriSuffix += $SuffixChar + "userQuery=" + $UserQuery
            }    

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($CatalogId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.Catalog'
    }

    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}


<#
.SYNOPSIS
Retrieves Catalog Types from OneSphere Management portal
.DESCRIPTION
Retrieves Catalog Types from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSCatalogType
.Notes
    NAME:  GET-HPEOSCatalogType
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSCatalogType
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(   

    )
    
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUri = $Global:HPEOSHostname + $Script:CatalogTypeUri 
        
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($CatalogId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.CatalogType'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves Services from OneSphere Management portal
.PARAMETER ServiceId
Optional: Service id to retrieve
.PARAMETER UserQuery
Optional: query string to prune services by (name, version or description)
.PARAMETER ServiceType
Optional: Type to filter services by
.PARAMETER Zone
Optional: Zone to filter services by
.PARAMETER Project
Optional: Project to filter services by
.PARAMETER Catalog
Optional: catalog to filter services by
.PARAMETER Full
Optional: Include all the details of the service(s)
.DESCRIPTION
Retrieves Services from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSService 
.EXAMPLE
GET-HPEOSService -id $MyServiceId
.EXAMPLE
GET-HPEOSService -id $MyServiceId -deployment
.EXAMPLE
GET-HPEOSService -userquery Ubuntu
.EXAMPLE
GET-HPEOSService -project $myProject

.Notes
    NAME:  GET-HPEOSService
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSService
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$ServiceId,
    
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full,

        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [alias ('where')]
        [switch]$Deployment,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('name','description','version')]
        [string]$UserQuery,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$ServiceType,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Zone,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Project,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Catalog
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected  )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
    
        if ($ServiceId){
            $FullUri = $Global:HPEOSHostname + $Script:ServiceUri + "/" + $ServiceId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ServiceUri 
        }

        $SuffixChar = "?"
        $FullUriSuffix = ""

        If ($UserQuery)
        {
            $FullUriSuffix += "?userQuery=" + $UserQuery
            $SuffixChar = "&"
        }

        If ($Zone)
        {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "zoneUri" $Zone.uri)
            $SuffixChar = "&"
        }

        If ($ServiceType)
        {

            $FullUriSuffix += $SuffixChar + (EncodeQuery "serviceTypeUri" $ServiceType.uri)
            $SuffixChar = "&"
        }

        If ($Catalog)
        {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "catalogUri" $Catalog.uri)
            $SuffixChar = "&"
        }

        If ($Project)
        {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "projectUri" $Project.uri)
            $SuffixChar = "&"
        }
        
        If ($Full)
        {
            $FullUriSuffix += $SuffixChar + "view=full"
            $SuffixChar = "&"
        }

        If ($Deployment)
        {
            $FullUriSuffix += $SuffixChar + "?view=deployment"
            $SuffixChar = "&"
        }
        
        $FullUri += $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"
            if ($res.count -lt $res.total)
            # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }   
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($ServiceId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }

        if ($Deployment){ 
            $ResultType = 'hpeonesphere.ServiceDeployment'
            }
        elseif ($Full) {
            $ResultType = 'hpeonesphere.ServiceFull'
            }
        else {
            $ResultType = 'hpeonesphere.Service'
        }
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves ServiceTypes from OneSphere Management portal
.PARAMETER ServiceTypeId
Optional: ServiceType id to retrieve
.DESCRIPTION
Retrieves ServiceTypes from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSServiceType
.EXAMPLE
GET-HPEOSServiceType -id $MyServiceTypeId
.Notes
    NAME:  GET-HPEOSServiceType
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSServiceType
{
    [CmdletBinding()]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
        [alias ('id')]
		[string]$ServiceTypeId
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
    
        if ($ServiceTypeId){
            $FullUri = $Global:HPEOSHostname + $Script:ServiceTypeUri + "/" + $ServiceTypeId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ServiceTypeUri 
        }
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            
            $PSCmdlet.ThrowTerminatingError($_)
    } 
    
        If ($ServiceTypeId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.ServiceType'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }

}

<#
.SYNOPSIS
Retrieves Virtual Machine Profiles from OneSphere Management portal
.PARAMETER VirtualMachineProfileId
Optional: VirtualMachineProfile id to retrieve
.PARAMETER Zone
Optional: Zone to filter virtual machine profiles by
.PARAMETER Service
Optional: Service to filter virtual machine profiles by
.DESCRIPTION
Retrieves VirtualMachineProfiles from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSVirtualMachineProfile 
.EXAMPLE
GET-HPEOSVirtualMachineProfile -id $MyVMId
.Notes
    NAME:  GET-HPEOSVirtualMachineProfile
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSVirtualMachineProfile
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$VirtualMachineProfileId,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Zone,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Service
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $SuffixChar = "?"
        $FullUriSuffix = ""

        if ($VirtualMachineProfileId){
            $FullUri = $Global:HPEOSHostname + $Script:VirtualMachineProfileUri + "/" + $VirtualMachineProfileId 
        }
        else 
            {           
            if ($Zone){
                $FullUriSuffix += $SuffixChar + (EncodeQuery "zoneUri" $Zone.uri)
                $SuffixChar = "&"
            }

            if ($Service) {
                $FullUriSuffix += $SuffixChar + (EncodeQuery "serviceUri" $Service.uri)
                $SuffixChar = "&"
            }

            $FullUri = $Global:HPEOSHostname + $Script:VirtualMachineProfileUri 
            $FullUri += $FullUriSuffix
            }

        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"   
            if ($res.count -lt $res.total)
            # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
    
        If ($VirtualMachineProfileId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        
        $ResultType = 'hpeonesphere.VirtualMachineProfile'
    }
    
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves Networks from OneSphere Management portal
.PARAMETER NetworkId
Optional: NetworkId to retrieve
.PARAMETER Zone
Zone to filter networks by
.PARAMETER Project
Optional: Query string to prune networks by
.DESCRIPTION
Retrieves Networks from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSNetwork -zone $MyZone
.EXAMPLE
GET-HPEOSNetwork -id $MyNetworkId
.Notes
    NAME:  GET-HPEOSNetwork
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSNetwork
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$NetworkId,

        [Parameter(Mandatory, ParameterSetName = "List")]
        [Object]$Zone,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [string]$Project
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = ""
        $SuffixChar = "?"
        
        if ($NetworkId){
            $FullUri = $Global:HPEOSHostname + $Script:NetworkUri + "/" + $NetworkId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:NetworkUri
            
            If ($Project) {
                $FullUriSuffix += $SuffixChar + (EncodeQuery "projectUri" $Project.uri)
                $SuffixChar = "&"
            }
            if ($Zone) {
                $FullUriSuffix += $SuffixChar + (EncodeQuery "zoneUri" $Zone.uri)
                $SuffixChar = "&"
                }
            }

        $FullUri += $FullUriSuffix 
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res" 
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }       
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($NetworkId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Network'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }   
}

<#
.SYNOPSIS
Retrieves Projects from OneSphere Management portal
.PARAMETER ProjectId
Optional: Project id to retrieve
.PARAMETER UserQuery
Optional: Query string to prune projects by. Any projects whose 'name' contains the userQuery will match
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves Projects from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSProject 
.EXAMPLE
GET-HPEOSProject -id $MyProjectId
.Notes
    NAME:  GET-HPEOSProject
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSProject
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$ProjectId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('name')]
        [string]$UserQuery,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = "" 
        $SuffixChar = "?"

        if ($ProjectId){
            $FullUri = $Global:HPEOSHostname + $Script:ProjectUri + "/" + $ProjectId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ProjectUri 
            
            if ($UserQuery){
                $FullUriSuffix = "?userQuery=" + $UserQuery
                $SuffixChar = "&"
                }
        }

        if ($Full) {
            $FullUriSuffix = $FullUriSuffix + $SuffixChar + "view=full"  
            }

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res" 
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }          
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($ProjectId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Project'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves Deployments from OneSphere Management portal
.PARAMETER DeploymentId
Optional: Deployment id to retrieve
.PARAMETER Zone
Optional: Zone to prune deployments by
.PARAMETER UserQuery
Optional: text string to prune deployments by (name)
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves Deployments from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSDeployment 
.EXAMPLE
GET-HPEOSDeployment -id $MyDeploymentId
.Notes
    NAME:  GET-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSDeployment
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$DeploymentId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Zone,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('name')]
        [string]$UserQuery,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = "" 
        $SuffixChar = "?"

        if ($DeploymentId){
            $FullUri = $Global:HPEOSHostname + $Script:DeploymentUri + "/" + $DeploymentId
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:DeploymentUri 
            
            if ($UserQuery){
                $FullUriSuffix = "?userQuery=" + $UserQuery
                $SuffixChar = "&"
                }

            if ($Zone){
                $FullUriSuffix += $SuffixChar + (EncodeQuery "zoneUri" $Zone.uri)
                $SuffixChar = "&"
                }
        }

        if ($Full) {
            $FullUriSuffix = $FullUriSuffix + $SuffixChar + "view=full"  
            }

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }              
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($DeploymentId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Deployment'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves Memberships from OneSphere Management portal
.PARAMETER Project
Optional: Project to prune memberships by
.PARAMETER User
Optional: User to prune memberships by
.PARAMETER Role
Optional: Role to prune memberships by
.DESCRIPTION
Retrieves Memberships from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSMembership
.EXAMPLE
GET-HPEOSMembership -user $myUser
.Notes
    NAME:  GET-HPEOSMembership
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSMembership
{
    [CmdletBinding(DefaultParameterSetName="ByProject")]
    Param
	(
        [Parameter(Mandatory=$False, ParameterSetName = "ByProject")]
        [Object]$Project,
    
        [Parameter(Mandatory=$False, ParameterSetName = "ByUser")]
        [Object]$User,

        [Parameter(Mandatory=$False, ParameterSetName = "ByRole")]
        [Object]$Role
    )
    
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        # We have no membership id in object membership yet 
        $MembershipId = $false

        if ($MembershipId){
            $FullUri = $Global:HPEOSHostname + $Script:MembershipUri + "/" + $MembershipId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:MembershipUri 
        }
        
        $SuffixChar = "?"
        $FullUriSuffix = ""  

        if ($Project) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "projectUri" $Project.uri)
            $SuffixChar = "&"
            }
        
        if ($User) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "userUri" $User.uri)
            $SuffixChar = "&"
            }

        if ($Role) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "roleUri" $Role.uri)
            $SuffixChar = "&"
            }

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }                  
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($MembershipId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Membership'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

<#
.SYNOPSIS
Retrieves Roles from OneSphere Management portal
.DESCRIPTION
Retrieves Roles from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSRole 
.Notes
    NAME:  GET-HPEOSRole
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSRole
{
    [CmdletBinding()]
    Param
	(
	)

    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUri = $Global:HPEOSHostname + $Script:RoleUri 
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res" 
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }                     
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        $ResultSet = $res.members
        $ResultType = 'hpeonesphere.Role'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }

}
<#
.SYNOPSIS
Downloads ConnectApp for OneSphere Management portal
.PARAMETER OS
Operating System required (supports mac or windows)
.PARAMETER OUTPUTFILE
Optional: Output file name for kit (default is Connect-App.zip)
.DESCRIPTION
Downloads ConnectApp for OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Get-HPEOSConnectApp -os windows
Get-HPEOSConnectApp -os mac
Get-HPEOSConnectApp -os windows -path C:\downloads\connect-app-win.zip
.Notes
    NAME:  Get-HPEOSConnectApp
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSConnectApp
{
    [CmdletBinding()]
    Param
	(
        [Parameter(Mandatory)]
        [string]$Os,

        [Parameter(Mandatory=$false)]
        [alias ('path')]
        [string]$Outputfile = (get-location).Path
        
    )

    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    if ($Script:ConnectAppOS -notcontains $Os)
        {
        Write-Verbose "OS type not supported by OneSphere portal"  
        $PSCmdlet.ThrowTerminatingError($_)   
        }
    }
    Process
    {
        $FullUri = $Global:HPEOSHostname + $Script:ConnectAppUri + "?os=$Os"
        write-debug "FullUri is $FullUri"  
        try {
            $res = Invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            
            Throw
        } 
        # From this, we download the Connect-App zip
        $CustomHeaders = @{}
        if (!$Outputfile)
            { $Outputfile="ConnectApp.zip"}

        #$CustomHeaders["Content-Disposition"] = "attachment; filename=$Output"
        $CustomHeaders["Content-Type"] = "application/octet-stream"

        $FullUri = $res
        write-debug "Headers : $CustomHeaders"
        write-debug "FullUri is $FullUri" 
        try{
            $res = Invoke-WebRequest -Uri $FullUri -Headers $CustomHeaders -Method GET -OutFile $Outputfile
            write-debug "Response from API call: $res"  
        }
        catch {
             $PSCmdlet.ThrowTerminatingError($_)
        } 
    }
    End
    {
    }
}

<#
.SYNOPSIS
Retrieves Users from OneSphere Management portal
.PARAMETER UserId
Optional: User id to retrieve
.PARAMETER UserQuery
Optional: Query string to prune names by. Any users whose 'name' or 'email' contains the userQuery will match.
.DESCRIPTION
Retrieves Users from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSUser 
.EXAMPLE
GET-HPEOSUser -id $MyUserId
.Notes
    NAME:  GET-HPEOSUser
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSUser
{
    [CmdletBinding()]
    Param
	( 
        [Parameter(Mandatory=$False, ValueFromPipeline=$True)]
        [alias ('id')]
        [string]$UserId,
        
        [Parameter(Mandatory=$False)]
        [alias ('name','email')]
        [string]$UserQuery
	)

    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        if ($UserId){
            $FullUri = $Global:HPEOSHostname + $Script:UserUri + "/" + $UserId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:UserUri 
        }

        $FullUriSuffix = "" 
        
        if ($UserQuery){
            $FullUriSuffix = "?userQuery=" + $UserQuery
            }
    
        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }                         
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($UserId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.User'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }    
}

<#
.SYNOPSIS
Retrieves Volumes from OneSphere Management portal
.PARAMETER VolumeId
Optional: Volume id to retrieve
.PARAMETER Project
Optional: Project object to prune volumes by
.PARAMETER Zone
Optional: Zone object to prune volumes by
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves Volumes from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSVolume 
.EXAMPLE
GET-HPEOSVolume -id $MyVolumeId
.Notes
    NAME:  GET-HPEOSVolume
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSVolume
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$VolumeId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Project,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Zone,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [switch]$Full
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        if ($VolumeId){
            $FullUri = $Global:HPEOSHostname + $Script:VolumeUri + "/" + $VolumeId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:VolumeUri 
        }
        $FullUriSuffix = "" 
        $SuffixChar = "?"

        if ($Project) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "projectUri" $Project.uri)
            $SuffixChar = "&"
            }

        if ($Zone) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "zoneUri" $Zone.uri)
            $SuffixChar = "&"
            }

        if ($Full) {
            $FullUriSuffix = $FullUriSuffix + $SuffixChar + "view=full"  
            }
    
        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"         
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }                         
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($VolumeId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Volume'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves appliances from OneSphere Management portal
.PARAMETER Names
Optional: The name(s) of the desired appliance(s)
.PARAMETER Region
Optional: appliances in region
.DESCRIPTION
Retrieves appliances from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSappliance 
.EXAMPLE
GET-HPEOSappliance -id $MyApplianceId
.Notes
    NAME:  GET-HPEOSappliance
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSappliance
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$ApplianceId,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [string[]]$Name,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Region
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        if ($ApplianceId){
            $FullUri = $Global:HPEOSHostname + $Script:ApplianceUri + "/" + $ApplianceId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:ApplianceUri 
        }

        $SuffixChar = "?"
        $FullUriSuffix = "" 

        if ($Region) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "regionUri" $Region.uri)
            $SuffixChar = "&"
        }

        foreach($res in $Name)
            {   
            $FullUriSuffix += $SuffixChar + "name=" + $res   
            $SuffixChar = "&"  
            }

        $FullUri = $FullUri + $FullUriSuffix    
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($ApplianceId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Appliance'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves rates from OneSphere Management portal
.PARAMETER RateId
Optional: rate id to retrieve
.DESCRIPTION
Retrieves rates from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSrate 
.EXAMPLE
GET-HPEOSrate -id $MyrateId
.Notes
    NAME:  GET-HPEOSrate
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSrate
{
    [CmdletBinding(DefaultParameterSetName="DefaultList")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
        [string]$RateId,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Object]$Resource,

        [Parameter(Mandatory=$False, ParameterSetName = "DefaultList")]
        [switch]$Default,

        [Parameter(Mandatory=$False, ParameterSetName = "DefaultList")]        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [switch]$Active
    )

    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = "" 
        $SuffixChar = "?"

        if ($RateId){
            $FullUri = $Global:HPEOSHostname + $Script:RateUri + "/" + $RateId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:RateUri 
        }
          
        if ($Default) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "resourceUri" "default")
            $SuffixChar = "&"
            }
    
        if ($Resource) {
            $FullUriSuffix += $SuffixChar + (EncodeQuery "resourceUri" $Resource.uri)
            $SuffixChar = "&"
            }    
            
        if ($Active) {
            $FullUriSuffix += $SuffixChar + "active=true"
            }
        

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"   
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }               
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($rateId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Rate'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves TagKeys from OneSphere Management portal
.PARAMETER TagKeyId
Optional: TagKey id to retrieve
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves TagKeys from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSTagKey 
.EXAMPLE
GET-HPEOSTagKey -id $MyTagKey
.Notes
    NAME:  GET-HPEOSTagKey
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSTagKey
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$TagKeyId,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        if ($TagKeyId){
            $FullUri = $Global:HPEOSHostname + $Script:TagKeyUri + "/" + $TagKeyId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:TagKeyUri 
        }
        
        if ($Full) {
            $FullUriSuffix += "?view=full"  
            }

        $FullUri = $FullUri + $FullUriSuffix  
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
             $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($TagKeyId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.TagKey'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
    
}

<#
.SYNOPSIS
Retrieves Tags from OneSphere Management portal
.PARAMETER TagId
Optional: Tag id to retrieve
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves Tags from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSTag 
.EXAMPLE
GET-HPEOSTag -id $MyTagId
.Notes
    NAME:  GET-HPEOSTag
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSTag
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$TagId,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        if ($TagId){
            $FullUri = $Global:HPEOSHostname + $Script:TagUri + "/" + $TagId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:TagUri 
        }

        if ($Full) {
            $FullUriSuffix += "?view=full"  
            }

        $FullUri = $FullUri + $FullUriSuffix  
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"    
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($TagId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.Tag'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }   
}
<#
.SYNOPSIS
Retrieves billing accounts from OneSphere Management portal
.PARAMETER BillingAccountId
Optional: BillingAccountId to retrieve
.PARAMETER query
Optional: query to filter accounts
.PARAMETER Full
Optional: Return related resources
.DESCRIPTION
Retrieves billing accounts from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Get-HPEOSBillingAccount
.EXAMPLE
Get-HPEOSBillingAccount -id $MyAccount
.Notes
    NAME:  Get-HPEOSBillingAccount
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSBillingAccount
{
    [CmdletBinding(DefaultParameterSetName="List")]
    Param
	(
        [Parameter(Mandatory=$False, ValueFromPipeline=$True, ParameterSetName = "Single")]
        [alias ('id')]
		[string]$BillingAccountId,
        
        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [alias ('name')]
        [string]$Query,

        [Parameter(Mandatory=$False, ParameterSetName = "List")]
        [Parameter(Mandatory=$False, ParameterSetName = "Single")]
        [switch]$Full
	)
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
    {
        $FullUriSuffix = "" 
        $SuffixChar = "?"

        if ($ProjectId){
            $FullUri = $Global:HPEOSHostname + $Script:BillingAccountUri + "/" + $BillingAccountId 
        }
        else {
            $FullUri = $Global:HPEOSHostname + $Script:BillingAccountUri 
            
            if ($Query){
                $FullUriSuffix = "?Query=" + $Query
                $SuffixChar = "&"
                }
        }

        if ($Full) {
            $FullUriSuffix = $FullUriSuffix + $SuffixChar + "view=full"  
            }

        $FullUri = $FullUri + $FullUriSuffix
        write-debug "FullUri is $FullUri"  
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res" 
            if ($res.count -lt $res.total)
                # We have more data to fetch
                {
                $start = $res.count
                $count = $res.total - $res.count
                
                $UriSuffix = $SuffixChar + "start=" + $start + "&count=" + $count
                $FullUri += $UriSuffix
                write-debug "FullUri is $FullUri" 
                $res2 = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res2"
                $res.members += $res2.members     
                }          
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        } 
        If ($ProjectId) {
            $ResultSet = $res
        }
        else {
            $ResultSet = $res.members
        }
        $ResultType = 'hpeonesphere.BillingAccount'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}

function ValidateObjectType
{ 
Param 
(
    [Parameter (Mandatory)]
    [Object]$InputObject,

    [Parameter (Mandatory)]
    [String]$ObjectType

)

    Process 
    {
        if (($InputObject.uri).Contains($ObjectType)) {
            return $true
        } else {
            return $false
        }
    }
}

<#
.SYNOPSIS
Deletes User from OneSphere Management portal
.PARAMETER InputObject
user object to delete
.DESCRIPTION
Deletes User from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSUser -user $myuser
.Notes
    NAME:  REMOVE-HPEOSUser
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSUser
{

   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('user')]
        [Object]$InputObject

    )

    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }
    Process
        {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "user")){
                throw "Object is not a valid user!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $Username = $InputObject.name
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    Write-verbose "User $UserName deleted successfully"
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal" 
                    $PSCmdlet.ThrowTerminatingError($_)
                    }   
            }
        }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}


<#
.SYNOPSIS
Deletes Project from OneSphere Management portal
.PARAMETER InputObject
Project object to delete
.DESCRIPTION
Deletes Project from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSProject -project $myProject
.Notes
    NAME:  REMOVE-HPEOSProject
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSProject
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('Project')]
        [Object]$InputObject

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
        {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "project")){
                throw "Object is not a valid project!"
                }
                    
            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
            
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $ProjectName =  $InputObject.name
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    Write-verbose "Project $ProjectName deleted successfully"
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal" 
                    $PSCmdlet.ThrowTerminatingError($_)
                    }
                }   
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Deletes TagKey from OneSphere Management portal
.PARAMETER InputObject
TagKey object to delete
.DESCRIPTION
Deletes TagKey from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSTagKey -TagKey $myTagKey
.Notes
    NAME:  REMOVE-HPEOSTagKey
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSTagKey
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('TagKey')]
        [Object]$InputObject

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
        {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "tag-key")){
                throw "Object is not a valid tag-key!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"
                    $Objectname = $InputObject.name
                    Write-verbose "Tagkey $Objectname deleted successfully"  
                    }
                catch 
                    {
                    Write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_) 
                    }   
                }
            }
        else 
            {
            throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Deletes Tag from OneSphere Management portal
.PARAMETER InputObject
Tag object to delete
.DESCRIPTION
Deletes Tag from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSTag -Tag $myTag
.Notes
    NAME:  REMOVE-HPEOSTag
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSTag
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('Tag')]
        [Object]$InputObject

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
        {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "tags")){
                Throw "Object is not a valid tag!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res" 
                    $Objectname = $InputObject.name
                    Write-verbose "Tag $Objectname deleted successfully"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }
                }   
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Deletes Membership from OneSphere Management portal
.PARAMETER InputObject
Membership object to delete
.DESCRIPTION
Deletes Membership from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSMembership -Membership $myMembership
.Notes
    NAME:  REMOVE-HPEOSMembership
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSMembership
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('Membership')]
        [Object]$InputObject

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        }
    }

    Process
    {
    if ($InputObject)
        {
        if (!(ValidateObjectType $InputObject "membership")){
            Throw "Object is not a valid membership!"
        } 

        $body = @{
            "userUri" = $InputObject.userUri
            "roleUri" = $InputObject.roleUri
            "projectUri" = $InputObject.ProjectUri
        }

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:MembershipUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        if ($PSCmdlet.ShouldProcess($body)) {
            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method DELETE
                write-debug "Response from API call: $res"  
                }
            catch 
                {
                write-verbose  "Error deleting object from OneSphere portal"
                $PSCmdlet.ThrowTerminatingError($_)
                }   
            }
        }
    else 
        {
        Throw "No object specified for deletion"
        }   
    }
}

<#
.SYNOPSIS
Deletes Zone from OneSphere Management portal
.PARAMETER InputObject
Zone object to delete
.PARAMETER Force
Optional: force deletion of object
.DESCRIPTION
Deletes Zone from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSZone -Zone $myZone
.EXAMPLE
REMOVE-HPEOSZone -Zone $myZone -force
.Notes
    NAME:  REMOVE-HPEOSZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSZone
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('zone')]
        [Object]$InputObject,

        [Parameter (Mandatory=$false)]
		[ValidateNotNullorEmpty()]
        [switch]$Force

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        }
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "zone")){
                Throw "Object is not a valid zone!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 

            if ($Force) {
                $FullUriSuffix += "?force=true"  
                }
    
            $FullUri = $FullUri + $FullUriSuffix  
            write-debug "FullUri is $FullUri"  

            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }
                }   
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Deletes Region from OneSphere Management portal
.PARAMETER InputObject
Region object to delete
.PARAMETER Force
Optional: force deletion of object
.DESCRIPTION
Deletes Region from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSRegion -region $myRegion 
.EXAMPLE
REMOVE-HPEOSRegion -region $myRegion -force
.Notes
    NAME:  REMOVE-HPEOSRegion
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSRegion
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('region')]
        [Object]$InputObject,

        [Parameter (Mandatory=$false)]
		[ValidateNotNullorEmpty()]
        [switch]$Force

    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "region")){
                Throw "Object is not a valid region!"
                }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            
            if ($Force) {
                $FullUriSuffix += "?force=true"  
                }
    
            $FullUri = $FullUri + $FullUriSuffix  
            write-debug "FullUri is $FullUri"  

            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }
                }   
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Deletes Provider from OneSphere Management portal
.PARAMETER InputObject
Provider object to delete
.DESCRIPTION
Deletes Provider from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSProvider - $myProvider
.Notes
    NAME:  REMOVE-HPEOSProvider
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSProvider
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('provider')]
        [Object]$InputObject
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "provider")){
                Throw "Object is not a valid provider!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }  
                } 
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Adds User to OneSphere Management portal
.PARAMETER UserName
user name
.PARAMETER UserEmail
user email
.PARAMETER UserRole
user role
.PARAMETER UserPassword
user password
.DESCRIPTION
Adds User to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSUser
.EXAMPLE
ADD-HPEOSUser -name didier -email didier.lalli@hpe.com -password supersecret123! -role administrator 
.Notes
    NAME:  ADD-HPEOSUser
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSUser
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$UserName,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('password')]
		[Object]$UserPassword,

        [Parameter (Mandatory)]
        [ValidateSet("administrator","analyst","consumer","project-creator")]
        [alias ('role')]
		[string]$UserRole,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('email')]
		[string]$UserEmail
    )

    begin 
        {
        if (!$Global:HPEOSPortalConnected )
            {
            Throw "Not connected to any OneSphere portal"                
            }
        }

    Process
        {

        $body = @{
            "email" = $UserEmail
            "name" = $UserName
            "password" = $UserPassword
            "role" = $UserRole
        }
        
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:UserUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "User $UserName added successfully"
            write-output $res
            }
        catch
            {
            write-verbose  "Failed to create user"
            $PSCmdlet.ThrowTerminatingError($_)
            }   
        }   
}

<#
.SYNOPSIS
Adds Project to OneSphere Management portal
.PARAMETER ProjectName
Project name
.PARAMETER ProjectDescription
Project description
.PARAMETER ProjectTags
Project tags
.DESCRIPTION
Adds Project to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSProject
.EXAMPLE
Add-HPEOSProject -name DidierAPITest2 -description "Didier Testing API" -tags production,Off-Premise,gold
.Notes
    NAME:  ADD-HPEOSProject
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSProject
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$ProjectName,

        [Parameter (Mandatory=$False)]
        [alias ('description')]
		[String]$ProjectDescription,

        [Parameter (Mandatory=$False)]
		[ValidateNotNullorEmpty()]
        [alias ('tags')]
        [String[]]$ProjectTags 
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        # Build list of tagUris instead of tag name (if any)
        $tagUris=[System.Collections.ArrayList]@()
        if ($ProjectTags)
            {
            $TagList=get-HPEOStag
            
            foreach ($tag in $ProjectTags) {
                $taguri = $TagList | where-object Name -eq $tag | select-object uri 
                if (@($taguri).length -eq 1) {
                    [void]$tagUris.Add($taguri[0].uri)
                    }
                }
            }   

        $body = @{
            "name" = $ProjectName
            "description" = $ProjectDescription
            "tagUris" =  [string[]]$tagUris 
        }

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:ProjectUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Project $ProjectName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Project"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}
    
<#
.SYNOPSIS
Adds Membership to OneSphere Management portal
.PARAMETER MembershipUser
Membership user
.PARAMETER MembershipRole
Membership role
.PARAMETER MembershipProject
Membership Project
.DESCRIPTION
Adds Membership to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSMembership
.EXAMPLE
Add-HPEOSMembership -user $myUser -role $myRole -project $myProject
.Notes
    NAME:  ADD-HPEOSMembership
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSMembership
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('user')]
		[Object]$MembershipUser,

        [Parameter (Mandatory)]
        [alias ('role')]
		[Object]$MembershipRole,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('Project')]
        [Object[]]$MembershipProject
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "userUri" = $MembershipUser.uri
            "membershipRoleUri" = $MembershipRole.uri
            "projectUri" = $MembershipProject.uri 
        }

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:MembershipUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Membership added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Membership"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Adds Zone to OneSphere Management portal
.PARAMETER ZoneName
Zone name
.PARAMETER ZoneRegion
Zone region
.PARAMETER ZoneProvider
Zone provider
.PARAMETER ZoneType
Zone type 
.DESCRIPTION
Adds Zone to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSZone
.EXAMPLE
Add-HPEOSZone -name MyNewZone -Region $myRegion -provider $myProvider -type $myZoneType
.Notes
    NAME:  ADD-HPEOSZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSZone
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$ZoneName,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('region')]
        [Object]$ZoneRegion,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('provider')]
		[Object]$ZoneProvider,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('type')]
        [Object]$ZoneType
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $ZoneName
            "providerUri" = $ZoneProvider.uri
            "regionUri" = $ZoneRegion.uri
            "zoneTypeUri" = $ZoneType.uri
        }
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:ZoneUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Zone $ZoneName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}
<#
.SYNOPSIS
Adds a Provider to OneSphere Management portal
.PARAMETER Providername
Provider name
.PARAMETER ProviderType
Provider type
.PARAMETER Disabled
Creates provider as disabled
.DESCRIPTION
Adds Provider to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Add-HPEOSProvider -name MyNewProvider -type $myProviderType
.EXAMPLE
Add-HPEOSProvider -name MyNewProvider -type $myProviderType -disabled

.Notes
    NAME:  ADD-HPEOSProvider
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSProvider
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$ProviderName,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('type')]
        [Object]$ProviderType,

        [Parameter (Mandatory=$false)]
        [Switch]$Disabled
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        if ($Disabled) {
            $ProviderState = "Disabled"
        }
        else {
            $ProviderState = "Enabled"
        }

        $body = @{
            "name" = $ProviderName
            "providerTypeUri" = $ProviderType.uri
            "state" = $ProviderState
        }
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:ProviderUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Provider $ProviderName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Provider"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Adds a Region to OneSphere Management portal
.PARAMETER Providername
Region name
.PARAMETER Provider
Region Provider 
.PARAMETER Latitude
Region latitude
.PARAMETER Longitude
Region longitude
.DESCRIPTION
Adds Region to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Add-HPEOSRegion -name MyNewRegion -provider $myProvider -lat 45 -long 20
.EXAMPLE
Add-HPEOSRegion -name MyNewRegion -provider $myProvider

.Notes
    NAME:  ADD-HPEOSRegion
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSRegion
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$RegionName,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [Object]$Provider,

        [Parameter (Mandatory=$false)]
        [alias ('lat')]
        [int]$Latitude = 0,

        [Parameter (Mandatory=$false)]
        [alias ('long')]
        [int]$Longitude = 0
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {   
        $body = @{
            "name" = $RegionName
            "providerUri" = $Provider.uri
            "location" = @{
                  "latitude" = $Latitude
                  "longitude" = $Longitude
                }
            }
        
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:RegionUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Region $RegionName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Region"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Adds Catalog to OneSphere Management portal
.PARAMETER CatalogName
Catalog name
.PARAMETER CatalogUrl
Catalog url
.PARAMETER CatalogType
Catalog Type
.DESCRIPTION
Adds Catalog to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSCatalog
.EXAMPLE
Add-HPEOSCatalog -name NewCatalog -url $myCatalogUrl
.Notes
    NAME:  ADD-HPEOSCatalog
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSCatalog
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$CatalogName,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('url')]
        [String]$CatalogUrl,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [alias ('type')]
        [Object]$CatalogType

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $CatalogName
            "URL" = $CatalogUrl
            "catalogTypeUri" = $CatalogType.uri
        }
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:CatalogUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Catalog added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Catalog" 
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify Catalog properties in OneSphere Management portal
.PARAMETER Catalog
Catalog to change
.PARAMETER state
New state 
.DESCRIPTION
Modify Catalog properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSCatalog -catalog $myCatalog -state disabled 
.Notes
    NAME:  SET-HPEOSCatalog
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSCatalog
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Catalog,

        [Parameter (Mandatory)]
        [ValidateSet("Enabled","Disabled")]
		[string]$State

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "state" = $State
        }
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Catalog.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method PATCH
            Write-verbose "Catalog patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch Catalog" 
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify Network properties in OneSphere Management portal
.PARAMETER Network
Network to change
.PARAMETER Projects
Project to grant access to
.DESCRIPTION
Modify Network properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSNetwork -projects $myProject1
.EXAMPLE
SET-HPEOSNetwork -projects $myProject1,$myProject2 
.Notes
    NAME:  SET-HPEOSNetwork
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSNetwork
{

   	[CmdletBinding (DefaultParameterSetName="Set")]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Network,

        [Parameter (Mandatory, ParameterSetName = "Set")]
        [ValidateNotNullorEmpty()]
        [alias ('Add')]
        [Object]$Project,

        [Parameter (Mandatory, ParameterSetName = "Unset")]
        [ValidateNotNullorEmpty()]
        [alias ('Remove')]
        [Object]$NoProject
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        If ($Project){
            $body = @(
                @{
                op = $Script:PatchOperationAdd
                path = "projectUris"
                value = $Project.uri 
                }
        )
        }
        else {
            $body = @(
                @{
                op = $Script:PatchOperationRemove
                path = "projectUris"
                value = $NoProject.uri 
                }
        )
        }

        $CustomHeaders = @{}
        $CustomHeaders["Accept"] = "application/json"
        $CustomHeaders["Content-Type"] = "application/json-patch+json"
        $CustomHeaders["Authorization"] = $Global:HPEOSHeaders["Authorization"]

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Network.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $CustomHeaders -body $jsonbody -Method PATCH
            Write-verbose "Network patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch network "
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify Catalog properties in OneSphere Management portal
.PARAMETER Catalog
Catalog to change
.PARAMETER state
New state 
.DESCRIPTION
Modify Catalog properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSCatalog -catalog $myCatalog -state disabled 
.Notes
    NAME:  SET-HPEOSCatalog
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSCatalog
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Catalog,

        [Parameter (Mandatory)]
        [ValidateSet("Enabled","Disabled")]
		[string]$State

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "state" = $State
        }
     
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Catalog.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method PATCH
            Write-verbose "Catalog patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch Catalog" 
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify Zone properties in OneSphere Management portal
.PARAMETER Zone
Zone to change
.PARAMETER Operation
Type of operation
.PARAMETER Field
Field to set for operation
.PARAMETER Value
Field to set for operation
.DESCRIPTION
Modify Zone properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSZone -zone $myZone -op add -field "resourceCapacity" -value 100
.Notes
    NAME:  SET-HPEOSZone
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSZone
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Zone,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [ValidateSet("add","remove","replace")]
        [string]$Operation,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Field,
        
        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Value
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @(
                @{
                op = $Operation
                path = $Field
                value = $Value 
                }
            )
        
                
        $CustomHeaders = @{}
        $CustomHeaders["Accept"] = "application/json"
        $CustomHeaders["Content-Type"] = "application/json-patch+json"
        $CustomHeaders["Authorization"] = $Global:HPEOSHeaders["Authorization"]

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Zone.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $CustomHeaders -body $jsonbody -Method PATCH
            Write-verbose "Zone patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch zone"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify provider properties in OneSphere Management portal
.PARAMETER Provider
Provider to change
.PARAMETER Operation
Type of operation
.PARAMETER Field
Field to set for operation
.PARAMETER Value
Field to set for operation
.DESCRIPTION
Modify provider properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSprovider -provider $myprovider -op replace -field accessKey -value JAHDTEGJFK
.Notes
    NAME:  SET-HPEOSprovider
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSprovider
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Provider,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [ValidateSet("add","remove","replace")]
        [string]$Operation,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Field,
        
        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Value
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @(
                @{
                op = $Operation
                path = $Field
                value = $Value 
                }
            )
        
        $CustomHeaders = @{}
        $CustomHeaders["Accept"] = "application/json"
        $CustomHeaders["Content-Type"] = "application/json-patch+json"
        $CustomHeaders["Authorization"] = $Global:HPEOSHeaders["Authorization"]

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Provider.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $CustomHeaders -body $jsonbody -Method PATCH
            Write-verbose "Provider patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch provider"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}

<#
.SYNOPSIS
Modify Region properties in OneSphere Management portal
.PARAMETER Region
Region to change
.PARAMETER Operation
Type of operation
.PARAMETER Field
Field to set for operation
.PARAMETER Value
Field to set for operation
.DESCRIPTION
Modify Region properties in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SET-HPEOSRegion -Region $myRegion -op replace -field name -value "New York City"
.Notes
    NAME:  SET-HPEOSRegion
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Set-HPEOSRegion
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
        [ValidateNotNullorEmpty()]
        [Object]$Region,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [ValidateSet("add","remove","replace")]
        [string]$Operation,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Field,
        
        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Value
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $body = @(
                @{
                op = $Operation
                path = $Field
                value = $Value 
                }
            )
    
        $CustomHeaders = @{}
        $CustomHeaders["Accept"] = "application/json"
        $CustomHeaders["Content-Type"] = "application/json-patch+json"
        $CustomHeaders["Authorization"] = $Global:HPEOSHeaders["Authorization"]

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Region.uri
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = Invoke-RestMethod -Uri $FullUri -Headers $CustomHeaders -body $jsonbody -Method PATCH
            Write-verbose "Region patched successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to patch Region"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}


<#
.SYNOPSIS
Deletes Catalog from OneSphere Management portal
.PARAMETER InputObject
Catalog object to delete
.DESCRIPTION
Deletes Catalog from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSCatalog - $myCatalog
.Notes
    NAME:  REMOVE-HPEOSCatalog
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSCatalog
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('catalog')]
        [Object]$InputObject
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "catalog")){
                Throw "Object is not a valid catalog!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
            
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }
                }   
            }
        else 
            {
            Write-Verbose "No object specified for deletion"
            $PSCmdlet.ThrowTerminatingError($_)
            }   
    }
}


<#
.SYNOPSIS
Adds Deployment to OneSphere Management portal
.PARAMETER DeploymentName
Deployment name
.PARAMETER Project
Project to deploy to
.PARAMETER Service
Service to deploy
.PARAMETER VirtualMachineProfile
VirtualMachineProfile to deploy
.PARAMETER Networks
List of Networks to connect to
.PARAMETER Zone
Optional: Zone to deploy to
.PARAMETER Region
Optional: Region to deploy to
.PARAMETER Key
Optional: Public key to pass to deployed instance
.PARAMETER UserData
Optional: User data to pass to deployed instance (cloud-init)
.PARAMETER NeedExternalIP
Optional: If External IP is required 
.DESCRIPTION
Adds Deployment to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Add-HPEOSDeployment -DeploymentName $VMname -Project $HOLProjObj -Service $HOLservice -VirtualMachineProfile $VMprofile -Zone $HOLprivZone -Networks $HOLnetworkObj -NeedExternalIp
.Notes
    NAME: ADD-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 

.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$DeploymentName,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]  
		[Object]$Project,
        
        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]    
        [Object]$Service, 

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]  
        [Object]$VirtualMachineProfile,

        [Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]  
		[Object[]]$Networks,
        
		[Parameter (Mandatory=$false)]
        [ValidateNotNullorEmpty()]    
        [Object]$Zone, 

        [Parameter (Mandatory=$false)]
        [ValidateNotNullorEmpty()]    
        [Object]$Region, 
        
        [Parameter (Mandatory=$false)]
		[ValidateNotNullorEmpty()]
        [alias ('key')]
        [string]$PublicKey,

        [Parameter (Mandatory=$false)]
		[ValidateNotNullorEmpty()]
        [string]$UserData,

        [Parameter (Mandatory=$false)]
		[switch]$NeedExternalIp
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }



    Process
        {
        if ($NeedExternalIp) {
            $SetExternalIp = $true
        } else {
            $SetExternalIp = $false
        }

        $body = @{
            "assignExternalIP" = $SetExternalIp
            "publicKey" = $PublicKey
            "name" = $DeploymentName
            "zoneUri" = $Zone.uri
            "projectUri" = $Project.uri
            "serviceUri" = $Service.uri
            "regionUri" = $Region.uri
            "userData" = $UserData
            "virtualMachineProfileUri" = $VirtualMachineProfile.uri
            }
     
        $networkbody = @()
        foreach ($net in $Networks)
            {
                $item = @{"networkUri" = $net.uri}
                $networkbody += $item
            }

        $body.Add("networks", $networkbody)

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:DeploymentUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Deployment added successfully"
            write-output $res
            }
        catch
            {
            write-verbose  "Failed to create deployment" 
            $PSCmdlet.ThrowTerminatingError($_)
            }   
        }
}

function ActionForDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [string]$Action,

        [Parameter (Mandatory=$False)]
		[boolean]$Force
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {

        $body = @{
                "force" = $Force
                "type" = $Action
        }

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Deployment.uri + "/actions"
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody
        
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Deployment $Action was successfully"
        }
        catch
        {
            write-verbose  "Failed to $Action deployment"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}


<#
.SYNOPSIS
Stops a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to stop 
.PARAMETER Force
Optional force stop
.DESCRIPTION
Stops a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
STOP-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  Stop-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Stop-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentStopAction -Force $Force
            
    }
}


<#
.SYNOPSIS
Starts a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to start 
.PARAMETER Force
Optional force start 
.DESCRIPTION
Starts a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
START-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  START-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Start-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentStartAction -Force $Force
        
    }
}


<#
.SYNOPSIS
Suspends a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to suspend 
.PARAMETER Force
Optional force suspend 
.DESCRIPTION
Suspends a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SUSPEND-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  SUSPEND-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Suspend-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentSuspendAction -Force $Force
        
    }
}


<#
.SYNOPSIS
Restarts a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to restart 
.PARAMETER Force
Optional force restart 
.DESCRIPTION
Restarts a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Restart-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  RESTART-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Restart-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentRestartAction -Force $Force
        
    }
}


<#
.SYNOPSIS
Suspends a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to suspend 
.PARAMETER Force
Optional force suspend 
.DESCRIPTION
Suspends a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
SUSPEND-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  SUSPEND-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Suspend-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentSuspendAction -Force $Force
        
    }
}



<#
.SYNOPSIS
Resumes a deployment in OneSphere Management portal
.PARAMETER Deployment
Deployment to Resume 
.PARAMETER Force
Optional force Resume 
.DESCRIPTION
Resumes a deployement in OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Resume-HPEOSDeployment -Deployment $my Deployement
.Notes
    NAME:  Resume-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Resume-HPEOSDeployment
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment,
        
        [Parameter (Mandatory=$False)]
		[switch]$Force
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        ActionForDeployment -deployment $Deployment -action $Script:DeploymentResumeAction -Force $Force
        
    }
}


<#
.SYNOPSIS
Get Deployment Console from OneSphere Management portal
.PARAMETER Deployment
Deployment 
.DESCRIPTION
gets Deployment console link from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Get-HPEOSDeploymentConsole myDeployment 
.Notes
    NAME:  GET-HPEOSDeploymentConsole
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function GET-HPEOSDeploymentConsole
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Deployment
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $FullUri = $Global:HPEOSHostname + $Deployment.uri + "/console"
        write-debug "FullUri is $FullUri"                 
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to get deployment console" 
            Throw
        }   
    }   
}

<#
.SYNOPSIS
Get Membership roles  from OneSphere Management portal
.DESCRIPTION
Get Membership roles from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Get-HPEOSMembershipRole 
.Notes
    NAME:  Get-HPEOSMembershipRole 
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSMembershipRole 
{

   	[CmdletBinding ()]
	Param 
	(

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {
        $FullUri = $Global:HPEOSHostname + $script:MembershipRoleUri
        write-debug "FullUri is $FullUri"                 
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
            write-debug "Response from API call: $res"  
        }
        catch
        {
            write-verbose  "Error retrieving details from OneSphere portal" 
            $PSCmdlet.ThrowTerminatingError($_)
        }  
        
        $ResultSet = $res.members
        $ResultType = 'hpeonesphere.MembershipRole'
    }
    End
    {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
    }
}   



<#
.SYNOPSIS
Deletes Deployment from OneSphere Management portal
.PARAMETER InputObject
Deployment object to delete
.DESCRIPTION
Deletes Deployment from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSDeployment- $myDeployment
.Notes
    NAME:  REMOVE-HPEOSDeployment
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSDeployment
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('deployment')]
        [Object]$InputObject
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "deployment")){
                Throw "Object is not a valid deployment!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }  
                } 
            }
        else 
            {
            Write-Verbose "No object specified for deletion"
            $PSCmdlet.ThrowTerminatingError($_)
            }   
        }
}



<#
.SYNOPSIS
Adds Volume to OneSphere Management portal
.PARAMETER VolumeName
Volume name
.PARAMETER VolumeSize
Volume size
.PARAMETER Zone
Volume zone
.PARAMETER Project
Volume name
.DESCRIPTION
Adds a volume to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
Add-HPEOSVolume -name myNewVolumeName -size 3GB -zone $MyZone -project $myProject 
.Notes
    NAME:  ADD-HPEOSVolume
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSVolume
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$VolumeName,

        [Parameter (Mandatory=$false)]
		[ValidateNotNullorEmpty()]
        [alias ('size')]
        [int]$VolumeSize = 2,

		[Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]    
        [Object]$Zone, 
        
		[Parameter (Mandatory)]
        [ValidateNotNullorEmpty()]  
		[Object]$Project

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $VolumeName
            "sizeGiB" = $VolumeSize 
            "zoneUri" = $Zone.uri
            "projectUri" = $Project.uri
        }

        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $script:VolumeUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Volume created successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create volume" 
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}


<#
.SYNOPSIS
Deletes Volume from OneSphere Management portal
.PARAMETER InputObject
Volume object to delete
.DESCRIPTION
Deletes Volume from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
REMOVE-HPEOSVolume- $myVolume
.Notes
    NAME:  REMOVE-HPEOSVolume
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Remove-HPEOSVolume
{
   	[CmdletBinding (SupportsShouldProcess=$True)]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Alias ('volume')]
        [Object]$InputObject
    )
    Begin
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"
        } 
    }

    Process
    {
        if ($InputObject)
            {
            if (!(ValidateObjectType $InputObject "volume")){
                Throw "Object is not a valid volume!"
            }

            $FullUri = $Global:HPEOSHostname + $InputObject.uri 
            write-debug "FullUri is $FullUri"  
    
            if ($PSCmdlet.ShouldProcess($InputObject.name)) {                
                try {
                    $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method DELETE
                    write-debug "Response from API call: $res"  
                    }
                catch 
                    {
                    write-verbose  "Error deleting object from OneSphere portal"
                    $PSCmdlet.ThrowTerminatingError($_)
                    }   
                }
            }
        else 
            {
            Throw "No object specified for deletion"
            }   
        }
}

<#
.SYNOPSIS
Adds TagKey to OneSphere Management portal
.PARAMETER TagKeyName
TagKey name
.DESCRIPTION
Adds TagKey to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSTagKey
.EXAMPLE
Add-HPEOSTagKey -name NewTagKey 
.Notes
    NAME:  ADD-HPEOSTagKey
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSTagKey
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$TagKeyName
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $TagKeyName
        }
                
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:TagKeyUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "TagKey $TageKeyName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose "Failed to create TagKey"
            $PSCmdlet.ThrowTerminatingError($_) 
        }   
    }   
}

<#
.SYNOPSIS
Adds Tag to OneSphere Management portal
.PARAMETER TagName
Tag name
.PARAMETER TagKey
TagKey object
.DESCRIPTION
Adds Tag to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSTag
.EXAMPLE
Add-HPEOSTag -name NewTag 
.Notes
    NAME:  ADD-HPEOSTag
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSTag
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$TagName,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
		[Object]$TagKey

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $TagName
            "tagKeyUri" = $TagKey.uri
        }
          
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:TagUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Tag $TageName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Tag"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}


<#
.SYNOPSIS
Adds a billing account to OneSphere Management portal
.PARAMETER BillingAccountName
Billing account name
.DESCRIPTION
Adds billing account to OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
ADD-HPEOSBillingAccount
.EXAMPLE
Add-HPEOSBillingAccount -name Newaccount
.Notes
    NAME:  ADD-HPEOSBillingAccount
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Add-HPEOSBillingAccount
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
        [alias ('name')]
		[string]$BillingAccountName,

        [Parameter (Mandatory)]
		[ValidateNotNullorEmpty()]
		[Object]$TagKey

    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $body = @{
            "name" = $TagName
            "tagKeyUri" = $TagKey.uri
        }
          
        $jsonbody = ConvertTo-Json -InputObject $body
        $FullUri = $Global:HPEOSHostname + $Script:TagUri 
        write-debug "FullUri is $FullUri"                 
        write-debug $jsonbody

        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method POST
            Write-verbose "Tag $TageName added successfully"
            write-output $res
        }
        catch
        {
            write-verbose  "Failed to create Tag"
            $PSCmdlet.ThrowTerminatingError($_)
        }   
    }   
}




<#
.SYNOPSIS
Wait for object state to become enabled
.PARAMETER Object
Object to query
.PARAMETER Timeout
Optional timeout in seconds
.DESCRIPTION
Queries state property of object and check if state is enabled sleep if not. Assumes portal is already connected
.EXAMPLE
Wait-HPEOSObjectEnabled $myObject
.Notes
    NAME:  Wait-HPEOSObjectEnabled
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Wait-HPEOSObjectEnabled
{

   	[CmdletBinding ()]
	Param 
	(
		[Parameter (Mandatory, ValueFromPipeline)]
		[ValidateNotNullorEmpty()]
        [Object]$Obj,
        
        [Parameter (Mandatory=$False)]
		[int]$Timeout
    )


    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
    {

        $FullUri = $Global:HPEOSHostname + $Obj.uri
        write-debug "FullUri is $FullUri"                 

        try {
            $Timer=0
            do {
                write-verbose $Timer  
                start-sleep 5
                $Timer += 5
                If ($Timer -eq $Timeout){
                    break;
                }
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method GET
            } while ($res.state -ne "Enabled")
        }
        catch
        {
            write-verbose  "Error getting object from OneSphere portal"
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }   
    End
    {
        if ($res.state -eq "Enabled"){
            $Result = $true
        } 
        else {
            $Result = $false
        } 
        
        write-output $Result         
    }  
}

<#
.SYNOPSIS
Retrieves metrics about resources from OneSphere Management portal
.PARAMETER Resource
.PARAMETER Category
.PARAMETER Query
.PARAMETER MetricName
.PARAMETER PeriodStart
.PARAMETER Period
.PARAMETER PeriodCount
.PARAMETER ResultStart
.PARAMETER ResultCount
.PARAMETER Full
.DESCRIPTION
Retrieves metrics about resources from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSMetric -ResourceUri /rest/Projects/85609a9e-31f5-4c7b-bd54-1ba50136bdf6 -start 2017-09-01T00:00:00Z -period hour -MetricName resource.cores.allocation  
.EXAMPLE
GET-HPEOSMetric -Category regions -name score.overall -Period hour -PeriodCount 1
.Notes
    NAME:  GET-HPEOSMetric
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSMetric
{

   	[CmdletBinding ()]
	Param 
	(
        [Parameter (Mandatory, ValueFromPipeline, ParameterSetName = "Resource")]
		[ValidateNotNullorEmpty()]
		[object[]]$Resource,

        [Parameter (Mandatory, ParameterSetName = "Category")]
		[ValidateSet('providers','regions','zones','projects','provider-services','deployments')]
		[string[]]$Category,

        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
		[ValidateNotNullorEmpty()]
		[string]$Query,

        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
		[ValidateNotNullorEmpty()]
        [string]$GroupBy,
        
        [Parameter (Mandatory, ParameterSetName = "Category")]
        [Parameter (Mandatory, ParameterSetName = "Resource")]
        [ValidateNotNullorEmpty()]
        [alias ('name')]
		[string[]]$MetricName,

        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
        [Parameter (Mandatory=$false, ParameterSetName = "Resource")]
		[ValidateNotNullorEmpty()]
        [alias ('start')]
        [string]$PeriodStart,
        
        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
        [Parameter (Mandatory=$false, ParameterSetName = "Resource")]
		[ValidateSet('month', 'day', 'hour')]
        [string]$Period,
        
        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
        [Parameter (Mandatory=$false, ParameterSetName = "Resource")]
		[ValidateNotNullorEmpty()]
        [alias ('count')]
        [int]$PeriodCount,

        [Parameter (Mandatory=$false, ParameterSetName = "Category")]
        [Parameter (Mandatory=$false, ParameterSetName = "Resource")]
		[ValidateNotNullorEmpty()]
        [switch]$Full
    )

    begin 
    {
    if (!$Global:HPEOSPortalConnected )
        {
        Throw "Not connected to any OneSphere portal"                
        }
    }

    Process
        {
        $FullUri = $Global:HPEOSHostname + $Script:MetricUri 
        $UrlFilter = "?"

        foreach($res in $Resource)
            {   
            $UrlFilter += "&resourceUri=" + $res.uri     
            }

        foreach($res in $Category)
            {   
            $UrlFilter += "&category=" + $res     
            }

        if ($Query)
            {
            # Format is uri=value, need to turn into &query={uri}+EQ+{value}
            $kv = $Query.Split('=') 
            $UrlFilter += "&query=" + $kv[0] + "+EQ+" + $kv[1] 
            }

        foreach($res in $MetricName)
            {   
            $UrlFilter += "&name=" + $res     
            }

        if ($PeriodStart)
            {
            $UrlFilter += "&periodStart=" + $PeriodStart     
            }

        if ($Period)
            {
            $UrlFilter += "&period=" + $Period     
            }

        if ($PeriodCount)
            {
            $UrlFilter += "&periodCount=" + $PeriodCount     
            }
            

        if ($Full) 
            {
            $UrlFilter += "&View=full"    
            $ResultType = 'hpeonesphere.MetricsFull'
            }
        else 
            {
            $ResultType = 'hpeonesphere.Metrics'
            }
 
        # Remove '?&" from UrlFilter
        $UrlFilter = $UrlFilter.replace("?&", "?")

        $FullUri += $UrlFilter
        write-debug "FullUri is $FullUri"                
        try {
            $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -body $jsonbody -Method GET
            $ResultSet = $res.members
            }
        catch
            {
            write-verbose  "Failed to retrieve Metrics"
            $PSCmdlet.ThrowTerminatingError($_)
            }
        }   
    End 
        {
        # return full list from ResultSet 
        foreach ($Result in $ResultSet)
            {
            $Result.PSObject.TypeNames.Insert(0,$ResultType)
            write-output $Result         
            }
        }   
}

<#
.SYNOPSIS
Retrieves KeyPairs from OneSphere Management portal
.PARAMETER Region
Optional: Region object to retrieve keypair for
.PARAMETER Project
Project object to retrieve keypair for
.DESCRIPTION
Retrieves Keypairs from OneSphere Management portal. Assumes portal is already connected
.EXAMPLE
GET-HPEOSKeyPair 
.EXAMPLE
GET-HPEOSKeyPair -Project $MyProject
.Notes
    NAME:  GET-HPEOSKeypair
    LASTEDIT: 
    KEYWORDS: OneSphere 
  
.Link
     http://www.hpe.com/onesphere
#>
function Get-HPEOSKeyPair
{
    [CmdletBinding()]
    Param
	(
	   [Parameter(Mandatory)]
		[Object]$Region,
     
        [Parameter(Mandatory)]
        [Object]$Project
        )

        Begin
        {
        if (!$Global:HPEOSPortalConnected )
            {
            Throw "Not connected to any OneSphere portal"
            } 
        }
    
        Process
            {
            $UrlFilter = "?regionUri=" + $Region.uri + "&projectUri=" + $Project.uri

            $FullUri = $Global:HPEOSHostname + $Script:KeyPairUri + $UrlFilter 
            write-debug "FullUri is $FullUri"                 

            try {
                $res = invoke-RestMethod -Uri $FullUri -Headers $Global:HPEOSHeaders -Method GET
                write-debug "Response from API call: $res"    
            }
            catch {
                write-verbose  "Error retrieving keypair from OneSphere portal"
                $PSCmdlet.ThrowTerminatingError($_)
            } 
        
            $ResultSet = $res
            $ResultType = 'hpeonesphere.Keypair'
            }
        
        End
        {
            # return full list from ResultSet 
            foreach ($Result in $ResultSet)
                {
                $Result.PSObject.TypeNames.Insert(0,$ResultType)
                write-output $Result         
                }
        }
}

# The GET

Export-ModuleMember -function Get-HPEOSStatus
Export-ModuleMember -function Get-HPEOSVersion
Export-ModuleMember -function Get-HPEOSProvider
Export-ModuleMember -function Get-HPEOSProviderType
Export-ModuleMember -function Get-HPEOSRegion
Export-ModuleMember -function Get-HPEOSZone
Export-ModuleMember -function Get-HPEOSZoneApplianceImage
Export-ModuleMember -function Get-HPEOSZoneTaskStatus
Export-ModuleMember -function Get-HPEOSZoneConnection
Export-ModuleMember -function Get-HPEOSZoneOsEndPoint
Export-ModuleMember -function Get-HPEOSZoneType
Export-ModuleMember -function Get-HPEOSCatalog
Export-ModuleMember -function Get-HPEOSCatalogType
Export-ModuleMember -function Get-HPEOSNetwork
Export-ModuleMember -function Get-HPEOSService
Export-ModuleMember -function Get-HPEOSServiceType
Export-ModuleMember -function Get-HPEOSVirtualMachineProfile
Export-ModuleMember -function Get-HPEOSDeployment
Export-ModuleMember -function Get-HPEOSProject
Export-ModuleMember -function Get-HPEOSMembership
Export-ModuleMember -function Get-HPEOSMembershipRole
Export-ModuleMember -function Get-HPEOSRole
Export-ModuleMember -function Get-HPEOSUser
Export-ModuleMember -function Get-HPEOSVolume
Export-ModuleMember -function Get-HPEOSTagKey
Export-ModuleMember -function Get-HPEOSTag
Export-ModuleMember -function Get-HPEOSSession
Export-ModuleMember -function GET-HPEOSMetric
Export-ModuleMember -function GET-HPEOSKeyPair
Export-ModuleMember -function GET-HPEOSConnectApp
Export-ModuleMember -function Get-HPEOSAppliance
Export-ModuleMember -function Get-HPEOSRate
Export-ModuleMember -function Get-HPEOSBillingAccount



# The DELETE
Export-ModuleMember -function Remove-HPEOSProvider
Export-ModuleMember -function Remove-HPEOSRegion
Export-ModuleMember -function Remove-HPEOSZone
Export-ModuleMember -function Remove-HPEOSUser
Export-ModuleMember -function Remove-HPEOSMembership
Export-ModuleMember -function Remove-HPEOSProject
Export-ModuleMember -function Remove-HPEOSTagKey
Export-ModuleMember -function Remove-HPEOSTag
Export-ModuleMember -function Remove-HPEOSCatalog
Export-ModuleMember -function Remove-HPEOSDeployment
Export-ModuleMember -function Remove-HPEOSVolume
Export-ModuleMember -function Disconnect-HPEOS

#The POST
Export-ModuleMember -function Connect-HPEOS
Export-ModuleMember -function Add-HPEOSUser
Export-ModuleMember -function Add-HPEOSProject
Export-ModuleMember -function Add-HPEOSMembership
Export-ModuleMember -function Add-HPEOSZone
Export-ModuleMember -function Add-HPEOSCatalog
Export-ModuleMember -function Add-HPEOSMembership
Export-ModuleMember -function Add-HPEOSTagKey
Export-ModuleMember -function Add-HPEOSTag
Export-ModuleMember -function Add-HPEOSProvider
Export-ModuleMember -function Add-HPEOSRegion
Export-ModuleMember -function Reset-HPEOSZone
Export-ModuleMember -function Reset-HPEOSPassword
Export-ModuleMember -function Set-HPEOSPassword
Export-ModuleMember -function Expand-HPEOSZoneCompute
Export-ModuleMember -function Expand-HPEOSZoneStorage
Export-ModuleMember -function Compress-HPEOSZoneCompute
Export-ModuleMember -function Compress-HPEOSZoneStorage
Export-ModuleMember -function Add-HPEOSDeployment
Export-ModuleMember -function Stop-HPEOSDeployment
Export-ModuleMember -function Start-HPEOSDeployment
Export-ModuleMember -function Resume-HPEOSDeployment
Export-ModuleMember -function Suspend-HPEOSDeployment
Export-ModuleMember -function Restart-HPEOSDeployment
Export-ModuleMember -function Get-HPEOSDeploymentConsole
Export-ModuleMember -function Add-HPEOSVolume
Export-ModuleMember -function Add-HPEOSBillingAccount


# The PATCH
Export-ModuleMember -function Set-HPEOSCatalog
Export-ModuleMember -function Set-HPEOSNetwork
Export-ModuleMember -function Set-HPEOSZone
Export-ModuleMember -function Set-HPEOSRegion
Export-ModuleMember -function Set-HPEOSProvider


# The Miscellaneous 
Export-ModuleMember -function Wait-HPEOSObjectEnabled