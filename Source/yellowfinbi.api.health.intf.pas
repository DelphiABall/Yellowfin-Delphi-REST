unit yellowfinbi.api.health.intf;

interface

uses System.Generics.Collections,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics,
  yellowfinbi.api.common;

type
  TYFNodeInfoTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    cacheType = ( viewCache,
                  reportDefinitionCache,
                  dashboardDefinitionCache,
                  personCache,
                  groupCache,
                  documentCache,
                  reportDataCache,
                  cachedFilterCache,
                  cachedFilterQueryCache,
                  cachedFilterMetadataCache,
                  textEntityCache,
                  geometryCache,
                  thumbnailCache,
                  olapMemberCache,
                  restUserCache
                  );
    {$SCOPEDENUMS OFF}

  end;


  IYFNodeCacheInfo = interface(IYFLoadFromJSON)
    ['{C8D9376B-180A-44D9-BFC8-D8318E10327C}']
    function GetCacheCurrentSize: Int64;
    function GetCacheMaxSize: Int64;
    function GetCacheType : TYFNodeInfoTypes.cacheType;
    procedure SetCacheType(Value : TYFNodeInfoTypes.cacheType);

    /// <summary>
    /// The type of Cache referenced
    /// </summary>
    property CacheType : TYFNodeInfoTypes.cacheType read GetCacheType write SetCacheType;

    /// <summary>
    /// A long value representing the current cache size in bytes.
    /// </summary>
    property CacheCurrentSize: Int64 read GetCacheCurrentSize;

    /// <summary>
    /// A long value representing the maximum cache size in bytes.
    /// </summary>
    property CacheMaxSize: Int64 read GetCacheMaxSize;
  end;

  IYFNodeCacheInfoList = interface(IYFModelList<IYFNodeCacheInfo>)
    ['{EAC58CB5-286F-422B-8EC2-B2F0BEC18F2C}']
  end;


  /// <summary>
  /// Provides connectivity information for the Yellowfin Configuration Database.
  /// </summary>
  IYFConfigDBInfo = interface(IYFLoadFromJSON)
    ['{C1F5631E-5A48-4DB3-9D88-9F8E843907CB}']

    function GetStatus: string;
    function GetMaxConnections: Integer;
    function GetMinConnections: Integer;
    function GetOpenConnections: Integer;
    function GetActiveConnections: Integer;

    /// <summary>
    /// The status of the configuration database, indicating its operational state.
    /// </summary>
    property Status: string read GetStatus;

    /// <summary>
    /// The maximum number of connections allowed to the configuration database.
    /// </summary>
    property MaxConnections: Integer read GetMaxConnections;

    /// <summary>
    /// The minimum number of connections maintained with the configuration database.
    /// </summary>
    property MinConnections: Integer read GetMinConnections;

    /// <summary>
    /// The current number of open connections to the configuration database.
    /// </summary>
    property OpenConnections: Integer read GetOpenConnections;

    /// <summary>
    /// The current number of active (in-use) connections to the configuration database.
    /// </summary>
    property ActiveConnections: Integer read GetActiveConnections;

  end;

  IYFNodeInfo = interface(IYFLoadFromJSON)
    ['{B0B7172E-4476-47F4-80CF-8F063F52F755}']

    function GetHostName: string;
    function GetApplicationVersion: string;
    function GetStatusCode: string;
    function GetAvailableProcessors: Integer;
    function GetJVMMemoryInUse: Int64;
    function GetJVMTotalMemory: Int64;
    function GetJVMFreeMemory: Int64;
    function GetSystemMemory: Int64;
    function GetJVMMaxMemory: Int64;
    function GetWebSessions: Integer;
    function GetCaches : IYFNodeCacheInfoList;
    function GetConfigDBInfo : IYFConfigDBInfo;


    /// <summary>
    /// The hostname of the node, used to identify it within the deployment.
    /// </summary>
    property HostName: string read GetHostName;

    /// <summary>
    /// The version of the Yellowfin application running on the node.
    /// </summary>
    property ApplicationVersion: string read GetApplicationVersion;

    /// <summary>
    /// The status code representing the operational state of the node.
    /// </summary>
    property StatusCode: string read GetStatusCode;

    /// <summary>
    /// The number of processors available on the node for processing tasks.
    /// </summary>
    property AvailableProcessors: Integer read GetAvailableProcessors;

    /// <summary>
    /// The amount of JVM memory currently in use, in bytes.
    /// </summary>
    property JVMMemoryInUse: Int64 read GetJVMMemoryInUse;

    /// <summary>
    /// The total memory allocated to the JVM, in bytes.
    /// </summary>
    property JVMTotalMemory: Int64 read GetJVMTotalMemory;

    /// <summary>
    /// The amount of free memory available within the JVM, in bytes.
    /// </summary>
    property JVMFreeMemory: Int64 read GetJVMFreeMemory;

    /// <summary>
    /// The maximum memory the JVM can use, in bytes.
    /// </summary>
    property JVMMaxMemory: Int64 read GetJVMMaxMemory;

    /// <summary>
    /// The total system memory available on the node, in bytes.
    /// </summary>
    property SystemMemory: Int64 read GetSystemMemory;

    /// <summary>
    /// The number of active web sessions currently connected to the node.
    /// </summary>
    property WebSessions: Integer read GetWebSessions;

    /// <summary>
    /// List of Caches in the node
    /// </summary>
    property Caches : IYFNodeCacheInfoList read GetCaches;

    /// <summary>
    /// Configuration Database Information for Yellowfin
    /// </summary>
    property ConfigDBInfo : IYFConfigDBInfo read GetConfigDBInfo;
  end;

  IYFNodeInfoList = interface(IYFModelList<IYFNodeInfo>)
    ['{3B3AC261-4122-4441-A23E-CA0DEE979981}']
  end;


  IYFHealth = interface(IYFLoadFromJSON)
    ['{A141F871-AE2F-4E00-AE20-52FE788FF0D8}']

    function GetNodes : IYFNodeInfoList;
    function GetStatus : string;

    property Nodes : IYFNodeInfoList read GetNodes;
    property Status : string read GetStatus;
  end;

implementation

end.
