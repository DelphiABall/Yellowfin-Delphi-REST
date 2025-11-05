unit yellowfinbi.api.roles;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport, yellowfinbi.api.transport.classes,
  yellowfinbi.api.roles.intf, REST.Types;

type
  TYF_Roles = class
    class function GetRoles(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string; var ARoles : IYFRoles): IYFTransportResponse;

    class function CreateRole(const ServerDetails : IYFServerDetails;
                            const yf_AccessToken : string;  var ARole : IYFRole): IYFTransportResponse;

    class function UpdateRole(const ServerDetails : IYFServerDetails;
                            const yf_AccessToken : string; ARoleCode : string; var ARole : IYFRole): IYFTransportResponse;

    class function DeleteRole(const ServerDetails : IYFServerDetails;
                            const yf_AccessToken : string; ARoleCode : string): IYFTransportResponse;

  end;

implementation

uses System.JSON, yellowfinbi.api.transport.generics;

{ TYF_Roles }

class function TYF_Roles.CreateRole(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; var ARole: IYFRole): IYFTransportResponse;
begin
  Assert(Assigned(ARole), 'Role can not be Null');

  var aURL := 'api/roles/';
  Result := TYFTransportResponseGenerics.Execute<IYFRole>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPost,
                                                  aURL,
                                                  ARole.AsJSON,
                                                  ARole);
end;

class function TYF_Roles.DeleteRole(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; ARoleCode: string): IYFTransportResponse;
begin
  Assert(ARoleCode > '', 'RoleCode can not be Null');

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        'api/roles/'+ARoleCode,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Roles.GetRoles(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; var ARoles : IYFRoles): IYFTransportResponse;
begin
  Result := TYFTransportResponseGenerics.Execute<IYFRoles>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGet,
                                                  'api/roles/',
                                                  nil,
                                                  ARoles);


end;

class function TYF_Roles.UpdateRole(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; ARoleCode : string; var ARole: IYFRole): IYFTransportResponse;
begin
  Assert(Assigned(ARole), 'Role can not be Null');

  if ARoleCode = '' then
    ARoleCode := ARole.RoleCode;

  Assert(ARoleCode > '', 'RoleCode missing');

  var aURL := 'api/roles/'+ARoleCode;
  Result := TYFTransportResponseGenerics.Execute<IYFRole>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmPATCH,
                                                  aURL,
                                                  ARole.AsJSON,
                                                  ARole);

end;

end.
