// requires Windows 7 Service Pack 1, Windows Server 2008 R2 SP1, and Windows Server 2008 Service Pack 2
// http://www.microsoft.com/en-us/download/details.aspx?id=34595

[CustomMessages]
wmf4_title=Windows Management Framework 4

wmf4_size_x86=14.1 MB
wmf4_size_x64=18.4 MB
wmf4_win81_size=17.5 MB

[Code]
const
	wmf4_url_x86   = 'http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x86-MultiPkg.msu';
	wmf4_url_x64   = 'http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows6.1-KB2819745-x64-MultiPkg.msu';
  wmf4_win81_url = 'http://download.microsoft.com/download/3/D/6/3D61D262-8549-4769-A660-230B67E15B25/Windows8-RT-KB2799888-x64.msu';
 
procedure wmf4(minVersion: integer; Version: TWindowsVersion); 
var
  IsWmfInstalled : boolean;
  WmfVersionInstalled : cardinal;
begin

  IsWmfInstalled := wmfinstalled(Wmf40)
  WmfVersionInstalled := wmfversion()
  
  if exactwinversion(6, 3) then
  begin
		if not IsWmfInstalled or (WmfVersionInstalled < minVersion) then 
    begin
      if (Version.ProductType = VER_NT_DOMAIN_CONTROLLER) or (Version.ProductType = VER_NT_SERVER) then 
      begin
        Log('Windows Server 2012 detected without WMF4 installed.');
        AddProduct('Windows8-RT-KB2799888-x64.msu','/quiet /norestart',CustomMessage('wmf4_title'),CustomMessage('wmf4_win81_size'),GetString('', wmf4_win81_url, ''),	false, false, true);
      end else 
      begin
        Log('Windows 8 client detected without WMF4 installed. Displaying Msgbox.');
        SuppressibleMsgBox('Windows 8 workstation is detected without Windows Management Framework 4 installed. Please install the Windows Feature before continuing.', mbCriticalError, MB_OK, IDOK);
        //Result := False;
        Exit;
      end;
    end;
  end
  else if (not IsWmfInstalled or (WmfVersionInstalled < minVersion)) then 
  begin
			AddProduct('Windows6.1-KB2819745-' + GetArchitectureString() + '-MultiPkg.msu',
				'/quiet /norestart',
				CustomMessage('wmf4_title'),
        CustomMessage('wmf4_size_' + GetArchitectureString()),
				GetString(wmf4_url_x86, wmf4_url_x64, ''),
				false, false, true);
	end
  
  else if (WmfVersionInstalled >= minVersion) then
  begin
    Log('Windows PowerShell version meets or exceeds the required version.');
  end;
end;
