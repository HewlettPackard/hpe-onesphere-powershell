// requires Windows 7 Service Pack 1, Windows Server 2008 R2 SP1, and Windows Server 2008 Service Pack 2
// http://www.microsoft.com/en-us/download/details.aspx?id=34595

[CustomMessages]
wmf3_title=Windows Management Framework 3

wmf3_size_win7_x86=11.7 MB
wmf3_size_win7_x64=15.8 MB
wmf3_size_w2k8_x86=10.5 MB
wmf3_size_w2k8_x64=14.4 MB

[Code]
const
	wmf3_url_win7_x86 = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu';
	wmf3_url_win7_x64 = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu';
  wmf3_url_w2k8_x86 = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.0-KB2506146-x86.msu';
	wmf3_url_w2k8_x64 = 'http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.0-KB2506146-x64.msu';
 
procedure wmf3(minVersion: integer; Version: TWindowsVersion); 
var
  IsWmfInstalled : boolean;
  WmfVersionInstalled : cardinal;
begin

  IsWmfInstalled := wmfinstalled(Wmf30)
  WmfVersionInstalled := wmfversion()

  if (exactwinversion(6, 1)) then 
  begin
    
    // Windows 7 SP1
    if (Version.ProductType = VER_NT_WORKSTATION) then
    begin
      Log('Windows 7 detected.');
      if (not IsWmfInstalled or (WmfVersionInstalled < minVersion)) then
      begin
        Log('Windows Management Framework 3 not detected. Adding to product install list.');
        AddProduct('Windows6.1-KB2506143-' + GetArchitectureString() + '.msu',
          '/quiet /norestart',
          CustomMessage('wmf3_title'),
          CustomMessage('wmf3_size_win7_' + GetArchitectureString()),
          GetString(wmf3_url_win7_x86, wmf3_url_win7_x64, ''),
          false, false, true);
      end;
      
    // Windows Server 2008/2008 R2
    end else
    begin
      Log('Windows Server 2008 detected.');
      if (not IsWmfInstalled or (WmfVersionInstalled < minVersion)) then
      begin
        Log('Windows Management Framework 3 not detected. Adding to product install list.');
        AddProduct('Windows6.0-KB2506146-' + GetArchitectureString() + '.msu',
          '/quiet /norestart',
          CustomMessage('wmf3_title'),
          CustomMessage('wmf3_size_w2k8_' + GetArchitectureString()),
          GetString(wmf3_url_w2k8_x86, wmf3_url_w2k8_x64, ''),
          false, false, true);
      end;
    end;
	end;
end;
