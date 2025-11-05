unit yellowfinbi.api.roles.intf;

interface

uses
  System.SysUtils,
  yellowfinbi.api.json, yellowfinbi.api.json.generics;

type
  IYFFunction = interface(IYFJSON)
    ['{D0F1D2E3-F4A5-4767-BF3B-8AC8F1A12B34}']
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

    property FunctionCode: string read GetFunctionCode write SetFunctionCode;
    property FunctionName: string read GetFunctionName write SetFunctionName;
    property FunctionTypeCode: string read GetFunctionTypeCode write SetFunctionTypeCode;
    property AccessLevelCode: string read GetAccessLevelCode write SetAccessLevelCode;
    property FunctionDescription: string read GetFunctionDescription write SetFunctionDescription;
  end;

  IYFFunctions = interface(IYFModelList<IYFFunction>)
  end;

  IYFRole = interface(IYFJSON)
    ['{A51C4C09-23A1-4AB9-A486-BB9A2C7D2D4C}']
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

    property RoleName: string read GetRoleName write SetRoleName;
    property RoleDescription: string read GetRoleDescription write SetRoleDescription;
    property RoleCode: string read GetRoleCode write SetRoleCode;
    property MandatoryFlag: Boolean read GetMandatoryFlag write SetMandatoryFlag;
    property DefaultFlag: Boolean read GetDefaultFlag write SetDefaultFlag;
    property GuestFlag: Boolean read GetGuestFlag write SetGuestFlag;
    property Functions: IYFFunctions read GetFunctions write SetFunctions;
  end;

  IYFRoles = interface(IYFModelListJSON<IYFRole>)
  end;


implementation

end.
