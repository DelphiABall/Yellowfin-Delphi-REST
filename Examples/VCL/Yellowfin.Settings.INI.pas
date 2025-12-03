unit Yellowfin.Settings.INI;

interface

uses
  System.Classes, yellowfinbi.api.common;

type
  TYellowfinServerConfigHelper = class helper for TYellowfinServerConfig
  public
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    function FileName: string;
  end;

implementation

uses System.SysUtils, System.NetEncoding, System.IniFiles, System.IOUtils, Yellowfin.Settings;

{ TYellowfinServerConfigHelper }

function TYellowfinServerConfigHelper.FileName: string;
begin
  var FPath : string;

  if (TOSVersion.Platform in [TOSVersion.TPlatform.pfWindows,
                             TOSVersion.TPlatform.pfWinRT,
                             //TOSVersion.TPlatform.pfMacOS,
                             TOSVersion.TPlatform.pfLinux]) then
    FPath := TPath.Combine(TPath.GetAppPath, 'YFSandbox.ini')
  else
    FPath := TPath.Combine(TPath.GetDocumentsPath, 'YFSandbox.ini');

  Result := FPath;
end;

procedure TYellowfinServerConfigHelper.LoadFromFile(const AFileName: string);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(AFileName);
  try
    ServerDetails.HostURL := INI.ReadString('SANDBOX', 'URL', YF_URL);
    ServerDetails.AppName := INI.ReadString('SANDBOX', 'INSTANCE_NAME', YF_INSTANCE_NAME);
    ServerDetails.Timeout := INI.ReadInteger('SANDBOX', 'TIMEOUT', YF_TIMEOUT);

    AdminCredentials.AdminUserName := INI.ReadString('SANDBOX', 'USERNAME', YF_ADMIN_USER);
    AdminCredentials.AdminPassword := TNetEncoding.Base64.Decode(INI.ReadString('SANDBOX', 'PASSWORD', ''));
    if AdminCredentials.AdminPassword = '' then
      AdminCredentials.AdminPassword := YF_ADMIN_PASSWORD;
    AdminCredentials.ClientOrg := INI.ReadString('SANDBOX', 'TENANT', YF_ORG);
  finally
    INI.Free;
  end;
end;

procedure TYellowfinServerConfigHelper.SaveToFile(const AFileName: string);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(AFileName);
  try
    INI.WriteString('SANDBOX', 'URL', ServerDetails.HostURL);
    INI.WriteString('SANDBOX', 'INSTANCE_NAME', ServerDetails.AppName);
    INI.WriteInteger('SANDBOX', 'TIMEOUT', ServerDetails.Timeout);

    INI.WriteString('SANDBOX', 'USERNAME', AdminCredentials.AdminUserName);
    INI.WriteString('SANDBOX', 'PASSWORD', TNetEncoding.Base64.Encode(AdminCredentials.AdminPassword));
    INI.WriteString('SANDBOX', 'TENANT', AdminCredentials.ClientOrg);
  finally
    INI.Free;
  end;
end;

end.

