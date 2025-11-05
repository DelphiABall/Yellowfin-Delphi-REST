unit yellowfinbi.api.datasources;

interface

uses REST.Types,
  yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.datasources.intf,
  yellowfinbi.api.transport.classes;

type

  TYF_Datasources = class
  public
    /// <summary>
    ///   Get a list of Datasources
    /// </summary>
    class function GetDatasources(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             var aDatasources : IYFDatasources): IYFTransportResponse;

    /// <summary>
    ///   Get a Specific Datasource based on ID (Int64)
    /// </summary>
    class function GetDatasource(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DataSourceID : Int64;
                             var aDatasource : IYFDatasource): IYFTransportResponse;

    /// <summary>
    ///   Close DataSource Connection Pool (use for Database maintenance to ensure they are closed)
    /// </summary>
    class function CloseConnectionPool(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DataSourceID : Int64): IYFTransportResponse;

    /// <summary>
    ///   Refreshes all automatic source filters, whether defined for reports or custom queries, associated with a specific data source.
    ///   Filters are used to e.g. Have Area managers see their data vs a local manager.
    /// </summary>
    class function RefreshAutomaticSourceFilters(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DataSourceID : Int64): IYFTransportResponse;

    /// <summary>
    ///   List of Client Data Sources (used for DataSource Subsitution based on the Client Org)
    /// </summary>
    class function ClientDataSources(const ServerDetails : IYFServerDetails;
                             const yf_AccessToken : string;
                             const yf_DataSourceID : Int64;
                             var aClientDataSourceList: IYFClientDataSourceList): IYFTransportResponse;

  end;

implementation

{ TYF_datasources }
uses System.JSON, System.SysUtils, yellowfinbi.api.transport.generics;

class function TYF_Datasources.ClientDataSources(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DataSourceID: Int64;
  var aClientDataSourceList: IYFClientDataSourceList): IYFTransportResponse;
begin
  var aURL := Format('api/data-sources/%d/client-data-sources',[yf_DataSourceID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFClientDataSourceList>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aClientDataSourceList);
end;

class function TYF_Datasources.CloseConnectionPool(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DataSourceID: Int64): IYFTransportResponse;
begin
  var aURL := Format('api/data-sources/%d/connection-pool',[yf_DataSourceID]);
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDelete,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil);

  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Datasources.GetDatasource(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DataSourceID: Int64;
  var aDatasource: IYFDatasource): IYFTransportResponse;
begin
  var aURL := Format('api/data-sources/%d',[yf_DataSourceID]);
  Result:= TYFTransportResponseGenerics.Execute<IYFDatasource>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aDatasource);
end;

class function TYF_Datasources.GetDatasources(const ServerDetails: IYFServerDetails;
  const yf_AccessToken : string; var aDatasources : IYFDatasources): IYFTransportResponse;
begin
  var aURL := 'api/data-sources/';
  Result:= TYFTransportResponseGenerics.Execute<IYFDatasources>
        (ServerDetails,
        yf_AccessToken,
        TRESTRequestMethod.rmGet,
        aURL,
        nil,
        aDatasources);
end;

class function TYF_Datasources.RefreshAutomaticSourceFilters(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const yf_DataSourceID: Int64): IYFTransportResponse;
begin

  var aURL := Format('api/rpc/data-sources/%d/refresh-source-filters',[yf_DataSourceID]);
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmPOST,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil);

  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

end.
