unit yellowfinbi.api.security.tokenManager.intf;

interface

uses yellowfinbi.api.transport.token, yellowfinbi.api.security, yellowfinbi.api.common;

type

  IYFRefreshTokenManager = interface
  ['{60B868EE-6FF0-49C0-9CB1-9F69B41103C7}']
    procedure SetTag(Value : string);
    function GetTag: string;
    function GetRefreshToken : IYFRefreshTokenResponse;

    property RefreshToken : IYFRefreshTokenResponse read GetRefreshToken;
    property Tag : string read GetTag write SetTag;
  end;

  IYFRefreshTokenManagerList = interface
  ['{CB621454-0F67-4A51-83A3-BA74FE25115F}']
    function FindByTag(aTag : string) : IYFRefreshTokenManager;
    function GetRefreshToken(const ServerDetails : IYFServerDetails;
                             const AdminCredentials: IYFAdminCredentials;
                             const yf_AccessToken: string = '') : IYFRefreshTokenResponse;
  end;


  IYFAccessTokenManager = interface
  ['{C605F9AB-1B7E-4652-BF51-8828CB0AECF6}']
    function GetAccessToken: string;
    function GetExpiry: TDateTime;
    function GetTokenHasExpired: Boolean;
    function GetAutoRefresh: Boolean;
    function GetServerDetails: IYFServerDetails;
    function GetAccessTokenResponse: IYFAccessTokenResponse;
    procedure SetAutoRefresh(const Value: Boolean);

    procedure Refresh;

    property AccessToken : string read GetAccessToken;
    property Expiry : TDateTime read GetExpiry;
    property TokenHasExpired : Boolean read GetTokenHasExpired;
    property AutoRefresh : Boolean read GetAutoRefresh write SetAutoRefresh;
    property ServerDetails : IYFServerDetails read GetServerDetails;
    property Response : IYFAccessTokenResponse read GetAccessTokenResponse;
  end;


implementation

end.
