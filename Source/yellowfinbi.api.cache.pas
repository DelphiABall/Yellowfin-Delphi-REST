unit yellowfinbi.api.cache;

interface

uses yellowfinbi.api.common, yellowfinbi.api.transport, yellowfinbi.api.transport.classes,
  yellowfinbi.api.cache.intf, REST.Types;

type
  TYF_Cache = class
    class function ClearAllContentsOfaCache(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const ACacheType : TYFCacheTypes.cacheType): IYFTransportResponse;

    class function ClearSpecificContentsOfaCache(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const ACacheType : TYFCacheTypes.cacheType;
                           const AContentId : string): IYFTransportResponse;

    class function ReloadCodesInOrgCaches(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const ACodes : TArray<TYFCacheTypes.OrgCacheType>): IYFTransportResponse;


    class function RefreshesCachedFiltersForViewContent(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const AContentId : string): IYFTransportResponse; overload;

    class function RefreshesCachedFiltersForViewContent(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const AContentId : Int64): IYFTransportResponse; overload;


    class function RefreshesCachedFiltersForDashboardContent(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const AContentId : string): IYFTransportResponse; overload;

    class function RefreshesCachedFiltersForDashboardContent(const ServerDetails : IYFServerDetails;
                           const yf_AccessToken : string;
                           const AContentId : Int64): IYFTransportResponse; overload;
  end;

implementation

uses System.SysUtils;

{ TYF_Cache }

class function TYF_Cache.ClearAllContentsOfaCache(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const ACacheType: TYFCacheTypes.cacheType): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        'api/caches/'+TYFCacheTypes.ValueToString<TYFCacheTypes.cacheType>(ACacheType),
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Cache.ClearSpecificContentsOfaCache(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const ACacheType: TYFCacheTypes.cacheType;
  const AContentId: string): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmDELETE,
        ServerDetails,
        Format('api/caches/%s/%s',[TYFCacheTypes.ValueToString<TYFCacheTypes.cacheType>(ACacheType),AContentID]),
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;

end;

class function TYF_Cache.RefreshesCachedFiltersForDashboardContent(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  AContentId: string): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmGET,
        ServerDetails,
        Format('api/rpc/dashboards/%s/refresh-cached-filters',[AContentID]),
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Cache.RefreshesCachedFiltersForDashboardContent(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const AContentId: Int64): IYFTransportResponse;
begin
  TYF_Cache.RefreshesCachedFiltersForDashboardContent(ServerDetails, yf_AccessToken, AContentId.ToString);
end;

class function TYF_Cache.RefreshesCachedFiltersForViewContent(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const AContentId: Int64): IYFTransportResponse;
begin
  Result := TYF_Cache.RefreshesCachedFiltersForViewContent(ServerDetails, yf_AccessToken, AContentId.ToString);
end;

class function TYF_Cache.RefreshesCachedFiltersForViewContent(
  const ServerDetails: IYFServerDetails; const yf_AccessToken,
  AContentId: string): IYFTransportResponse;
begin
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmGET,
        ServerDetails,
        Format('api/rpc/views/%s/refresh-cached-filters',[AContentID]),
        yf_AccessToken,
        nil); // no body required
  try
    Result := Transport.Execute;
  finally
    Transport.Free;
  end;
end;

class function TYF_Cache.ReloadCodesInOrgCaches(
  const ServerDetails: IYFServerDetails; const yf_AccessToken: string;
  const ACodes: TArray<TYFCacheTypes.OrgCacheType>): IYFTransportResponse;
var
  aURL : string;
  QueryParamsSeperator : string;

  procedure AppendURL(Value : string);
  begin
    aURL := aURL + QueryParamsSeperator + Value;
    QueryParamsSeperator := '&';
  end;

begin
  aURL := 'api/rpc/caches/reload-codes';
  QueryParamsSeperator := '?';
  for var Code in ACodes do
    AppendURL('code='+TYFCacheTypes.ValueToString<TYFCacheTypes.OrgCacheType>(Code));

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

end.
