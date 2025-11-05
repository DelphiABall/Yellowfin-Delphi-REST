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

(************* Find Bugs ***************
1. In the function
TYFTransport.Execute, during catch block of exception, It sets the Result.Status
as `555`, which indicates an error. However, if an exception occurs during the
creation of TYFTransportResponse object, then results will be nil and the
attempt to set its properties will result in a null reference exception.
Instead, it should instantiate the TYFTransportResponse object before the try
block so in case of any error it can be processed in the exception block
correctly.

2. In Prepare method, the parameter `poDoNotEncode` is used with
AddHeader. It implies that the header values are not URL encoded. Make sure this
is what the API expects, especially since this could potentially be a security
risk if unusual characters are entered in the header fields.

3. In the
constructor of TYFTransport, when appending '/' to undefined base_url might
cause problems in some cases.

4. In TYFTransport.Create function, the
constructor hasn't checked whether the given ServerDetails is `nil` or not. If
it's `nil`, then this causes a null exception error.

5. The function
randomUUID doesn't handle the situation that CreateGUID returns anything other
than S_OK. Code doesn't ensure that the GUID was created successfully.

6. The
RESTRequest.Execute call in Execute method is not protected with a try/catch
block. Since network operations are notoriously unreliable, it's a good idea to
handle potential exceptions like e.g. connection errors here.

7. In the class
TYFTransport there is no destructor to free the resources. For example, the
instances created from the constructor Create are not freed, which can cause
memory leaks.

8. RESTClient, RESTRequest, and RESTResponse are used in this
class, but their origin or declaration are not visible in the provided code
snippet. If they are not properly declared, it might lead to runtime
errors.

9. The code contains no protection against concurrent usage. If
multiple threads call any of the public methods simultaneously, they can
interfere with each other, e.g. changing RESTRequest or RESTClient fields. This
could be solved by using critical sections or other thread-protection
techniques.
*)
end.
