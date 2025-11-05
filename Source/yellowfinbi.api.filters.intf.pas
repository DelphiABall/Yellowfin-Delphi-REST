unit yellowfinbi.api.filters.intf;

interface

uses
  System.SysUtils,
  yellowfinbi.api.json, yellowfinbi.api.json.generics, yellowfinbi.api.common;

type
  TYFFilterTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    FilterOperator = (EQUAL_TO, NOT_EQUAL_TO, CONTAINS, BETWEEN, GREATER_THAN, SMALLER_THAN);
    SortDirection = (ASC, DESC);
    {$SCOPEDENUMS OFF}
  end;

  IYFFiltersRequest = interface(IYFJSON)
    ['{822280A6-3403-4389-967A-122457FB3D76}']
  end;

  IYFFilterValue = interface(IYFLoadFromJSON)
    ['{F7B5C907-B52C-497E-908F-0BFB7DE31DFA}']
    function GetDisplayText: string;
    function GetFilterValueCode: string;
    function GetIsDefault: Boolean;
    procedure SetDisplayText(const Value: string);
    procedure SetFilterValueCode(const Value: string);
    procedure SetIsDefault(const Value: Boolean);

    property DisplayText: string read GetDisplayText write SetDisplayText;
    property FilterValueCode: string read GetFilterValueCode write SetFilterValueCode;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
  end;

  IYFPossibleFilter = interface(IYFLoadFromJSON)
    ['{9B4CE34A-7D5F-4BB9-8418-7D106CBE8FD9}']
    function GetPropertyName: string;
    function GetOperator: TYFFilterTypes.FilterOperator;
    function GetPossibleFilterValues: TYFModelList<IYFFilterValue>;
    procedure SetPropertyName(const Value: string);
    procedure SetOperator(const Value: TYFFilterTypes.FilterOperator);
    procedure SetPossibleFilterValues(const Value: TYFModelList<IYFFilterValue>);

    property PropertyName: string read GetPropertyName write SetPropertyName;
    property FilterOperator: TYFFilterTypes.FilterOperator read GetOperator write SetOperator;
    property PossibleFilterValues: TYFModelList<IYFFilterValue> read GetPossibleFilterValues write SetPossibleFilterValues;
  end;

  IYFSortOption = interface(IYFLoadFromJSON)
    ['{18F25B0C-0C6E-4D1C-A5A4-8C0E4743D896}']
    function GetDisplayName: string;
    function GetDefaultSortDirection: TYFFilterTypes.SortDirection;
    function GetIsDefault: Boolean;
    function GetPropertyName: string;
    procedure SetDisplayName(const Value: string);
    procedure SetDefaultSortDirection(const Value: TYFFilterTypes.SortDirection);
    procedure SetIsDefault(const Value: Boolean);
    procedure SetPropertyName(const Value: string);

    property DisplayName: string read GetDisplayName write SetDisplayName;
    property DefaultSortDirection: TYFFilterTypes.SortDirection read GetDefaultSortDirection write SetDefaultSortDirection;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property PropertyName: string read GetPropertyName write SetPropertyName;
  end;

  IYFSearchOptions = interface(IYFLoadFromJSON)
    ['{CC45F872-334D-4AC1-B47F-22B12B1E4DD4}']
    function GetPossibleFilters: TYFModelList<IYFPossibleFilter>;
    function GetPossibleSortOptions: TYFModelList<IYFSortOption>;
    procedure SetPossibleFilters(const Value: TYFModelList<IYFPossibleFilter>);
    procedure SetPossibleSortOptions(const Value: TYFModelList<IYFSortOption>);

    property PossibleFilters: TYFModelList<IYFPossibleFilter> read GetPossibleFilters write SetPossibleFilters;
    property PossibleSortOptions: TYFModelList<IYFSortOption> read GetPossibleSortOptions write SetPossibleSortOptions;
  end;

  TYFFilterHelper = class
  public
    class function BuildURL(aURL : string;
                            const FilterRequestValues : IYFFiltersRequest;
                            const yf_MaxItem : Integer): string;

  end;


implementation

uses System.NetEncoding;

{ TYFFilterHelper }

class function TYFFilterHelper.BuildURL(aURL: string;
  const FilterRequestValues: IYFFiltersRequest;
  const yf_MaxItem: Integer): string;

 var
  QueryParamsSeperator : string;

  procedure AppendURL(Value : string);
  begin
    aURL := aURL + QueryParamsSeperator + Value;
    QueryParamsSeperator := '&';
  end;

begin
  QueryParamsSeperator := '?';

  // There is the chance of multiple paramaters, so use the AppendURL to track this.
  // The first will get ? and then the reset & to format the URL correcrtly.

  if yf_MaxItem > 0 then
    AppendURL(Format('limit=%d',[yf_MaxItem]));

  if Assigned(FilterRequestValues) then
  begin
    var aFilterString : string := FilterRequestValues.ToJSON;

    if aFilterString > '' then
    begin
      // Ensure, if a single Object, its passed as an Array
      if not aFilterString.StartsWith('[') then
        aFilterString := '['+aFilterString+']';

      AppendURL('filters='+TURLEncoding.URL.Encode(aFilterString));
    end;
  end;

  Result := aURL;
end;

end.

