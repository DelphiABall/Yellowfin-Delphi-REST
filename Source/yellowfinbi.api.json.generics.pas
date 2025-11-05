unit yellowfinbi.api.json.generics;

interface

uses System.Generics.Collections, yellowfinbi.api.json, System.JSON, System.SysUtils;

type
  IYFModelList<I: IYFLoadFromJSON> = interface(IYFLoadFromJSONArray)
    ['{79CAC7B2-7DC0-42D1-BA6F-522AEDE8BFCF}']
    function GetItems: TList<I>;
    function GetItem(Index : Integer): I;
    function GetCount: NativeInt;

    procedure LoadFromJSON(const AJSON: TJSONObject);
    procedure LoadFromJSONArray(const AJSONArray: TJSONArray);

    property Items: TList<I> read GetItems;
    property Item[Index: Integer]: I read GetItem; default;
    property Count: NativeInt read GetCount;
  end;

  IYFModelListJSON<I: IYFJSON> = interface(IYFModelList<I>)
    function AsJSON: TJSONValue;
    function ToJSON: string;
  end;

  TYFModelList<I: IYFLoadFromJSON> = class(TInterfacedObject, IYFModelList<I>)
  private
    FItemsArrayName: string;
    FItems: TList<I>;
    FFactory: TFunc<I>;

    function GetItems: TList<I>;
    procedure SetItems(const Value: TList<I>);
    function GetItem(Index : Integer): I;
    function GetCount: NativeInt;

  protected
    function NewItem(AddToList : Boolean = True): I; virtual;
  public
    constructor Create(const AItemsArrayName: string = 'items'); overload;
    constructor Create(const AFactory: TFunc<I>; const AItemsArrayName: string = 'items'); overload;
    destructor Destroy; override;

    procedure LoadFromJSON(const AJSON: TJSONObject); virtual;
    procedure LoadFromJSONArray(const AJSONArray: TJSONArray); virtual;

    property Items: TList<I> read GetItems write SetItems;
    property Item[Index: Integer]: I read GetItem; default;
    property Count: NativeInt read GetCount;
  end;

  TYFModelListJSON<I: IYFJSON> = class(TYFModelList<I>, IYFJSON)
  public
    function AsJSON: TJSONValue;
    function ToJSON: string;
  end;

implementation

uses System.TypInfo, yellowfinbi.api.classfactory;

constructor TYFModelList<I>.Create(const AFactory: TFunc<I>; const AItemsArrayName: string);
begin
  inherited Create;
  FItemsArrayName := AItemsArrayName;
  FFactory := AFactory;
  FItems := TList<I>.Create;
end;

constructor TYFModelList<I>.Create(const AItemsArrayName: string);
begin
  Create(nil, AItemsArrayName);
end;

destructor TYFModelList<I>.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TYFModelList<I>.GetCount: NativeInt;
begin
  Result := FItems.Count;
end;

function TYFModelList<I>.GetItem(Index: Integer): I;
begin
  Result := FItems[Index];
end;

function TYFModelList<I>.GetItems: TList<I>;
begin
  Result := FItems;
end;

procedure TYFModelList<I>.SetItems(const Value: TList<I>);
begin
  FItems := Value;
end;

function TYFModelList<I>.NewItem(AddToList : Boolean): I;
begin
  if Assigned(FFactory) then
    Result := FFactory()
  else
  begin
    var Func := TYFFactoryRegistry.ResolveFactory<I>();
    if Func = nil then
      raise Exception.Create('No factory method provided');

    Result := Func();
  end;

  if AddToList and Assigned(Result) then
    Items.Add(Result);
end;


procedure TYFModelList<I>.LoadFromJSON(const AJSON: TJSONObject);
begin
  FItems.Clear;
  if Assigned(AJSON) then
  begin
    var AJSONArray: TJSONArray;
    if AJSON.TryGetValue<TJSONArray>(FItemsArrayName, AJSONArray) then
      LoadFromJSONArray(AJSONArray);
  end;
end;

procedure TYFModelList<I>.LoadFromJSONArray(const AJSONArray: TJSONArray);
begin
  if AJSONArray = nil then
    Exit;

  FItems.Clear;

  for var JSONValue in AJSONArray do
  begin
    if JSONValue is TJSONObject then
    begin
      var Item := NewItem(False);
      Item.LoadFromJSON(TJSONObject(JSONValue));
      FItems.Add(Item);
    end;
  end;
end;


{ TYFModelListJSON<I> }

function TYFModelListJSON<I>.AsJSON: TJSONValue;
var
  ItemsArray: TJSONArray;
  CurrI: I;
begin
  var JSON := TJSONObject.Create;

  ItemsArray := TJSONArray.Create;
  for CurrI in Items do
    ItemsArray.AddElement(TJSONObject.ParseJSONValue(CurrI.ToJSON) as TJSONObject);
  JSON.AddPair('items', ItemsArray);
  Result := JSON;
end;

function TYFModelListJSON<I>.ToJSON: string;
begin
  var FJSON := AsJSON;
  try
    Result := FJSON.ToJSON;
  finally
    FJSON.Free;
  end;
end;

end.
