unit yellowfinbi.api.health.classes;

interface

uses
  System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics,
  yellowfinbi.api.health.intf;

type
  /// <summary>
  /// Default implementation of IYFNodeCacheInfo
  /// </summary>
  TYFNodeCacheInfo = class(TInterfacedObject, IYFNodeCacheInfo)
  private
    FCacheCurrentSize: Int64;
    FCacheMaxSize: Int64;
    FCacheType: TYFNodeInfoTypes.cacheType;

    function GetCacheCurrentSize: Int64;
    function GetCacheMaxSize: Int64;
    function GetCacheType: TYFNodeInfoTypes.cacheType;
    procedure SetCacheType(Value : TYFNodeInfoTypes.cacheType);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property CacheType: TYFNodeInfoTypes.cacheType read GetCacheType;
    property CacheCurrentSize: Int64 read GetCacheCurrentSize;
    property CacheMaxSize: Int64 read GetCacheMaxSize;
  end;

  TYFNodeCacheInfoList = class(TYFModelList<IYFNodeCacheInfo>, IYFNodeCacheInfoList)
  public
    procedure LoadFromJSON(const AJSON: TJSONObject); override;
    procedure LoadFromJSONArray(const AJSONArray: TJSONArray); override;
    constructor Create; overload;
  end;

  /// <summary>
  /// Default implementation of IYFConfigDBInfo
  /// </summary>
  TYFConfigDBInfo = class(TInterfacedObject, IYFConfigDBInfo)
  private
    FStatus: string;
    FMaxConnections: Integer;
    FMinConnections: Integer;
    FOpenConnections: Integer;
    FActiveConnections: Integer;

    function GetStatus: string;
    function GetMaxConnections: Integer;
    function GetMinConnections: Integer;
    function GetOpenConnections: Integer;
    function GetActiveConnections: Integer;
  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property Status: string read GetStatus;
    property MaxConnections: Integer read GetMaxConnections;
    property MinConnections: Integer read GetMinConnections;
    property OpenConnections: Integer read GetOpenConnections;
    property ActiveConnections: Integer read GetActiveConnections;
  end;

  /// <summary>
  /// Provides read-only information about a Yellowfin deployment node.
  /// </summary>
  TYFNodeInfo = class(TInterfacedObject, IYFNodeInfo)
  private
    FHostName: string;
    FApplicationVersion: string;
    FStatusCode: string;
    FAvailableProcessors: Integer;
    FJVMMemoryInUse: Int64;
    FJVMTotalMemory: Int64;
    FJVMFreeMemory: Int64;
    FJVMMaxMemory: Int64;
    FSystemMemory: Int64;
    FWebSessions: Integer;
    FCaches: IYFNodeCacheInfoList;
    FConfigDBInfo: IYFConfigDBInfo;

    function GetHostName: string;
    function GetApplicationVersion: string;
    function GetStatusCode: string;
    function GetAvailableProcessors: Integer;
    function GetJVMMemoryInUse: Int64;
    function GetJVMTotalMemory: Int64;
    function GetJVMFreeMemory: Int64;
    function GetJVMMaxMemory: Int64;
    function GetSystemMemory: Int64;
    function GetWebSessions: Integer;
    function GetCaches: IYFNodeCacheInfoList;
    function GetConfigDBInfo: IYFConfigDBInfo;
  public
    constructor Create; overload;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property HostName: string read GetHostName;
    property ApplicationVersion: string read GetApplicationVersion;
    property StatusCode: string read GetStatusCode;
    property AvailableProcessors: Integer read GetAvailableProcessors;
    property JVMMemoryInUse: Int64 read GetJVMMemoryInUse;
    property JVMTotalMemory: Int64 read GetJVMTotalMemory;
    property JVMFreeMemory: Int64 read GetJVMFreeMemory;
    property JVMMaxMemory: Int64 read GetJVMMaxMemory;
    property SystemMemory: Int64 read GetSystemMemory;
    property WebSessions: Integer read GetWebSessions;
    property Caches: IYFNodeCacheInfoList read GetCaches;
    property ConfigDBInfo: IYFConfigDBInfo read GetConfigDBInfo;
  end;

  TYFNodeInfoList = class(TYFModelList<IYFNodeInfo>, IYFNodeInfoList)
  public
    constructor Create; overload;
  end;

  /// <summary>
  /// Default implementation of IYFHealth
  /// </summary>
  TYFHealth = class(TInterfacedObject, IYFHealth)
  private
    FNodes: IYFNodeInfoList;
    FStatus: string;

    function GetNodes: IYFNodeInfoList;
    function GetStatus: string;
  public
    constructor Create; overload;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property Nodes: IYFNodeInfoList read GetNodes;
    property Status: string read GetStatus;
  end;

implementation

uses
  yellowfinbi.api.classfactory;

{ TYFNodeCacheInfo }

function TYFNodeCacheInfo.GetCacheCurrentSize: Int64;
begin
  Result := FCacheCurrentSize;
end;

function TYFNodeCacheInfo.GetCacheMaxSize: Int64;
begin
  Result := FCacheMaxSize;
end;

function TYFNodeCacheInfo.GetCacheType: TYFNodeInfoTypes.cacheType;
begin
  Result := FCacheType;
end;

procedure TYFNodeCacheInfo.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then
    Exit;

  if AJSON.TryGetValue('cacheType', jv) then
    // cache type from the key
    FCacheType := TYFNodeInfoTypes.GetValue<TYFNodeInfoTypes.cacheType>(
                  jv.Value,
                  TYFNodeInfoTypes.cacheType.viewCache);

  if AJSON.TryGetValue('cacheCurrentSize', jv) then
    FCacheCurrentSize := jv.Value.ToInt64;

  if AJSON.TryGetValue('cacheMaxSize', jv) then
    FCacheMaxSize := jv.Value.ToInt64;

end;

procedure TYFNodeCacheInfo.SetCacheType(Value: TYFNodeInfoTypes.cacheType);
begin
  FCacheType := Value;
end;

{ TYFNodeCacheInfoList }

constructor TYFNodeCacheInfoList.Create;
begin
  inherited Create('caches');
end;


procedure TYFNodeCacheInfoList.LoadFromJSON(const AJSON: TJSONObject);
var
  JV : TJSONValue;
begin
  //inherited;
  if AJSON = nil then
    Exit;

  Self.Items.Clear;

  for var CurrCacheType := Low(TYFNodeInfoTypes.cacheType) to High(TYFNodeInfoTypes.cacheType) do
  begin

    var cacheTypeStr := TYFNodeInfoTypes.ValueToString<TYFNodeInfoTypes.cacheType>(CurrCacheType);

    var JObj := TJSONObject.Create;
    try
      JObj.AddPair('cacheType',cacheTypeStr);

      if AJSON.TryGetValue(cacheTypeStr+'.cacheCurrentSize', jv) then
        JObj.AddPair('cacheCurrentSize',jv.Value);

      if AJSON.TryGetValue(cacheTypeStr+'.cacheMaxSize', jv) then
        JObj.AddPair('cacheMaxSize',jv.Value);

      var Item := NewItem(False);
      Item.LoadFromJSON(JObj);
      Self.Items.Add(Item);

    finally
      JObj.Free;
    end;

  end;
end;

procedure TYFNodeCacheInfoList.LoadFromJSONArray(const AJSONArray: TJSONArray);
begin
  inherited;
end;

{ TYFConfigDBInfo }

function TYFConfigDBInfo.GetActiveConnections: Integer;
begin
  Result := FActiveConnections;
end;

function TYFConfigDBInfo.GetMaxConnections: Integer;
begin
  Result := FMaxConnections;
end;

function TYFConfigDBInfo.GetMinConnections: Integer;
begin
  Result := FMinConnections;
end;

function TYFConfigDBInfo.GetOpenConnections: Integer;
begin
  Result := FOpenConnections;
end;

function TYFConfigDBInfo.GetStatus: string;
begin
  Result := FStatus;
end;

procedure TYFConfigDBInfo.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  if AJSON.TryGetValue('status', jv) then
    FStatus := jv.Value;

  if AJSON.TryGetValue('maxConnections', jv) then
    FMaxConnections := jv.Value.ToInteger;

  if AJSON.TryGetValue('minConnections', jv) then
    FMinConnections := jv.Value.ToInteger;

  if AJSON.TryGetValue('openConnections', jv) then
    FOpenConnections := jv.Value.ToInteger;

  if AJSON.TryGetValue('activeConnections', jv) then
    FActiveConnections := jv.Value.ToInteger;
end;

{ TYFNodeInfo }

constructor TYFNodeInfo.Create;
begin
  inherited Create;
  FCaches := TYFNodeCacheInfoList.Create;
  FConfigDBInfo := TYFConfigDBInfo.Create;
end;

function TYFNodeInfo.GetApplicationVersion: string;
begin
  Result := FApplicationVersion;
end;

function TYFNodeInfo.GetAvailableProcessors: Integer;
begin
  Result := FAvailableProcessors;
end;

function TYFNodeInfo.GetCaches: IYFNodeCacheInfoList;
begin
  Result := FCaches;
end;

function TYFNodeInfo.GetConfigDBInfo: IYFConfigDBInfo;
begin
  Result := FConfigDBInfo;
end;

function TYFNodeInfo.GetHostName: string;
begin
  Result := FHostName;
end;

function TYFNodeInfo.GetJVMFreeMemory: Int64;
begin
  Result := FJVMFreeMemory;
end;

function TYFNodeInfo.GetJVMMemoryInUse: Int64;
begin
  Result := FJVMMemoryInUse;
end;

function TYFNodeInfo.GetJVMTotalMemory: Int64;
begin
  Result := FJVMTotalMemory;
end;

function TYFNodeInfo.GetJVMMaxMemory: Int64;
begin
  Result := FJVMMaxMemory;
end;

function TYFNodeInfo.GetStatusCode: string;
begin
  Result := FStatusCode;
end;

function TYFNodeInfo.GetSystemMemory: Int64;
begin
  Result := FSystemMemory;
end;

function TYFNodeInfo.GetWebSessions: Integer;
begin
  Result := FWebSessions;
end;

procedure TYFNodeInfo.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON.TryGetValue('hostName', jv) then
    FHostName := jv.Value;

  if AJSON.TryGetValue('applicationVersion', jv) then
    FApplicationVersion := jv.Value;

  if AJSON.TryGetValue('statusCode', jv) then
    FStatusCode := jv.Value;

  if AJSON.TryGetValue('availableProcessors', jv) then
    FAvailableProcessors := jv.Value.ToInteger;

  if AJSON.TryGetValue('jvmMemoryInUse', jv) then
    FJVMMemoryInUse := jv.Value.ToInt64;

  if AJSON.TryGetValue('jvmTotalMemory', jv) then
    FJVMTotalMemory := jv.Value.ToInt64;

  if AJSON.TryGetValue('jvmFreeMemory', jv) then
    FJVMFreeMemory := jv.Value.ToInt64;

  if AJSON.TryGetValue('jvmMaxMemory', jv) then
    FJVMMaxMemory := jv.Value.ToInt64;

  if AJSON.TryGetValue('systemMemory', jv) then
    FSystemMemory := jv.Value.ToInt64;

  if AJSON.TryGetValue('webSessions', jv) then
    FWebSessions := jv.Value.ToInteger;

  if AJSON.TryGetValue('caches', jv) then
    FCaches.LoadFromJSON(jv as TJSONObject);

  if AJSON.TryGetValue('configDB', jv) then
    FConfigDBInfo.LoadFromJSON(jv as TJSONObject);
end;

constructor TYFNodeInfoList.Create;
begin
  inherited Create('nodes');
end;

{ TYFHealth }

constructor TYFHealth.Create;
begin
  inherited Create;
  FNodes := TYFNodeInfoList.Create;
end;

function TYFHealth.GetNodes: IYFNodeInfoList;
begin
  Result := FNodes;
end;

function TYFHealth.GetStatus: string;
begin
  Result := FStatus;
end;

procedure TYFHealth.LoadFromJSON(const AJSON: TJSONObject);
begin
  if AJSON = nil then Exit;
  FStatus := AJSON.GetValue<string>('statusCode', '');
  FNodes.LoadFromJSON(AJSON);
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFHealth>(
    function: IYFHealth
    begin
      Result := TYFHealth.Create;
    end);

  TYFFactoryRegistry.RegisterFactory<IYFNodeInfo>(
    function: IYFNodeInfo
    begin
      Result := TYFNodeInfo.Create;
    end);

  TYFFactoryRegistry.RegisterFactory<IYFNodeInfoList>(
    function: IYFNodeInfoList
    begin
      Result := TYFNodeInfoList.Create;
    end);

  TYFFactoryRegistry.RegisterFactory<IYFNodeCacheInfo>(
    function: IYFNodeCacheInfo
    begin
      Result := TYFNodeCacheInfo.Create;
    end);

  TYFFactoryRegistry.RegisterFactory<IYFNodeCacheInfoList>(
    function: IYFNodeCacheInfoList
    begin
      Result := TYFNodeCacheInfoList.Create;
    end);

  TYFFactoryRegistry.RegisterFactory<IYFConfigDBInfo>(
    function: IYFConfigDBInfo
    begin
      Result := TYFConfigDBInfo.Create;
    end);

end.

