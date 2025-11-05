unit yellowfinbi.api.datasources.intf;

interface

uses
  System.SysUtils,
  yellowfinbi.api.json,
  yellowfinbi.api.json.generics,
  yellowfinbi.api.common;

type
  // ===============================
  // DataSource Types
  // ===============================
  TYFDataSourceTypes = class(TYFTypes)
  public
    type
      /// <summary>
      /// The permissions/access level for this data source. 
      /// UNSECURE - Allow all users with required role permissions.
      /// ACCESSLEVEL - Allow only specified users with required role permissions.
      /// </summary>
      TAccessLevelCode = (UNSECURE, ACCESSLEVEL);
  end;

  // ===============================
  // DataSource Option
  // ===============================
  IYFDataSourceOption = interface(IYFLoadFromJSON)
    ['{A6A3D842-9D8E-4F59-89F5-21E9AA383123}']
    
    function GetOptionKey: string;
    procedure SetOptionKey(const Value: string);

    function GetOptionValue: string;
    procedure SetOptionValue(const Value: string);

    function GetValueDataType: string;
    procedure SetValueDataType(const Value: string);
        
    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property OptionKey: string read GetOptionKey write SetOptionKey;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property OptionValue: string read GetOptionValue write SetOptionValue;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property ValueDataType: string read GetValueDataType write SetValueDataType;    
  end;

  IYFDataSourceOptionsList = interface(IYFModelList<IYFDataSourceOption>)
    ['{EFB47B0C-7C73-46C9-9944-63C59E4A62C5}']
  end;

  // ===============================
  // DataSource
  // ===============================
  IYFDataSource = interface(IYFLoadFromJSON)
    ['{5FEC7A9B-C71B-4C15-8D37-7F3F71C5AB42}']
    // ================== Getters/Setters ==================
    function GetSourceID: Int64;
    procedure SetSourceID(const Value: Int64);

    function GetSourceName: string;
    procedure SetSourceName(const Value: string);

    function GetSourceDescription: string;
    procedure SetSourceDescription(const Value: string);

    function GetSourceType: string;
    procedure SetSourceType(const Value: string);

    function GetConnectionType: string;
    procedure SetConnectionType(const Value: string);

    function GetConnectionTypeCode: string;
    procedure SetConnectionTypeCode(const Value: string);

    function GetConnectionDriver: string;
    procedure SetConnectionDriver(const Value: string);

    function GetConnectionPath: string;
    procedure SetConnectionPath(const Value: string);

    function GetConnectionString: string;
    procedure SetConnectionString(const Value: string);

    function GetConnectionTimeout: Int64;
    procedure SetConnectionTimeout(const Value: Int64);

    function GetUserName: string;
    procedure SetUserName(const Value: string);

    function GetUserPassword: string;
    procedure SetUserPassword(const Value: string);

    function GetMinimumConnections: Int64;
    procedure SetMinimumConnections(const Value: Int64);

    function GetMaximumConnections: Int64;
    procedure SetMaximumConnections(const Value: Int64);

    function GetRefreshTime: Int64;
    procedure SetRefreshTime(const Value: Int64);

    function GetTimezone: string;
    procedure SetTimezone(const Value: string);

    function GetLogFile: string;
    procedure SetLogFile(const Value: string);

    function GetAccessLevelCode: TYFDataSourceTypes.TAccessLevelCode;
    procedure SetAccessLevelCode(const Value: TYFDataSourceTypes.TAccessLevelCode);

    function GetMaxRows: Int64;
    procedure SetMaxRows(const Value: Int64);

    function GetMaxAnalysisRows: Int64;
    procedure SetMaxAnalysisRows(const Value: Int64);

    function GetInheritChildSourceFilters: Boolean;
    procedure SetInheritChildSourceFilters(const Value: Boolean);

    function GetPlatformTypeCode: string;
    procedure SetPlatformTypeCode(const Value: string);

    function GetSourceLogIndicator: Boolean;
    procedure SetSourceLogIndicator(const Value: Boolean);

    function GetSourceOptions: IYFDataSourceOptionsList;
    procedure SetSourceOptions(const Value: IYFDataSourceOptionsList);

    /// <summary>
    /// Yellowfin Internall ID for the database source.
    /// </summary>
    property SourceID: Int64 read GetSourceID write SetSourceID;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property SourceName: string read GetSourceName write SetSourceName;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property SourceDescription: string read GetSourceDescription write SetSourceDescription;

    /// <summary>
    /// Database type being connected to (e.g., MySQL, Oracle).
    /// </summary>
    property SourceType: string read GetSourceType write SetSourceType;

    /// <summary>
    /// Type of connection driver being used (e.g., JDBC).
    /// </summary>
    property ConnectionType: string read GetConnectionType write SetConnectionType;

    /// <summary>
    /// Connection authentication method (e.g., GENERICUSER).
    /// </summary>
    property ConnectionTypeCode: string read GetConnectionTypeCode write SetConnectionTypeCode;

    /// <summary>
    /// The connection driver being used. Must be a supported driver.
    /// </summary>
    property ConnectionDriver: string read GetConnectionDriver write SetConnectionDriver;

    /// <summary>
    /// The schema name or equivalent concept (e.g., OLAP catalog).
    /// </summary>
    property ConnectionPath: string read GetConnectionPath write SetConnectionPath;

    /// <summary>
    /// Database URL for this connection. Usually generated internally.
    /// </summary>
    property ConnectionString: string read GetConnectionString write SetConnectionString;

    /// <summary>
    /// Timeout in seconds for application connections to this source.
    /// </summary>
    property ConnectionTimeout: Int64 read GetConnectionTimeout write SetConnectionTimeout;

    /// <summary>
    /// Username credential for connecting to this source.
    /// </summary>
    property UserName: string read GetUserName write SetUserName;

    /// <summary>
    /// Password credential for connecting to this source (encrypted on save).
    /// </summary>
    property UserPassword: string read GetUserPassword write SetUserPassword;

    /// <summary>
    /// Minimum number of connections in the pool.
    /// </summary>
    property MinimumConnections: Int64 read GetMinimumConnections write SetMinimumConnections;

    /// <summary>
    /// Maximum number of connections in the pool. Must be = minimum.
    /// </summary>
    property MaximumConnections: Int64 read GetMaximumConnections write SetMaximumConnections;

    /// <summary>
    /// Time in hours between refreshing connections in the pool.
    /// </summary>
    property RefreshTime: Int64 read GetRefreshTime write SetRefreshTime;

    /// <summary>
    /// Timezone for this data source, used as a default for related settings.
    /// </summary>
    property Timezone: string read GetTimezone write SetTimezone;

    /// <summary>
    /// Log file path. A String with a maximum size of 255 characters.
    /// </summary>
    property LogFile: string read GetLogFile write SetLogFile;

    /// <summary>
    /// Permissions/access level (UNSECURE or ACCESSLEVEL). Defaults to UNSECURE.
    /// </summary>
    property AccessLevelCode: TYFDataSourceTypes.TAccessLevelCode read GetAccessLevelCode write SetAccessLevelCode;

    /// <summary>
    /// Default maximum rows fetched from this data source.
    /// </summary>
    property MaxRows: Int64 read GetMaxRows write SetMaxRows;

    /// <summary>
    /// Default maximum rows fetched for analysis purposes.
    /// </summary>
    property MaxAnalysisRows: Int64 read GetMaxAnalysisRows write SetMaxAnalysisRows;

    /// <summary>
    /// Controls whether child source filters are inherited.
    /// </summary>
    property InheritChildSourceFilters: Boolean read GetInheritChildSourceFilters write SetInheritChildSourceFilters;

    /// <summary>
    /// Writable status. "TARGET" = system can write to this database.
    /// </summary>
    property PlatformTypeCode: string read GetPlatformTypeCode write SetPlatformTypeCode;

    /// <summary>
    /// Indicates if this writable connection is used for CSV imports by default.
    /// </summary>
    property SourceLogIndicator: Boolean read GetSourceLogIndicator write SetSourceLogIndicator;

    /// <summary>
    /// List of data source options.
    /// </summary>
    property SourceOptions: IYFDataSourceOptionsList read GetSourceOptions write SetSourceOptions;    
  end;

  IYFDataSources = interface(IYFModelList<IYFDataSource>)
    ['{EFB47B0C-7C73-46C9-9944-63C59E4A62C5}']
  end;

  IYFClientDataSource = interface(IYFLoadFromJSON)
    function GetClientOrgId : Int64;
    procedure SetClientOrgId(const Value : Int64);

    function GetClientOrgRef : string;
    procedure SetClientOrgRef(const Value : string);

    function GetClientOrgName : string;
    procedure SetClientOrgName(const Value : string);

    function GetSourceId : Int64;
    procedure SetSourceId(const Value : Int64);

    function GetSourceName : string;
    procedure SetSourceName(const Value : string);

    /// <summary>
    /// An integer id referring to a client org
    /// </summary>
    property ClientOrgId : Int64 read GetClientOrgId write SetClientOrgId;

    /// <summary>
    /// Client Org Reference
    /// </summary>
    property ClientOrgRef : string read GetClientOrgRef write SetClientOrgRef;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property ClientOrgName : string read GetClientOrgName write SetClientOrgName;

    /// <summary>
    /// An integer id that references a data source
    /// </summary>
    property SourceId : Int64 read GetSourceId write SetSourceId;

    /// <summary>
    /// A String with a maximum size of 255 characters. May be empty.
    /// </summary>
    property SourceName : string read GetSourceName write SetSourceName;
  end;

  IYFClientDataSourceList = interface(IYFModelList<IYFClientDataSource>)
    ['{E6D0609E-EA4C-4257-BF60-15EBA1EBF696}']
  end;

implementation

end.

