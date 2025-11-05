unit yellowfinbi.api.security;

interface

uses yellowfinbi.api.transport.token, System.Classes, yellowfinbi.api.common;

type
  TYF_TokenRequests = class
    /// <summary>
    /// Creates a Refresh Token - Similar to an Application Key - allowing creation of Access Tokens to call the core API. The Refresh Token is used to "Refresh" the access tokens that have a timed validity period.
    /// </summary>
    /// <param name="ServerDetails">
    /// Requires an object that implements IYFServerDetails to read the HostURL, AppName (default is YELLOWFIN unless whitelabeled), and Timeout (default 6000ms)
    /// </param>
    /// <returns>
    /// Returns a TYFRefreshTokenResponse containing the Refresh token. - Its a good idea to store this rather than the admin Username / Password as a Refresh Token can always be invalidated. Responses are HTML codes. e.g. 200 = OK
    /// </returns>
    class function GetRefreshToken(const ServerDetails : IYFServerDetails;
                                   const AdminCredentials: IYFAdminCredentials;
                                   const yf_AccessToken: string = '') : IYFRefreshTokenResponse;

    class function DeleteRefreshToken(const ServerDetails : IYFServerDetails;
                                      const yf_AccessToken : string;
                                      const TokenID : Int64): Boolean;

    class function GetAccessToken (const ServerDetails : IYFServerDetails;
                                   const yf_RefreshToken: string) : IYFAccessTokenResponse;

    class function GetUserRefreshTokenNoPassword
                                  (const ServerDetails : IYFServerDetails;
                                   const yf_AdminAccessToken,
                                         yf_currUserID,
                                         orgID : string) : IYFRefreshTokenResponse;

    /// <summary>
    /// Creates a LoginToken for a specific user - requires an Access token.
    /// </summary>
    /// <param name="ServerDetails">
    /// Requires an object that implements IYFServerDetails to read the HostURL, AppName (default is YELLOWFIN unless whitelabeled), and Timeout (default 6000ms)
    /// </param>
    /// <param name="yf_AccessToken">
    /// Access token for authentication
    /// </param>
    /// <param name="yf_UserID">
    /// User ID / username of the Yellowfin user requesting the Login Token. (this might be their email)
    /// </param>
    /// <param name="yf_UserPassword">
    /// Leave blank if using Single Sign-On (SSO) - otherwise enter the password for the specified user.
    /// </param>
    /// <param name="yf_ClientOrg">
    /// Force a specific Tenant for users with multiple tenancy. Leave blank to allow the user to choose.
    /// </param>
    /// <param name="yf_loginParameters">
    /// Pass in the list of Values NAME=VALUE as per loginParameters described at
    /// https://developers.yellowfinbi.com/dev/api-docs/current/#operation/createLoginToken
    /// </param>
    /// <param name="yf_customerParameters">
    /// Optional - customer-specific parameters to pass during login.
    /// </param>
    /// <returns>
    /// Returns a TYFTokenResponse containing the authentication token. Responses are HTML codes. e.g. 200 = OK
    /// </returns>
    class function GetLoginToken  (const ServerDetails : IYFServerDetails;
                                   const yf_AccessToken,
                                         yf_UserID,
                                         yf_UserPassword,
                                         yf_ClientOrg : string;
                                   const yf_loginParameters : TStrings;
                                   const yf_customerParameters : string) : IYFTokenResponse;

    class function GetLoginTokenSSO(const ServerDetails : IYFServerDetails;
                                    const AdminCredentials: IYFAdminCredentials;
                                    const yf_UserID,
                                          yf_UserPassword,
                                          yf_ClientOrg : string;
                                    const yf_loginParameters : TStrings;
                                    const yf_customerParameters : string) : IYFTokenResponse;

  end;


implementation

uses System.SysUtils, System.JSON, REST.Types, System.StrUtils,
  REST.Client;

{ TYFTokenRequests }

class function TYF_TokenRequests.DeleteRefreshToken(
  const ServerDetails: IYFServerDetails; const yf_AccessToken : string; const TokenID: Int64): Boolean;
begin
  // 1 - No body required.
  // 2 - Create an Access Token based on the user for the Refresh Token.

  // Build the request and send it
  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        'api/refresh-tokens/'+TokenID.ToString,
        yf_AccessToken,
        nil); // no body required
  try
    // 3 - Call the API end point
    Transport.Execute;
    Result := Transport.RESTResponse.Status.Success;
  finally
    Transport.Free;
  end;

end;

class function TYF_TokenRequests.GetAccessToken(const ServerDetails : IYFServerDetails;
  const yf_RefreshToken: string): IYFAccessTokenResponse;
begin
  // 1 - No body required.
  // 2 - Create an Access Token based on the user for the Refresh Token.

  // Build the request and send it
  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmPost,
        ServerDetails,
        'api/access-tokens',
        yf_RefreshToken,
        nil); // no body required
  try
    // 3 - Call the API end point
    Result := Transport.ExecuteAccessToken;
  finally
    Transport.Free;
  end;

end;

class function TYF_TokenRequests.GetLoginToken(const ServerDetails : IYFServerDetails;
  const yf_AccessToken, yf_UserID, yf_UserPassword, yf_ClientOrg : string; {Blank for SSO}
  const yf_loginParameters : TStrings;  const yf_customerParameters : string): IYFTokenResponse;
begin

  // Build the request and send it
  var jsonObject := TJSONObject.Create;

  // Sign On User
  var signOnUser := TJSONObject.Create;
  signOnUser.AddPair('userName', yf_UserID);

  if (yf_UserPassword.IsEmpty = False) then
    signOnUser.AddPair('password', yf_UserPassword);

  if yf_ClientOrg > '' then
    signOnUser.AddPair('clientOrgRef', yf_ClientOrg);

  jsonObject.AddPair('signOnUser', signOnUser);

  // Login Params
  if (yf_loginParameters <> nil) and (yf_loginParameters.Count > 0) then
  begin
    var loginParams := TJSONArray.Create; // Created and then owned by jsonObject

    for var CurrValue in yf_loginParameters do
      loginParams.Add(CurrValue);

    jsonObject.AddPair('loginParameters',loginParams);
  end;

  jsonObject.AddPair('noPassword', BoolToStr(yf_UserPassword.IsEmpty, True));

  if yf_customerParameters > '' then
    jsonObject.AddPair('customParameters',yf_customerParameters);

  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmPost,
        ServerDetails,
        'api/login-tokens',
        yf_AccessToken,
        jsonObject);
  try
    Result := Transport.ExecuteToken;
  finally
    Transport.Free;
  end;

end;

class function TYF_TokenRequests.GetLoginTokenSSO(const ServerDetails : IYFServerDetails;
  const AdminCredentials: IYFAdminCredentials;
  const yf_UserID, yf_UserPassword, yf_ClientOrg : string;
  const yf_loginParameters : TStrings; const yf_customerParameters : string): IYFTokenResponse;
begin
  // 1) Build Request Body
  // 2) Adds to the transport
  // 3) Gets the token

  var JSONObject := TJSONObject.Create;

  // 1.a - Make the "signOnUser" JSON part of the data packet
  var signOnUser := TJSONObject.Create;
  signOnUser.AddPair('userName', yf_UserID);
  if yf_UserPassword > '' then
    signOnUser.AddPair('password', yf_UserPassword);
  if yf_ClientOrg > '' then
    signOnUser.AddPair('clientOrgRef', yf_ClientOrg);

  jsonObject.AddPair('signOnUser', signOnUser);
  jsonObject.AddPair('noPassword', BoolToStr(yf_UserPassword.IsEmpty, True));


  // 1.b - Make the "adminUser" JSON part of the data packet
  var adminUser  := TJSONObject.Create;
  adminUser.AddPair('userName', AdminCredentials.AdminUserName);
  adminUser.AddPair('password', AdminCredentials.AdminPassword);

  jsonObject.AddPair('adminUser', adminUser);

  // 1.c - Login Params
  if (yf_loginParameters <> nil) and (yf_loginParameters.Count > 0) then
  begin
    var loginParams := TJSONArray.Create; // Created and then owned by jsonObject

    for var CurrValue in yf_loginParameters do
      loginParams.Add(CurrValue);

    jsonObject.AddPair('loginParameters',loginParams);
  end;

  // 1.d - Add any custom Tracking param
  if yf_customerParameters > '' then
    jsonObject.AddPair('customParameters',yf_customerParameters);

  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmPost,
        ServerDetails,
        'api/rpc/login-tokens/create-sso-token',
        '', // SSO doesn't use an existing security token...
        jsonObject); // Transport takes ownership by default to remove object from memory
  try
    Result := Transport.ExecuteToken;
  finally
    Transport.Free;
  end;

end;

class function TYF_TokenRequests.GetRefreshToken(const ServerDetails : IYFServerDetails;
  const AdminCredentials: IYFAdminCredentials; const yf_AccessToken: string): IYFRefreshTokenResponse;
begin
  Assert(Assigned(ServerDetails),'Server Details Missing');
  Assert(Assigned(AdminCredentials),'Admin Credentials Missing');

  // Build the request and send it
  var jsonObject := TJSONObject.Create;
  jsonObject.AddPair('userName', AdminCredentials.AdminUserName);

  if not AdminCredentials.AdminPassword.IsEmpty then
    jsonObject.AddPair('password', AdminCredentials.AdminPassword);

  jsonObject.AddPair('clientOrgRef', AdminCredentials.ClientOrg);

  var FURL : string;
  if yf_AccessToken.IsEmpty then
    FURL := '/api/refresh-tokens'
  else if AdminCredentials.AdminPassword.IsEmpty then
    FURL := '/api/refresh-tokens?singleSignOn=true&noPassword=true'
  else
    FURL := '/api/refresh-tokens?singleSignOn=true';

  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmPost,
        ServerDetails,
        FURL,
        yf_AccessToken, // don't use an existing security token unless getting a user specific Refresh Token from admin user
        jsonObject);
  try
    Result := Transport.executeRefreshToken;
  finally
    Transport.Free;
  end;

end;

class function TYF_TokenRequests.GetUserRefreshTokenNoPassword(
  const ServerDetails : IYFServerDetails;
  const yf_AdminAccessToken, yf_currUserID, orgID : string): IYFRefreshTokenResponse;
begin
  //entryPoint = "api/refresh-tokens?singleSignOn=true&noPassword=true";

  var jsonObject := TJSONObject.Create;

  jsonObject.AddPair('userName', yf_currUserID);

  var Transport := TYFTransportToken.Create(nil,
        TRESTRequestMethod.rmPost,
        ServerDetails,
        'api/refresh-tokens?singleSignOn=true&noPassword=true',
        yf_AdminAccessToken, // don't use an existing security token...
        jsonObject);

  try
    Result := Transport.executeRefreshToken;
  finally
    Transport.Free;
  end;

end;

end.
