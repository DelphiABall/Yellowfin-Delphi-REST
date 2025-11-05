unit yellowfinbi.api;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.transport.classes, yellowfinbi.api.intf;

type
  TYF_API = class
  public
    /// <summary>
    ///   Get Information about the Yellowfin API
    /// </summary>
    class function GetAPIInformation (const ServerDetails : IYFServerDetails;
                            const yf_AccessToken : string;
                            var API_Info : IYFAPIInfo): IYFTransportResponse;
  end;



implementation

uses yellowfinbi.api.transport.generics, REST.Types;

{ TYF_API }

class function TYF_API.GetAPIInformation(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; var API_Info: IYFAPIInfo): IYFTransportResponse;
begin
   var aURL := 'api';
   Result := TYFTransportResponseGenerics.Execute<IYFAPIInfo>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  API_Info);
end;

end.
