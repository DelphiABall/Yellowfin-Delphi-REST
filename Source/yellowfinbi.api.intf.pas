unit yellowfinbi.api.intf;

interface

uses
  //System.SysUtils,
  //yellowfinbi.api.json.generics,
 yellowfinbi.api.json;

type
  /// <summary>
  /// Represents API and application version information returned by the Yellowfin server.
  /// </summary>
  IYFAPIInfo = interface(IYFLoadFromJSON)
    ['{3E6AC92F-EB84-44D3-BB8A-4A5111E30C3A}']

    /// <summary>
    /// The major version of the API that is running on the target server.
    /// </summary>
    function GetApiMajorVersion: string;
    procedure SetApiMajorVersion(const Value: string);
    property ApiMajorVersion: string read GetApiMajorVersion write SetApiMajorVersion;

    /// <summary>
    /// The minor version of the API that is running on the target server.
    /// </summary>
    function GetApiMinorVersion: string;
    procedure SetApiMinorVersion(const Value: string);
    property ApiMinorVersion: string read GetApiMinorVersion write SetApiMinorVersion;

    /// <summary>
    /// The full version string of the API that is running on the target server.
    /// </summary>
    function GetApiVersion: string;
    procedure SetApiVersion(const Value: string);
    property ApiVersion: string read GetApiVersion write SetApiVersion;

    /// <summary>
    /// The major application version of the target server.
    /// </summary>
    function GetApplicationMajorVersion: string;
    procedure SetApplicationMajorVersion(const Value: string);
    property ApplicationMajorVersion: string read GetApplicationMajorVersion write SetApplicationMajorVersion;

    /// <summary>
    /// The minor application version of the target server.
    /// </summary>
    function GetApplicationMinorVersion: string;
    procedure SetApplicationMinorVersion(const Value: string);
    property ApplicationMinorVersion: string read GetApplicationMinorVersion write SetApplicationMinorVersion;

    /// <summary>
    /// The full application version of the target server.
    /// </summary>
    function GetApplicationVersion: string;
    procedure SetApplicationVersion(const Value: string);
    property ApplicationVersion: string read GetApplicationVersion write SetApplicationVersion;

    /// <summary>
    /// The version pattern string that describes the application version format.
    /// </summary>
    function GetVersionPattern: string;
    procedure SetVersionPattern(const Value: string);
    property VersionPattern: string read GetVersionPattern write SetVersionPattern;
  end;


implementation

end.
