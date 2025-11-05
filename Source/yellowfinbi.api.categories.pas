unit yellowfinbi.api.categories;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.categories.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Categories = class
  public
    /// <summary>
    ///   Get a list of Categories
    /// </summary>
    class function GetCategories(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aCategories : IYFSimpleCategoryModelList): IYFTransportResponse;

    class function GetCategory(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_CategoryUUID : string;
                             var aCategory : IYFCategory): IYFTransportResponse;

    class function GetCategorySubCategories(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_CategoryUUID : string;
                             var aCategories : IYFSimpleCategoryModelList): IYFTransportResponse;

    class function CreateCategory(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aCategory : IYFCategory): IYFTransportResponse;

    class function UpdateCategory(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aCategory : IYFCategory): IYFTransportResponse;

    class function DeleteCategory(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_CategoryUUID : string): IYFTransportResponse;

    class function DeleteCategories(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_CategoryUUIDs: TArray<string>): IYFTransportResponse;

    class function RefreshCategoryAccessLevels(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_CategoryUUID : string): IYFTransportResponse;

  end;

implementation

{ TYF_categories }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics,
  System.NetEncoding;

class function TYF_Categories.CreateCategory(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var aCategory: IYFCategory): IYFTransportResponse;
begin
  var aURL := 'api/categories/';

  var JSON := aCategory.AsJSON;
  Result:= TYFTransportResponseGenerics.Execute<IYFCategory>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmPOST,
        aURL,
        JSON,
        aCategory);
end;

class function TYF_Categories.DeleteCategories(
  const ServerDetails: IYFServerDetails; const yf_AccessToken : string;
  const yf_CategoryUUIDs: TArray<string>): IYFTransportResponse;
var
  StrArrayToList :  string;
begin
// Example
//  [ {
//    "propertyName": "ITEMS",
//    "valueOne": [
//      "a23c2ec6-a2fa-45c7-b5da-dcf3f02e6633",
//      "beaf11dd-6b34-4584-9ce9-8c3ed4f4d0a9"
//    ]
//  } ]

  for var S in yf_CategoryUUIDs do
  begin
    if StrArrayToList = '' then
      StrArrayToList := AnsiQuotedStr(S, '"')
    else
      StrArrayToList := StrArrayToList +', '+ AnsiQuotedStr(S, '"');
  end;

  var FilterForItems : string :=
     Format(
     '''
     [
        {
        "propertyName": "ITEMS",
        "valueOne": [ %s ]
      }
     ]
     ''',
     [StrArrayToList]);

  var aURL := 'api/categories?filters='+TNetEncoding.URL.Encode(FilterForItems);

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Categories.DeleteCategory(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  yf_CategoryUUID: string): IYFTransportResponse;
begin
  var aURL := Format('api/categories/%s',[yf_CategoryUUID]);

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Categories.GetCategories(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aCategories : IYFSimpleCategoryModelList): IYFTransportResponse;
begin
  var aURL := 'api/categories/';
  Result:= TYFTransportResponseGenerics.Execute<IYFSimpleCategoryModelList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aCategories);
end;

class function TYF_Categories.GetCategory(const ServerDetails: IYFServerDetails;
  const yf_AccessToken, yf_CategoryUUID: string;
  var aCategory: IYFCategory): IYFTransportResponse;
begin
  var aURL := Format('api/categories/%s',[yf_CategoryUUID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFCategory>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aCategory);
end;

class function TYF_Categories.GetCategorySubCategories(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  yf_CategoryUUID: string;
  var aCategories: IYFSimpleCategoryModelList): IYFTransportResponse;
begin
  var aURL := Format('api/categories/%s/subcategories',[yf_CategoryUUID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFSimpleCategoryModelList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aCategories);
end;

class function TYF_Categories.RefreshCategoryAccessLevels(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  yf_CategoryUUID: string): IYFTransportResponse;
begin
  var aURL := Format('api/rpc/categories/%s/refresh-access-cache',[yf_CategoryUUID]);

  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPOST,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Categories.UpdateCategory(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var aCategory: IYFCategory): IYFTransportResponse;
begin
  var aURL := Format('api/categories/%s',[aCategory.CategoryUUID]);
  var JSON := aCategory.AsJSON;

  Result:= TYFTransportResponseGenerics.Execute<IYFCategory>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmPATCH,
        aURL,
        JSON,
        aCategory);
end;

end.
