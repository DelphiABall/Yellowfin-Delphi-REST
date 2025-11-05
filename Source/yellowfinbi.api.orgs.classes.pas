unit yellowfinbi.api.orgs.classes;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, Yellowfinbi.api.JSON.generics,
  yellowfinbi.api.orgs.intf;

type
  /// <summary>
  ///   List of YF Org IYFOrgRelationship (Default implementation of TYFOrgRelationship)
  /// </summary>
  TYFOrgRelationships = class(TYFModelList<IYFOrgRelationship>, IYFOrgRelationships)
    constructor Create; overload;
  end;

  /// <summary>
  ///   TYFOrgRelationship is the default implementation of IYFOrgRelationship
  /// </summary>
  TYFOrgRelationship = class(TInterfacedObject, IYFOrgRelationship)
  strict private
    FRelationshipCode: string;
    FIpOrg: Int64;
    FOrgName: string;

    function GetRelationshipCode: string;
    procedure SetRelationshipCode(AValue: string);

    function GetIpOrg: Int64;
    procedure SetIpOrg(AValue: Int64);

    function GetOrgName: string;
    procedure SetOrgName(AValue: string);
  public
    property relationshipCode: string read GetRelationshipCode write SetRelationshipCode;
    property ipOrg: Int64 read GetIpOrg write SetIpOrg;
    property orgName: string read GetOrgName write SetOrgName;

    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;

  /// <summary>
  ///   TYFOrg implements IYFOrg to show the details of a YF Org.
  /// </summary>
  TYFOrg = class(TInterfacedObject, IYFOrg)
  strict private
    FIpOrg: Int64;
    FClientRefId: string;
    FName: string;
    FDefaultTimezone: string;
    FIsDefaultOrg: Boolean;
    FCustomStylePath: string;
    FRelationships: IYFOrgRelationships;

    function GetIpOrg: Int64;
    procedure SetIpOrg(Value: Int64);

    function GetClientRefId: string;
    procedure SetClientRefId(const Value: string);

    function GetName: string;
    procedure SetName(const Value: string);

    function GetDefaultTimezone: string;
    procedure SetDefaultTimezone(const Value: string);

    function GetIsDefaultOrg: Boolean;
    procedure SetIsDefaultOrg(Value: Boolean);

    function GetCustomStylePath: string;
    procedure SetCustomStylePath(const Value: string);

    function GetRelationships: IYFOrgRelationships;
    procedure SetRelationships(Value: IYFOrgRelationships);

  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromJSON(const AJSON: TJSONObject);

    property ipOrg: Int64 read GetIpOrg write SetIpOrg;
    property clientRefId: string read GetClientRefId write SetClientRefId;
    property name: string read GetName write SetName;
    property defaultTimezone: string read GetDefaultTimezone write SetDefaultTimezone;
    property isDefaultOrg: Boolean read GetIsDefaultOrg write SetIsDefaultOrg;
    property customStylePath: string read GetCustomStylePath write SetCustomStylePath;
    property relationships: IYFOrgRelationships read GetRelationships write SetRelationships;
  end;

  /// <summary>
  ///   List of Yellowfin Orgs, default implementation of IYFOrgs
  /// </summary>
  TYFOrgs = class(TYFModelList<IYFOrg>, IYFOrgs)
    constructor Create; overload;
  end;


implementation

uses  yellowfinbi.api.classfactory;

{ TYFOrgRelationship }

function TYFOrgRelationship.GetIpOrg: Int64;
begin
  Result := FIpOrg;
end;

function TYFOrgRelationship.GetOrgName: string;
begin
  Result := FOrgName;
end;

function TYFOrgRelationship.GetRelationshipCode: string;
begin
  Result := FRelationshipCode;
end;

procedure TYFOrgRelationship.LoadFromJSON(const AJSON: TJSONObject);
begin
  if AJSON = nil then Exit;
  relationshipCode := AJSON.GetValue<string>('relationshipCode');
  ipOrg := AJSON.GetValue<Int64>('ipOrg');
  orgName := AJSON.GetValue<string>('orgName');
end;

procedure TYFOrgRelationship.SetIpOrg(AValue: Int64);
begin
  FIpOrg := AValue;
end;

procedure TYFOrgRelationship.SetOrgName(AValue: string);
begin
  orgName := AValue;
end;

procedure TYFOrgRelationship.SetRelationshipCode(AValue: string);
begin
  relationshipCode := AValue;
end;

{ TYFOrg }

constructor TYFOrg.Create;
begin
  inherited Create;
  //relationships := TYFOrgRelationships.Create;
  relationships := TYFFactoryRegistry.CreateNew<IYFOrgRelationships>;
end;

destructor TYFOrg.Destroy;
begin
  inherited;
end;

procedure TYFOrg.LoadFromJSON(const AJSON: TJSONObject);
begin
  if AJSON = nil then Exit;

  ipOrg := AJSON.GetValue<Int64>('ipOrg', 0);
  clientRefId := AJSON.GetValue<string>('clientRefId', '');
  name := AJSON.GetValue<string>('name', '');
  defaultTimezone := AJSON.GetValue<string>('defaultTimezone', '');
  isDefaultOrg := AJSON.GetValue<Boolean>('isDefaultOrg', False);
  customStylePath := AJSON.GetValue<string>('customStylePath', '');

  relationships.LoadFromJSON(AJSON);
end;

function TYFOrg.GetIpOrg: Int64;
begin
  Result := FIpOrg;
end;

procedure TYFOrg.SetIpOrg(Value: Int64);
begin
  FIpOrg := Value;
end;

function TYFOrg.GetClientRefId: string;
begin
  Result := FClientRefId;
end;

procedure TYFOrg.SetClientRefId(const Value: string);
begin
  FClientRefId := Value;
end;

function TYFOrg.GetName: string;
begin
  Result := FName;
end;

procedure TYFOrg.SetName(const Value: string);
begin
  FName := Value;
end;

function TYFOrg.GetDefaultTimezone: string;
begin
  Result := FDefaultTimezone;
end;

procedure TYFOrg.SetDefaultTimezone(const Value: string);
begin
  FDefaultTimezone := Value;
end;

function TYFOrg.GetIsDefaultOrg: Boolean;
begin
  Result := FIsDefaultOrg;
end;

procedure TYFOrg.SetIsDefaultOrg(Value: Boolean);
begin
  FIsDefaultOrg := Value;
end;

function TYFOrg.GetCustomStylePath: string;
begin
  Result := FCustomStylePath;
end;

procedure TYFOrg.SetCustomStylePath(const Value: string);
begin
  FCustomStylePath := Value;
end;

function TYFOrg.GetRelationships: IYFOrgRelationships;
begin
  Result := FRelationships;
end;

procedure TYFOrg.SetRelationships(Value: IYFOrgRelationships);
begin
  FRelationships := Value;
end;

{ TYFOrgs }

constructor TYFOrgs.Create;
begin
  inherited Create(nil, 'items');
end;

{ TYFOrgRelationships }

constructor TYFOrgRelationships.Create;
begin
  inherited Create(nil, 'relationships');
end;

initialization
   TYFFactoryRegistry.RegisterFactory<IYFOrgs>(
    function: IYFOrgs
    begin
      Result := TYFOrgs.Create;
    end
  );

   TYFFactoryRegistry.RegisterFactory<IYFOrg>(
    function: IYFOrg
    begin
      Result := TYFOrg.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFOrgRelationships>(
    function() : IYFOrgRelationships
    begin
      Result := TYFOrgRelationships.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFOrgRelationship>(
    function() : IYFOrgRelationship
    begin
      Result := TYFOrgRelationship.Create;
    end
  );


end.
