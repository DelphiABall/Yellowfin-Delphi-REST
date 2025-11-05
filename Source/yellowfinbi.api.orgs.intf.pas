unit yellowfinbi.api.orgs.intf;

interface

uses System.Generics.Collections,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics;

type
  IYFOrgRelationship = interface(IYFLoadFromJSON)
  ['{7B3D1849-5B2C-4994-B80A-0B249FCD96F8}']
    function GetRelationshipCode: string;
    procedure SetRelationshipCode(AValue: string);

    function GetIpOrg: Int64;
    procedure SetIpOrg(AValue: Int64);

    function GetOrgName: string;
    procedure SetOrgName(AValue: string);

    property relationshipCode: string read GetRelationshipCode write SetRelationshipCode;
    property ipOrg: Int64 read GetIpOrg write SetIpOrg;
    property orgName: string read GetOrgName write SetOrgName;
  end;

  IYFOrgRelationships = interface(IYFModelList<IYFOrgRelationship>)
    ['{179533A6-A169-4071-9072-2A83A04C31EF}']
  end;

  IYFOrg = interface(IYFLoadFromJSON)
  ['{A34CFF14-8D71-4F6A-8AF9-5F64C1D3FAF7}']
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

    property ipOrg: Int64 read GetIpOrg write SetIpOrg;
    property clientRefId: string read GetClientRefId write SetClientRefId;
    property name: string read GetName write SetName;
    property defaultTimezone: string read GetDefaultTimezone write SetDefaultTimezone;
    property isDefaultOrg: Boolean read GetIsDefaultOrg write SetIsDefaultOrg;
    property customStylePath: string read GetCustomStylePath write SetCustomStylePath;
    property relationships: IYFOrgRelationships read GetRelationships write SetRelationships;
  end;

  IYFOrgs = interface(IYFModelList<IYFOrg>)
    ['{17702336-050B-4F89-836B-DB7C8050F180}']
  end;

implementation

end.
