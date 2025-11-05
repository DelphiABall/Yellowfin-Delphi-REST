unit yellowfinbi.api.reports.intf;

interface

uses
  System.SysUtils, yellowfinbi.api.json,  yellowfinbi.api.common, System.JSON,
  System.Generics.Collections, yellowfinbi.api.json.generics;

type
  TYFReportTypes = class(TYFTypes)
  end;

  IYFReportListItemModel = interface(IYFLoadFromJSON)
    ['{EFC5A5F6-758A-45C4-B7E2-26A8F8B93589}']
    function GetReportId: Int64;
    function GetReportPublishUUID: string;
    function GetName: string;
    function GetDescription: string;
    function GetCategoryCode: string;
    function GetCategoryName: string;
    function GetSubCategoryCode: string;
    function GetSubCategoryName: string;
    function GetStatusCode: TYFReportTypes.statusCode;
    function GetViewId: Int64;
    function GetViewName: string;
    function GetSourceId: Int64;
    function GetSourceName: string;
    function GetAccessTypeCode: string;
    function GetUpdatedDate: TDateTime;
    function GetFormattedUpdatedDate: string;
    function GetPublishedDate: TDateTime;
    function GetFormattedPublishedDate: string;
    function GetCreatorId: Int64;
    function GetCreatorName: string;
    function GetLastUpdaterId: Int64;
    function GetLastUpdaterName: string;
    function GetIsFavouritedByUser: Boolean;
    function GetCommentCount: Int64;


    procedure SetReportId(const Value: Int64);
    procedure SetReportPublishUUID(const Value: string);
    procedure SetName(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetCategoryCode(const Value: string);
    procedure SetCategoryName(const Value: string);
    procedure SetSubCategoryCode(const Value: string);
    procedure SetSubCategoryName(const Value: string);
    procedure SetStatusCode(const Value: TYFReportTypes.statusCode);
    procedure SetViewId(const Value: Int64);
    procedure SetViewName(const Value: string);
    procedure SetSourceId(const Value: Int64);
    procedure SetSourceName(const Value: string);
    procedure SetAccessTypeCode(const Value: string);
    procedure SetUpdatedDate(const Value: TDateTime);
    procedure SetFormattedUpdatedDate(const Value: string);
    procedure SetPublishedDate(const Value: TDateTime);
    procedure SetFormattedPublishedDate(const Value: string);
    procedure SetCreatorId(const Value: Int64);
    procedure SetCreatorName(const Value: string);
    procedure SetLastUpdaterId(const Value: Int64);
    procedure SetLastUpdaterName(const Value: string);
    procedure SetCommentCount(const Value: Int64);
    procedure SetIsFavouritedByUser(const Value: Boolean);


    property ReportId: Int64 read GetReportId write SetReportId;
    property ReportPublishUUID: string read GetReportPublishUUID write SetReportPublishUUID;
    property Name: string read GetName write SetName;
    property Description: string read GetDescription write SetDescription;
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;
    property CategoryName: string read GetCategoryName write SetCategoryName;
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;
    property StatusCode: TYFReportTypes.statusCode read GetStatusCode write SetStatusCode;
    property ViewId: Int64 read GetViewId write SetViewId;
    property ViewName: string read GetViewName write SetViewName;
    property SourceId: Int64 read GetSourceId write SetSourceId;
    property SourceName: string read GetSourceName write SetSourceName;
    property AccessTypeCode: string read GetAccessTypeCode write SetAccessTypeCode;
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;
    property FormattedPublishedDate: string read GetFormattedPublishedDate write SetFormattedPublishedDate;
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;
    property CreatorName: string read GetCreatorName write SetCreatorName;
    property LastUpdaterId: Int64 read GetLastUpdaterId write SetLastUpdaterId;
    property LastUpdaterName: string read GetLastUpdaterName write SetLastUpdaterName;
    property IsFavouritedByUser : Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
    property CommentCount: Int64 read GetCommentCount write SetCommentCount;
  end;

  IYFReportListItems = interface(IYFModelList<IYFReportListItemModel>)
  end;


implementation

end.
