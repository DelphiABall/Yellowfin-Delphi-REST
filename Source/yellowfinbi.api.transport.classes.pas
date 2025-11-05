unit yellowfinbi.api.transport.classes;

interface

type
  IYFTransportResponse= interface
    ['{D671BB61-74EF-4FE7-8F11-428DDF6809FE}']
    function GetSuccessful : Boolean;

    function GetStatus : Integer;
    procedure SetStatus(const Value : Integer);

    function GetData : string;
    procedure SetData(const Value : string);


    property Successful : Boolean read GetSuccessful;
    property Status : Integer read GetStatus write SetStatus;
    property Data : string read GetData write SetData;
  end;

  TYFTransportResponse = class(TInterfacedObject, IYFTransportResponse)
  private
    FStatus: Integer;
    FData: string;
    function GetSuccessful: Boolean;

    function GetStatus : Integer;
    procedure SetStatus(const Value : Integer);

    function GetData : string;
    procedure SetData(const Value : string);

  public
    constructor Create(AStatus : Integer; AData : string); overload;
    constructor Create; overload;

    property Successful : Boolean read GetSuccessful;
    property Status : Integer read GetStatus write SetStatus;
    property Data : string read GetData write SetData;
  end;


implementation

{ TYFTransportResponse }

constructor TYFTransportResponse.Create(AStatus: Integer; AData: string);
begin
  Create;
  Status := AStatus;
  Data := AData;
end;

constructor TYFTransportResponse.Create;
begin
  inherited Create;
end;

function TYFTransportResponse.GetData: string;
begin
  Result := FData;
end;

function TYFTransportResponse.GetStatus: Integer;
begin
  Result := FStatus;
end;

function TYFTransportResponse.GetSuccessful: Boolean;
begin
  Result := (Status >= 200) and (Status < 300);
end;

procedure TYFTransportResponse.SetData(const Value: string);
begin
  FData := Value;
end;

procedure TYFTransportResponse.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
