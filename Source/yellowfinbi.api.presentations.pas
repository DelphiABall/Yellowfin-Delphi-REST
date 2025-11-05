unit yellowfinbi.api.presentations;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.presentations.intf,
  yellowfinbi.api.filters.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Presentations = class
  public
    /// <summary>
    ///   Get a list of Presentations
    /// </summary>
    class function GetPresentationsList(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aPresentations : IYFPresentationsList;
                             const FilterRequestValues : IYFFiltersRequest;
                             const yf_MaxItem : Integer): IYFTransportResponse;

    class function GetAvailableMetadataForPresentationList(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var MetaData : IYFSearchOptions): IYFTransportResponse;

    class function GetPresentation(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_PresentationID : Int64;
                             var aPresentation : IYFPresentationListItemModel): IYFTransportResponse;

    class function GetPresentationReports(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_PresentationID : Int64;
                             var aPresentationReportList : IYFPresentationReportList): IYFTransportResponse;
  end;

implementation

{ TYF_presentations }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Presentations.GetAvailableMetadataForPresentationList(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var MetaData: IYFSearchOptions): IYFTransportResponse;
begin
  var aURL := 'api/presentations/metadata';
   Result := TYFTransportResponseGenerics.Execute<IYFSearchOptions>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  MetaData);

end;

class function TYF_Presentations.GetPresentation(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_PresentationID: Int64;
  var aPresentation: IYFPresentationListItemModel): IYFTransportResponse;
begin
  var aURL := Format('api/presentations/%d', [yf_PresentationID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFPresentationListItemModel>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aPresentation);
end;

class function TYF_Presentations.GetPresentationReports(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_PresentationID: Int64;
  var aPresentationReportList: IYFPresentationReportList): IYFTransportResponse;
begin

end;

class function TYF_Presentations.GetPresentationsList(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aPresentations : IYFPresentationsList;
  const FilterRequestValues : IYFFiltersRequest;
  const yf_MaxItem : Integer): IYFTransportResponse;
begin
  var aURL := TYFFilterHelper.BuildURL('api/presentations/', FilterRequestValues, yf_MaxItem);
  Result:= TYFTransportResponseGenerics.Execute<IYFPresentationsList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aPresentations);
end;

end.
