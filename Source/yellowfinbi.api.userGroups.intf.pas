unit yellowfinbi.api.userGroups.intf;

interface

uses
  System.SysUtils, System.Classes, System.JSON, yellowfinbi.api.json,
  System.Generics.Collections, yellowfinbi.api.common, yellowfinbi.api.json.generics;

type
  TYFUserGroupTypes = class(TYFTypes)
    type
      {$SCOPEDENUMS ON}
      groupStatus = (OPEN, DRAFT);
      memberEntityType = (PERSON, GROUP, LDAP, ROLE);
      memberMembershipType = (INCLUDED, EXCLUDED);
      {$SCOPEDENUMS OFF}
  end;

  TYFUserGroupMembersPost = record
    entityType : TYFUserGroupTypes.memberEntityType;
    entityCode : string;
    membershipType : TYFUserGroupTypes.memberMembershipType
  end;

  TYFUserGroupMembersPatch = record
    memberId : string;
    membershipType : TYFUserGroupTypes.memberMembershipType
  end;


  IYFUserGroupListItemModel = interface(IYFJSON)
    ['{A7B8EEDD-7C19-4B44-97AD-94D409C1C154}']
    function GetUserGroupId: Int64;
    function GetShortDescription: string;
    function GetLongDescription: string;

    procedure SetUserGroupId(const Value: Int64);
    procedure SetShortDescription(const Value: string);
    procedure SetLongDescription(const Value: string);

    property UserGroupId: Int64 read GetUserGroupId write SetUserGroupId;
    property ShortDescription: string read GetShortDescription write SetShortDescription;
    property LongDescription: string read GetLongDescription write SetLongDescription;
  end;

  IYFUserGroups = interface(IYFModelList<IYFUserGroupListItemModel>)
  end;

  IYFUserGroup = interface(IYFUserGroupListItemModel)
    function GetIsSecureGroup :Boolean;
    procedure SetIsSecureGroup(const Value: Boolean);
    function GetGroupStatus :TYFUserGroupTypes.GroupStatus;
    procedure SetGroupStatus(const Value: TYFUserGroupTypes.GroupStatus);

    property isSecureGroup : Boolean read GetIsSecureGroup write SetIsSecureGroup;
    property groupStatus : TYFUserGroupTypes.GroupStatus read GetGroupStatus write SetGroupStatus;
  end;

  IYFUserGroupMemberListItem = interface(IYFLoadFromJSON)
    ['{50E6601F-C91D-43B0-927A-F775B4CE166A}']
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

    property GroupId: Int64 read GetGroupId write SetGroupId;
    property MemberId: string read GetMemberId write SetMemberId;
    property EntityType: TYFUserGroupTypes.memberEntityType read GetEntityType write SetEntityType;
    property EntityCode: string read GetEntityCode write SetEntityCode;
    property MemberName: string read GetMemberName write SetMemberName;
    property MembershipType: TYFUserGroupTypes.memberMembershipType read GetMembershipType write SetMembershipType;
  end;

  IYFUserGroupMembers = interface(IYFModelList<IYFUserGroupMemberListItem>)
  end;

implementation

end.
