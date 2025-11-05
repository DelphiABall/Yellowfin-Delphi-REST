unit yellowfinbi.api.template;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.orgs.classes, REST.Types;

type
  TYF_Template = class
    class function GetOrgs(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const TokenID : Int64): Boolean;

  end;

implementation

{ TYFTemplate }

class function TYF_Template.GetOrgs(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const TokenID: Int64): Boolean;
begin
  // 1 - No body required.
  // 2 - Create an Access Token based on the user for the Refresh Token.

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmGet,
        ServerDetails,
        'api/refresh-tokens/',
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

end.
