unit yellowfinbi.api.common;

interface

type
  TYFTypes = class
  type
    {$SCOPEDENUMS ON}
    statusCode = (OPEN, DRAFT, ARCHIVED, PENDING, DELETED);
    {$SCOPEDENUMS OFF}
  public
    class function GetValue<T>(const Value : string; DefaultValue : T): T; static;
    class function ValueToString<T>(const Value : T): string; static;
  end;

  // Interface for general Yellowfin server configuration
  IYFServerDetails = interface
    ['{42C93884-17E0-4A7A-9EF2-9D4D3BDF6D22}']
    function GetHostURL: string;
    procedure SetHostURL(const Value: string);

    function GetAppName: string;
    procedure SetAppName(const Value: string);

    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);

    property HostURL: string read GetHostURL write SetHostURL;
    property AppName: string read GetAppName write SetAppName;
    property Timeout: Integer read GetTimeout write SetTimeout;
  end;

  // Interface for admin authentication credentials
  IYFAdminCredentials = interface
    ['{0A8F5F5A-F1C7-41FA-9F26-84E896A2D5B2}']
    function GetAdminUserName: string;
    procedure SetAdminUserName(const Value: string);

    function GetAdminPassword: string;
    procedure SetAdminPassword(const Value: string);

    function GetClientOrg: string;
    procedure SetClientOrg(const Value: string);

    property AdminUserName: string read GetAdminUserName write SetAdminUserName;
    property AdminPassword: string read GetAdminPassword write SetAdminPassword;
    property ClientOrg: string read GetClientOrg write SetClientOrg;
  end;

  // Class implementing IServerDetails
  TYFServerDetails = class(TInterfacedObject, IYFServerDetails)
  private
    FHostURL: string;
    FAppName: string;
    FTimeout: Integer;

    function GetHostURL: string;
    procedure SetHostURL(const Value: string);

    function GetAppName: string;
    procedure SetAppName(const Value: string);

    function GetTimeout: Integer;
    procedure SetTimeout(const Value: Integer);
  public
    constructor Create; overload;
    constructor Create(const aHostURL, aAppName : string; const aTimeout : Integer); overload;
  end;

  // Class implementing IServerAdminCredentials
  TYFServerAdminCredentials = class(TInterfacedObject, IYFAdminCredentials)
  private
    FAdminUserName: string;
    FAdminPassword: string;
    FClientOrg: string;

    function GetAdminUserName: string;
    procedure SetAdminUserName(const Value: string);

    function GetAdminPassword: string;
    procedure SetAdminPassword(const Value: string);

    function GetClientOrg: string;
    procedure SetClientOrg(const Value: string);
  public
    constructor Create; overload;
    constructor Create(const aAdminUser, aAdminPassword, aClientOrg : string); overload;
  end;

  // Container class combining both interfaces
  TYellowfinServerConfig = class
  private
    FServerDetails: IYFServerDetails;
    FAdminCredentials: IYFAdminCredentials;
  public
    constructor Create; overload;
    constructor Create(const aHostURL, aAppName, aAdminUser, aAdminPassword, aOrgID: string; const aTimeOut: Integer); overload;

    property ServerDetails: IYFServerDetails read FServerDetails;
    property AdminCredentials: IYFAdminCredentials read FAdminCredentials;
  end;

implementation

uses System.Rtti, System.TypInfo, System.SysUtils;

{ TServerDetails }

constructor TYFServerDetails.Create;
begin
  Create('http://localhost:8888','YELLOWFIN',6000);
end;

function TYFServerDetails.GetHostURL: string;
begin
  Result := FHostURL;
end;

procedure TYFServerDetails.SetHostURL(const Value: string);
begin
  FHostURL := Value;
end;

constructor TYFServerDetails.Create(const aHostURL, aAppName: string;
  const aTimeout: Integer);
begin
  inherited Create;
  FHostURL := aHostURL;
  FAppName := aAppName;
  FTimeout := aTimeout;
end;

function TYFServerDetails.GetAppName: string;
begin
  Result := FAppName;
end;

procedure TYFServerDetails.SetAppName(const Value: string);
begin
  FAppName := Value;
end;

function TYFServerDetails.GetTimeout: Integer;
begin
  Result := FTimeout;
end;

procedure TYFServerDetails.SetTimeout(const Value: Integer);
begin
  FTimeout := Value;
end;

{ TServerAdminCredentials }

constructor TYFServerAdminCredentials.Create;
begin
  Create('admin@yellowfin.com.au' , 'test', 'default');
end;

constructor TYFServerAdminCredentials.Create(const aAdminUser, aAdminPassword, aClientOrg : string);
begin
  inherited Create;
  FAdminUserName := aAdminUser;
  FAdminPassword := aAdminPassword;
  FClientOrg := aClientOrg;
end;

function TYFServerAdminCredentials.GetAdminUserName: string;
begin
  Result := FAdminUserName;
end;

function TYFServerAdminCredentials.GetClientOrg: string;
begin
  Result := FClientOrg;
end;

procedure TYFServerAdminCredentials.SetAdminUserName(const Value: string);
begin
  FAdminUserName := Value;
end;

procedure TYFServerAdminCredentials.SetClientOrg(const Value: string);
begin
  FClientOrg := Value;
end;

function TYFServerAdminCredentials.GetAdminPassword: string;
begin
  Result := FAdminPassword;
end;

procedure TYFServerAdminCredentials.SetAdminPassword(const Value: string);
begin
  FAdminPassword := Value;
end;

{ TYellowfinServerConfig }

constructor TYellowfinServerConfig.Create;
begin
  Create('http://localhost:8888','YELLOWFIN','admin@yellowfin.com.au', 'test', 'default', 6000);
end;

constructor TYellowfinServerConfig.Create(const aHostURL, aAppName, aAdminUser,
  aAdminPassword, aOrgID: string; const aTimeOut: Integer);
begin
  inherited Create;
  FServerDetails := TYFServerDetails.Create(aHostURL, aAppName, aTimeout);
  FAdminCredentials := TYFServerAdminCredentials.Create(aAdminUser, aAdminPassword, aOrgID);
end;

{ TYFTypes }

class function TYFTypes.GetValue<T>(const Value: string; DefaultValue : T): T;
var
  EnumType: PTypeInfo;
  EnumData: PTypeData;
  EnumName: string;
begin
  EnumType := TypeInfo(T);
  if not Assigned(EnumType) or (EnumType^.Kind <> tkEnumeration) then
    raise Exception.Create('GetValue<T>: T must be an enumerated type');

  EnumData := GetTypeData(EnumType);

  for var CurrValue := EnumData^.MinValue to EnumData^.MaxValue do
  begin
    EnumName := GetEnumName(EnumType, CurrValue);
    if SameText(EnumName, Value) then
    begin
      Result :=  T(Pointer(@CurrValue)^);
      Exit;
    end;
  end;

  // If no match found, use default value
  Result := DefaultValue;
end;

class function TYFTypes.ValueToString<T>(const Value: T): string;
begin
  Result := TRttiEnumerationType.GetName<T>(Value);
end;

end.


