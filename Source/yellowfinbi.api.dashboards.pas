unit yellowfinbi.api.dashboards;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.dashboards.intf,
  yellowfinbi.api.transport.classes,
  yellowfinbi.api.filters.intf;

type

  TYF_Dashboards = class
  public
    /// <summary>
    ///   Get a list of Dashboards
    /// </summary>
    class function GetDashboardsList(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aDashboards : IYFDashboardsList;
                             const FilterRequestValues : IYFFiltersRequest;
                             const yf_MaxItem : Integer): IYFTransportResponse;
    /// <summary>
    ///   Get a MetaData for searching for Dashboards
    /// </summary>
    class function GetAvailableMetadataForDashboardList(
                             const ServerDetails: IYFServerDetails;
                             const yf_AccessToken: string;
                             var MetaData: IYFSearchOptions): IYFTransportResponse;

    /// <summary>
    ///   Get a specific Dashboards visible to the user
    /// </summary>
    class function GetDashboard(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DashboardID : Int64;
                             var aDashboard : IYFDashboardListItemModel
                             ): IYFTransportResponse;

    /// <summary>
    ///   Get the Reports that make up a specific Dashboards
    /// </summary>
    class function GetDashboardReports(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DashboardID : Int64;
                             var aDashboardReports : IYFDashboardReportList
                             ): IYFTransportResponse;

  end;

implementation

{ TYF_dashboards }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Dashboards.GetAvailableMetadataForDashboardList(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  var MetaData: IYFSearchOptions): IYFTransportResponse;
begin
  var aURL := 'api/dashboards/metadata';
   Result := TYFTransportResponseGenerics.Execute<IYFSearchOptions>(
                                                  ServerDetails,
                                                  yf_AccessToken,
                                                  TRESTRequestMethod.rmGET,
                                                  aURL,
                                                  nil,
                                                  MetaData);

end;

class function TYF_Dashboards.GetDashboard(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DashboardID: Int64;
  var aDashboard: IYFDashboardListItemModel): IYFTransportResponse;
begin
  var aURL := Format('api/dashboards/%d',[yf_DashboardID]);

  Result:= TYFTransportResponseGenerics.Execute<IYFDashboardListItemModel>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aDashboard);

end;

class function TYF_Dashboards.GetDashboardReports(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DashboardID: Int64;
  var aDashboardReports: IYFDashboardReportList): IYFTransportResponse;
begin
  var aURL := Format('api/dashboards/%d/reports',[yf_DashboardID]);

  Result:= TYFTransportResponseGenerics.Execute<IYFDashboardReportList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aDashboardReports);
end;

class function TYF_Dashboards.GetDashboardsList(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aDashboards : IYFDashboardsList;
  const FilterRequestValues : IYFFiltersRequest; const yf_MaxItem : Integer): IYFTransportResponse;
begin
  var aURL := TYFFilterHelper.BuildURL('api/dashboards/', FilterRequestValues, yf_MaxItem);

  Result:= TYFTransportResponseGenerics.Execute<IYFDashboardsList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aDashboards);
end;

end.
