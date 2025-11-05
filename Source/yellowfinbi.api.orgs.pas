unit yellowfinbi.api.orgs;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.orgs.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Orgs = class
  public
    /// <summary>
    ///   Get a list of Orgs
    /// </summary>
    class function GetOrgs(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var OrgsList : IYFOrgs): IYFTransportResponse;

    /// <summary>
    ///   Get the list of orgs that this user has login access to
    /// </summary>
    class function GetUserOrgs (const ServerDetails : IYFServerDetails;
                               const yf_AccessToken : string;
                               const yf_UserID: Int64;
                               var OrgsList : IYFOrgs): IYFTransportResponse;
  end;

implementation

{ TYFOrgs }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Orgs.GetOrgs(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var OrgsList : IYFOrgs): IYFTransportResponse;
begin
  var aURL := 'api/orgs/';
  Result:= TYFTransportResponseGenerics.Execute<IYFOrgs>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        OrgsList);
end;

class function TYF_Orgs.GetUserOrgs(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_UserID: Int64;
  var OrgsList: IYFOrgs): IYFTransportResponse;
begin
  var aURL := Format('api/admin/users/%d/org-access',[yf_UserID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFOrgs>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        OrgsList);
end;

end.
