unit yellowfinbi.api.cache.intf;

interface

uses
  //System.SysUtils, yellowfinbi.api.json,
  yellowfinbi.api.common;
  //System.JSON,
  //System.Generics.Collections,
  //yellowfinbi.api.json.generics;

type
  TYFCacheTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    cacheType = (GEO_PACK, BINARY_CLASS, VIEW_GEOMETRY, VIEW, REPORT, DASHBOARD_TAB, PERSON, TEXT_ENTITY, CATEGORY, DOCUMENT, FILTER);
    OrgCacheType = (ADDRESS, NAME, PARAMETER, REFCODE, ROLEFN, ORGRELATIONSHIPS);
    {$SCOPEDENUMS OFF}
  end;

implementation

end.
