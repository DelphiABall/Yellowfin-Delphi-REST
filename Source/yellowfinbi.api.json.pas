unit yellowfinbi.api.json;

interface

uses System.JSON, System.SysUtils;


type
  IYFLoadFromJSON = interface
    ['{EEEFC372-BD82-4B8D-8F07-0EB7C0D04BDB}']
    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;

  IYFLoadFromJSONArray = interface(IYFLoadFromJSON)
    ['{EEEFC372-BD82-4B8D-8F07-0EB7C0D04BDB}']
    procedure LoadFromJSONArray(const AJSONArray: TJSONArray);
  end;

  IYFJSON = interface(IYFLoadFromJSON)
    ['{582834FA-DD3C-4916-969D-8653F71CFCA1}']
    function ToJSON: string;
    function AsJSON: TJSONValue;
  end;

  function YFDateStrToTDateTime(DateStr : string): TDateTime;
  function JSONToBool(const jv: TJSONValue; const Default: Boolean = False): Boolean;

implementation

uses System.DateUtils;

function YFDateStrToTDateTime(DateStr : string): TDateTime;
var
  Y, M, D, H, N, S: Integer;
begin
  try
    if Length(DateStr) = 14 then
      begin
        if TryStrToInt(Copy(DateStr, 1, 4), Y) and
           TryStrToInt(Copy(DateStr, 5, 2), M) and
           TryStrToInt(Copy(DateStr, 7, 2), D) and
           TryStrToInt(Copy(DateStr, 9, 2), H) and
           TryStrToInt(Copy(DateStr, 11, 2), N) and
           TryStrToInt(Copy(DateStr, 13, 2), S) then
        begin
          Result := EncodeDateTime(Y, M, D, H, N, S, 0);
        end
        else
          Result := 0; // fallback or raise an exception if needed
      end
      else
        Result := 0; // fallback or raise an exception if needed
  except
    Result := 0
  end;
end;

function JSONToBool(const jv: TJSONValue; const Default: Boolean = False): Boolean;
begin
  if jv = nil then
    Exit(Default);

  if jv is TJSONBool then
    Exit(TJSONBool(jv).AsBoolean);

  if jv is TJSONNumber then
    Exit(TJSONNumber(jv).AsInt <> 0);

  if jv is TJSONString then
  begin
    if SameText(TJSONString(jv).Value, 'true') or
       SameText(TJSONString(jv).Value, '1') then
      Exit(True)
    else if SameText(TJSONString(jv).Value, 'false') or
            SameText(TJSONString(jv).Value, '0') then
      Exit(False);
  end;

  Result := Default;
end;

end.
