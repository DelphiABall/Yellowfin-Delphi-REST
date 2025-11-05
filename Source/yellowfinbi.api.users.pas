unit yellowfinbi.api.users;

interface

uses yellowfinbi.api.common,
  yellowfinbi.api.transport,
  yellowfinbi.api.transport.classes,
  yellowfinbi.api.orgs.intf, REST.Types,
  yellowfinbi.api.users.intf,

  yellowfinbi.api.filters.intf,

  yellowfinbi.api.json,
  yellowfinbi.api.images.intf;

type
  TYF_Users = class
  private
    class function InternalGetUser(const ServerDetails : IYFServerDetails;
                                   const yf_AccessToken : string;
                                   const aURL : string;
                                   var User : IYFUser ): IYFTransportResponse;

    class function InternalGetSimpleUserList(const ServerDetails : IYFServerDetails;
                                   const yf_AccessToken : string;
                                   const aURL : string;
                                   var UsersList : IYFSimpleUserModelList ): IYFTransportResponse;

  public
    // Helper Method to check an Email against Regular Expression
    class function IsValidEMail(Email : string): Boolean;
{$REGION 'User(s) Management'}
    /// <summary>
    /// List of all users
    /// </summary>
    class function GetUsers(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const FilterRequestValues : IYFFiltersRequest;
                           var UsersList : IYFSimpleUserModelList): IYFTransportResponse;

    /// <summary>
    /// List of all users
    /// </summary>
    class function GetAvailableMetadataForUsersList(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var MetaData : IYFSearchOptions): IYFTransportResponse;

    /// <summary>
    ///   Gets a detailed User
    /// </summary>
    class function GetUserByID(const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               var UserDetails : IYFUser): IYFTransportResponse;

    /// <summary>
    ///   Gets a detailed User using their UserName
    /// </summary>
    class function GetUserByUserName(const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserName: string;
                               var UserDetails : IYFUser): IYFTransportResponse;

    /// <summary>
    ///   Gets a detailed User using their email address
    /// </summary>
    class function GetUserByEmailAddress(const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserEmail: string;
                               var UserDetails : IYFUser): IYFTransportResponse;
    /// <summary>
    ///   Update a Users details
    /// </summary>
    class function UpdateUser (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               var UserDetails : IYFUserPatch): IYFTransportResponse;

    /// <summary>
    ///   Update a Users UserName
    /// </summary>
    class function UpdateUserName (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               const NewUserName : string): IYFTransportResponse;

    /// <summary>
    ///   Update a Users Password
    /// </summary>
    class function UpdateUserPassword (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               const NewUserPassword : string): IYFTransportResponse;

{$ENDREGION 'User(s) Management'}

{$REGION 'User Access'}
    /// <summary>
    ///   Create an list of new users. Their ID is returned in the response updating the objects passed in
    /// </summary>
    class function CreateUsers (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               var yf_NewUsers: TYFNewUserList): IYFTransportResponse;

    /// <summary>
    ///  This endpoint generates a new password for the specified user and sends a reset email to them.
    ///  The user will receive instructions to log in with the new password and update it if necessary.
    /// </summary>
    class function RequestNewPasswordForUser(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64): IYFTransportResponse;

    /// <summary>
    ///   Deletes the User from all Orgs
    /// </summary>
    class function DeleteUserFromAllOrgs (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64): IYFTransportResponse;

    /// <summary>
    ///   Add login access to an org for the specified user
    /// </summary>
    class function AddUserLoginToSpecificOrg (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               const yf_OrgID: Int64): IYFTransportResponse;
    /// <summary>
    ///   Remove this user's login access to the specified org
    /// </summary>
    class function DeleteUserFromSpecificOrg (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               const yf_OrgID: Int64): IYFTransportResponse;

    /// <summary>
    ///   Get the list of orgs that this user has login access to
    /// </summary>
    class function GetUserOrgs (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               var OrgsList : IYFOrgs): IYFTransportResponse;

    /// <summary>
    ///   Terminates all active HTTP sessions for the specified user,
    ///   logging them out of the web application and any associated JavaScript API sessions.
    ///   This action does not affect the user’s REST API tokens, which remain valid.
    /// </summary>
    class function TerminateHTTPSessions(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64): IYFTransportResponse;
{$ENDREGION 'User Access'}

{$REGION 'Following Requests'}
    /// <summary>
    ///   Retrieves a list of users that follow the specified user
    /// </summary>
    class function GetUsersFollowers(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           var UsersList : IYFSimpleUserModelList): IYFTransportResponse;


    /// <summary>
    ///   Retrieves a list of users that the specified user is following
    /// </summary>
    class function GetUsersFollowees(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           var UsersList : IYFSimpleUserModelList): IYFTransportResponse;

    /// <summary>
    ///   Creates a request to follow a User
    /// </summary>
    class function SubmitFollowUserRequest(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const yf_UserToFollowID: Int64;
                           var AFollowResponse : IYFUserFollowRequest): IYFTransportResponse;

    /// <summary>
    ///   Unfollow a specific user
    /// </summary>
    class function UnfollowUser(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const yf_UserToUnfollowID: Int64): IYFTransportResponse;

    /// <summary>
    ///   Confirms a request from another user to follow the User
    /// </summary>
    class function ConfirmFollowUserRequest(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const yf_FollowerID: Int64;
                           var AFollowResponse : IYFUserFollowRequest): IYFTransportResponse;


{$ENDREGION 'Following Requests'}

{$REGION 'User Favourites'}
    /// <summary>
    ///   Get a list of User Favourites
    /// </summary>
    class function GetUserFavourites(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           var Favourites : IYFFavouriteModels): IYFTransportResponse;

    /// <summary>
    ///   Add an item to Favourites for a User - Content Type Path, e.g. story.
    /// </summary>
    class function FavouriteAContentItem(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const yf_ContentTypePath : string;
                           const yf_ContentID :Int64;
                           var Favourite : IYFFavouriteModel): IYFTransportResponse;

    /// <summary>
    ///   Add an item to Favourites for a User - Content Type Path, e.g. story.
    /// </summary>
    class function UnfavouriteAContentItem(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const yf_ContentTypePath : string;
                           const yf_ContentID :Int64): IYFTransportResponse;
{$ENDREGION}

//    /// <summary>
//    ///   Get a list of User Notifications
//    /// </summary>
//    class function GetUserNotifications(const ServerDetails : IYFServerDetails;
//                           const yf_AccessToken : string;
//                           const yf_UserID: Int64;
//                           var Notifications : UserCommentNotificationModel / RegularNotificationModel): IYFTransportResponse;


//    /// <summary>
//    ///   Get the User Image - Need to Debug
//    /// </summary>
    class function GetUserAvatar(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserID: Int64;
                           const ThumbSize : TYFImagesTypes.thumbSize;
                           var Image : IYFImageModel): IYFTransportResponse;



  end;

implementation

uses System.JSON, System.SysUtils, System.NetEncoding, System.RegularExpressions,
  System.Classes, yellowfinbi.api.orgs, yellowfinbi.api.transport.generics,
  yellowfinbi.api.classfactory;

{ TYFTemplate }

class function TYF_Users.AddUserLoginToSpecificOrg(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID, yf_OrgID: Int64): IYFTransportResponse;
begin
  // ToDo Update Response to be the list of Orgs for the User.

  var Body := TJSONObject.Create;
  Body.AddPair('orgId',yf_OrgID);

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPOST,
        ServerDetails,
        'api/admin/users/'+yf_UserID.ToString+'/org-access',
        yf_AccessToken,
        Body); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Users.ConfirmFollowUserRequest(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID, yf_FollowerID: Int64;
  var AFollowResponse: IYFUserFollowRequest): IYFTransportResponse;
begin
  var aURL := Format('api/users/%d/followees/%d',[yf_UserID, yf_FollowerID]);
  Result := TYFTransportResponseGenerics.Execute<IYFUserFollowRequest>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPUT,
                                                  aURL,
                                                  nil,
                                                  AFollowResponse);
end;

class function TYF_Users.CreateUsers(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string;
  var yf_NewUsers: TYFNewUserList): IYFTransportResponse;
var
  UserIDObj : IYFUserID;
begin

  var UsersJSON := TJSONArray.Create;

  for var CurrUser in yf_NewUsers do
  begin
    UsersJSON.Add(CurrUser.ToJSON);
  end;

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPOST,
        ServerDetails,
        'api/admin/users',
        yf_AccessToken,
        UsersJSON);
  try
    // 3 - Call the API end point
    var TransportData := Transport.Execute;
    Result := nil;

    // Check if the object supports ID interface.... and update
    if Assigned(TransportData) and TransportData.Successful then
    begin
      Result := TransportData;

      var JSON := TJSONObject.ParseJSONValue(TransportData.Data);
      try
        var ItemsArray := JSON.GetValue<TJSONArray>('items');

        if ItemsArray = nil then
          Exit;

        // Loop returned data and update the current object
        for var item : TJSONValue in ItemsArray do
        begin
          var email := item.GetValue<string>('email','');

          if email.IsEmpty then
            Break;

            // Bring the ID back to the original items.
          for var CurrUser in yf_NewUsers do
          begin
            if email = CurrUser.Email then
            begin
              // Refresh with Server Data.
              CurrUser.LoadFromJSON(item as TJSONObject);
              // Ensure we have the ID.
              if Supports(CurrUser, IYFUserID, UserIDObj) then
                UserIDObj.UserID := item.GetValue<int64>('userId',0);

              Break;
            end;
          end;

        end;
      finally
        JSON.Free;
      end;
    end;

  finally
    Transport.Free;
  end;
  
end;

class function TYF_Users.DeleteUserFromAllOrgs(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64): IYFTransportResponse;
begin
 // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDelete,
        ServerDetails,
        'api/admin/users/'+yf_UserID.ToString,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Users.DeleteUserFromSpecificOrg(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID, yf_OrgID: Int64): IYFTransportResponse;
begin
 // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDelete,
        ServerDetails,
        'api/admin/users/'+yf_UserID.ToString+'/org-access/'+yf_OrgID.ToString,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Users.FavouriteAContentItem(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64; const yf_ContentTypePath: string;
  const yf_ContentID: Int64;
  var Favourite: IYFFavouriteModel): IYFTransportResponse;
begin
   var aURL := Format('api/users/%d/favourites/%s/%d',[yf_UserID,yf_ContentTypePath,yf_ContentID]);
   Result := TYFTransportResponseGenerics.Execute<IYFFavouriteModel>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPOST,
                                                  aURL,
                                                  nil,
                                                  Favourite);
end;

class function TYF_Users.GetAvailableMetadataForUsersList(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var MetaData: IYFSearchOptions): IYFTransportResponse;
begin
   var aURL := 'api/users/metadata';
   Result := TYFTransportResponseGenerics.Execute<IYFSearchOptions>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  MetaData);
end;

class function TYF_Users.GetUserAvatar(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64; const ThumbSize : TYFImagesTypes.thumbSize;
  var Image: IYFImageModel): IYFTransportResponse;
begin
  var ThumbSizeStr := TYFImagesTypes.ValueToString<TYFImagesTypes.thumbSize>(ThumbSize);

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmGet,
        ServerDetails,
        Format('api/users/%d/avatar?thumbSize=%s',[yf_UserID,ThumbSizeStr]),
        yf_AccessToken,
        nil); // no body required
  Transport.Accepts := 'image/*';

  try
    Result := Transport.Execute;

    if Image = nil then
      Image := yellowfinbi.api.classfactory.TYFFactoryRegistry.ResolveFactory<IYFImageModel>()(); // TYFImageModel.Create;

    Image.Assign(Transport.RESTResponse.RawBytes);

  finally
    Transport.Free;
  end;
end;

class function TYF_Users.GetUserByEmailAddress(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  yf_UserEmail: string; var UserDetails : IYFUser): IYFTransportResponse;
begin
  if TYF_Users.IsValidEMail(yf_UserEmail) then
    Result := InternalGetUser(ServerDetails,
                              yf_AccessToken,
                              TNetEncoding.URL.EncodePath('api/rpc/users/user-details-by-email/'+yf_UserEmail),
                              UserDetails)
  else begin
    Result := TYFTransportResponse.Create(400, 'Invalid Email Address');
  end;

end;

class function TYF_Users.GetUserByID(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64; var UserDetails : IYFUser): IYFTransportResponse;
begin
  if yf_UserID <= 0 then
    Exit(TYFTransportResponse.Create(400, 'Invalid UserID'));

  Result := InternalGetUser(ServerDetails,
                            yf_AccessToken,
                            'api/users/'+yf_UserID.ToString,
                            UserDetails);

end;

class function TYF_Users.GetUserByUserName(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  yf_UserName: string; var UserDetails : IYFUser): IYFTransportResponse;
begin
  if yf_UserName = '' then
    Exit(TYFTransportResponse.Create(400, 'Invalid UserName'));

  Result := InternalGetUser(ServerDetails,
                            yf_AccessToken,
                            TNetEncoding.URL.EncodePath('api/rpc/users/user-details-by-username/'+yf_UserName),
                            UserDetails);
end;


class function TYF_Users.GetUserFavourites(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64;
  var Favourites: IYFFavouriteModels): IYFTransportResponse;
begin
   var aURL := Format('api/users/%d/favourites',[yf_UserID]);
   Result := TYFTransportResponseGenerics.Execute<IYFFavouriteModels>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  Favourites);

end;

class function TYF_Users.GetUserOrgs(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64;
  var OrgsList: IYFOrgs): IYFTransportResponse;
begin
  // Redirects to the Orgs class to keep code D.R.Y.
  Result := TYF_Orgs.GetUserOrgs(ServerDetails, yf_AccessToken, yf_UserID, OrgsList);
end;

class function TYF_Users.GetUsers(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const FilterRequestValues : IYFFiltersRequest; var UsersList : IYFSimpleUserModelList):IYFTransportResponse;
begin
  //Deal with the filter
  var aURL : string := 'api/users';

  if Assigned(FilterRequestValues) then
  begin
    var aFilterString := FilterRequestValues.ToJSON;
    if aFilterString > '' then
      aURL := aURL+'?filters='+TURLEncoding.URL.Encode(aFilterString);
  end;

  Result := InternalGetSimpleUserList(ServerDetails,yf_AccessToken, aURL, UsersList);
end;

class function TYF_Users.GetUsersFollowees(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string; const yf_UserID: Int64;
  var UsersList: IYFSimpleUserModelList): IYFTransportResponse;
begin
  Result := InternalGetSimpleUserList(ServerDetails,yf_AccessToken,'api/users/'+yf_UserID.ToString+'/followees',UsersList);
end;

class function TYF_Users.GetUsersFollowers(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64;
  var UsersList: IYFSimpleUserModelList): IYFTransportResponse;
begin
  Result := InternalGetSimpleUserList(ServerDetails,yf_AccessToken,'api/users/'+yf_UserID.ToString+'/followers',UsersList);
end;

class function TYF_Users.InternalGetSimpleUserList(
  const ServerDetails: IYFServerDetails; const yf_AccessToken, aURL: string;
  var UsersList: IYFSimpleUserModelList): IYFTransportResponse;
begin
  Result := TYFTransportResponseGenerics.Execute<IYFSimpleUserModelList>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  UsersList);
end;

class function TYF_Users.InternalGetUser(const ServerDetails : IYFServerDetails;
  const yf_AccessToken : string; const aURL : string; var User : IYFUser ): IYFTransportResponse;
begin
  Result := TYFTransportResponseGenerics.Execute<IYFUser>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  User);
end;

class function TYF_Users.IsValidEMail(Email: string): Boolean;
const
  EMAIL_REGEX = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
begin
  if Email.IsEmpty then
    Exit(False);

  Result := TRegEx.IsMatch(Email, EMAIL_REGEX);
end;

class function TYF_Users.RequestNewPasswordForUser(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPOST,
        ServerDetails,
        'api/rpc/admin/users/'+yf_UserID.ToString+'/reset-password',
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Users.SubmitFollowUserRequest(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID, yf_UserToFollowID: Int64;
  var AFollowResponse: IYFUserFollowRequest): IYFTransportResponse;
begin
  var aURL := Format('api/users/%d/followees/%d',[yf_UserID, yf_UserToFollowID]);
  Result := TYFTransportResponseGenerics.Execute<IYFUserFollowRequest>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  AFollowResponse);

end;

class function TYF_Users.TerminateHTTPSessions(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64): IYFTransportResponse;
begin
 // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDelete,
        ServerDetails,
        'api/admin/users/'+yf_UserID.ToString+'/sessions',
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Users.UnfavouriteAContentItem(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64; const yf_ContentTypePath: string;
  const yf_ContentID: Int64): IYFTransportResponse;
begin
   var aURL := Format('api/users/%d/favourites/%s/%d',[yf_UserID,yf_ContentTypePath,yf_ContentID]);

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil);
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Users.UnfollowUser(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID,
  yf_UserToUnfollowID: Int64): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        'api/users/'+yf_UserID.ToString+'/followees/'+yf_UserToUnfollowID.ToString,
        yf_AccessToken,
        nil);

  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Users.UpdateUser(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64;
  var UserDetails: IYFUserPatch): IYFTransportResponse;
begin
  if not Assigned(UserDetails) then
    Exit(nil);

  var jsonObject := TJSONObject.Create;
  jsonObject.AddPair('firstName', UserDetails.FirstName);
  jsonObject.AddPair('lastName', UserDetails.lastName);
  jsonObject.AddPair('title', UserDetails.title);
  jsonObject.AddPair('description', UserDetails.description);

  if not UserDetails.preferredLanguageCode.IsEmpty then
    jsonObject.AddPair('preferredLanguageCode', UserDetails.preferredLanguageCode);

  if not UserDetails.timeZoneCode.IsEmpty then
    jsonObject.AddPair('timeZoneCode', UserDetails.timeZoneCode);

  UserDetails.UserPreferences.AddToJSON(jsonObject);

  var aURL := Format('api/users/%d/',[yf_UserID]);

  Result := TYFTransportResponseGenerics.Execute<IYFUserPatch>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPATCH,
                                                  aURL,
                                                  jsonObject,
                                                  UserDetails);

end;

class function TYF_Users.UpdateUserName(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64;
  const NewUserName: string): IYFTransportResponse;
begin
  var Body := TJSONObject.Create;
  Body.AddPair('userName',NewUserName);

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPut,
        ServerDetails,
        Format('api/admin/users/%d/username',[yf_UserID]),
        yf_AccessToken,
        Body); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Users.UpdateUserPassword(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserID: Int64; const NewUserPassword: string): IYFTransportResponse;
begin
  var Body := TJSONObject.Create;
  Body.AddPair('password',NewUserPassword);

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPut,
        ServerDetails,
        Format('api/admin/users/%d/password',[yf_UserID]),
        yf_AccessToken,
        Body); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

end.

