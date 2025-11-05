unit yellowfinbi.api.transport;

interface

uses System.Classes, REST.Transport, REST.Client, REST.Types, IPPeerClient,
  System.JSON, yellowfinbi.api.common, yellowfinbi.api.transport.classes;

type
  TYFTransport = class(TRESTTransportBase)
  private
    FAppName : string;
    FOwnsRequestBody: Boolean;
    FRequestBody: TJSONAncestor;
  public
    class function randomUUID : string;
    class function Epoc: Int64;
    constructor Create(aOwner: TComponent; ahttpVerbType : TRESTRequestMethod;
        aBase_url,
        aAppName,
        aEntry_point,
        aSecurity_token : string;
        aRequestBody : TJSONAncestor;  // Post, Patch, Delete only
        aTimeout : Integer);  overload;

    constructor Create(aOwner: TComponent; ahttpVerbType : TRESTRequestMethod;
        ServerDetails : IYFServerDetails;
        aEntry_point,
        aSecurity_token : string;
        aRequestBody : TJSONAncestor); overload;  // Post, Patch, Delete only

    destructor Destroy; override;

    procedure Prepare(const aSecurity_token : string);
    function Execute(): IYFTransportResponse;
    property OwnsRequestBody : Boolean read FOwnsRequestBody write FOwnsRequestBody;
  end;


implementation

uses System.SysUtils, System.DateUtils, System.NetEncoding;


{ TYFTransport }

class function TYFTransport.Epoc: Int64;
begin
  Result := DateTimeToUnix(TTimeZone.Local.ToUniversalTime(Now)) * 1000;
end;

function TYFTransport.Execute: IYFTransportResponse;
begin
  Result := TYFTransportResponse.Create;
  try
    if FRequestBody <> nil then
      RESTRequest.Body.JSONWriter.WriteRawValue( FRequestBody.ToJSON );

    RESTRequest.Execute;

    Result.Status := RESTResponse.StatusCode;
    Result.Data := RESTResponse.Content;

  except
    on e:Exception do begin
      Result.Status := 555; // Internal Code to show AV / Error.
      Result.Data := e.Message;
    end;
  end;

end;

procedure TYFTransport.Prepare(const aSecurity_token : string);
const
  pAuthorization = 'Authorization';
var
  aParam : TRESTRequestParameter;
  aHeader : string;

begin

  if (aSecurity_token.IsEmpty()) then
    aHeader := FAppName+' ts=' + EPOC.ToString + ', nonce=' + randomUUID
  else
    aHeader := FAppName+' ts=' + EPOC.ToString + ', nonce=' + randomUUID() + ', token=' + ASecurity_token;

  aParam := RESTClient.Params.AddHeader(pAuthorization, aHeader);
  aParam.Options := [poDoNotEncode];
end;

class function TYFTransport.randomUUID: string;
var
  GUID: TGUID;
begin
  if CreateGUID(GUID) = S_OK then
    Result := StringReplace(Copy(GUIDToString(GUID), 2, 36),'-','z',[rfReplaceAll])
  else
    raise Exception.Create('Failed to create GUID for API Access');
end;

constructor TYFTransport.Create(aOwner: TComponent;
  ahttpVerbType: TRESTRequestMethod; ServerDetails: IYFServerDetails;
  aEntry_point, aSecurity_token: string; aRequestBody: TJSONAncestor);
begin
  Create(aOwner, ahttpVerbType, ServerDetails.HostURL, ServerDetails.AppName, aEntry_point, aSecurity_token, aRequestBody, ServerDetails.Timeout);
  OwnsRequestBody := True;
end;


destructor TYFTransport.Destroy;
begin
  if OwnsRequestBody and (Assigned(FRequestBody)) then
  try
    FRequestBody.Free;
  except
  end;
  inherited;
end;

constructor TYFTransport.Create(aOwner: TComponent;
  ahttpVerbType: TRESTRequestMethod; aBase_url, aAppName, aEntry_point,
  aSecurity_token: string; aRequestBody: TJSONAncestor; aTimeout: Integer);
begin
  inherited Create(aOwner,
                   ahttpVerbtype,
                  'application/vnd.yellowfin.api-v4+json',
                   aTimeout);

  FRequestBody := aRequestBody;
  FAppName := aAppName;

  if aBase_url.EndsWith('/') then
    RESTClient.BaseURL := aBase_url
  else
    RESTClient.BaseURL :=aBase_url + '/';

  RESTRequest.Resource := aEntry_point;

  Prepare(aSecurity_token);
end;

end.
