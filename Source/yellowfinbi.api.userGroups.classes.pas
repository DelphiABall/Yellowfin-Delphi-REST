unit yellowfinbi.api.userGroups.classes;

interface

uses
  System.SysUtils, System.Classes, System.JSON, yellowfinbi.api.json,
  System.Generics.Collections, yellowfinbi.api.common, yellowfinbi.api.json.generics,
  yellowfinbi.api.userGroups.intf;

type
  TYFUserGroupListItemModel = class(TInterfacedObject, IYFUserGroupListItemModel)
  private
    FUserGroupId: Int64;
    FShortDescription: string;
    FLongDescription: string;

    function GetUserGroupId: Int64;
    function GetShortDescription: string;
    function GetLongDescription: string;

    procedure SetUserGroupId(const Value: Int64);
    procedure SetShortDescription(const Value: string);
    procedure SetLongDescription(const Value: string);
  public
    property UserGroupId: Int64 read GetUserGroupId write SetUserGroupId;
    property ShortDescription: string read GetShortDescription write SetShortDescription;
    property LongDescription: string read GetLongDescription write SetLongDescription;

    procedure LoadFromJSON(const AJSON: TJSONObject); virtual;
    function ToJSON: string;
    function AsJSON: TJSONValue; virtual;
  end;

  /// <summary>
  /// List of IUserGroupListItemModel
  /// </summary>
  TYFUserGroups = class(TYFModelList<IYFUserGroupListItemModel>, IYFUserGroups)
    constructor Create; overload;
  end;


  TYFUserGroup = class(TYFUserGroupListItemModel, IYFUserGroup)
  strict private
    FIsSecureGroup: Boolean;
    FGroupStatus : TYFUserGroupTypes.GroupStatus;

    function GetIsSecureGroup :Boolean;
    procedure SetIsSecureGroup(const Value: Boolean);
    function GetGroupStatus :TYFUserGroupTypes.GroupStatus;
    procedure SetGroupStatus(const Value: TYFUserGroupTypes.GroupStatus);
  public
    procedure LoadFromJSON(const AJSON: TJSONObject); override;
    function AsJSON: TJSONValue; override;

    /// <summary>
    ///   A secure group can only be edited by a member of that group
    /// </summary>
    property isSecureGroup : Boolean read GetIsSecureGroup write SetIsSecureGroup;

    property groupStatus : TYFUserGroupTypes.GroupStatus read GetGroupStatus write SetGroupStatus;
  end;

  TYFUserGroupMemberListItem = class(TInterfacedObject, IYFUserGroupMemberListItem)
  private
    FGroupId: Int64;
    FMemberId: string;
    FEntityType: TYFUserGroupTypes.memberEntityType;
    FEntityCode: string;
    FMemberName: string;
    FMembershipType: TYFUserGroupTypes.memberMembershipType;

    function GetGroupId: Int64;
    function GetMemberId: string;
    function GetEntityType: TYFUserGroupTypes.memberEntityType;
    function GetEntityCode: string;
    function GetMemberName: string;
    function GetMembershipType: TYFUserGroupTypes.memberMembershipType;

    procedure SetGroupId(const Value: Int64);
    procedure SetMemberId(const Value: string);
    procedure SetEntityType(const Value: TYFUserGroupTypes.memberEntityType);
    procedure SetEntityCode(const Value: string);
    procedure SetMemberName(const Value: string);
    procedure SetMembershipType(const Value: TYFUserGroupTypes.memberMembershipType);
  public
    property GroupId: Int64 read GetGroupId write SetGroupId;
    property MemberId: string read GetMemberId write SetMemberId;
    property EntityType: TYFUserGroupTypes.memberEntityType read GetEntityType write SetEntityType;
    property EntityCode: string read GetEntityCode write SetEntityCode;
    property MemberName: string read GetMemberName write SetMemberName;
    property MembershipType: TYFUserGroupTypes.memberMembershipType read GetMembershipType write SetMembershipType;

    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;

  TYFUserGroupMembers = class(TYFModelList<IYFUserGroupMemberListItem>, IYFUserGroupMembers)
    constructor Create; overload;
  end;


implementation

uses yellowfinbi.api.classfactory;

{ TUserGroupListItemModel Implementation }

function TYFUserGroupListItemModel.GetUserGroupId: Int64;
begin
  Result := FUserGroupId;
end;

function TYFUserGroupListItemModel.GetShortDescription: string;
begin
  Result := FShortDescription;
end;

function TYFUserGroupListItemModel.AsJSON: TJSONValue;
begin
  var JSON := TJSONObject.Create;
  //JSON.AddPair('userGroupId', UserGroupId);
  JSON.AddPair('groupName', ShortDescription);
  JSON.AddPair('groupDescription', LongDescription);
  Result := JSON;
end;

function TYFUserGroupListItemModel.GetLongDescription: string;
begin
  Result := FLongDescription;
end;

procedure TYFUserGroupListItemModel.SetUserGroupId(const Value: Int64);
begin
  FUserGroupId := Value;
end;

function TYFUserGroupListItemModel.ToJSON: string;
begin
  var JSON := AsJSON;
  try
    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;

procedure TYFUserGroupListItemModel.SetShortDescription(const Value: string);
begin
  FShortDescription := Value;
end;

procedure TYFUserGroupListItemModel.SetLongDescription(const Value: string);
begin
  FLongDescription := Value;
end;

procedure TYFUserGroupListItemModel.LoadFromJSON(const AJSON: TJSONObject);
begin
  AJSON.TryGetValue<Int64>('userGroupId', FUserGroupId);
  AJSON.TryGetValue<string>('shortDescription', FShortDescription);
  AJSON.TryGetValue<string>('longDescription', FLongDescription);
end;

{ TYFUserGroup }

function TYFUserGroup.AsJSON: TJSONValue;
begin
  var OBJ := inherited AsJSON as TJSONObject;
  OBJ.AddPair('groupStatus', TYFUserGroupTypes.ValueToString<TYFUserGroupTypes.groupStatus>(GroupStatus));
  OBJ.AddPair('isSecureGroup',isSecureGroup);
  Result := OBJ;
end;

function TYFUserGroup.GetGroupStatus: TYFUserGroupTypes.GroupStatus;
begin
  Result:= FGroupStatus;
end;

function TYFUserGroup.GetIsSecureGroup: Boolean;
begin
  Result := FIsSecureGroup;
end;

procedure TYFUserGroup.LoadFromJSON(const AJSON: TJSONObject);
begin
  inherited;
  AJSON.TryGetValue<Boolean>('isSecureGroup',FIsSecureGroup);
  var S : string;
  if AJSON.TryGetValue<string>('groupStatus',S) then
  begin
    groupStatus := TYFUserGroupTypes.GetValue<TYFUserGroupTypes.groupStatus>(S, TYFUserGroupTypes.groupStatus.OPEN);
  end;
end;

procedure TYFUserGroup.SetGroupStatus(
  const Value: TYFUserGroupTypes.GroupStatus);
begin
  FGroupStatus := Value;
end;

procedure TYFUserGroup.SetIsSecureGroup(const Value: Boolean);
begin
  FIsSecureGroup := Value;
end;

{ TYFUserGroupMemberListItem }

function TYFUserGroupMemberListItem.GetGroupId: Int64;
begin
  Result := FGroupId;
end;

procedure TYFUserGroupMemberListItem.SetGroupId(const Value: Int64);
begin
  FGroupId := Value;
end;

function TYFUserGroupMemberListItem.GetMemberId: string;
begin
  Result := FMemberId;
end;

procedure TYFUserGroupMemberListItem.SetMemberId(const Value: string);
begin
  FMemberId := Value;
end;

function TYFUserGroupMemberListItem.GetEntityType: TYFUserGroupTypes.memberEntityType;
begin
  Result := FEntityType;
end;

procedure TYFUserGroupMemberListItem.SetEntityType(const Value: TYFUserGroupTypes.memberEntityType);
begin
  FEntityType := Value;
end;

function TYFUserGroupMemberListItem.GetEntityCode: string;
begin
  Result := FEntityCode;
end;

procedure TYFUserGroupMemberListItem.SetEntityCode(const Value: string);
begin
  FEntityCode := Value;
end;

function TYFUserGroupMemberListItem.GetMemberName: string;
begin
  Result := FMemberName;
end;

procedure TYFUserGroupMemberListItem.SetMemberName(const Value: string);
begin
  FMemberName := Value;
end;

function TYFUserGroupMemberListItem.GetMembershipType: TYFUserGroupTypes.memberMembershipType;
begin
  Result := FMembershipType;
end;

procedure TYFUserGroupMemberListItem.SetMembershipType(const Value: TYFUserGroupTypes.memberMembershipType);
begin
  FMembershipType := Value;
end;

procedure TYFUserGroupMemberListItem.LoadFromJSON(const AJSON: TJSONObject);
var
  strEntityType, strMembershipType : string;
begin
  if AJSON = nil then
    Exit;

  AJSON.TryGetValue('groupId', FGroupId);
  AJSON.TryGetValue('memberId', FMemberId);
  AJSON.TryGetValue('entityCode', FEntityCode);
  AJSON.TryGetValue('memberName', FMemberName);

  if AJSON.TryGetValue<string>('entityType', strEntityType) then
    FEntityType := TYFUserGroupTypes.GetValue<TYFUserGroupTypes.memberEntityType>(strEntityType, EntityType);

  if AJSON.TryGetValue<string>('membershipType', strMembershipType) then
    FMembershipType := TYFUserGroupTypes.GetValue<TYFUserGroupTypes.memberMembershipType>(strMembershipType, MembershipType);
end;

{ TYFUserGroupMembers }
constructor TYFUserGroupMembers.Create;
begin
  var Func : TFunc<IYFUserGroupMemberListItem>  :=
    function() : IYFUserGroupMemberListItem
    begin
      Result := TYFUserGroupMemberListItem.Create;
    end;

  inherited Create(func, 'items');
end;

{ TYFUserGroups }

constructor TYFUserGroups.Create;
begin
  var Func : TFunc<IYFUserGroupListItemModel>  :=
    function() : IYFUserGroupListItemModel
    begin
      Result := TYFUserGroupListItemModel.Create;
    end;

  inherited Create(func, 'items');
end;

initialization

  TYFFactoryRegistry.RegisterFactory<IYFUserGroupListItemModel>(
    function: IYFUserGroupListItemModel
    begin
      Result := TYFUserGroupListItemModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserGroups>(
    function: IYFUserGroups
    begin
      Result := TYFUserGroups.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserGroup>(
    function: IYFUserGroup
    begin
      Result := TYFUserGroup.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserGroupMemberListItem>(
    function: IYFUserGroupMemberListItem
    begin
      Result := TYFUserGroupMemberListItem.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserGroupMembers>(
    function: IYFUserGroupMembers
    begin
      Result := TYFUserGroupMembers.Create;
    end
  );
end.
