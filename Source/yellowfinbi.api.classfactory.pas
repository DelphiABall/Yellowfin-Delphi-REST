unit yellowfinbi.api.classfactory;

interface

uses System.TypInfo, System.Generics.Collections, System.SysUtils;

type
  TYFFactoryRegistry = class
  private
    class var FRegistry: TDictionary<PTypeInfo, TFunc<IInterface>>;
  public
    class constructor Create;
    class destructor Destroy;

    class procedure RegisterFactory<I: IInterface>(const Factory: TFunc<I>);
    class function ResolveFactory<I: IInterface>: TFunc<I>;
    class function CreateNew<I: IInterface>: I;

  end;

implementation

{ TYFFactoryRegistry }

class constructor TYFFactoryRegistry.Create;
begin
  FRegistry := TDictionary<PTypeInfo, TFunc<IInterface>>.Create;
end;

class function TYFFactoryRegistry.CreateNew<I>: I;
begin
  var AFunc : TFunc<I> := TYFFactoryRegistry.ResolveFactory<I>();
  if AFunc <> nil then
    Result := AFunc()
  else
    Result := nil;
end;

class destructor TYFFactoryRegistry.Destroy;
begin
  FRegistry.Free;
end;

class procedure TYFFactoryRegistry.RegisterFactory<I>(const Factory: TFunc<I>);
var
  TypeInfo: PTypeInfo;
begin
  TypeInfo := System.TypeInfo(I);
  FRegistry.AddOrSetValue(TypeInfo, TFunc<IInterface>(Factory));
end;

class function TYFFactoryRegistry.ResolveFactory<I>: TFunc<I>;
var
  TypeInfo: PTypeInfo;
  BaseFunc: TFunc<IInterface>;
begin
  TypeInfo := System.TypeInfo(I);
  if FRegistry.TryGetValue(TypeInfo, BaseFunc) then
    Result := function: I begin Result := I(BaseFunc()); end
  else
    raise Exception.CreateFmt('No factory registered for interface %s', [TypeInfo.Name]);
end;

end.
