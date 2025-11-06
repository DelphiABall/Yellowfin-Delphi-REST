program YFSimpleAPIExample;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  REST.Transport in '..\..\Source\REST.Transport.pas',
  yellowfinbi.api.cache.intf in '..\..\Source\yellowfinbi.api.cache.intf.pas',
  yellowfinbi.api.cache in '..\..\Source\yellowfinbi.api.cache.pas',
  yellowfinbi.api.categories.classes in '..\..\Source\yellowfinbi.api.categories.classes.pas',
  yellowfinbi.api.categories.intf in '..\..\Source\yellowfinbi.api.categories.intf.pas',
  yellowfinbi.api.categories in '..\..\Source\yellowfinbi.api.categories.pas',
  yellowfinbi.api.classes in '..\..\Source\yellowfinbi.api.classes.pas',
  yellowfinbi.api.classfactory in '..\..\Source\yellowfinbi.api.classfactory.pas',
  yellowfinbi.api.common in '..\..\Source\yellowfinbi.api.common.pas',
  yellowfinbi.api.content.classes in '..\..\Source\yellowfinbi.api.content.classes.pas',
  yellowfinbi.api.content.intf in '..\..\Source\yellowfinbi.api.content.intf.pas',
  yellowfinbi.api.content in '..\..\Source\yellowfinbi.api.content.pas',
  yellowfinbi.api.dashboards.classes in '..\..\Source\yellowfinbi.api.dashboards.classes.pas',
  yellowfinbi.api.dashboards.intf in '..\..\Source\yellowfinbi.api.dashboards.intf.pas',
  yellowfinbi.api.dashboards in '..\..\Source\yellowfinbi.api.dashboards.pas',
  yellowfinbi.api.datasources.classes in '..\..\Source\yellowfinbi.api.datasources.classes.pas',
  yellowfinbi.api.datasources.intf in '..\..\Source\yellowfinbi.api.datasources.intf.pas',
  yellowfinbi.api.datasources in '..\..\Source\yellowfinbi.api.datasources.pas',
  yellowfinbi.api.filters.classes in '..\..\Source\yellowfinbi.api.filters.classes.pas',
  yellowfinbi.api.filters.intf in '..\..\Source\yellowfinbi.api.filters.intf.pas',
  yellowfinbi.api.health.classes in '..\..\Source\yellowfinbi.api.health.classes.pas',
  yellowfinbi.api.health.intf in '..\..\Source\yellowfinbi.api.health.intf.pas',
  yellowfinbi.api.health in '..\..\Source\yellowfinbi.api.health.pas',
  yellowfinbi.api.images.classes in '..\..\Source\yellowfinbi.api.images.classes.pas',
  yellowfinbi.api.images.intf in '..\..\Source\yellowfinbi.api.images.intf.pas',
  yellowfinbi.api.images in '..\..\Source\yellowfinbi.api.images.pas',
  yellowfinbi.api.intf in '..\..\Source\yellowfinbi.api.intf.pas',
  yellowfinbi.api.json.generics in '..\..\Source\yellowfinbi.api.json.generics.pas',
  yellowfinbi.api.json in '..\..\Source\yellowfinbi.api.json.pas',
  yellowfinbi.api.orgs.classes in '..\..\Source\yellowfinbi.api.orgs.classes.pas',
  yellowfinbi.api.orgs.intf in '..\..\Source\yellowfinbi.api.orgs.intf.pas',
  yellowfinbi.api.orgs in '..\..\Source\yellowfinbi.api.orgs.pas',
  yellowfinbi.api in '..\..\Source\yellowfinbi.api.pas',
  yellowfinbi.api.presentations.classes in '..\..\Source\yellowfinbi.api.presentations.classes.pas',
  yellowfinbi.api.presentations.intf in '..\..\Source\yellowfinbi.api.presentations.intf.pas',
  yellowfinbi.api.presentations in '..\..\Source\yellowfinbi.api.presentations.pas',
  yellowfinbi.api.reports.classes in '..\..\Source\yellowfinbi.api.reports.classes.pas',
  yellowfinbi.api.reports.intf in '..\..\Source\yellowfinbi.api.reports.intf.pas',
  yellowfinbi.api.reports in '..\..\Source\yellowfinbi.api.reports.pas',
  yellowfinbi.api.roles.classes in '..\..\Source\yellowfinbi.api.roles.classes.pas',
  yellowfinbi.api.roles.intf in '..\..\Source\yellowfinbi.api.roles.intf.pas',
  yellowfinbi.api.roles in '..\..\Source\yellowfinbi.api.roles.pas',
  yellowfinbi.api.security in '..\..\Source\yellowfinbi.api.security.pas',
  yellowfinbi.api.security.tokenManager in '..\..\Source\yellowfinbi.api.security.tokenManager.pas',
  yellowfinbi.api.template in '..\..\Source\yellowfinbi.api.template.pas',
  yellowfinbi.api.transport.classes in '..\..\Source\yellowfinbi.api.transport.classes.pas',
  yellowfinbi.api.transport.generics in '..\..\Source\yellowfinbi.api.transport.generics.pas',
  yellowfinbi.api.transport in '..\..\Source\yellowfinbi.api.transport.pas',
  yellowfinbi.api.transport.token in '..\..\Source\yellowfinbi.api.transport.token.pas',
  yellowfinbi.api.userGroups.classes in '..\..\Source\yellowfinbi.api.userGroups.classes.pas',
  yellowfinbi.api.userGroups.intf in '..\..\Source\yellowfinbi.api.userGroups.intf.pas',
  yellowfinbi.api.userGroups in '..\..\Source\yellowfinbi.api.userGroups.pas',
  yellowfinbi.api.users.classes in '..\..\Source\yellowfinbi.api.users.classes.pas',
  yellowfinbi.api.users.intf in '..\..\Source\yellowfinbi.api.users.intf.pas',
  yellowfinbi.api.users in '..\..\Source\yellowfinbi.api.users.pas',
  System.Classes,
  System.JSON,
  System.TypInfo,
  yellowfinbi.api.security.tokenManager.intf in '..\..\Source\yellowfinbi.api.security.tokenManager.intf.pas',
  System.IniFiles,
  System.NetEncoding;

var
  orgID: string;
  AdminRefreshToken : IYFRefreshTokenResponse;
  AdminAccessToken  : IYFAccessTokenManager;  
  LoginToken: IYFTokenResponse;
  TokenManager : IYFRefreshTokenManagerList;
  ConfigData : TYellowfinServerConfig;
  
begin  
  {$REGION 'Credentials'}
  var INI := TIniFile.Create('YFSandbox.ini');
  try
    var YF_URL            := INI.ReadString('SANDBOX', 'URL', 'https://sandbox.yellowfinbi.com');
    var YF_INSTANCE_NAME  := INI.ReadString('SANDBOX', 'INSTANCE_NAME', 'YELLOWFIN');
    var YF_ADMIN_USER     := INI.ReadString('SANDBOX', 'USERNAME' , '');
    var YF_ADMIN_PASSWORD := TNetEncoding.Base64.Decode(INI.ReadString('SANDBOX', 'PASSWORD', '')); // This isn't encrypted - just encoded. Don't use in production. 
    var YF_ORG            := INI.ReadString('SANDBOX', 'TENANT', '');
    var YF_TIMEOUT        := INI.ReadInteger('SANDBOX', 'TIMEOUT', 6000);

    if (YF_ADMIN_USER > '') or (YF_ADMIN_PASSWORD > '') or (YF_ORG > '') then
    begin
      WriteLn(Format('You are about to connect to %s on %s',[YF_ORG, YF_URL] ));
      WriteLn(Format('With user %s',[YF_ADMIN_USER] ));
      WriteLn('Press C to change details, or anyother key to continue');
      var aResponse : Char;
      Readln(aResponse);
      if Uppercase(aResponse) = 'C' then
      begin
        YF_ADMIN_USER := '';
        YF_ADMIN_PASSWORD := '';
        YF_ORG := '';
      end;
    end;

    while (YF_ADMIN_USER = '') do 
    begin
      writeln('What is your SANDBOX user name?');
      Readln(YF_ADMIN_USER);      
      INI.WriteString('SANDBOX','USERNAME', YF_ADMIN_USER);
    end;    

    while (YF_ADMIN_PASSWORD = '') do 
    begin
      writeln('What is your SANDBOX password?');
      Readln(YF_ADMIN_PASSWORD);

      writeln('Would you like to save the password for subsequent runs? Y or N');
      var SavePassword : Char;
      Readln(SavePassword);
      if SavePassword = 'Y' then
        INI.WriteString('SANDBOX','PASSWORD', TNetEncoding.Base64.Encode(YF_ADMIN_PASSWORD))
      else 
        INI.WriteString('SANDBOX','PASSWORD', '');
    end;

    while (YF_ORG = '') do 
    begin
      writeln('What is your SANDBOX Tenant_ID / Org_ID?');
      Readln(YF_ORG);
      INI.WriteString('SANDBOX','TENANT', YF_ORG);
    end;
    {$ENDREGION}

    ConfigData := TYellowfinServerConfig.Create(
      YF_URL,
      YF_INSTANCE_NAME,
      YF_ADMIN_USER,
      YF_ADMIN_PASSWORD,
      YF_ORG,
      YF_TIMEOUT);
    
  finally
    INI.Free;
  end;
  
  try

    // This demo uses the 
    // yellowfinbi.api.security.tokenManager
    // Defining the AccessToken response will enable auto free-ing of all Resource Tokens. 
    TokenManager := TYFRefreshTokenManagerList.Create(function(Sender: IYFRefreshTokenManager): string
                                                      begin
                                                        if Assigned(AdminAccessToken) then                                                                  
                                                          Result := AdminAccessToken.AccessToken
                                                        else 
                                                          Result := '';
                                                      end);
      
    try  
      orgID := ConfigData.AdminCredentials.ClientOrg;
      Writeln('Welcome to the sample for showing how to connect to Yellowfin REST API from Delphi!');
      Writeln;
      Writeln('For more details on the API, visit https://developers.yellowfinbi.com/dev/api-docs/current');
      Writeln('This is designed to provide helper methods to get you started quickly, passing the endpoint to the YFTransport method and also shows how to use the different tokens');
      Writeln;

      Writeln('The Yellowfin API uses 3 different tokens. Refresh, Access and Login');
      Writeln('> "Refresh Token" - is long lasting and is linked to a specific user');
      Writeln('> "Access Token"  - is short lived token, to provide access to the API on behalf of the Refresh Token User');
      Writeln('> "Login Token"   - is single use token used for single sign on. It is possible to set a number of params to effect how the login elements are rendered (e.g. with System headers, log off buttons etc)');

      Writeln('Press Enter to continue');
      Readln;
              
      // Refresh Token
      Writeln;
      Writeln('Refresh Token: - Required to get a Access Token ');
      AdminRefreshToken := TokenManager.GetRefreshToken(ConfigData.ServerDetails, ConfigData.AdminCredentials);
      
      Writeln('Status: ' + AdminRefreshToken.Status.ToString);
      Writeln('Refresh Token: ' + AdminRefreshToken.Token);
      Writeln('Refresh Token ID: ' + AdminRefreshToken.ID.ToString);
      Writeln;

      if not AdminRefreshToken.Successful then begin
        Writeln('Unsuccessful Response. Terminating');
        Readln;
        Exit;
      end;

      // Access Token
      Writeln('Access Token: (lasts 20 minutes - 1200 seconds) - Used to call most of the Yellowfin API, is linked to the user from the Refresh Token');
      //To manyally manage a token call TYF_TokenRequests.GetAccessToken(ConfigData.ServerDetails, AdminRefreshToken.Token);
      AdminAccessToken := TYFAccessTokenManager.Create(ConfigData.ServerDetails, AdminRefreshToken.Token, True);

      Writeln('Status: ' + AdminAccessToken.Response.Status.ToString);
      Writeln('Access Token: ' + AdminAccessToken.AccessToken);
      Writeln('Expiry: '+ FormatDateTime('HH:NN.SS',AdminAccessToken.Expiry));
      Writeln;

      Writeln('List Users (Name / ID)');
      Writeln('----------------------');
      var UsersList : IYFSimpleUserModelList := TYFSimpleUserModelList.Create;
      if TYF_Users.GetUsers(ConfigData.ServerDetails, AdminAccessToken.AccessToken, nil, UsersList).Successful then
      begin
        for var User in UsersList.Items do
        begin
          Writeln(User.name+' /  '+User.userId.ToString+' / '+ GetEnumName(TypeInfo(TYFUserTypes.userConnectionStatus), Ord(User.userConnectionStatus)) );
        end;

        Writeln('');
        var I : Int64;

        if UsersList.Count = 1 then
          I := UsersList[0].userId
        else begin
          Writeln('Enter UserID to select a user...');
          Readln(I);
          Writeln('');
        end;

        // [USERS] 1. When Fetching a User, you can either pass in your own object that implements IYFUser
        var User : IYFUser := TYFUser.Create;
        if TYF_Users.GetUserByID(ConfigData.ServerDetails, AdminAccessToken.AccessToken, I, User).Successful and Assigned(User) then
        begin
          var Orgs : IYFOrgs := TYFOrgs.Create;
          if TYF_Orgs.GetUserOrgs(ConfigData.ServerDetails, AdminAccessToken.AccessToken, I, Orgs).Successful then
          begin
            Writeln(Format('User %S has access to Orgs:',[User.FirstName+' '+User.LastName]));
            for var Org in Orgs.Items do
            begin
              if Org.isDefaultOrg then
                Writeln(Org.name+' / '+ Org.clientRefId+ ' ['+Org.ipOrg.ToString+'] - Default')
              else
                Writeln(Org.name+' / '+ Org.clientRefId+ ' ['+Org.ipOrg.ToString+']')
            end;
            Writeln;
          end;


          // Login Token for User
          Writeln('Login Token: (Single Use)');

          var YF_Params := TStringList.Create;
          try
            // See  https://developers.yellowfinbi.com/dev/api-docs/current/#tag/login-tokens
            // There are many more for setting / hiding content

            YF_Params.Add('YFTOOLBAR=FALSE'); // Hides the tool bar for navigation inside Yellowfin
            YF_Params.Add('ENTRY=TIMELINE');  // Sets where you want to enter into Yellowfin
            YF_Params.Add('DISABLEHEADER=TRUE'); // Hides the branding at the top / Header
            YF_Params.Add('DISABLEFOOTER=TRUE');
            YF_Params.Add('DISABLESIDENAV=TRUE');
            YF_Params.Add('DISABLELOGOFF=TRUE');

            var UserName := User.Email; // If your system users a different value, you need to pass in that - Default is email
            var userPassword := ''; // Default to '' for Single Sign On  / Empty Password requires SIMPLE_AUTHENTICATION = TRUE

            LoginToken := TYF_TokenRequests.GetLoginToken(ConfigData.ServerDetails, AdminAccessToken.AccessToken, UserName, userPassword, orgID, YF_Params, '');

            Writeln('Status: ' + LoginToken.Status.ToString);

            // SSO URL Example
            if LoginToken.Successful then
            begin
              Writeln('Login Token: ' + LoginToken.Token);
              Writeln;
              // 'SSO URL Example, using the LoginToken just created with the specific paramas specified'
              // Learn more @ https://wiki.yellowfinbi.com/display/yfcurrent/Defining+Login+Session+Options'

              Writeln('*******************************************************************');
              Writeln('**** Open this URL in a browser to see how Single Signon Works ****');
              Writeln('**** The URL will open using the params specified in code      ****');
              Writeln('****                                                           ****');
              Writeln(ConfigData.ServerDetails.hostURL + '/logon.i4?LoginWebserviceId=' + LoginToken.Token);
              Writeln('****                                                           ****');
              Writeln('*******************************************************************');
              Writeln;
            end
            else begin
              Writeln('LoginToken Failed');
              WriteLn('Data: ' + LoginToken.Data);
              Writeln;
            end;


            Writeln('Alternative Method to get a SSO token - Use this approach if you don''t have other admin calls to make on the API');
            var SSOToken := TYF_TokenRequests.GetLoginTokenSSO(ConfigData.ServerDetails,ConfigData.AdminCredentials, userName, userPassword, orgID, YF_Params, '');
            Writeln('SSO Login Status: ' + SSOToken.Status.ToString);
            if SSOToken.Successful then
            begin
              Writeln('SSO Login Token: ' + SSOToken.Token);
              Writeln(ConfigData.ServerDetails.hostURL + '/logon.i4?LoginWebserviceId=' + SSOToken.Token);
            end else
            begin
              WriteLn('GetLoginTokenSSO Failed');
              Writeln('Data: '+SSOToken.Data);
            end;
            Writeln;
          finally
            YF_Params.Free;
          end;


          /// Now we know the User, we need to get the User with RefreshToken.
          // Checking Refresh Token Creation for other user.
          var UserCredentials : IYFAdminCredentials := TYFServerAdminCredentials.Create(
             User.Email, // Assuming using Email as the ID on the Server
             '', // Going to use Singls sign-on so no password
             ConfigData.AdminCredentials.ClientOrg
             );

          // Pass in the Current Access token for the system admin to get the user refresh token
          // var UserRefreshToken := TYF_TokenRequests.GetRefreshToken(ConfigData.ServerDetails, UserCredentials, AdminAccessToken.Token);
          var UserRefreshToken := TokenManager.GetRefreshToken(ConfigData.ServerDetails, UserCredentials, AdminAccessToken.AccessToken);

          // Now get an Access token for the user
          if not UserRefreshToken.Successful then
          begin
            Writeln('Failed to get User Specific Refresh Token');
            Writeln('Status : '+UserRefreshToken.Status.ToString);
            Writeln('Data : '+UserRefreshToken.Data);
          end
          else
          begin
            Writeln('User Refresh Token : '+UserRefreshToken.Token);

            var UserAccessToken := TYF_TokenRequests.GetAccessToken(ConfigData.ServerDetails, UserRefreshToken.Token);
          
            // Update the user with the new RefreshToken to see all details
            // This will enable visibility and access to update more details.
            TYF_Users.GetUserByID(ConfigData.ServerDetails, UserAccessToken.Token, I, User);

            WriteLn('Name: '+User.FirstName+' '+User.LastName);
            WriteLn('Status: '+TYFUserTypes.ValueToString<TYFUserTypes.status>(User.Status));
            WriteLn('Title: '+User.Title);
            WriteLn('Zone: '+User.TimeZoneCode);
            WriteLn('Language: '+User.PreferredLanguageCode);
            WriteLn('Entry: '+User.UserPreferences.EntryPage);
            WriteLn('allowUsersToConnect: '+TYFUserTypes.ValueToString<TYFUserTypes.AllowUsersToConnect>(User.UserPreferences.AllowUsersToConnect));
            WriteLn('allowUsersToPostOnTimeline: '+TYFUserTypes.ValueToString<TYFUserTypes.allowUsersToPostOnTimeline>(User.UserPreferences.AllowUsersToPostOnTimeline));
            WriteLn('UserName: '+User.UserName);
            WriteLn('----');

            // Showing / Testing other API's can be used... No need to call multiple times You can use any one of these methods.
            WriteLn('Email: '+User.Email);

            // [USERS] There are three ways to get a User. Depending on what ID you are using on your system.
            // TYF_Users.GetUserByID(ConfigData.ServerDetails, UserAccessToken.Token, {user ID}, User)
            // TYF_Users.GetUserByEmailAddress(ConfigData.ServerDetails, UserAccessToken.Token, {email}, User)
            // TYF_Users.GetUserByUserName(ConfigData.ServerDetails, UserAccessToken.Token, {username}, User)
            var NamedUser : IYFUser;
            if TYF_Users.GetUserByUserName(ConfigData.ServerDetails, UserAccessToken.Token, User.UserName, NamedUser).Successful and
              Assigned(NamedUser) then
            begin
              // Showing / Testing other API's can be used... No need to call multiple times You can use any one of these methods.
              WriteLn('UserName: '+NamedUser.UserName);
            end
            else
              Writeln('GetUserByUserName returned no user details');

            // Updating User.
            Writeln;
            Writeln('Updating User');
            Writeln('DraftContentItemCount is currently '+User.UserPreferences.DraftContentItemCount.ToString);
            User.UserPreferences.DraftContentItemCount := User.UserPreferences.DraftContentItemCount +1;

            if User.UserPreferences.DraftContentItemCount > 10 then
              User.UserPreferences.DraftContentItemCount := 5
            else if User.UserPreferences.DraftContentItemCount < 5 then
              User.UserPreferences.DraftContentItemCount := 5;

            if User.UserPreferences.EntryPage = 'DASHBOARD' then
              User.UserPreferences.EntryPage := 'TIMELINE'
            else
              User.UserPreferences.EntryPage := 'DASHBOARD';


            var UserUpdateResp := TYF_Users.UpdateUser(ConfigData.ServerDetails, UserAccessToken.Token, User.UserId, IYFUserPatch(User));
            if Assigned(UserUpdateResp) and UserUpdateResp.Successful then
            begin
              Writeln('DraftContentItemCount is now '+User.UserPreferences.DraftContentItemCount.ToString);
              Writeln('Entry is now '+User.UserPreferences.EntryPage);
              Writeln('Status : '+UserUpdateResp.Status.ToString);
            end
            else
            begin
              Writeln('Error Updating User '+UserUpdateResp.Status.ToString);
              Writeln(UserUpdateResp.Data);
            end;

          end;
        end;

        Writeln;
      end;

      Writeln;
      Readln;
    finally
      ConfigData.Free;
    end;

  except
    on E: Exception do begin
      Writeln(E.ClassName, ': ', E.Message);
      Readln;
    end;
  end;
end.
