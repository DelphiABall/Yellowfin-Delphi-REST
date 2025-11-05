unit yellowfinbi.api.health;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.health.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Health = class
  public
    /// <summary>
    ///   Get a list of Health
    /// </summary>
    class function GetHealth(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aHealth : IYFHealth): IYFTransportResponse;


  end;

implementation

{ TYF_health }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Health.GetHealth(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aHealth : IYFHealth): IYFTransportResponse;
begin
  var aURL := 'api/health/';
  Result:= TYFTransportResponseGenerics.Execute<IYFHealth>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aHealth);
end;

end.
