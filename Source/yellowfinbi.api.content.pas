unit yellowfinbi.api.content;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.content.intf,
  yellowfinbi.api.filters.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Content = class
  public
    /// <summary>
    ///   Get a list of Content
    /// </summary>
    class function GetContent(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aContentList : IYFContentList;
                             const FilterRequestValues : IYFFiltersRequest;
                             const yf_MaxItem : Integer = 0): IYFTransportResponse;

    /// <summary>
    ///   Get a MetaData for Selecting Content
    /// </summary>
    class function GetAvailableMetadataForContentList(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var MetaData : IYFSearchOptions): IYFTransportResponse;

    /// <summary>
    ///   Get a list of Content for a specific user (YF 9.16.1+)
    /// </summary>
    class function GetContentForUser(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aContentList : IYFContentList;
                             const yf_UserID : Integer;
                             const FilterRequestValues : IYFFiltersRequest;
                             const yf_MaxItem : Integer = 0): IYFTransportResponse;
  end;

implementation

{ TYF_content }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Content.GetContent(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aContentList : IYFContentList;
  const FilterRequestValues : IYFFiltersRequest; const yf_MaxItem : Integer = 0): IYFTransportResponse;
begin
  var aURL := TYFFilterHelper.BuildURL('api/content', FilterRequestValues, yf_MaxItem);
  Result:= TYFTransportResponseGenerics.Execute<IYFContentList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aContentList);
end;

class function TYF_Content.GetAvailableMetadataForContentList(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var MetaData: IYFSearchOptions): IYFTransportResponse;
begin
   var aURL := 'api/reports/metadata';
   Result := TYFTransportResponseGenerics.Execute<IYFSearchOptions>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  MetaData);

end;

class function TYF_Content.GetContentForUser(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; var aContentList: IYFContentList;
  const yf_UserID: Integer; const FilterRequestValues: IYFFiltersRequest;
  const yf_MaxItem: Integer): IYFTransportResponse;
begin
  var aURL := TYFFilterHelper.BuildURL(Format('api/admin/users/%d/content',[yf_UserID]), FilterRequestValues, yf_MaxItem);
  Result:= TYFTransportResponseGenerics.Execute<IYFContentList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aContentList);

end;

end.
