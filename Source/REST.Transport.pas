unit REST.Transport;

interface

uses
  System.Classes, REST.Client, REST.Types, IPPeerClient;

type
 TRESTTransportBase = class(TComponent)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    function GetAccepts: string;
    procedure SetAccepts(const Value: string);
  public
    constructor Create(AOwner: TComponent; const AhttpVerbType : TRESTRequestMethod; const AAccept : string; const Atimeout: Integer = 30000); reintroduce;
    destructor Destroy; override;
    property RESTClient: TRESTClient read FRESTClient;
    property RESTRequest: TRESTRequest read FRESTRequest write FRESTRequest;
    property RESTResponse: TRESTResponse read FRESTResponse;
    property Accepts : string read GetAccepts write SetAccepts;
  end;

implementation

{ TRESTTransportBase }

constructor TRESTTransportBase.Create(AOwner: TComponent;
  const AhttpVerbType : TRESTRequestMethod; const AAccept : string; const Atimeout: Integer);
begin
 inherited Create(AOwner);

  FRESTClient := TRESTClient.Create(Self);
  FRestClient.ContentType := CONTENTTYPE_APPLICATION_JSON;
  FRestClient.Accept := AAccept;
  FRestClient.AcceptCharset :=  'utf-8, *;q=0.8';
  FRestClient.HandleRedirects := True;
  FRestClient.RaiseExceptionOn500 := False;

  FRESTResponse := TRESTResponse.Create(Self);
  FRESTResponse.ContentType := CONTENTTYPE_APPLICATION_JSON;

  FRESTRequest := TRESTRequest.Create(Self);
  FRESTRequest.Response := FRESTResponse;
  FRESTRequest.Client := FRESTClient;
  //FRESTRequest.AutoCreateParams := True;

  FRESTRequest.Method := AhttpVerbType;
  FRESTRequest.Accept := AAccept;
  //FRESTRequest.AcceptCharset :=  'utf-8, *;q=0.8';
  FRESTRequest.Timeout := Atimeout;
  FRESTRequest.AssignedValues := [TCustomRESTRequest.TAssignedValue.rvConnectTimeout,TCustomRESTRequest.TAssignedValue.rvHandleRedirects];
end;

destructor TRESTTransportBase.Destroy;
begin
  FRESTClient.Free;
  FRESTResponse.Free;
  FRESTRequest.Free;

  inherited;
end;

function TRESTTransportBase.GetAccepts: string;
begin
  Result := FRESTRequest.Accept;
end;

procedure TRESTTransportBase.SetAccepts(const Value: string);
begin
  FRestClient.Accept:= Value;
  FRESTRequest.Accept:= Value;
end;

end.
