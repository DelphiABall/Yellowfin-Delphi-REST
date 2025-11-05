unit yellowfinbi.api.reports;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.reports.intf, REST.Types, yellowfinbi.api.transport.classes,
  yellowfinbi.api.filters.intf;

type
  TYF_Reports = class
    class function GetReports(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var ReportsList : IYFReportListItems;
                           const FilterRequestValues : IYFFiltersRequest;
                           const yf_MaxItem : Integer = 0): IYFTransportResponse;

    class function GetAvailableMetadataForReportsList(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var MetaData : IYFSearchOptions): IYFTransportResponse;

    class function GetSpecificReports(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           var yf_ReportID : Int64;
                           var Report : IYFReportListItemModel): IYFTransportResponse;
  end;

implementation

uses
  yellowfinbi.api.transport.generics, System.SysUtils, System.NetEncoding;

{ TYF_Reports }

class function TYF_Reports.GetAvailableMetadataForReportsList(
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

class function TYF_Reports.GetReports(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string;
  var ReportsList: IYFReportListItems;
  const FilterRequestValues : IYFFiltersRequest;
  const yf_MaxItem : Integer): IYFTransportResponse;
begin
  var aURL := TYFFilterHelper.BuildURL('api/reports', FilterRequestValues, yf_MaxItem);

  Result:= TYFTransportResponseGenerics.Execute<IYFReportListItems>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        ReportsList);
end;

class function TYF_Reports.GetSpecificReports(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var yf_ReportID: Int64;
  var Report: IYFReportListItemModel): IYFTransportResponse;
begin
  var aURL := Format('api/reports/%d', [yf_ReportID]);

  Result:= TYFTransportResponseGenerics.Execute<IYFReportListItemModel>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        Report);
end;

end.
