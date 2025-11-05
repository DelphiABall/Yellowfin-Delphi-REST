unit yellowfinbi.api.classes;

interface

uses System.SysUtils, yellowfinbi.api.intf, System.JSON;


type
  /// <summary>
  /// Concrete implementation of <see cref="IYFAPIInfo"/>.
  /// Stores API and application version details, and can populate itself
  /// from a JSON object.
  /// </summary>
  TYFAPIInfo = class(TInterfacedObject, IYFAPIInfo)
  private
    FApiMajorVersion: string;
    FApiMinorVersion: string;
    FApiVersion: string;
    FApplicationMajorVersion: string;
    FApplicationMinorVersion: string;
    FApplicationVersion: string;
    FVersionPattern: string;

    function GetApiMajorVersion: string;
    procedure SetApiMajorVersion(const Value: string);

    function GetApiMinorVersion: string;
    procedure SetApiMinorVersion(const Value: string);

    function GetApiVersion: string;
    procedure SetApiVersion(const Value: string);

    function GetApplicationMajorVersion: string;
    procedure SetApplicationMajorVersion(const Value: string);

    function GetApplicationMinorVersion: string;
    procedure SetApplicationMinorVersion(const Value: string);

    function GetApplicationVersion: string;
    procedure SetApplicationVersion(const Value: string);

    function GetVersionPattern: string;
    procedure SetVersionPattern(const Value: string);
  public
    /// <summary>
    /// Populate this instance from a JSON object returned by the Yellowfin API.
    /// Expected keys:
    /// "apiMajorVersion", "apiMinorVersion", "apiVersion",
    /// "applicationMajorVersion", "applicationMinorVersion",
    /// "applicationVersion", "versionPattern".
    /// </summary>
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property ApiMajorVersion: string read GetApiMajorVersion write SetApiMajorVersion;
    property ApiMinorVersion: string read GetApiMinorVersion write SetApiMinorVersion;
    property ApiVersion: string read GetApiVersion write SetApiVersion;
    property ApplicationMajorVersion: string read GetApplicationMajorVersion write SetApplicationMajorVersion;
    property ApplicationMinorVersion: string read GetApplicationMinorVersion write SetApplicationMinorVersion;
    property ApplicationVersion: string read GetApplicationVersion write SetApplicationVersion;
    property VersionPattern: string read GetVersionPattern write SetVersionPattern;
  end;

implementation

uses  yellowfinbi.api.classfactory;

{ TYFAPIInfo }

function TYFAPIInfo.GetApiMajorVersion: string;
begin
  Result := FApiMajorVersion;
end;

procedure TYFAPIInfo.SetApiMajorVersion(const Value: string);
begin
  FApiMajorVersion := Value;
end;

function TYFAPIInfo.GetApiMinorVersion: string;
begin
  Result := FApiMinorVersion;
end;

procedure TYFAPIInfo.SetApiMinorVersion(const Value: string);
begin
  FApiMinorVersion := Value;
end;

function TYFAPIInfo.GetApiVersion: string;
begin
  Result := FApiVersion;
end;

procedure TYFAPIInfo.SetApiVersion(const Value: string);
begin
  FApiVersion := Value;
end;

function TYFAPIInfo.GetApplicationMajorVersion: string;
begin
  Result := FApplicationMajorVersion;
end;

procedure TYFAPIInfo.SetApplicationMajorVersion(const Value: string);
begin
  FApplicationMajorVersion := Value;
end;

function TYFAPIInfo.GetApplicationMinorVersion: string;
begin
  Result := FApplicationMinorVersion;
end;

procedure TYFAPIInfo.SetApplicationMinorVersion(const Value: string);
begin
  FApplicationMinorVersion := Value;
end;

function TYFAPIInfo.GetApplicationVersion: string;
begin
  Result := FApplicationVersion;
end;

procedure TYFAPIInfo.SetApplicationVersion(const Value: string);
begin
  FApplicationVersion := Value;
end;

function TYFAPIInfo.GetVersionPattern: string;
begin
  Result := FVersionPattern;
end;

procedure TYFAPIInfo.SetVersionPattern(const Value: string);
begin
  FVersionPattern := Value;
end;

procedure TYFAPIInfo.LoadFromJSON(const AJSON: TJSONObject);
begin
  if AJSON = nil then
    Exit;

  if AJSON.TryGetValue<string>('apiMajorVersion', FApiMajorVersion) then ;
  if AJSON.TryGetValue<string>('apiMinorVersion', FApiMinorVersion) then ;
  if AJSON.TryGetValue<string>('apiVersion', FApiVersion) then ;
  if AJSON.TryGetValue<string>('applicationMajorVersion', FApplicationMajorVersion) then ;
  if AJSON.TryGetValue<string>('applicationMinorVersion', FApplicationMinorVersion) then ;
  if AJSON.TryGetValue<string>('applicationVersion', FApplicationVersion) then ;
  if AJSON.TryGetValue<string>('versionPattern', FVersionPattern) then ;
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFAPIInfo>(
    function: IYFAPIInfo
    begin
      Result := TYFAPIInfo.Create;
    end
  );

end.
