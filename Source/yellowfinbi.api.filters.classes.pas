unit yellowfinbi.api.filters.classes;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.JSON,
  yellowfinbi.api.json, yellowfinbi.api.json.generics, yellowfinbi.api.common,
  yellowfinbi.api.filters.intf;

type
  TYFFilterRequestValue = class(TInterfacedObject, IYFFiltersRequest)
  public
    PropertyName: string;
    FilterOperator: TYFFilterTypes.FilterOperator;
    Value1 : string;
    Value2 : string;

    function DateToQueryValue(Value : TDateTime): string;
    function ToJSON: string;
    function AsJSON: TJSONValue;
    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;

  TYFFilterRequestValues = class(TInterfacedObject, IYFFiltersRequest)
    Values : TObjectList<TYFFilterRequestValue>;

    function ToJSON: string;
    function AsJSON: TJSONValue;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    constructor Create(OwnsValues : Boolean = True);
    destructor Destroy; override;
  end;

  TYFFilterValue = class(TInterfacedObject, IYFFilterValue)
  private
    FDisplayText: string;
    FFilterValueCode: string;
    FIsDefault: Boolean;

    function GetDisplayText: string;
    function GetFilterValueCode: string;
    function GetIsDefault: Boolean;
    procedure SetDisplayText(const Value: string);
    procedure SetFilterValueCode(const Value: string);
    procedure SetIsDefault(const Value: Boolean);
  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property DisplayText: string read GetDisplayText write SetDisplayText;
    property FilterValueCode: string read GetFilterValueCode write SetFilterValueCode;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
  end;

  TYFPossibleFilter = class(TInterfacedObject, IYFPossibleFilter)
  private
    FPropertyName: string;
    FOperator: TYFFilterTypes.FilterOperator;
    FPossibleFilterValues: TYFModelList<IYFFilterValue>;

    function GetPropertyName: string;
    function GetOperator: TYFFilterTypes.FilterOperator;
    function GetPossibleFilterValues: TYFModelList<IYFFilterValue>;

    procedure SetPropertyName(const Value: string);
    procedure SetOperator(const Value: TYFFilterTypes.FilterOperator);
    procedure SetPossibleFilterValues(const Value: TYFModelList<IYFFilterValue>);
  public
    constructor Create(AFactory : TFunc<IYFFilterValue> = nil);
    destructor Destroy; override;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property PropertyName: string read GetPropertyName write SetPropertyName;
    property FilterOperator: TYFFilterTypes.FilterOperator read GetOperator write SetOperator;
    property PossibleFilterValues: TYFModelList<IYFFilterValue> read GetPossibleFilterValues write SetPossibleFilterValues;
  end;

  TYFSortOption = class(TInterfacedObject, IYFSortOption)
  private
    FDisplayName: string;
    FDefaultSortDirection: TYFFilterTypes.SortDirection;
    FIsDefault: Boolean;
    FPropertyName: string;

    function GetDisplayName: string;
    function GetDefaultSortDirection: TYFFilterTypes.SortDirection;
    function GetIsDefault: Boolean;
    function GetPropertyName: string;
    procedure SetDisplayName(const Value: string);
    procedure SetDefaultSortDirection(const Value: TYFFilterTypes.SortDirection);
    procedure SetIsDefault(const Value: Boolean);
    procedure SetPropertyName(const Value: string);
  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property DisplayName: string read GetDisplayName write SetDisplayName;
    property DefaultSortDirection: TYFFilterTypes.SortDirection read GetDefaultSortDirection write SetDefaultSortDirection;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property PropertyName: string read GetPropertyName write SetPropertyName;
  end;

  TYFSearchOptions = class(TInterfacedObject, IYFSearchOptions)
  private
    FPossibleFilters: TYFModelList<IYFPossibleFilter>;
    FPossibleSortOptions: TYFModelList<IYFSortOption>;

    function GetPossibleFilters: TYFModelList<IYFPossibleFilter>;
    function GetPossibleSortOptions: TYFModelList<IYFSortOption>;
    procedure SetPossibleFilters(const Value: TYFModelList<IYFPossibleFilter>);
    procedure SetPossibleSortOptions(const Value: TYFModelList<IYFSortOption>);
  public
    constructor Create(APossibleFilterFactory : TFunc<IYFPossibleFilter> = nil;
                       ASortOptionFactory : TFunc<IYFSortOption> = nil);
    destructor Destroy; override;

    procedure LoadFromJSON(const AJSON: TJSONObject);

    property PossibleFilters: TYFModelList<IYFPossibleFilter> read GetPossibleFilters write SetPossibleFilters;
    property PossibleSortOptions: TYFModelList<IYFSortOption> read GetPossibleSortOptions write SetPossibleSortOptions;
  end;

implementation

uses yellowfinbi.api.classfactory;

{ TYFFilterValue }

function TYFFilterValue.GetDisplayText: string;
begin
  Result := FDisplayText;
end;

function TYFFilterValue.GetFilterValueCode: string;
begin
  Result := FFilterValueCode;
end;

function TYFFilterValue.GetIsDefault: Boolean;
begin
  Result := FIsDefault;
end;

procedure TYFFilterValue.LoadFromJSON(const AJSON: TJSONObject);
begin
  FDisplayText := AJSON.GetValue<string>('displayText');
  FFilterValueCode := AJSON.GetValue<string>('filterValueCode');
  FIsDefault := AJSON.GetValue<Boolean>('isDefault');
end;

procedure TYFFilterValue.SetDisplayText(const Value: string);
begin
  FDisplayText := Value;
end;

procedure TYFFilterValue.SetFilterValueCode(const Value: string);
begin
  FFilterValueCode := Value;
end;

procedure TYFFilterValue.SetIsDefault(const Value: Boolean);
begin
  FIsDefault := Value;
end;

{ TYFPossibleFilter }

constructor TYFPossibleFilter.Create(AFactory : TFunc<IYFFilterValue>);
begin
  inherited Create();
  FPossibleFilterValues := TYFModelList<IYFFilterValue>.Create( AFactory,
                                                                'possibleFilterValues');
end;

destructor TYFPossibleFilter.Destroy;
begin
  FPossibleFilterValues.Free;
  inherited;
end;

function TYFPossibleFilter.GetOperator: TYFFilterTypes.FilterOperator;
begin
  Result := FOperator;
end;

function TYFPossibleFilter.GetPossibleFilterValues: TYFModelList<IYFFilterValue>;
begin
  Result := FPossibleFilterValues;
end;

function TYFPossibleFilter.GetPropertyName: string;
begin
  Result := FPropertyName;
end;

procedure TYFPossibleFilter.LoadFromJSON(const AJSON: TJSONObject);
begin
  var filterMetadataJSON : TJSONObject;
  possibleFilterValues.Items.Clear;

  if not AJSON.TryGetValue<TJSONObject>('filterMetadata', filterMetadataJSON) then
    Exit;

  PropertyName := filterMetadataJSON.GetValue<string>('propertyName');
  FilterOperator :=  TYFFilterTypes.GetValue<TYFFilterTypes.FilterOperator>(filterMetadataJSON.GetValue<string>('operator'), TYFFilterTypes.FilterOperator.EQUAL_TO);

  possibleFilterValues.LoadFromJSON(AJSON);
end;

procedure TYFPossibleFilter.SetOperator(const Value: TYFFilterTypes.FilterOperator);
begin
  FOperator := Value;
end;

procedure TYFPossibleFilter.SetPossibleFilterValues(const Value: TYFModelList<IYFFilterValue>);
begin
  FPossibleFilterValues := Value;
end;

procedure TYFPossibleFilter.SetPropertyName(const Value: string);
begin
  FPropertyName := Value;
end;

{ TYFSortOption }

function TYFSortOption.GetDefaultSortDirection: TYFFilterTypes.SortDirection;
begin
  Result := FDefaultSortDirection;
end;

function TYFSortOption.GetDisplayName: string;
begin
  Result := FDisplayName;
end;

function TYFSortOption.GetIsDefault: Boolean;
begin
  Result := FIsDefault;
end;

function TYFSortOption.GetPropertyName: string;
begin
  Result := FPropertyName;
end;

procedure TYFSortOption.LoadFromJSON(const AJSON: TJSONObject);
begin
// TODO
end;

procedure TYFSortOption.SetDefaultSortDirection(const Value: TYFFilterTypes.SortDirection);
begin
  FDefaultSortDirection := Value;
end;

procedure TYFSortOption.SetDisplayName(const Value: string);
begin
  FDisplayName := Value;
end;

procedure TYFSortOption.SetIsDefault(const Value: Boolean);
begin
  FIsDefault := Value;
end;

procedure TYFSortOption.SetPropertyName(const Value: string);
begin
  FPropertyName := Value;
end;

{ TYFSearchOptions }

constructor TYFSearchOptions.Create(
  APossibleFilterFactory : TFunc<IYFPossibleFilter> = nil;
  ASortOptionFactory : TFunc<IYFSortOption> = nil);
begin
  inherited Create;

  FPossibleFilters := TYFModelList<IYFPossibleFilter>.Create(
    APossibleFilterFactory,
    'possibleFilters');

  FPossibleSortOptions := TYFModelList<IYFSortOption>.Create(
    ASortOptionFactory,
    'possibleSortOptions');
end;

destructor TYFSearchOptions.Destroy;
begin
  FPossibleFilters.Free;
  FPossibleSortOptions.Free;
  inherited;
end;

function TYFSearchOptions.GetPossibleFilters: TYFModelList<IYFPossibleFilter>;
begin
  Result := FPossibleFilters;
end;

function TYFSearchOptions.GetPossibleSortOptions: TYFModelList<IYFSortOption>;
begin
  Result := FPossibleSortOptions;
end;

procedure TYFSearchOptions.LoadFromJSON(const AJSON: TJSONObject);
begin
  FPossibleFilters.LoadFromJSON(AJSON);
  FPossibleSortOptions.LoadFromJSON(AJSON);
end;

procedure TYFSearchOptions.SetPossibleFilters(const Value: TYFModelList<IYFPossibleFilter>);
begin
  FPossibleFilters := Value;
end;

procedure TYFSearchOptions.SetPossibleSortOptions(const Value: TYFModelList<IYFSortOption>);
begin
  FPossibleSortOptions := Value;
end;

{ TYFFilterRequestValue }

function TYFFilterRequestValue.AsJSON: TJSONValue;
begin
  var JSON := TJSONObject.Create;
  JSON.AddPair('propertyName', PropertyName);
  JSON.AddPair('operator', TYFFilterTypes.ValueToString<TYFFilterTypes.FilterOperator>(FilterOperator));
  JSON.AddPair('valueOne', Value1);
  JSON.AddPair('valueTwo', Value2);

  Result := JSON;
end;

function TYFFilterRequestValue.DateToQueryValue(Value: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd',Value);
end;

procedure TYFFilterRequestValue.LoadFromJSON(const AJSON: TJSONObject);
begin
  AJSON.TryGetValue<string>('propertyName', PropertyName);

  var OpVal : string;
  if AJSON.TryGetValue<string>('operator', OpVal) then
    FilterOperator := TYFFilterTypes.GetValue<TYFFilterTypes.FilterOperator>(OpVal, TYFFilterTypes.FilterOperator.EQUAL_TO);

  AJSON.TryGetValue<string>('valueOne', Value1);
  AJSON.TryGetValue<string>('valueTwo', Value2);
end;

function TYFFilterRequestValue.ToJSON: string;
begin
  var JSON := AsJSON;
  try
    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;

{ TYFFilterRequestValues }

function TYFFilterRequestValues.AsJSON: TJSONValue;
begin
  var JSONArray := TJSONArray.Create;
  for var CurrValue in Values do
  begin
    var J := CurrValue.AsJSON;
    JSONArray.Add(TJSONObject(J));
  end;
  Result := JSONArray;
end;

constructor TYFFilterRequestValues.Create(OwnsValues: Boolean);
begin
  Values := TObjectList<TYFFilterRequestValue>.Create(OwnsValues);
end;

destructor TYFFilterRequestValues.Destroy;
begin
  Values.Free;
  inherited;
end;

procedure TYFFilterRequestValues.LoadFromJSON(const AJSON: TJSONObject);
begin
  //
end;

function TYFFilterRequestValues.ToJSON: string;
begin
  var JSON := AsJSON;
  try
    Result := JSON.ToJSON;
  finally
    JSON.Free;
  end;
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFFilterValue>(
    function: IYFFilterValue
    begin
      Result := TYFFilterValue.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFPossibleFilter>(
    function: IYFPossibleFilter
    begin
      Result := TYFPossibleFilter.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFSortOption>(
    function: IYFSortOption
    begin
      Result := TYFSortOption.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFSearchOptions>(
    function: IYFSearchOptions
    begin
      Result := TYFSearchOptions.Create;
    end
  );

end.

