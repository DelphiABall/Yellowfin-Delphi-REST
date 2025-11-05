unit yellowfinbi.api.transport.generics;

interface

uses  yellowfinbi.api.common, System.JSON, yellowfinbi.api.json, REST.Types,
  yellowfinbi.api.transport.classes,  System.SysUtils;

type
  TYFTransportResponseGenerics = class
  public
    /// <summary>
    ///   Execute a Transport Request, defining both the Interface and Type you want returned. Type must support the interface
    /// </summary>
//    class function Execute<I : IYFLoadFromJSON; T : class, constructor>(
//                           const ServerDetails: IYFServerDetails;
//                           const yf_AccessToken: string;
//                           const AMethod: TRESTRequestMethod;
//                           const AEndpoint: string;
//                           const ABody : TJSONValue;
//                           var AResponse: I): IYFTransportResponse; overload;

    /// <summary>
    ///   Execute a Transport Request, defining the Interface you want returned. New Objects will be created via the Factory function
    /// </summary>
    class function Execute<I : IYFLoadFromJSON>(
                           const ServerDetails: IYFServerDetails;
                           const yf_AccessToken: string;
                           const AMethod: TRESTRequestMethod;
                           const AEndpoint: string;
                           const ABody : TJSONValue;
                           const AFactory : TFunc<I>;
                           var AResponse: I): IYFTransportResponse; overload;

    /// <summary>
    ///   Execute a Transport Request, defining the Interface you want returned. New Objects will be created via the Factory function from the TYFFactoryRegistry.ClassFactory
    /// </summary>
    class function Execute<I : IYFLoadFromJSON>(
                           const ServerDetails: IYFServerDetails;
                           const yf_AccessToken: string;
                           const AMethod: TRESTRequestMethod;
                           const AEndpoint: string;
                           const ABody : TJSONValue;
                           var AResponse: I): IYFTransportResponse; overload;
  end;


implementation

uses yellowfinbi.api.transport, System.TypInfo, yellowfinbi.api.classfactory;


{ TYFTransportResponseGenerics }

//class function TYFTransportResponseGenerics.Execute<I, T>(
//  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
//  const AMethod: TRESTRequestMethod; const AEndpoint: string; const ABody : TJSONValue;
//  var AResponse: I): IYFTransportResponse;
//begin
//  var AFactory : TFunc<I> := function() : I
//    begin
//      var Obj := T.Create;
//        if not Supports(Obj, GetTypeData(TypeInfo(I)).Guid, Result) then
//          raise EInvalidCast.Create('Cannot cast created object to expected interface');
//    end;
//
//  Result := TYFTransportResponseGenerics.Execute<I>(ServerDetails, yf_AccessToken, AMethod, AEndpoint, ABody, AFactory, AResponse);
//end;

class function TYFTransportResponseGenerics.Execute<I>(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const AMethod: TRESTRequestMethod; const AEndpoint: string;
  const ABody: TJSONValue; const AFactory: TFunc<I>;
  var AResponse: I): IYFTransportResponse;
begin
 var Transport := TYFTransport.Create(nil, AMethod, ServerDetails, AEndpoint, yf_AccessToken, ABody);
  try
    Result := Transport.Execute;

    if Assigned(Result) and Result.Successful then
    begin
      if not Assigned(AResponse) then
      begin
        AResponse := AFactory;
      end;

      var JObj := TJSONObject.ParseJSONValue(Result.Data) as TJSONObject;
      if Assigned(JObj) then
      try
        AResponse.LoadFromJSON(JObj);
      finally
        JObj.Free;
      end;
    end;

  finally
    Transport.Free;
  end;
end;

class function TYFTransportResponseGenerics.Execute<I>(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const AMethod: TRESTRequestMethod; const AEndpoint: string;
  const ABody: TJSONValue; var AResponse: I): IYFTransportResponse;
begin
  var AFactory : TFunc<I> := TYFFactoryRegistry.ResolveFactory<I>();

  Result := TYFTransportResponseGenerics.Execute<I>(ServerDetails, yf_AccessToken, AMethod, AEndpoint, ABody, AFactory, AResponse);
end;

end.
