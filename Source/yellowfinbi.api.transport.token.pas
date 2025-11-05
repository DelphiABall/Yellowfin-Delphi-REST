unit yellowfinbi.api.transport.token;

interface

uses yellowfinbi.api.transport,
     yellowfinbi.api.transport.classes, System.JSON;

type
  IYFTokenResponse = interface(IYFTransportResponse)
    ['{78F8DFBA-63AE-4996-90D4-022AB7A1A7D0}']
    procedure SetToken(const Value : string);
    function GetToken : string;

    property Token : string read GetToken write SetToken;
  end;

  IYFAccessTokenResponse = interface(IYFTokenResponse)
    ['{117C5A77-ACD2-45C4-B554-81EBDD343685}']
    procedure SetExpiry(const Value : TDateTime);
    function GetExpiry : TDateTime;

    property Expiry : TDateTime read GetExpiry write SetExpiry;
  end;

  IYFRefreshTokenResponse = interface(IYFTokenResponse)
    ['{117C5A77-ACD2-45C4-B554-81EBDD343685}']
    procedure SetTokenID(const Value : Int64);
    function GetTokenID : Int64;

     property ID : Int64 read GetTokenID write SetTokenID;
  end;


  TYFTokenResponse = class(TYFTransportResponse, IYFTokenResponse)
  strict private
    FToken: string;
  private
    function GetToken: string;
    procedure SetToken(const Value: string);
  public
    property Token : string read GetToken write SetToken;
  end;

  TYFAccessTokenResponse = class(TYFTokenResponse, IYFAccessTokenResponse)
  strict private
    FExpiry : TDateTime;
  private
    procedure SetExpiry(const Value : TDateTime);
    function GetExpiry : TDateTime;

  public
    property Expiry : TDateTime read GetExpiry write SetExpiry;
  end;

  TYFRefreshTokenResponse = class(TYFTokenResponse, IYFRefreshTokenResponse)
  strict private
    FID: Int64;
  private
    procedure SetTokenID(const Value : Int64);
    function GetTokenID : Int64;
  public
    property ID : Int64 read GetTokenID write SetTokenID;
  end;


  TYFTransportToken = class(TYFTransport)
  private
    function FindSecurityToken(JSONValue: TJSONValue): string;
    procedure InternalExecute(aToken : TYFTokenResponse);
  public
    function executeToken(): TYFTokenResponse;
    function executeAccessToken(): TYFAccessTokenResponse;
    function executeRefreshToken(): TYFRefreshTokenResponse;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections, System.RegularExpressions,
  System.DateUtils;

{ TYFTransportToken }

function TYFTransportToken.executeToken: TYFTokenResponse;
begin
  Result := TYFTokenResponse.Create;
  InternalExecute(Result);
end;


function TYFTransportToken.executeAccessToken: TYFAccessTokenResponse;
var
  JSONObject: TJSONObject;
begin
  var DT : TDateTime := now;

  Result := TYFAccessTokenResponse.Create;
  InternalExecute(Result);

  // Get ID
  if (RESTResponse.Status.Success) then
  begin
    JSONObject := RESTResponse.JSONValue as TJSONObject;
    var FExpiry := JSONObject.GetValue<Integer>('expiry',0);
    if FExpiry > 0 then
      Result.Expiry := IncSecond(DT, FExpiry)
    else
      Result.Expiry := 0;
  end;

end;

function TYFTransportToken.executeRefreshToken: TYFRefreshTokenResponse;
var
  JSONObject, LinksObj, SelfObj: TJSONObject;
  HrefValue: string;
  SlashPos: Integer;
begin
  Result := TYFRefreshTokenResponse.Create;
  InternalExecute(Result);

  // Get ID
  if (RESTResponse.Status.Success)
    and Assigned(RESTResponse.JSONValue)
    and (RESTResponse.JSONValue is TJSONObject)
  then
  begin
    JSONObject := RESTResponse.JSONValue as TJSONObject;

    if JSONObject.TryGetValue<TJSONObject>('_links', LinksObj) then
    begin
      if LinksObj.TryGetValue<TJSONObject>('self', SelfObj) then
      begin
        if SelfObj.TryGetValue<string>('href', HrefValue) then
        begin
          // Assuming the href ends with the ID, extract it
          SlashPos := HrefValue.LastIndexOf('/');
          if SlashPos > -1 then
          begin
            var aID := Copy(HrefValue, SlashPos + 2, Length(HrefValue)-SlashPos);
            Result.ID := StrToIntDef(aID, -1);
          end;
        end;
      end;
    end;
  end;

end;

function TYFTransportToken.FindSecurityToken(JSONValue: TJSONValue): string;
var
  Pair: TJSONPair;
  Obj: TJSONObject;
  Arr: TJSONArray;
  I: Integer;
begin
  Result := '';
  if JSONValue is TJSONObject then
  begin
    Obj := TJSONObject(JSONValue);
    for Pair in Obj do
    begin
      if SameText(Pair.JsonString.Value, 'securityToken') then
      begin
        Exit(Pair.JsonValue.Value);
      end;

      // Recursive search in child objects/arrays
      Result := FindSecurityToken(Pair.JsonValue);
      if Result <> '' then Exit;
    end;
  end
  else if JSONValue is TJSONArray then
  begin
    Arr := TJSONArray(JSONValue);
    for I := 0 to Arr.Count - 1 do
    begin
      Result := FindSecurityToken(Arr.Items[I]);
      if Result <> '' then Exit;
    end;
  end;

end;

procedure TYFTransportToken.InternalExecute(aToken: TYFTokenResponse);
begin
  var data := self.execute();

  if data = nil then
    Exit();

  aToken.Data := data.data;
  aToken.Status := data.Status;

  if (RESTResponse.Status.Success)
    and Assigned(RESTResponse.JSONValue)
    and (RESTResponse.JSONValue is TJSONObject)
  then
    aToken.Token := FindSecurityToken(TJSONObject(RESTResponse.JSONValue))
  else
    {$IFDEF DEBUG}
    aToken.Token := aToken.Data;
    {$ELSE}
    aToken.Token := '';
    {$ENDIF}
end;

{ TYFTokenResponse }

function TYFTokenResponse.GetToken: string;
begin
  Result := FToken;
end;

procedure TYFTokenResponse.SetToken(const Value: string);
begin
  FToken := Value;
end;

{ TYFAccessTokenResponse }

function TYFAccessTokenResponse.GetExpiry: TDateTime;
begin
  Result := FExpiry;
end;

procedure TYFAccessTokenResponse.SetExpiry(const Value: TDateTime);
begin
  FExpiry := Value;
end;

{ TYFRefreshTokenResponse }

function TYFRefreshTokenResponse.GetTokenID: Int64;
begin
  Result := FID;
end;

procedure TYFRefreshTokenResponse.SetTokenID(const Value: Int64);
begin
  FID := Value;
end;

end.
