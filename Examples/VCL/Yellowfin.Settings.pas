unit Yellowfin.Settings;

interface

uses yellowfinbi.api.security.tokenManager, yellowfinbi.api.transport.token,
  yellowfinbi.api.common;

const
  YF_URL =  'https://sandbox.yellowfinbi.com/';
  YF_INSTANCE_NAME = 'YELLOWFIN';
  YF_ADMIN_USER = 'admin@yellowfin.com.au';
  YF_ADMIN_PASSWORD = 'test';
  YF_ORG = 'Default';
  YF_TIMEOUT = 6000;

  function RefreshToken : string;
  function RefreshTokenObj : IYFRefreshTokenResponse;
  function AccessToken : string;
  function ConfigData : TYellowfinServerConfig;
  procedure ClearYFTokens;

implementation

uses System.SysUtils;

var
  FRefreshTokenManager : TYFRefreshTokenManager;
  FAccessTokenManager : TYFAccessTokenManager;
  FConfigData : TYellowfinServerConfig;


procedure ClearYFTokens;
begin
  // Free the refresh token first, so it can then remove with the current access token.
  if Assigned(FRefreshTokenManager) then
    FreeAndNil(FRefreshTokenManager);

  if Assigned(FAccessTokenManager) then
    FreeAndNil(FAccessTokenManager);

end;

function ConfigData : TYellowfinServerConfig;
begin
  if not Assigned(FConfigData) then
  begin
    FConfigData := TYellowfinServerConfig.Create(YF_URL,
                                                 YF_INSTANCE_NAME,
                                                 YF_ADMIN_USER,
                                                 YF_ADMIN_PASSWORD,
                                                 YF_ORG,
                                                 YF_TIMEOUT);
  end;

  Result := FConfigData;
end;


function RefreshToken : string;
begin
  if Assigned(FRefreshTokenManager) then
    Exit(FRefreshTokenManager.RefreshToken.Token);

  FRefreshTokenManager := TYFRefreshTokenManager.Create(FConfigData.ServerDetails, FConfigData.AdminCredentials);
  Result := FRefreshTokenManager.RefreshToken.Token;
end;

function RefreshTokenObj : IYFRefreshTokenResponse;
begin
  if Assigned(FRefreshTokenManager) then
    Exit(FRefreshTokenManager.RefreshToken)
  else
    Exit(nil);
end;

function AccessToken : string;
begin
  if Assigned(FAccessTokenManager) then
    Exit(FAccessTokenManager.AccessToken);

  FAccessTokenManager := TYFAccessTokenManager.Create(FConfigData.ServerDetails, RefreshToken, true);
  Result := FAccessTokenManager.AccessToken;

end;


initialization
begin
  FAccessTokenManager := nil;
end;

finalization
begin
  ClearYFTokens;

  if Assigned(FConfigData) then
    FConfigData.Free;

end;


end.
