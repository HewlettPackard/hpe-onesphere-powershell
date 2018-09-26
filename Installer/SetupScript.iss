#define use_dotnetfx46
#define use_wmf4
;#define use_dotnetfx40
;#define use_wmf3

#define MyAppName "HPE OneSphere PowerShell Library"
#define MyAppNameShort "hpeonesphere"
#define MyAppVersion "1.1"
#define MyAppPublisher "Hewlett Packard Enterprise"
#define MyAppPublisherShort "HPE"
#define MyAppURL "https://github.com/HewlettPackard/hpe-onesphere-powershell"
#define MyAppId "{d90ead4f-7fdd-4817-91f3-b304ccd56e8d}"
#define MySetupImageIco ".\Icon.ico"

[Setup]
SetupIconFile={#MySetupImageIco}
;UninstallDisplayIcon={#MySetupImageIco}
AllowNoIcons=yes
AppCopyright=© Copyright 2018 Hewlett Packard Enterprise Development LP
AppId={{#MyAppId}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppVersion={#MyAppVersion}
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64
Compression=lzma
;Changing installation directory. look at HPLabReset installer.iss for new method.
DefaultDirName="{pf}\WindowsPowerShell\Modules\{#MyAppNameShort}"
DefaultGroupName={#MyAppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
DisableReadyMemo=no
DisableReadyPage=no
LicenseFile="license.txt"
;Need to look into displaying custom message that Windows Server 2008 R2 SP1 is required for .NET 4.6 Framework.
MinVersion=0,6.1.7601
OutputBaseFilename={#MyAppName}
OutputDir=Output
PrivilegesRequired=admin
SetupLogging=yes
SolidCompression=yes
SourceDir=.
UninstallDisplayName={#MyAppName}
UsePreviousAppDir=yes
VersionInfoCompany={#MyAppPublisher}
VersionInfoVersion={#MyAppVersion}

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
; Main Library components
Source: "..\hpeonesphere.psd1"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\hpeonesphere.psm1"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\hpeonesphere.format.ps1xml"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\en-US\about_HPEOS.help.txt"; DestDir: "{app}\en-US"; Flags: ignoreversion
;Source: "..\Installer\Unattended\*"; DestDir: "{app}\Unattended"; Flags: ignoreversion recursesubdirs

; SAMPLE SCRIPTS
//Source: "..\Samples\hpeos-tests.ps1"; DestDir: "{app}\Samples"; Flags: ignoreversion
//Source: "..\Samples\Export-OSResources.ps1"; DestDir: "{app}\Samples"; Flags: ignoreversion
//Source: "..\Samples\Import-OSResources.ps1"; DestDir: "{app}\Samples"; Flags: ignoreversion
Source: "..\Samples\*"; DestDir: "{app}\Samples"; Flags: ignoreversion
Source: "..\Samples\ImportOneSphereCSV\*"; DestDir: "{app}\Samples\ImportOneSphereCSV"; Flags: ignoreversion


[Icons]
Name: "{app}\{#MyAppName}"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; WorkingDir: "%HOMEDRIVE%%HOMEPATH%"; Parameters: "-noexit -command ""& import-module hpeonesphere"""
Name: "{group}\{#MyAppName}"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; WorkingDir: "%HOMEDRIVE%%HOMEPATH%"; Parameters: "-noexit -command ""& import-module hpeonesphere"""
Name: "{commondesktop}\{#MyAppName}"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; WorkingDir: "%HOMEDRIVE%%HOMEPATH%"; Parameters: "-noexit -command ""& import-module hpeonesphere"""; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; WorkingDir: "%HOMEDRIVE%%HOMEPATH%"; Parameters: "-noexit -command ""& import-module hpeonesphere"""; Tasks: quicklaunchicon

[Run]
Filename: "notepad.exe"; Parameters: "{app}\en-US\about_HPEOS.help.txt"; Description: "Display What's New"; Flags: postinstall skipifsilent nowait

[CustomMessages]
;win_sp_title=Windows %1 Service Pack %2


[Code]
// shared code for installing the products
#include "scripts\products.iss"
// helper functions
#include "scripts\products\stringversion.iss"
#include "scripts\products\winversion.iss"
#include "scripts\products\fileversion.iss"
#include "scripts\products\dotnetfxversion.iss"
#include "scripts\products\wmfversion.iss"

// actual products
#ifdef use_wmf4
#include "scripts\products\wmf4.iss"
#endif

#ifdef use_wmf3
#include "scripts\products\wmf3.iss"
#endif

#ifdef use_iis
#include "scripts\products\iis.iss"
#endif

#ifdef use_kb835732
#include "scripts\products\kb835732.iss"
#endif

#ifdef use_msi20
#include "scripts\products\msi20.iss"
#endif
#ifdef use_msi31
#include "scripts\products\msi31.iss"
#endif
#ifdef use_msi45
#include "scripts\products\msi45.iss"
#endif

#ifdef use_ie6
#include "scripts\products\ie6.iss"
#endif

#ifdef use_dotnetfx11
#include "scripts\products\dotnetfx11.iss"
#include "scripts\products\dotnetfx11sp1.iss"
#ifdef use_dotnetfx11lp
#include "scripts\products\dotnetfx11lp.iss"
#endif
#endif

#ifdef use_dotnetfx20
#include "scripts\products\dotnetfx20.iss"
#include "scripts\products\dotnetfx20sp1.iss"
#include "scripts\products\dotnetfx20sp2.iss"
#ifdef use_dotnetfx20lp
#include "scripts\products\dotnetfx20lp.iss"
#include "scripts\products\dotnetfx20sp1lp.iss"
#include "scripts\products\dotnetfx20sp2lp.iss"
#endif
#endif

#ifdef use_dotnetfx35
//#include "scripts\products\dotnetfx35.iss"
#include "scripts\products\dotnetfx35sp1.iss"
#ifdef use_dotnetfx35lp
//#include "scripts\products\dotnetfx35lp.iss"
#include "scripts\products\dotnetfx35sp1lp.iss"
#endif
#endif

#ifdef use_dotnetfx40
#include "scripts\products\dotnetfx40client.iss"
#include "scripts\products\dotnetfx40full.iss"
#endif

#ifdef use_dotnetfx46
#include "scripts\products\dotnetfx46.iss"
#endif

#ifdef use_wic
#include "scripts\products\wic.iss"
#endif

#ifdef use_msiproduct
#include "scripts\products\msiproduct.iss"
#endif
#ifdef use_vc2005
#include "scripts\products\vcredist2005.iss"
#endif
#ifdef use_vc2008
#include "scripts\products\vcredist2008.iss"
#endif
#ifdef use_vc2010
#include "scripts\products\vcredist2010.iss"
#endif
#ifdef use_vc2012
#include "scripts\products\vcredist2012.iss"
#endif
#ifdef use_vc2013
#include "scripts\products\vcredist2013.iss"
#endif
#ifdef use_vc2015
#include "scripts\products\vcredist2015.iss"
#endif

#ifdef use_directxruntime
#include "scripts\products\directxruntime.iss"
#endif

#ifdef use_mdac28
#include "scripts\products\mdac28.iss"
#endif
#ifdef use_jet4sp8
#include "scripts\products\jet4sp8.iss"
#endif

#ifdef use_sqlcompact35sp2
#include "scripts\products\sqlcompact35sp2.iss"
#endif

#ifdef use_sql2005express
#include "scripts\products\sql2005express.iss"
#endif
#ifdef use_sql2008express
#include "scripts\products\sql2008express.iss"
#endif

var
  SelectUsersPage: TInputOptionWizardPage;
  IsUpgrade : Boolean;
  UpgradePage: TOutputMsgWizardPage;

procedure InitializeWizard();
var
  AlreadyInstalledPath: String;
  InfFile: string;
  I: Integer;
  UsersDefault: Integer;

begin

  // Determine if it is an upgrade...
  // Read from registry to know if this is a fresh install or an upgrade
  if RegQueryStringValue(HKLM, 'Software\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppId}_is1', 'Inno Setup: App Path', AlreadyInstalledPath) then
    begin

      Log('Install is an UPGRADE.');

      // So, this is an upgrade set target directory as installed before
      WizardForm.DirEdit.Text := AlreadyInstalledPath;
      // and skip SelectUsersPage
      IsUpgrade := True;

      // Create a page to be viewed instead of Ready To Install
      UpgradePage := CreateOutputMsgPage(wpReady,
        'Ready To Upgrade', 'Setup is now ready to upgrade {#MyAppName} on your computer.',
        'Click Upgrade to continue, or click Back if you want to review or change any settings.');
    end
  else
    begin
      Log('Install is a new install.');
      IsUpgrade:= False;
    end;

  if not IsUpgrade then begin
    // Determine if user is providing an answer file
    for I := 1 to ParamCount do
      if CompareText(Copy(ParamStr(I), 1, 9), '/LOADINF=') = 0 then
      begin
        InfFile := ParamStr(I);
        Delete(InfFile, 1, 9);
      end;
  
    UsersDefault := 0;
  
    if InfFile <> '' then
    begin
      Log(Format('Reading INF file %s', [InfFile]));
      UsersDefault := GetIniInt('Setup', 'Users', UsersDefault, 0, 0, ExpandFileName(InfFile));
      Log(Format('Read default "Users" selection %d', [UsersDefault]));
    end
      else
    begin
      Log('No INF file');
    end;
  
  end;

end;

function GetFileName(const AFileName: string): string;
begin
  Result := ExpandConstant('{app}\' + AFileName);
end;

function GetSubDirName(const ASubDirName: string): string;
begin
  Result := ExpandConstant('{app}\' + ASubDirName);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if( IsUpgrade and (CurPageID = UpgradePage.ID)) then begin
    WizardForm.NextButton.Caption := '&Upgrade';
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  CurrentPSModulePathValue: String;
  UpdatedPSModulePathValue: String;
  DirectoryName: String;
  ResultCode: Integer;
	UpdatePSModulePath: Boolean;
begin
  if (CurStep = ssInstall) then
  begin
    if DirExists(GetSubDirName('Classes')) then
    // if not FileExists(GetSubDirName('lib')) then 
      begin
        Log('Classes dir exists. Renaming.');
        RenameFile(GetFileName('Classes'), GetFileName('lib'));
      end
    else
      begin
        Log('Classes dir does NOT exist.');
      end;
  end;
  
  // if (CurStep = ssPostInstall) AND (Not IsUpgrade) then
	if (CurStep = ssPostInstall) AND (Not IsUpgrade) then
  begin
  
    RegQueryStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment','PSModulePath', CurrentPSModulePathValue)
    Log(Format('Original PSModulesPath: %s', [CurrentPSModulePathValue]));
    
    // Add installation path to HKLM registry
    if RegQueryStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment','PSModulePath', CurrentPSModulePathValue) then
    begin
    
      DirectoryName := ExpandConstant('{app}');
    
      if Pos(ExpandConstant('{app}'), CurrentPSModulePathValue) = 0 then 
      begin
      
				if Pos(ExpandConstant('{app}'), CurrentPSModulePathValue) = 0 then
				begin
					UpdatedPSModulePathValue := CurrentPSModulePathValue + ';' + ExpandConstant('{app}') + ';';
					UpdatePSModulePath := true;
				end;
        if Pos(ExpandConstant('{pf}') + '\WindowsPowerShell\Modules\FormatPX;', CurrentPSModulePathValue) = 0 then
				begin
          UpdatedPSModulePathValue := UpdatedPSModulePathValue + ExpandConstant('{pf}') + '\WindowsPowerShell\Modules\FormatPX;';
					UpdatePSModulePath := true;
				end;
        if Pos(ExpandConstant('{pf}') + '\WindowsPowerShell\Modules\SnippetPx;', CurrentPSModulePathValue) = 0 then
				begin
          UpdatedPSModulePathValue := UpdatedPSModulePathValue + ExpandConstant('{pf}') + '\WindowsPowerShell\Modules\SnippetPx';
					UpdatePSModulePath := true;
				end;
				
				if (UpdatePSModulePath) then
				begin
					Log(Format('Updated PSModulesPath: %s', [UpdatedPSModulePathValue]));

					RegWriteStringValue(HKLM, 'System\CurrentControlSet\Control\Session Manager\Environment','PSModulePath', UpdatedPSModulePathValue);

					Log('Added module directory location to PSModulesPath');

					Log('Updating System Environment Variable to new value');
					Exec('setx.exe', Format('PSModulePath "%s" -m', [UpdatedPSModulePathValue]), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
					
					if ResultCode > 0 then
					begin
						Log(Format('Unable to execute Setx, ResultCode: %d',[ResultCode]));
					end
					
					else 
					begin
						Log('Updated PSModulePath environment variable successfully.');
					end;
				end
				
				else
				begin
					Log(Format('Reloading System Environment Variable to original value: %s', [CurrentPSModulePathValue]));
					Exec('setx.exe', Format('PSModulePath "%s" -m', [CurrentPSModulePathValue]), '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
					
					if ResultCode > 0 then
					begin
						Log(Format('Unable to execute Setx, ResultCode: %d',[ResultCode]));
					end
					else 
					begin
						Log('Reloaded PSModulePath environment variable successfully.');
					end;
				end;
      end;
    end;  
  end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin

  if (PageID = wpReady) then begin
    if IsUpgrade then
      begin
        Result := True;
      end
    else
      begin
        Result:= False;
      end
  end;
end;

function NextButtonClick(CurPageID: Integer): boolean;
begin

  if CurPageID = wpReady then 
  begin
		if downloadMemo <> '' then 
    begin
			//change isxdl language only if it is not english because isxdl default language is already english
			if (ActiveLanguage() <> 'en') then 
      begin
				ExtractTemporaryFile(CustomMessage('isxdl_langfile'));
				isxdl_SetOption('language', ExpandConstant('{tmp}{\}') + CustomMessage('isxdl_langfile'));
			end;

			if SuppressibleMsgBox(FmtMessage(CustomMessage('depdownload_msg'), [downloadMessage]), mbConfirmation, MB_YESNO, IDYES) = IDNO then
				Result := false
			else if isxdl_DownloadFiles(StrToInt(ExpandConstant('{wizardhwnd}'))) = 0 then
				Result := false;
		end;
	end;
   Result := True;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  CurrentPSModulePathValue: String;
  UpdatedPSModulePathValue: String;
  DirectoryName: String;
  ResultCode: Integer;
begin
  if CurUninstallStep = usPostUninstall then
  begin
  
    Log('usPostUninstall');
    
    RegQueryStringValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment','PSModulePath', CurrentPSModulePathValue)
    
    if Pos(ExpandConstant('{app}'), CurrentPSModulePathValue) > 0 then
    begin
    
      UpdatedPSModulePathValue := CurrentPSModulePathValue;
      
      StringChangeEx(UpdatedPSModulePathValue, (ExpandConstant('{app}') + ';'), '', True);
      
      Log(Format('Updated PSModulesPath: %s', [UpdatedPSModulePathValue]));
      
      RegWriteStringValue(HKLM, 'System\CurrentControlSet\Control\Session Manager\Environment','PSModulePath', UpdatedPSModulePathValue);

      Exec('setx.exe', Format('PSModulePath "%s" -m', [UpdatedPSModulePathValue]), '%windir%', SW_HIDE, ewWaitUntilTerminated, ResultCode);
      
    end
    
  end;
  
end;

function InitializeSetup(): boolean;
var
  Version: TWindowsVersion;
begin
	// initialize windows version
	initwinversion();
  Log('Beginning installer for {#MyAppName}, version {#MyAppVersion}');
  GetWindowsVersionEx(Version);
  Log(Format('Product Type is %d', [Version.ProductType]));
  
#ifdef use_dotnetfx46
    dotnetfx46(50); // min allowed version is 4.5.0
#endif

#ifdef use_wmf4
    wmf4(40,Version);
#endif

#ifdef use_wmf3
    wmf3(30,Version);
#endif
  
#ifdef use_iis
	if (not iis()) then exit;
#endif

#ifdef use_msi20
	msi20('2.0'); // min allowed version is 2.0
#endif
#ifdef use_msi31
	msi31('3.1'); // min allowed version is 3.1
#endif
#ifdef use_msi45
	msi45('4.5'); // min allowed version is 4.5
#endif
#ifdef use_ie6
	ie6('5.0.2919'); // min allowed version is 5.0.2919
#endif

#ifdef use_dotnetfx11
	dotnetfx11();
#ifdef use_dotnetfx11lp
	dotnetfx11lp();
#endif
	dotnetfx11sp1();
#endif

	// install .netfx 2.0 sp2 if possible; if not sp1 if possible; if not .netfx 2.0
#ifdef use_dotnetfx20
	// check if .netfx 2.0 can be installed on this OS
	if not minwinspversion(5, 0, 3) then begin
		msgbox(fmtmessage(custommessage('depinstall_missing'), [fmtmessage(custommessage('win_sp_title'), ['2000', '3'])]), mberror, mb_ok);
		exit;
	end;
	if not minwinspversion(5, 1, 2) then begin
		msgbox(fmtmessage(custommessage('depinstall_missing'), [fmtmessage(custommessage('win_sp_title'), ['XP', '2'])]), mberror, mb_ok);
		exit;
	end;

	if minwinversion(5, 1) then begin
		dotnetfx20sp2();
#ifdef use_dotnetfx20lp
		dotnetfx20sp2lp();
#endif
	end else begin
		if minwinversion(5, 0) and minwinspversion(5, 0, 4) then begin
#ifdef use_kb835732
			kb835732();
#endif
			dotnetfx20sp1();
#ifdef use_dotnetfx20lp
			dotnetfx20sp1lp();
#endif
		end else begin
			dotnetfx20();
#ifdef use_dotnetfx20lp
			dotnetfx20lp();
#endif
		end;
	end;
#endif

#ifdef use_dotnetfx35
	//dotnetfx35();
	dotnetfx35sp1();
#ifdef use_dotnetfx35lp
	//dotnetfx35lp();
	dotnetfx35sp1lp();
#endif
#endif

#ifdef use_wic
	wic();
#endif

	// if no .netfx 4.0 is found, install the client (smallest)
#ifdef use_dotnetfx40
	if (not netfxinstalled(NetFx40Client, '') and not netfxinstalled(NetFx40Full, '')) then
		dotnetfx40client();
#endif


#ifdef use_vc2005
	vcredist2005();
#endif
#ifdef use_vc2008
	vcredist2008();
#endif
#ifdef use_vc2010
	vcredist2010();
#endif
#ifdef use_vc2012
	vcredist2012();
#endif
#ifdef use_vc2013
	//SetForceX86(true); // force 32-bit install of next products
	vcredist2013();
	//SetForceX86(false); // disable forced 32-bit install again
#endif
#ifdef use_vc2015
	vcredist2015();
#endif

#ifdef use_directxruntime
	// extracts included setup file to temp folder so that we don't need to download it
	// and always runs directxruntime installer as we don't know how to check if it is required
	directxruntime();
#endif

#ifdef use_mdac28
	mdac28('2.7'); // min allowed version is 2.7
#endif
#ifdef use_jet4sp8
	jet4sp8('4.0.8015'); // min allowed version is 4.0.8015
#endif

#ifdef use_sqlcompact35sp2
	sqlcompact35sp2();
#endif

#ifdef use_sql2005express
	sql2005express();
#endif
#ifdef use_sql2008express
	sql2008express();
#endif

	Result := true;
end;
