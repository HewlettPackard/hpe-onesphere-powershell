[Code]
type
	WmfType = (Wmf20, Wmf30, Wmf40, Wmf50);

const
	wmf2_reg = 'Software\Microsoft\PowerShell\1';
	wmf3_reg = 'Software\Microsoft\PowerShell\3';

function wmfinstalled(version: WmfType): boolean;
var
	regVersion: cardinal;
	regVersionString: string;
begin
	case version of
		Wmf20:
			RegQueryDWordValue(HKLM, wmf2_reg, 'Install', regVersion);
		Wmf30:
			RegQueryDWordValue(HKLM, wmf3_reg, 'Install', regVersion);
		Wmf40:
			RegQueryDWordValue(HKLM, wmf3_reg, 'Install', regVersion);
		Wmf50:
			RegQueryDWordValue(HKLM, wmf3_reg, 'Install', regVersion);
	end;
  Log(Format('PowerShell installed: %d', [regVersion]));
	Result := (regVersion <> 0);
end;

//function wmfversion(version: WmfType): integer;

function wmfversion(): integer;
var
	regVersion: string;
  wmfInstalledVersion: cardinal;
  logVersion: cardinal;
begin

  if (RegQueryStringValue(HKLM, wmf3_reg + '\PowerShellEngine', 'PowerShellVersion', regVersion)) then 
  begin

    log(Format('PowerShell  Full Version installed %s', [regVersion]));

		if (regVersion = '3.0') then
			wmfInstalledVersion := 30 // PowerShell 3.0 installed
		else if (regVersion = '4.0') then
			wmfInstalledVersion := 40 // PowerShell 4.0 installed
		else if (regVersion = '5.0') then
			wmfInstalledVersion := 50 // PowerShell 5.0 installed
    else if (regVersion = '5.0.10586.0') then
			wmfInstalledVersion := 50 // 5.0 RC installed
		else if (regVersion = '5.0.10240.16384') then
			wmfInstalledVersion := 50 // Windows 10 RTM 5.0 Preview installed
    else if (regVersion = '5.1.14393.0') then
			wmfInstalledVersion := 51 // Windows 10 v1607 5.1 Release
		else
			wmfInstalledVersion := -1; // Not Installed, or unknown release
	end
  
  else if (RegQueryStringValue(HKLM, wmf2_reg + '\PowerShellEngine', 'PowerShellVersion', regVersion)) then 
  begin
    if (regVersion = '2.0') then
			wmfInstalledVersion := 20 // PowerShell 2.0 installed
		else
			wmfInstalledVersion := -1; // Not Installed
  end;
  Log(Format('PowerShell version installed: %d', [wmfInstalledVersion]));
	Result := wmfInstalledVersion;
end;
