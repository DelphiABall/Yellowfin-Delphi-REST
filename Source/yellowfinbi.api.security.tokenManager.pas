unit yellowfinbi.api.security.tokenManager;

interface

uses
  yellowfinbi.api.transport.token, System.SysUtils, yellowfinbi.api.security,
  yellowfinbi.api.common, System.Generics.Collections, yellowfinbi.api.security.tokenManager.intf;

type
  TYFGetCurrentAdminAccessToken = reference to function(Sender: IYFRefreshTokenManager): string;

  TYFRefreshTokenManager = class(TinterfacedObject, IYFRefreshTokenManager)
  private
    FServerDetails : IYFServerDetails;
    FUserCredentials: IYFAdminCredentials;

    FRefreshTokenResponse : IYFRefreshTokenResponse;
    FTag: string;
    FAutoRemove: TYFGetCurrentAdminAccessToken;
    function GetRefreshToken: IYFRefreshTokenResponse;
    procedure SetTag(Value : string);
    function GetTag: string;

  public
    constructor Create(const aServerDetails : IYFServerDetails;
                       const aUserCredentials: IYFAdminCredentials;
                       const yf_AccessToken: string = '';  // Used if creating for another user.
                       aAutoRemoveToken : TYFGetCurrentAdminAccessToken = nil;
                       const aTag : string = '');

    destructor Destroy; override;

    property RefreshToken : IYFRefreshTokenResponse read GetRefreshToken;

    // Use if you need to store a value with the Regresh Token, Defaults to the specific User Name.
    property Tag : string read GetTag write SetTag;
  end;

  TYFRefreshTokenManagerList = class(TInterfacedObject, IYFRefreshTokenManagerList)
  private
    FAutoRemoveToken: TYFGetCurrentAdminAccessToken;
    FItems : TList<IYFRefreshTokenManager>;
    function GetItems : TList<IYFRefreshTokenManager>;
  public
    constructor Create(aAutoRemoveToken : TYFGetCurrentAdminAccessToken);
    destructor Destroy; override;

    function FindByTag(aTag : string) : IYFRefreshTokenManager;
    function GetRefreshToken(const ServerDetails : IYFServerDetails;
                             const AdminCredentials: IYFAdminCredentials;
                             const yf_AccessToken: string = '') : IYFRefreshTokenResponse;

    property Items: TList<IYFRefreshTokenManager> read GetItems;
  end;


  TYFAccessTokenManager = class(TInterfacedObject, IYFAccessTokenManager)
  private
    FRefreshToken : string;

    FServerDetails : IYFServerDetails;
    FAccessTokenResponse : IYFAccessTokenResponse;
    FAutoRefresh: Boolean;
    function GetAccessToken: string;
    function GetExpiry: TDateTime;
    function GetTokenHasExpired: Boolean;
    function GetAutoRefresh: Boolean;
    function GetServerDetails: IYFServerDetails;
    function GetAccessTokenResponse: IYFAccessTokenResponse;
    procedure SetAutoRefresh(const Value: Boolean);

  public
    constructor Create(const aServerDetails : IYFServerDetails; const aRefreshToken : string; const aAutoRefreshAccessToken : Boolean);
    procedure Refresh;

    property AccessToken : string read GetAccessToken;
    property Expiry : TDateTime read GetExpiry;
    property TokenHasExpired : Boolean read GetTokenHasExpired;
    property AutoRefresh : Boolean read GetAutoRefresh write SetAutoRefresh;
    property ServerDetails : IYFServerDetails read GetServerDetails;
    property Response : IYFAccessTokenResponse read GetAccessTokenResponse;
  end;

implementation

{ TYFAccessTokenManager }

constructor TYFAccessTokenManager.Create(const aServerDetails : IYFServerDetails;
  const aRefreshToken : string; const aAutoRefreshAccessToken : Boolean);
begin
  Assert(aRefreshToken.IsEmpty = False, 'Refresh Token Missing');
  Assert(Assigned(aServerDetails), 'Server Details Missing');

  inherited Create;
  FServerDetails := aServerDetails;
  FRefreshToken := aRefreshToken;
  FAutoRefresh := aAutoRefreshAccessToken;

  if FAutoRefresh then
    Refresh;
end;

function TYFAccessTokenManager.GetAccessToken: string;
begin
  if TokenHasExpired and AutoRefresh then
    Refresh;
  // Get New Token

  if Assigned(FAccessTokenResponse) then
    Result := FAccessTokenResponse.Token
  else
    Result := '';
end;

function TYFAccessTokenManager.GetAccessTokenResponse: IYFAccessTokenResponse;
begin
  Result := FAccessTokenResponse;
end;

function TYFAccessTokenManager.GetAutoRefresh: Boolean;
begin
  Result := FAutoRefresh;
end;

function TYFAccessTokenManager.GetExpiry: TDateTime;
begin
  if Assigned(FAccessTokenResponse) and FAccessTokenResponse.Successful then
    Result := FAccessTokenResponse.Expiry
  else
    Result := 0;
end;

function TYFAccessTokenManager.GetServerDetails: IYFServerDetails;
begin
  Result := FServerDetails;
end;

function TYFAccessTokenManager.GetTokenHasExpired: Boolean;
begin
  Result := (Expiry <= Now);
end;

procedure TYFAccessTokenManager.Refresh;
begin
  FAccessTokenResponse := TYF_TokenRequests.GetAccessToken(FServerDetails, FRefreshToken);
end;

procedure TYFAccessTokenManager.SetAutoRefresh(const Value: Boolean);
begin
  FAutoRefresh := Value;
end;

{ TYFRefreshTokenManager }

constructor TYFRefreshTokenManager.Create(const aServerDetails: IYFServerDetails;
  const aUserCredentials: IYFAdminCredentials;
  const yf_AccessToken: string; aAutoRemoveToken : TYFGetCurrentAdminAccessToken;
  const aTag: string);
begin
  inherited Create;

  FUserCredentials := aUserCredentials;
  FServerDetails := aServerDetails;
  FAutoRemove := aAutoRemoveToken;

  if aTag = '' then
    Tag :=  FUserCredentials.AdminUserName
  else
    Tag := aTag;

  FRefreshTokenResponse := TYF_TokenRequests.GetRefreshToken(FServerDetails, FUserCredentials, yf_AccessToken);
end;

destructor TYFRefreshTokenManager.Destroy;
begin
  if Assigned(FAutoRemove) and Assigned(FRefreshTokenResponse) then
  begin
    var AToken := FAutoRemove(Self);
    if AToken > '' then
      TYF_TokenRequests.DeleteRefreshToken(FServerDetails, AToken, RefreshToken.ID);
  end;

  inherited;
end;

function TYFRefreshTokenManager.GetRefreshToken: IYFRefreshTokenResponse;
begin
  Result := FRefreshTokenResponse;
end;

function TYFRefreshTokenManager.GetTag: string;
begin
  Result := FTag;
end;

procedure TYFRefreshTokenManager.SetTag(Value: string);
begin
  FTag := Value;
end;

{ TYFRefreshTokenManagerList }

constructor TYFRefreshTokenManagerList.Create(
  aAutoRemoveToken: TYFGetCurrentAdminAccessToken);
begin
  inherited Create;

  FAutoRemoveToken := aAutoRemoveToken;
  FItems := TList<IYFRefreshTokenManager>.Create;

end;

destructor TYFRefreshTokenManagerList.destroy;
begin
  var Obj : IYFRefreshTokenManager;

  // Remove it reverse Order...
  for var Idx := Pred(Items.Count) downto 0 do
  begin
    Obj := Items[Idx];
    Items.Remove(Obj);  // This frees the object in no other references exist to the interface.
  end;

  inherited;
end;

function TYFRefreshTokenManagerList.FindByTag(
  aTag: string): IYFRefreshTokenManager;
begin
  Result := nil;

  for var Obj in Items do
    if Obj.Tag = aTag then
      Exit(Obj);
end;

function TYFRefreshTokenManagerList.GetItems: TList<IYFRefreshTokenManager>;
begin
  Result := FItems;
end;

function TYFRefreshTokenManagerList.GetRefreshToken(
  const ServerDetails: IYFServerDetails;
  const AdminCredentials: IYFAdminCredentials;
  const yf_AccessToken: string = ''): IYFRefreshTokenResponse;
begin
  var FToken := FindByTag(AdminCredentials.AdminUserName);

  if not Assigned(FToken) then
  begin
    FToken := TYFRefreshTokenManager.Create(ServerDetails, AdminCredentials, yf_AccessToken, FAutoRemoveToken);
    if Assigned(FToken) and (FToken.RefreshToken.Successful) then
      Items.Add(FToken)
  end;

  if Assigned(FToken) then
    Result := FToken.RefreshToken
  else
    Result := nil;
end;

end.
