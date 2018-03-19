## -------------------------------------------------------------------------------------------------------------
##
##
##      Description: Creator functions
##
## DISCLAIMER
## The sample scripts are not supported under any HPE standard support program or service.
## The sample scripts are provided AS IS without warranty of any kind. 
## HPE further disclaims all implied warranties including, without limitation, any implied 
## warranties of merchantability or of fitness for a particular purpose. 
##
##    
## Scenario
##     Automate setup of objects in OneSphere
##	
## Description
##      The script setup OneSphere resources from CSV files    
##		
##
## Input parameters:
##         Portal                      		  = Url of the onesphere appliance
##		   Username                           = User name of the appliance
##         Password                           = Users's password
##         OSProjectsCSV              		  = path to the CSV file containing Projects definition
##         OSUsersCSV                  		  = path to the CSV file containing Users definition
##
## Contact : pramod-reddy.sareddy@hpe.com
##
##
## -------------------------------------------------------------------------------------------------------------
<#
  .SYNOPSIS
     Setup resources in OneSphere appliance from CSV files.
  
  .DESCRIPTION
	 Setup resources in OneSphere appliance from CSV files.
        
  .EXAMPLE

    .\ Import-OSResources.ps1  -Portal YourOneSphereUrl -Username YourOneSphereUserName -password YourOneSpherePassword -OSProjectsCSV .\Projects.csv 
        The script connects to the OneSphere appliance and setup Projects from the Projects.csv file

    .\ Import-OSResources.ps1  -Portal YourOneSphereUrl -Username YourOneSphereUserName -password YourOneSpherePassword -OSUsersCSV .\Users.csv 
    The script connects to the OneSphere appliance and setup users from the UsersCSV.csv file

   
  .PARAMETER Portal                   
    Url of the OS appliance

  .PARAMETER Username                     
    user name of the appliance

  .PARAMETER Password                 
    Users's password


  .PARAMETER OSProjectsCSV
    Path to the CSV file containing Projects definition

  .PARAMETER OSUsersCSV
    Path to the CSV file containing Users definition

  
  .Notes
    NAME:  Import-OSResources
    LASTEDIT: 01/31/2018
    KEYWORDS: OS  Import
   
  .Link
     http://www.hpe.com/onesphere

 #>
  
## -------------------------------------------------------------------------------------------------------------
[CmdletBinding()]
Param
(
	[Parameter(Mandatory)]
    [string]$Portal,

    [Parameter(Mandatory)]
    [string]$Username,

    [Parameter(Mandatory)]
    [string]$Password,
    [string]$OSProjectsCSV    = "",
	[string]$OSUsersCSV    = "",
	[string]$sepchar = "|"

)
$ErrorActionPreference = 'Continue'
$ProjectOwner ="Project Owner"
$ProjectMember ="Project Member"

remove-module hpeonesphere
import-module  hpeonesphere

$secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
$Global:mycreds = New-Object System.Management.Automation.PSCredential ($Username, $secpasswd)

Connect-HPEOS -portal $Portal  -credentials $mycreds -verbose 
get-HPEOSstatus -verbose
write-host "This is my session token: " @(get-hpeossession).token


## -------------------------------------------------------------------------------------------------------------
##
##                     Function Create-OSProjects
##
## -------------------------------------------------------------------------------------------------------------

Function Create-OSProjects
{

<#
  .SYNOPSIS
    Configure Projects in OneSphere

  .DESCRIPTION
	Configure Projects in OneSphere

  .EXAMPLE
    Create-OSProjects.ps1  -OSProjectsCSV .\ImportOneSphereCSV\Projects.csv

  .PARAMETER OSProjectsCSV
    Name of the CSV file containing Projects definition

  .Notes
    NAME:  Create-OSProjects
    LASTEDIT: 01/31/2018
    KEYWORDS: OS Projects

  .Link
     http://www.hpe.com/onesphere

 #Requires PS -Version 3.0
 #>
Param ([string]$OSProjectsCSV =".\ImportOneSphereCSV\Projects.csv")

    if ( -not (Test-path $OSProjectsCSV))
    {
        write-host "No file specified or file $OSProjectsCSV does not exist."
        return
    }
    # Read the CSV Users file
    $tempFile = [IO.Path]::GetTempFileName()
    type $OSProjectsCSV | where { ($_ -notlike ",,,,,*") -and ($_ -notlike '"*') -and ( $_ -notlike "#*") -and ($_ -notlike ",,,#*") } > $tempfile   # Skip blank line

    $ListofProjects    = import-csv $tempfile

    foreach ($P in $ListofProjects)
    {
        $Name    = $P.Name
        $Description  = $P.Description
		$Owner    = $P.Owner
        $Members  = $P.Members
		$Tags  = $P.Tags      
		$tagValueList =@()
		
        if ( $Name)
        {
            $ThisProjectName = get-HPEOSProject | where name -eq $Name
		
            if ($ThisProjectName -eq $NULL)
            {
				write-host -foreground Cyan "-------------------------------------------------------------"
                write-host -foreground Cyan "Creating Project...." 
                write-host -foreground Cyan "-------------------------------------------------------------"

				$TagsList = $Tags.Split($SepChar)
                foreach($Tag in $TagsList)
                {
                    $Key,$Value= $Tag.Split('=')
                    if (-not $Value)
                        { $Value =""}
						
					try {	
						$ThisTag = get-HPEOStag -id $Tag
					}
					catch {
						write-verbose  "Error retrieving details from OneSphere portal"
					} 
					if($ThisTag){
						$tagValueList += $Value
					}else{
						$tagkey = get-hpeostagkey | where name -eq $Key 
						add-hpeostag -name $Value -TagKey $tagkey
						$tagValueList += $Value
					}
					
                }
			
                $Cmds = "Add-HPEOSProject -name `$Name -description `$ProjectDescription -tags `$tagValueList "

                $ThisProject = Invoke-Expression $Cmds
				
				if($ThisProject){
				write-host -foreground Cyan "-------------------------------------------------------------"
                write-host -foreground Cyan "Created Project $Name" 
                write-host -foreground Cyan "-------------------------------------------------------------"
				}
				
				if($Owner){
					try {	
						$ThisUser = Get-HPEOSUser | where email -eq $Owner
						$ThisRole = Get-HPEOSMembershipRole | where displayName -eq $ProjectOwner
						$ThisProject=GET-HPEOSProject | where name -eq $Name
					}catch {
						write-verbose  "Error retrieving details from OneSphere portal"
					} 					
					if($ThisUser -and $ThisRole){
						Add-HPEOSMembership -user $ThisUser -role $ThisRole -project $ThisProject
					}else{
						write-host -ForegroundColor Yellow "Please check user $Owner exist and try again ..."
					}
				}
				
				$MembersList = $Members.Split($SepChar)
                foreach($Member in $MembersList)
                {
					try {	
						$ThisUser = Get-HPEOSUser | where email -eq $Member
						$ThisRole = Get-HPEOSMembershipRole | where displayName -eq $ProjectMember
						$ThisProject=GET-HPEOSProject | where name -eq $Name
					}catch {
						write-verbose  "Error retrieving details from OneSphere portal"
					} 					
					if($ThisUser -and $ThisRole){
						Add-HPEOSMembership -user $ThisUser -role $ThisRole -project $ThisProject
					}else{
						write-host -ForegroundColor Yellow "Please check user $Member exist and try again ..."
					}
                } 
				
            }else{
				 write-host -ForegroundColor Yellow "Project $ProjectName already existed, Skip creating it..."
			}
        }

    }

}

## -------------------------------------------------------------------------------------------------------------
##
##                     Function Create-OSUsers
##
## -------------------------------------------------------------------------------------------------------------

Function Create-OSUser
{

<#
  .SYNOPSIS
    Configure Users in OneSphere

  .DESCRIPTION
	Configure Users in OneSphere

  .EXAMPLE
    Create-OSUsers.ps1  -OSUsersCSV .\ImportOneSphereCSV\Users.csv

  .PARAMETER OSUsersCSV
    Name of the CSV file containing Users definition

  .Notes
    NAME:  Create-OSUsers
    LASTEDIT: 01/31/2018
    KEYWORDS: OS Users

  .Link
     http://www.hpe.com/onesphere

 #>
Param ([string]$OSUsersCSV =".\ImportOneSphereCSV\Users.csv")

    if ( -not (Test-path $OSUsersCSV))
    {
        write-host "No file specified or file $OSUsersCSV does not exist."
        return
    }
    # Read the CSV Users file
    $tempFile = [IO.Path]::GetTempFileName()
    type $OSUsersCSV | where { ($_ -notlike ",,,,,*") -and ($_ -notlike '"*') -and ( $_ -notlike "#*") -and ($_ -notlike ",,,#*") } > $tempfile   # Skip blank line

    $ListofUsers    = import-csv $tempfile

    foreach ($U in $ListofUsers)
    {
        $FullName    = $U.Name
        $EmailId  = $U.Email
		$Password  = $U.Password
		$Role=$U.Role
		  

        if ( $FullName)
        {
            $ThisUserName = Get-HPEOSUser | where name -eq $FullName
            if ($ThisUserName -eq $NULL)
            {
				write-host -foreground Cyan "-------------------------------------------------------------"
                write-host -foreground Cyan "Creating User...." 
                write-host -foreground Cyan "-------------------------------------------------------------"

                $Cmds = "Add-HPEOSUser -UserName `$FullName -UserEmail `$EmailId -UserPassword  `$Password -UserRole `$Role"

                $ThisUser = Invoke-Expression $Cmds
				
				if($ThisUser){
				write-host -foreground Cyan "-------------------------------------------------------------"
                write-host -foreground Cyan "Created User $FullName" 
                write-host -foreground Cyan "-------------------------------------------------------------"
				RESET-HPEOSPassword -email $EmailId				
                }
				
            }else{
				 write-host -ForegroundColor Yellow "User $FullName already existed, Skip creating it..."
			}
        }

    }

}

 if ( ! [string]::IsNullOrEmpty($OSProjectsCSV) -and (Test-path $OSProjectsCSV) )
        {
            Create-OSProjects -OSProjectsCSV $OSProjectsCSV
        }


 if ( ! [string]::IsNullOrEmpty($OSUsersCSV) -and (Test-path $OSUsersCSV) )
        {
            Create-OSUser -OSUsersCSV $OSUsersCSV
        }
