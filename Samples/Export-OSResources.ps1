## -------------------------------------------------------------------------------------------------------------
##
##
##      Description: Export
##
## DISCLAIMER
## The sample scripts are not supported under any HPE standard support program or service.
## The sample scripts are provided AS IS without warranty of any kind. 
## HPE further disclaims all implied warranties including, without limitation, any implied 
## warranties of merchantability or of fitness for a particular purpose. 
##
##    
## Scenario
##     	Export OneSphere resources
##	
## Description
##      The script export OneSphere resources to CSV files    
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
     Export resources from OneSphere appliance.
  
  .DESCRIPTION
	 Export resources from OneSphere appliance.
        
  .EXAMPLE

    .\ Export-OSResources.ps1  -Portal YourOneSphereUrl -Username YourOneSphereUserName -password YourOneSpherePassword -OSProjectsCSV .\Projects.csv 
        The script connects to the OneSphere appliance and exports Projects to the Projects.csv file

    .\ Export-OSResources.ps1  -Portal YourOneSphereUrl -Username YourOneSphereUserName -password YourOneSpherePassword -OSUsersCSV .\Users.csv 
    The script connects to the OneSphere appliance and exports users to the UsersCSV.csv file

   
  .PARAMETER Portal                   
    Url of the OS appliance

  .PARAMETER Username                     
    user name of the appliance

  .PARAMETER Password                 
    Users's password

  .PARAMETER All
    if present, export all resources

  .PARAMETER OSProjectsCSV
    Path to the CSV file containing Projects definition

  .PARAMETER OSUsersCSV
    Path to the CSV file containing Users definition

  
  .Notes
    NAME:  Export-OSResources
    LASTEDIT: 01/31/2018
    KEYWORDS: OS  Export
   
  .Link
     http://www.hpe.com/onesphere

 #>
  
## -------------------------------------------------------------------------------------------------------------

Param ( [string]$Portal="", 
        [string]$Username="", 
        [string]$Password="",

        [switch]$All,

        [string]$OSProjectsCSV ="",                                               #.\ExportOneSphereCSV\Projects.csv",
        [string]$OSUsersCSV =""                                                   #.\ExportOneSphereCSV\Users.csv",

        )


$Delimiter = "\"   # Delimiter for CSV profile file
$Sep       = ";"   # USe for multiple values fields
$SepChar   = '|'
$CRLF      = "`r`n"
$OpenDelim = "={"
$CloseDelim = "}" 
$CR         = "`n"
$Comma      = ','

# ------------------ Headers

$ProjectHeader           = "Name,Description,Owner,Members,Tags"
                       

$UserHeader            = "Name,Role,Email,Password"

$WarningText = @"
***WarninG***
Profile CSV file use '$Delimiter' as delimiter for CSV. 
When importing to Excel,use this character as delimiter.
***WarninG*** 

"@

## -------------------------------------------------------------------------------------------------------------
##
##                     Function Export-OSUser - Export OneSphere users
##
## -------------------------------------------------------------------------------------------------------------

Function Export-OSUser ([string]$OutFile )  
{

    $ListofUsers = Get-HPEOSUser


    foreach ($user in $ListofUsers )
    {

        $name        = $user.Name
        $role        = $user.Role
        $email       = $User.Email
		$password 	 = "***Info N/A***"        

        $ValuesArray += "$name,$role,$email,$password" + $CR
    }

    if ($ValuesArray -ne $NULL)
    {
        $a = New-Item $OutFile  -type file -force
        Set-content -Path $OutFile -Value $UserHeader
        Add-content -path $OutFile -Value $ValuesArray

    }
}

## -------------------------------------------------------------------------------------------------------------
##
##                     Function Export-OSProject - Export OneSphere Projects
##
## -------------------------------------------------------------------------------------------------------------

Function Export-OSProject ([string]$OutFile )  
{

    #$ListofProjects = Get-HPEOSProject | where name -eq "ProjectName"
	$ListofProjects = Get-HPEOSProject

    foreach ($project in $ListofProjects )
    {

        $name        = $project.Name
        $description = $project.Description 
		$tagUris		= $project.tagUris
		$owner =''
		$members =''
		
		if($tagUris){
		$tags =$tagUris.Replace("/rest/tags/","") -join $SepChar
		}
		
		$membership = Get-HPEOSMembership -Project $project
		foreach ($member in $membership )
		{

			try{
				$memberRole = Get-HPEOSMembershipRole | where id -eq $member.membershipRoleUri.SubString(23)
			}catch {
				write-verbose  "Error retrieving details from OneSphere portal"
			} 
			try{
				$user = Get-HPEOSUser -id $member.userUri.SubString(12)
			}catch {
				write-verbose  "Error retrieving details from OneSphere portal"
			} 
			
			IF(-not [string]::IsNullOrEmpty($memberRole.displayName) -and $memberRole.displayName -eq "Project Owner") {
				$owner = $user.Email
			}elseif(-not [string]::IsNullOrEmpty($memberRole.displayName) -and $memberRole.displayName -eq "Project Member"){
				$members += $user.Email + $SepChar
				}
			
		}
		IF(-not [string]::IsNullOrEmpty($members)){
			$members = $members.Substring(0,$members.Length-1)
		}
        $ValuesArray += "$name,$description,$owner,$members,$tags" + $CR
    }

    if ($ValuesArray -ne $NULL)
    {
        $a = New-Item $OutFile  -type file -force
        Set-content -Path $OutFile -Value $ProjectHeader
        Add-content -path $OutFile -Value $ValuesArray

    }

}

# -------------------------------------------------------------------------------------------------------------
#
#                  Main Entry
#
#
# -------------------------------------------------------------------------------------------------------------


       # -----------------------------------
       #    Always reload module
   

        remove-module hpeonesphere
		import-module  hpeonesphere



        # ---------------- Connect to OneSphere appliance
        #
        write-host -foreground Cyan "$CR Connect to the OneSphere appliance..."
        $secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
		$Global:mycreds = New-Object System.Management.Automation.PSCredential ($Username, $secpasswd)

		Connect-HPEOS -portal $Portal  -credentials $mycreds -verbose 

       if ($All)
       {
            $OSProjectsCSV          = ".\ExportOneSphereCSV\Projects.csv"
            $OSUsersCSV                = ".\ExportOneSphereCSV\Users.csv"
       }  
        

       # ------------------------------ 
	   
	    if (-not [string]::IsNullOrEmpty($OSProjectsCSV) )
        {
			write-host -ForegroundColor Cyan "Exporting Projects to CSV file --> $OSProjectsCSV"
            Export-OSProject -OutFile $OSProjectsCSV
        }


		 if (-not [string]::IsNullOrEmpty($OSUsersCSV) )
        {
			write-host -ForegroundColor Cyan "Exporting users to CSV file --> $OSUsersCSV"
            Export-OSUser -OutFile $OSUsersCSV
        }


        #write-host -foreground Cyan "$CR Disconnect from the OneSphere appliance..."
        #Disconnect-HPEOS

        write-host -foreground Cyan "--------------------------------------------------------------"
        write-host -foreground Cyan "The script does not export credentials of OneSphere resources. "
        write-host -foreground Cyan "If applied, review the following files to update credentials: "
        write-host -foreground Cyan "  - UsersCSV.csv"
        write-host -foreground Cyan "--------------------------------------------------------------"