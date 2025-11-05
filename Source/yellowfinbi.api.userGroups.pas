unit yellowfinbi.api.userGroups;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport,
  REST.Types, yellowfinbi.api.userGroups.intf,
  yellowfinbi.api.transport.classes,
  yellowfinbi.api.users.intf;

type
  TYF_UserGroups = class
    /// <summary>
    ///   Gets a list of Yellowfin User Groups
    /// </summary>
    class function GetUserGroups(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var UserGroupList : IYFUserGroups): IYFTransportResponse;

{$REGION 'Usergroup Admin'}
    /// <summary>
    ///   Gets the full description of a Yellowfin UserGroup
    /// </summary>
    class function GetUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           var AUserGroup: IYFUserGroup): IYFTransportResponse;
    /// <summary>
    ///   Updates a Yellowfin UserGroup
    /// </summary>
    class function CreateUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var AUserGroup: IYFUserGroup): IYFTransportResponse;

    /// <summary>
    ///   Updates a Yellowfin UserGroup
    /// </summary>
    class function UpdateUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var AUserGroup: IYFUserGroup): IYFTransportResponse;

    /// <summary>
    ///   Deletes a Yellowfin UserGroup
    /// </summary>
    class function DeleteUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64): IYFTransportResponse;

{$ENDREGION 'Usergroup Admin'}

    /// <summary>
    ///   Retrieves a flattened list of users belonging to the specified User Group
    /// </summary>
    class function GetFlattenedUserGroupUsers(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           var UsersList : IYFSimpleUserModelList): IYFTransportResponse;

    /// <summary>
    ///   Gets the List of Users for a Specific UserGroup  https://developers.yellowfinbi.com/dev/api-docs/current/#operation/getUserGroupMemberList
    /// </summary>
    class function GetMembersListForUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           var GroupMembersList : IYFUserGroupMembers): IYFTransportResponse;

    /// <summary>
    ///   Bulk-Add one or more members to the UserGroup - Returns the updated List
    /// </summary>
    class function BulkAddMembersListForUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           AddMembers : TArray<TYFUserGroupMembersPost>;
                           var UpdatedGroupMembersList : IYFUserGroupMembers): IYFTransportResponse;

    /// <summary>
    ///   Bulk-Update one or more members to the UserGroup - Returns the updated List
    /// </summary>
    class function BulkUpdateMembersListForUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           UpdateMembers : TArray<TYFUserGroupMembersPatch>;
                           var UpdatedGroupMembersList : IYFUserGroupMembers): IYFTransportResponse;

    /// <summary>
    ///   Bulk-Update one or more members to the UserGroup - Returns the updated List
    /// </summary>
    class function BulkDeleteMembersListForUserGroup(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const yf_UserGroupID : int64;
                           MembersIdsToDelete : TArray<string>;
                           var UpdatedGroupMembersList : IYFUserGroupMembers): IYFTransportResponse;

  end;

implementation


uses
  yellowfinbi.api.transport.generics, System.SysUtils, System.JSON;

{ TYF_UserGroups }

class function TYF_UserGroups.BulkAddMembersListForUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64; AddMembers: TArray<TYFUserGroupMembersPost>;
  var UpdatedGroupMembersList: IYFUserGroupMembers): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d/members',[yf_UserGroupID]);

  var JSONArray := TJSONArray.Create;
  for var Member in AddMembers do
  begin
    var JObj := TJSONObject.Create;
    JObj.AddPair('entityType', TYFUserGroupTypes.ValueToString<TYFUserGroupTypes.memberEntityType>(Member.entityType));
    JObj.AddPair('entityCode', Member.entityCode);
    JObj.AddPair('membershipType', TYFUserGroupTypes.ValueToString<TYFUserGroupTypes.memberMembershipType>(Member.membershipType));

    JSONArray.Add(JObj);
  end;


  Result := TYFTransportResponseGenerics.Execute<IYFUserGroupMembers>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPOST,
                                                  aURL,
                                                  JSONArray,
                                                  UpdatedGroupMembersList);
end;

class function TYF_UserGroups.BulkDeleteMembersListForUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64; MembersIdsToDelete: TArray<string>;
  var UpdatedGroupMembersList: IYFUserGroupMembers): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d/members',[yf_UserGroupID]);

  // Build Query Param
  var IDsString : string := '';
  if Length(MembersIdsToDelete) > 0 then
  begin
    for var Member in MembersIdsToDelete do
    begin
      if IDsString = '' then
        IDsString := ''''+Member+''''
      else
        IDsString := IDsString + ','''+Member+'''';
      //JObj.AddPair('memberId', Member.memberId);
    end;
    if not IDsString.IsEmpty then
      aURL := aURL+'?memberIds=['+IDsString+']';
  end;

  Result := TYFTransportResponseGenerics.Execute<IYFUserGroupMembers>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmDELETE,
                                                  aURL,
                                                  nil,
                                                  UpdatedGroupMembersList);


end;

class function TYF_UserGroups.BulkUpdateMembersListForUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64;
  UpdateMembers: TArray<TYFUserGroupMembersPatch>;
  var UpdatedGroupMembersList: IYFUserGroupMembers): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d/members',[yf_UserGroupID]);

  var JSONArray := TJSONArray.Create;
  for var Member in UpdateMembers do
  begin
    var JObj := TJSONObject.Create;
    JObj.AddPair('memberId', Member.memberId);
    JObj.AddPair('membershipType', TYFUserGroupTypes.ValueToString<TYFUserGroupTypes.memberMembershipType>(Member.membershipType));

    JSONArray.Add(JObj);
  end;


  Result := TYFTransportResponseGenerics.Execute<IYFUserGroupMembers>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPATCH,
                                                  aURL,
                                                  JSONArray,
                                                  UpdatedGroupMembersList);

end;

class function TYF_UserGroups.CreateUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var AUserGroup: IYFUserGroup): IYFTransportResponse;
begin
  Assert(Assigned(AUserGroup));
  var aURL := 'api/user-groups';
  Result := TYFTransportResponseGenerics.Execute<IYFUserGroup>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPOST,
                                                  aURL,
                                                  AUserGroup.AsJSON,
                                                  AUserGroup);

end;

class function TYF_UserGroups.DeleteUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d',[yf_UserGroupID]);
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil); // no body required
  try
    // 3 - Call the API end point
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_UserGroups.GetFlattenedUserGroupUsers(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64;
  var UsersList: IYFSimpleUserModelList): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d/flat-users',[yf_UserGroupID]);
  Result := TYFTransportResponseGenerics.Execute<IYFSimpleUserModelList>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  UsersList);
end;

class function TYF_UserGroups.GetMembersListForUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64;
  var GroupMembersList: IYFUserGroupMembers): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d/members',[yf_UserGroupID]);
  Result := TYFTransportResponseGenerics.Execute<IYFUserGroupMembers>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGet,
                                                  aURL,
                                                  nil,
                                                  GroupMembersList);
end;

class function TYF_UserGroups.GetUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_UserGroupID: int64; var AUserGroup: IYFUserGroup): IYFTransportResponse;
begin
  var aURL := Format('api/user-groups/%d',[yf_UserGroupID]);
  Result := TYFTransportResponseGenerics.Execute<IYFUserGroup>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGet,
                                                  aURL,
                                                  nil,
                                                  AUserGroup);
end;

class function TYF_UserGroups.GetUserGroups(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var UserGroupList: IYFUserGroups): IYFTransportResponse;
begin
  var aURL := 'api/user-groups';
  Result := TYFTransportResponseGenerics.Execute<IYFUserGroups>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGet,
                                                  aURL,
                                                  nil,
                                                  UserGroupList);
end;

class function TYF_UserGroups.UpdateUserGroup(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var AUserGroup: IYFUserGroup): IYFTransportResponse;
begin
  Assert(Assigned(AUserGroup));
  var aURL := Format('api/user-groups/%d',[AUserGroup.UserGroupId]);
  Result := TYFTransportResponseGenerics.Execute<IYFUserGroup>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPATCH,
                                                  aURL,
                                                  AUserGroup.AsJSON,
                                                  AUserGroup);
end;

end.
