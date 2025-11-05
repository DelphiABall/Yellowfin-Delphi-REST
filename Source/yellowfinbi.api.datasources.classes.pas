unit yellowfinbi.api.datasources.classes;

interface

uses
  System.SysUtils, System.JSON, System.Generics.Collections,
  yellowfinbi.api.json, yellowfinbi.api.json.generics,
  yellowfinbi.api.datasources.intf;

type
  // ===============================
  // DataSource Option
  // ===============================
  TYFDataSourceOption = class(TInterfacedObject, IYFDataSourceOption)
  private
    FOptionKey: string;
    FOptionValue: string;
    FValueDataType: string;

    function GetOptionKey: string;
    procedure SetOptionKey(const Value: string);

    function GetOptionValue: string;
    procedure SetOptionValue(const Value: string);

    function GetValueDataType: string;
    procedure SetValueDataType(const Value: string);
  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property OptionKey: string read GetOptionKey write SetOptionKey;
    property OptionValue: string read GetOptionValue write SetOptionValue;
    property ValueDataType: string read GetValueDataType write SetValueDataType;
  end;

  TYFDataSourceOptionsList = class(TYFModelList<IYFDataSourceOption>, IYFDataSourceOptionsList)
  end;

  // ===============================
  // DataSource
  // ===============================
  TYFDataSource = class(TInterfacedObject, IYFDataSource)
  private
    FSourceID : Int64;
    FSourceName: string;
    FSourceDescription: string;
    FSourceType: string;
    FConnectionType: string;
    FConnectionTypeCode: string;
    FConnectionDriver: string;
    FConnectionPath: string;
    FConnectionString: string;
    FConnectionTimeout: Int64;
    FUserName: string;
    FUserPassword: string;
    FMinimumConnections: Int64;
    FMaximumConnections: Int64;
    FRefreshTime: Int64;
    FTimezone: string;
    FLogFile: string;
    FAccessLevelCode: TYFDataSourceTypes.TAccessLevelCode;
    FMaxRows: Int64;
    FMaxAnalysisRows: Int64;
    FInheritChildSourceFilters: Boolean;
    FPlatformTypeCode: string;
    FSourceLogIndicator: Boolean;
    FSourceOptions: IYFDataSourceOptionsList;

    function GetSourceID: Int64;
    procedure SetSourceID(const Value: Int64);

    function GetSourceName: string;
    procedure SetSourceName(const Value: string);

    function GetSourceDescription: string;
    procedure SetSourceDescription(const Value: string);

    function GetSourceType: string;
    procedure SetSourceType(const Value: string);

    function GetConnectionType: string;
    procedure SetConnectionType(const Value: string);

    function GetConnectionTypeCode: string;
    procedure SetConnectionTypeCode(const Value: string);

    function GetConnectionDriver: string;
    procedure SetConnectionDriver(const Value: string);

    function GetConnectionPath: string;
    procedure SetConnectionPath(const Value: string);

    function GetConnectionString: string;
    procedure SetConnectionString(const Value: string);

    function GetConnectionTimeout: Int64;
    procedure SetConnectionTimeout(const Value: Int64);

    function GetUserName: string;
    procedure SetUserName(const Value: string);

    function GetUserPassword: string;
    procedure SetUserPassword(const Value: string);

    function GetMinimumConnections: Int64;
    procedure SetMinimumConnections(const Value: Int64);

    function GetMaximumConnections: Int64;
    procedure SetMaximumConnections(const Value: Int64);

    function GetRefreshTime: Int64;
    procedure SetRefreshTime(const Value: Int64);

    function GetTimezone: string;
    procedure SetTimezone(const Value: string);

    function GetLogFile: string;
    procedure SetLogFile(const Value: string);

    function GetAccessLevelCode: TYFDataSourceTypes.TAccessLevelCode;
    procedure SetAccessLevelCode(const Value: TYFDataSourceTypes.TAccessLevelCode);

    function GetMaxRows: Int64;
    procedure SetMaxRows(const Value: Int64);

    function GetMaxAnalysisRows: Int64;
    procedure SetMaxAnalysisRows(const Value: Int64);

    function GetInheritChildSourceFilters: Boolean;
    procedure SetInheritChildSourceFilters(const Value: Boolean);

    function GetPlatformTypeCode: string;
    procedure SetPlatformTypeCode(const Value: string);

    function GetSourceLogIndicator: Boolean;
    procedure SetSourceLogIndicator(const Value: Boolean);

    function GetSourceOptions: IYFDataSourceOptionsList;
    procedure SetSourceOptions(const Value: IYFDataSourceOptionsList);
  public
    constructor Create;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property SourceID: Int64 read GetSourceID write SetSourceID;
    property SourceName: string read GetSourceName write SetSourceName;
    property SourceDescription: string read GetSourceDescription write SetSourceDescription;
    property SourceType: string read GetSourceType write SetSourceType;
    property ConnectionType: string read GetConnectionType write SetConnectionType;
    property ConnectionTypeCode: string read GetConnectionTypeCode write SetConnectionTypeCode;
    property ConnectionDriver: string read GetConnectionDriver write SetConnectionDriver;
    property ConnectionPath: string read GetConnectionPath write SetConnectionPath;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property ConnectionTimeout: Int64 read GetConnectionTimeout write SetConnectionTimeout;
    property UserName: string read GetUserName write SetUserName;
    property UserPassword: string read GetUserPassword write SetUserPassword;
    property MinimumConnections: Int64 read GetMinimumConnections write SetMinimumConnections;
    property MaximumConnections: Int64 read GetMaximumConnections write SetMaximumConnections;
    property RefreshTime: Int64 read GetRefreshTime write SetRefreshTime;
    property Timezone: string read GetTimezone write SetTimezone;
    property LogFile: string read GetLogFile write SetLogFile;
    property AccessLevelCode: TYFDataSourceTypes.TAccessLevelCode read GetAccessLevelCode write SetAccessLevelCode;
    property MaxRows: Int64 read GetMaxRows write SetMaxRows;
    property MaxAnalysisRows: Int64 read GetMaxAnalysisRows write SetMaxAnalysisRows;
    property InheritChildSourceFilters: Boolean read GetInheritChildSourceFilters write SetInheritChildSourceFilters;
    property PlatformTypeCode: string read GetPlatformTypeCode write SetPlatformTypeCode;
    property SourceLogIndicator: Boolean read GetSourceLogIndicator write SetSourceLogIndicator;
    property SourceOptions: IYFDataSourceOptionsList read GetSourceOptions write SetSourceOptions;
  end;

  TYFDataSources = class(TYFModelList<IYFDataSource>, IYFDataSources)
  end;

  TYFClientDataSource = class(TInterfacedObject, IYFClientDataSource)
  private
    FClientOrgId : Int64;
    FClientOrgRef : string;
    FClientOrgName : string;
    FSourceId : Int64;
    FSourceName : string;

    function GetClientOrgId : Int64;
    procedure SetClientOrgId(const Value : Int64);

    function GetClientOrgRef : string;
    procedure SetClientOrgRef(const Value : string);

    function GetClientOrgName : string;
    procedure SetClientOrgName(const Value : string);

    function GetSourceId : Int64;
    procedure SetSourceId(const Value : Int64);

    function GetSourceName : string;
    procedure SetSourceName(const Value : string);
  public
    constructor Create;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    /// <summary>
    /// An integer id referring to a client org
    /// </summary>
    property ClientOrgId : Int64 read GetClientOrgId write SetClientOrgId;

    /// <summary>
    /// Client Org Reference
    /// </summary>
    property ClientOrgRef : string read GetClientOrgRef write SetClientOrgRef;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property ClientOrgName : string read GetClientOrgName write SetClientOrgName;

    /// <summary>
    /// An integer id that references a data source
    /// </summary>
    property SourceId : Int64 read GetSourceId write SetSourceId;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property SourceName : string read GetSourceName write SetSourceName;
  end;

  TYFClientDataSourceList = class(TYFModelList<IYFClientDataSource>, IYFClientDataSourceList)
  end;


implementation

uses
  yellowfinbi.api.classfactory;

{ TYFDataSourceOption }

procedure TYFDataSourceOption.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  if AJSON.TryGetValue('optionKey', jv) then
    FOptionKey := jv.Value;

  if AJSON.TryGetValue('optionValue', jv) then
    FOptionValue := jv.Value;

  if AJSON.TryGetValue('valueDataType', jv) then
    FValueDataType := jv.Value;
end;

function TYFDataSourceOption.GetOptionKey: string;
begin
  Result := FOptionKey;
end;

procedure TYFDataSourceOption.SetOptionKey(const Value: string);
begin
  FOptionKey := Value;
end;

function TYFDataSourceOption.GetOptionValue: string;
begin
  Result := FOptionValue;
end;

procedure TYFDataSourceOption.SetOptionValue(const Value: string);
begin
  FOptionValue := Value;
end;

function TYFDataSourceOption.GetValueDataType: string;
begin
  Result := FValueDataType;
end;

procedure TYFDataSourceOption.SetValueDataType(const Value: string);
begin
  FValueDataType := Value;
end;

{ TYFDataSource }

constructor TYFDataSource.Create;
begin
  inherited Create;
  FSourceOptions := TYFDataSourceOptionsList.Create('sourceOptions');
end;

procedure TYFDataSource.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  if AJSON.TryGetValue('sourceId', jv) then
    SourceID := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('sourceName', jv) then
    SourceName := jv.Value;

  if AJSON.TryGetValue('sourceDescription', jv) then
    SourceDescription := jv.Value;

  if AJSON.TryGetValue('sourceType', jv) then
    SourceType := jv.Value;

  if AJSON.TryGetValue('connectionType', jv) then
    ConnectionType := jv.Value;

  if AJSON.TryGetValue('connectionTypeCode', jv) then
    ConnectionTypeCode := jv.Value;

  if AJSON.TryGetValue('connectionDriver', jv) then
    ConnectionDriver := jv.Value;

  if AJSON.TryGetValue('connectionPath', jv) then
    ConnectionPath := jv.Value;

  if AJSON.TryGetValue('connectionString', jv) then
    ConnectionString := jv.Value;

  if AJSON.TryGetValue('connectionTimeout', jv) then
    ConnectionTimeout := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('userName', jv) then
    UserName := jv.Value;

  if AJSON.TryGetValue('userPassword', jv) then
    UserPassword := jv.Value;

  if AJSON.TryGetValue('minimumConnections', jv) then
    MinimumConnections := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('maximumConnections', jv) then
    MaximumConnections := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('refreshTime', jv) then
    RefreshTime := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('timezone', jv) then
    Timezone := jv.Value;

  if AJSON.TryGetValue('logFile', jv) then
    LogFile := jv.Value;

  if AJSON.TryGetValue('accessLevelCode', jv) then
    AccessLevelCode := TYFDataSourceTypes.GetValue<TYFDataSourceTypes.TAccessLevelCode>(jv.Value, TYFDataSourceTypes.TAccessLevelCode.UNSECURE)
  else
    AccessLevelCode := TYFDataSourceTypes.TAccessLevelCode.UNSECURE;

  if AJSON.TryGetValue('maxRows', jv) then
    MaxRows := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('maxAnalysisRows', jv) then
    MaxAnalysisRows := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('inheritChildSourceFilters', jv) then
    InheritChildSourceFilters := JSONToBool(jv, False);

  if AJSON.TryGetValue('platformTypeCode', jv) then
    PlatformTypeCode := jv.Value;

  if AJSON.TryGetValue('sourceLogIndicator', jv) then
    SourceLogIndicator := JSONToBool(jv, False);

  // SourceOptions array
  FSourceOptions.LoadFromJSON(AJSON);
//  if AJSON.TryGetValue<TJSONArray>('sourceOptions', arr) then
//  begin
//    FSourceOptions.LoadFromJSONArray(arr)
//  end else
//    FSourceOptions.Items.Clear;
end;

{ TYFDataSource Get/Set Implementations }

function TYFDataSource.GetSourceName: string;
begin
  Result := FSourceName;
end;

procedure TYFDataSource.SetSourceName(const Value: string);
begin
  FSourceName := Value;
end;

function TYFDataSource.GetSourceDescription: string;
begin
  Result := FSourceDescription;
end;

function TYFDataSource.GetSourceID: Int64;
begin
  Result := FSourceID;
end;

procedure TYFDataSource.SetSourceDescription(const Value: string);
begin
  FSourceDescription := Value;
end;

procedure TYFDataSource.SetSourceID(const Value: Int64);
begin
  FSourceID := Value;
end;

function TYFDataSource.GetSourceType: string;
begin
  Result := FSourceType;
end;

procedure TYFDataSource.SetSourceType(const Value: string);
begin
  FSourceType := Value;
end;

function TYFDataSource.GetConnectionType: string;
begin
  Result := FConnectionType;
end;

procedure TYFDataSource.SetConnectionType(const Value: string);
begin
  FConnectionType := Value;
end;

function TYFDataSource.GetConnectionTypeCode: string;
begin
  Result := FConnectionTypeCode;
end;

procedure TYFDataSource.SetConnectionTypeCode(const Value: string);
begin
  FConnectionTypeCode := Value;
end;

function TYFDataSource.GetConnectionDriver: string;
begin
  Result := FConnectionDriver;
end;

procedure TYFDataSource.SetConnectionDriver(const Value: string);
begin
  FConnectionDriver := Value;
end;

function TYFDataSource.GetConnectionPath: string;
begin
  Result := FConnectionPath;
end;

procedure TYFDataSource.SetConnectionPath(const Value: string);
begin
  FConnectionPath := Value;
end;

function TYFDataSource.GetConnectionString: string;
begin
  Result := FConnectionString;
end;

procedure TYFDataSource.SetConnectionString(const Value: string);
begin
  FConnectionString := Value;
end;

function TYFDataSource.GetConnectionTimeout: Int64;
begin
  Result := FConnectionTimeout;
end;

procedure TYFDataSource.SetConnectionTimeout(const Value: Int64);
begin
  FConnectionTimeout := Value;
end;

function TYFDataSource.GetUserName: string;
begin
  Result := FUserName;
end;

procedure TYFDataSource.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

function TYFDataSource.GetUserPassword: string;
begin
  Result := FUserPassword;
end;

procedure TYFDataSource.SetUserPassword(const Value: string);
begin
  FUserPassword := Value;
end;

function TYFDataSource.GetMinimumConnections: Int64;
begin
  Result := FMinimumConnections;
end;

procedure TYFDataSource.SetMinimumConnections(const Value: Int64);
begin
  FMinimumConnections := Value;
end;

function TYFDataSource.GetMaximumConnections: Int64;
begin
  Result := FMaximumConnections;
end;

procedure TYFDataSource.SetMaximumConnections(const Value: Int64);
begin
  FMaximumConnections := Value;
end;

function TYFDataSource.GetRefreshTime: Int64;
begin
  Result := FRefreshTime;
end;

procedure TYFDataSource.SetRefreshTime(const Value: Int64);
begin
  FRefreshTime := Value;
end;

function TYFDataSource.GetTimezone: string;
begin
  Result := FTimezone;
end;

procedure TYFDataSource.SetTimezone(const Value: string);
begin
  FTimezone := Value;
end;

function TYFDataSource.GetLogFile: string;
begin
  Result := FLogFile;
end;

procedure TYFDataSource.SetLogFile(const Value: string);
begin
  FLogFile := Value;
end;

function TYFDataSource.GetAccessLevelCode: TYFDataSourceTypes.TAccessLevelCode;
begin
  Result := FAccessLevelCode;
end;

procedure TYFDataSource.SetAccessLevelCode(const Value: TYFDataSourceTypes.TAccessLevelCode);
begin
  FAccessLevelCode := Value;
end;

function TYFDataSource.GetMaxRows: Int64;
begin
  Result := FMaxRows;
end;

procedure TYFDataSource.SetMaxRows(const Value: Int64);
begin
  FMaxRows := Value;
end;

function TYFDataSource.GetMaxAnalysisRows: Int64;
begin
  Result := FMaxAnalysisRows;
end;

procedure TYFDataSource.SetMaxAnalysisRows(const Value: Int64);
begin
  FMaxAnalysisRows := Value;
end;

function TYFDataSource.GetInheritChildSourceFilters: Boolean;
begin
  Result := FInheritChildSourceFilters;
end;

procedure TYFDataSource.SetInheritChildSourceFilters(const Value: Boolean);
begin
  FInheritChildSourceFilters := Value;
end;

function TYFDataSource.GetPlatformTypeCode: string;
begin
  Result := FPlatformTypeCode;
end;

procedure TYFDataSource.SetPlatformTypeCode(const Value: string);
begin
  FPlatformTypeCode := Value;
end;

function TYFDataSource.GetSourceLogIndicator: Boolean;
begin
  Result := FSourceLogIndicator;
end;

procedure TYFDataSource.SetSourceLogIndicator(const Value: Boolean);
begin
  FSourceLogIndicator := Value;
end;

function TYFDataSource.GetSourceOptions: IYFDataSourceOptionsList;
begin
  Result := FSourceOptions;
end;

procedure TYFDataSource.SetSourceOptions(const Value: IYFDataSourceOptionsList);
begin
  FSourceOptions := Value;
end;



{ TYFClientDataSource }

constructor TYFClientDataSource.Create;
begin
  inherited Create;
end;

function TYFClientDataSource.GetClientOrgId: Int64;
begin
  Result := FClientOrgId;
end;

function TYFClientDataSource.GetClientOrgName: string;
begin
  Result := FClientOrgName;
end;

function TYFClientDataSource.GetClientOrgRef: string;
begin
  Result := FClientOrgRef;
end;

function TYFClientDataSource.GetSourceId: Int64;
begin
  Result := FSourceId;
end;

function TYFClientDataSource.GetSourceName: string;
begin
  Result := FSourceName;
end;

procedure TYFClientDataSource.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  if AJSON.TryGetValue('clientOrgId', jv) then
    ClientOrgId := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('clientOrgRef', jv) then
    ClientOrgRef := jv.Value;

  if AJSON.TryGetValue('clientOrgName', jv) then
    ClientOrgName := jv.Value;

  if AJSON.TryGetValue('sourceId', jv) then
    SourceId := StrToIntDef(jv.Value, 0);

  if AJSON.TryGetValue('sourceName', jv) then
    SourceName := jv.Value;

end;

procedure TYFClientDataSource.SetclientOrgId(const Value: Int64);
begin
  FClientOrgId := Value;
end;

procedure TYFClientDataSource.SetclientOrgName(const Value: string);
begin
  FClientOrgName := Value;
end;

procedure TYFClientDataSource.SetclientOrgRef(const Value: string);
begin
  FClientOrgRef := Value;
end;

procedure TYFClientDataSource.SetsourceId(const Value: Int64);
begin
  FSourceId := Value;
end;

procedure TYFClientDataSource.SetsourceName(const Value: string);
begin
  FSourceName := Value;
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFDataSourceOption>(
    function: IYFDataSourceOption
    begin
      Result := TYFDataSourceOption.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFDataSourceOptionsList>(
    function: IYFDataSourceOptionsList
    begin
      Result := TYFDataSourceOptionsList.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFDataSource>(
    function: IYFDataSource
    begin
      Result := TYFDataSource.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFDataSources>(
    function: IYFDataSources
    begin
      Result := TYFDataSources.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFClientDataSource>(
    function: IYFClientDataSource
    begin
      Result := TYFClientDataSource.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFClientDataSourceList>(
    function: IYFClientDataSourceList
    begin
      Result := TYFClientDataSourceList.Create;
    end
  );

end.
