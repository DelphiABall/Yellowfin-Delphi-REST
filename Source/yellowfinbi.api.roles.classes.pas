unit yellowfinbi.api.roles.classes;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  yellowfinbi.api.json, yellowfinbi.api.json.generics,
  yellowfinbi.api.roles.intf;

type
  TYFFunctions = class(TYFModelList<IYFFunction>, IYFFunctions)
  public
    constructor Create; overload;
    function FunctionByCode(aFunctionCode : string): IYFFunction;
  end;

  TYFFunction = class(TInterfacedObject, IYFFunction)
  private
    FFunctionCode: string;
    FFunctionName: string;
    FFunctionTypeCode: string;
    FFunctionDescription: string;

    FCanCreate: Boolean;
    FCanRead: Boolean;
    FCanUpdate: Boolean;
    FCanDelete: Boolean;

    function GetFunctionCode: string;
    function GetFunctionName: string;
    function GetFunctionTypeCode: string;
    function GetAccessLevelCode: string;
    function GetFunctionDescription: string;

    procedure SetFunctionCode(const Value: string);
    procedure SetFunctionName(const Value: string);
    procedure SetFunctionTypeCode(const Value: string);
    procedure SetAccessLevelCode(const Value: string);
    procedure SetFunctionDescription(const Value: string);
    function GetCanCreate: Boolean;
    function GetCanDelete: Boolean;
    function GetCanRead: Boolean;
    function GetCanUpdate: Boolean;
    procedure SetCanCreate(const Value: Boolean);
    procedure SetCanDelete(const Value: Boolean);
    procedure SetCanRead(const Value: Boolean);
    procedure SetCanUpdate(const Value: Boolean);

  public
    property FunctionCode: string read GetFunctionCode write SetFunctionCode;
    property FunctionName: string read GetFunctionName write SetFunctionName;
    property FunctionTypeCode: string read GetFunctionTypeCode write SetFunctionTypeCode;
    property AccessLevelCode: string read GetAccessLevelCode write SetAccessLevelCode;
    property FunctionDescription: string read GetFunctionDescription write SetFunctionDescription;

    property CanCreate: Boolean read GetCanCreate write SetCanCreate;
    property CanRead: Boolean read GetCanRead write SetCanRead;
    property CanUpdate: Boolean read GetCanUpdate write SetCanUpdate;
    property CanDelete: Boolean read GetCanDelete write SetCanDelete;

    procedure LoadFromJSON(const AJSON: TJSONObject);
    function ToJSON: string;
    function AsJSON: TJSONValue;
  end;

  TYFRole = class(TInterfacedObject, IYFRole)
  private
    FRoleName: string;
    FRoleDescription: string;
    FRoleCode: string;
    FMandatoryFlag: Boolean;
    FDefaultFlag: Boolean;
    FGuestFlag: Boolean;
    FFunctions: IYFFunctions;

    function GetRoleName: string;
    function GetRoleDescription: string;
    function GetRoleCode: string;
    function GetMandatoryFlag: Boolean;
    function GetDefaultFlag: Boolean;
    function GetGuestFlag: Boolean;
    function GetFunctions: IYFFunctions;

    procedure SetRoleName(const Value: string);
    procedure SetRoleDescription(const Value: string);
    procedure SetRoleCode(const Value: string);
    procedure SetMandatoryFlag(const Value: Boolean);
    procedure SetDefaultFlag(const Value: Boolean);
    procedure SetGuestFlag(const Value: Boolean);
    procedure SetFunctions(const Value: IYFFunctions);

  public
    constructor Create;
    destructor Destroy; override;

    property RoleName: string read GetRoleName write SetRoleName;
    property RoleDescription: string read GetRoleDescription write SetRoleDescription;
    property RoleCode: string read GetRoleCode write SetRoleCode;
    property MandatoryFlag: Boolean read GetMandatoryFlag write SetMandatoryFlag;
    property DefaultFlag: Boolean read GetDefaultFlag write SetDefaultFlag;
    property GuestFlag: Boolean read GetGuestFlag write SetGuestFlag;
    property Functions: IYFFunctions read GetFunctions write SetFunctions;

    procedure LoadFromJSON(const AJSON: TJSONObject);
    function ToJSON: string;
    function AsJSON: TJSONValue;
  end;

  TYFRoles = class(TYFModelListJSON<IYFRole>, IYFRoles)
    constructor Create; overload;
    function RoleByCode(aCode : string): IYFRole;
  end;


implementation

uses
  yellowfinbi.api.classfactory;

{ TYFFunction }

procedure TYFFunction.LoadFromJSON(const AJSON: TJSONObject);
var
  Value : string;
begin
  if AJSON.TryGetValue('functionCode', Value) then
    FunctionCode := Value;

  if AJSON.TryGetValue('functionName', Value) then
    FunctionName := Value;

  if AJSON.TryGetValue('functionTypeCode', Value) then
    FunctionTypeCode := Value;

  if AJSON.TryGetValue('accessLevelCode', Value) then
    AccessLevelCode := Value;

  if AJSON.TryGetValue('functionDescription', Value) then
    FunctionDescription := Value;
end;

function TYFFunction.GetFunctionCode: string;
begin
  Result := FFunctionCode;
end;

function TYFFunction.GetFunctionName: string;
begin
  Result := FFunctionName;
end;

function TYFFunction.GetFunctionTypeCode: string;
begin
  Result := FFunctionTypeCode;
end;

function TYFFunction.AsJSON: TJSONValue;
begin
  var JSON := TJSONObject.Create;
  JSON.AddPair('functionCode', FunctionCode);
  JSON.AddPair('functionName', FunctionName);
  if FunctionTypeCode <> '' then
    JSON.AddPair('functionTypeCode', FunctionTypeCode);
  if AccessLevelCode <> '' then
    JSON.AddPair('accessLevelCode', AccessLevelCode);
  JSON.AddPair('functionDescription', FunctionDescription);
  Result := JSON;
end;

function TYFFunction.ToJSON: string;
begin
  var JSON := AsJSON;
  try
    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;


function TYFFunction.GetAccessLevelCode: string;
begin
  Result := '';
  if CanCreate then
    Result := Result + 'C';
  if CanRead then
    Result := Result + 'R';
  if CanUpdate then
    Result := Result + 'U';
  if CanDelete then
    Result := Result + 'D';
end;

function TYFFunction.GetCanCreate: Boolean;
begin
  Result := FCanCreate;
end;

function TYFFunction.GetCanRead: Boolean;
begin
  Result := FCanRead;
end;

function TYFFunction.GetCanUpdate: Boolean;
begin
  Result := FCanUpdate;
end;

function TYFFunction.GetCanDelete: Boolean;
begin
  Result := FCanDelete;
end;

function TYFFunction.GetFunctionDescription: string;
begin
  Result := FFunctionDescription;
end;

procedure TYFFunction.SetFunctionCode(const Value: string);
begin
  FFunctionCode := Value;
end;

procedure TYFFunction.SetFunctionName(const Value: string);
begin
  FFunctionName := Value;
end;

procedure TYFFunction.SetFunctionTypeCode(const Value: string);
begin
  FFunctionTypeCode := Value;
end;

procedure TYFFunction.SetAccessLevelCode(const Value: string);
var
  FValue : string;
begin
  FValue := Uppercase(Value);
  CanCreate := Value.Contains('C');
  CanRead := Value.Contains('R');
  CanUpdate := Value.Contains('U');
  CanDelete := Value.Contains('D');
end;

procedure TYFFunction.SetCanCreate(const Value: Boolean);
begin
  FCanCreate := Value;
end;

procedure TYFFunction.SetCanRead(const Value: Boolean);
begin
  FCanRead := Value;
end;

procedure TYFFunction.SetCanUpdate(const Value: Boolean);
begin
  FCanUpdate := Value;
end;

procedure TYFFunction.SetCanDelete(const Value: Boolean);
begin
  FCanDelete := Value;
end;

procedure TYFFunction.SetFunctionDescription(const Value: string);
begin
  FFunctionDescription := Value;
end;

{ TYFRoles }

constructor TYFRoles.Create;
begin
  var AFunc : TFunc<IYFRole>  :=
    function : IYFRole
      begin
        Result := TYFRole.Create;
      end;
  Create(AFunc, 'items');
end;

function TYFRoles.RoleByCode(aCode: string): IYFRole;
begin
  aCode := Uppercase(aCode);
  for var Role in Items do
    if Uppercase(Role.RoleCode) = aCode then
      Exit(Role);

  Result := nil;
end;

{ TYFRole }

constructor TYFRole.Create;
begin
  FFunctions := TYFFunctions.Create;
end;

destructor TYFRole.Destroy;
begin
  inherited;
end;

procedure TYFRole.LoadFromJSON(const AJSON: TJSONObject);
begin
  AJSON.TryGetValue('roleName', FRoleName);
  AJSON.TryGetValue('roleDescription', FRoleDescription);
  AJSON.TryGetValue('roleCode', FRoleCode);
  AJSON.TryGetValue('mandatoryFlag', FMandatoryFlag);
  AJSON.TryGetValue('defaultFlag', FDefaultFlag);
  AJSON.TryGetValue('guestFlag', FGuestFlag);

  FFunctions.LoadFromJSON(AJSON);
end;

function TYFRole.GetRoleName: string;
begin
  Result := FRoleName;
end;

procedure TYFRole.SetRoleName(const Value: string);
begin
  FRoleName := Value;
end;

function TYFRole.GetRoleDescription: string;
begin
  Result := FRoleDescription;
end;

procedure TYFRole.SetRoleDescription(const Value: string);
begin
  FRoleDescription := Value;
end;

function TYFRole.GetRoleCode: string;
begin
  Result := FRoleCode;
end;

procedure TYFRole.SetRoleCode(const Value: string);
begin
  FRoleCode := Value;
end;

function TYFRole.GetMandatoryFlag: Boolean;
begin
  Result := FMandatoryFlag;
end;

procedure TYFRole.SetMandatoryFlag(const Value: Boolean);
begin
  FMandatoryFlag := Value;
end;

function TYFRole.GetDefaultFlag: Boolean;
begin
  Result := FDefaultFlag;
end;

procedure TYFRole.SetDefaultFlag(const Value: Boolean);
begin
  FDefaultFlag := Value;
end;

function TYFRole.GetGuestFlag: Boolean;
begin
  Result := FGuestFlag;
end;

procedure TYFRole.SetGuestFlag(const Value: Boolean);
begin
  FGuestFlag := Value;
end;

function TYFRole.GetFunctions: IYFFunctions;
begin
  Result := FFunctions;
end;

procedure TYFRole.SetFunctions(const Value: IYFFunctions);
begin
  FFunctions := Value;
end;

function TYFRole.AsJSON: TJSONValue;
var
  FuncArray: TJSONArray;
  Func: IYFFunction;
begin
  var JSON := TJSONObject.Create;

  JSON.AddPair('roleName', RoleName);
  JSON.AddPair('roleDescription', RoleDescription);
  JSON.AddPair('roleCode', RoleCode);
  JSON.AddPair('mandatoryFlag', TJSONBool.Create(MandatoryFlag));
  JSON.AddPair('defaultFlag', TJSONBool.Create(DefaultFlag));
  JSON.AddPair('guestFlag', TJSONBool.Create(GuestFlag));

  FuncArray := TJSONArray.Create;
  for Func in Functions.Items do
    FuncArray.AddElement(TJSONObject.ParseJSONValue(Func.ToJSON) as TJSONObject);
  JSON.AddPair('functions', FuncArray);
  Result := JSON;
end;

function TYFRole.ToJSON: string;
begin
  var JSON := AsJSON;
  try
    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;


{ TYFFunctions }

constructor TYFFunctions.Create;
begin
  inherited Create('functions');
end;

function TYFFunctions.FunctionByCode(aFunctionCode: string): IYFFunction;
begin
  aFunctionCode := Uppercase(aFunctionCode);
  for var FFunc in Items do
    if Uppercase(FFunc.FunctionCode) = aFunctionCode then
      Exit(FFunc);
end;

initialization
   TYFFactoryRegistry.RegisterFactory<IYFFunctions>(
    function: IYFFunctions
    begin
      Result := TYFFunctions.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFFunction>(
    function: IYFFunction
    begin
      Result := TYFFunction.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFRoles>(
    function: IYFRoles
    begin
      Result := TYFRoles.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFRole>(
    function: IYFRole
    begin
      Result := TYFRole.Create;
    end
  );

end.
