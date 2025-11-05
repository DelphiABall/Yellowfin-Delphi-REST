unit yellowfinbi.api.presentations.intf;

interface

uses System.Generics.Collections,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics,
  yellowfinbi.api.common;

type

  TYFPresentationTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    defaultDisplay = (CANVAS, CHART, REPORT);
    accessTypeCode = (PERSONAL, CORPORATE);
    {$SCOPEDENUMS OFF}
  end;

  /// <summary>
  /// Interface representing a Yellowfin Presentation List Item Model.
  /// </summary>
  IYFPresentationListItemModel = interface(IYFLoadFromJSON)
    ['{1A5F6A2C-4AF9-4C2C-9E4F-6B7326F9A7D1}']

    /// <summary>
    /// The internal Yellowfin ID of this presentation.
    /// </summary>
    function GetPresentationId: Int64;
    procedure SetPresentationId(const Value: Int64);
    property PresentationId: Int64 read GetPresentationId write SetPresentationId;

    /// <summary>
    /// The UUID of this presentation.
    /// </summary>
    function GetPresentationPublishUUID: string;
    procedure SetPresentationPublishUUID(const Value: string);
    property PresentationPublishUUID: string read GetPresentationPublishUUID write SetPresentationPublishUUID;

    /// <summary>
    /// The internal Yellowfin ID of the theme used for this presentation.
    /// </summary>
    function GetThemeId: Int64;
    procedure SetThemeId(const Value: Int64);
    property ThemeId: Int64 read GetThemeId write SetThemeId;

    /// <summary>
    /// The name of this presentation (translated if applicable).
    /// </summary>
    function GetName: string;
    procedure SetName(const Value: string);
    property Name: string read GetName write SetName;

    /// <summary>
    /// The description of this presentation (translated if applicable).
    /// </summary>
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    property Description: string read GetDescription write SetDescription;

    /// <summary>
    /// The code for the parent category (i.e. content folder).
    /// Unique string with uppercase letters and numbers.
    /// </summary>
    function GetCategoryCode: string;
    procedure SetCategoryCode(const Value: string);
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;

    /// <summary>
    /// The display name for the parent category (translated if applicable).
    /// </summary>
    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);
    property CategoryName: string read GetCategoryName write SetCategoryName;

    /// <summary>
    /// The code for the subcategory (i.e. content folder).
    /// Unique string with uppercase letters and numbers.
    /// </summary>
    function GetSubCategoryCode: string;
    procedure SetSubCategoryCode(const Value: string);
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;

    /// <summary>
    /// The display name for the subcategory (translated if applicable).
    /// </summary>
    function GetSubCategoryName: string;
    procedure SetSubCategoryName(const Value: string);
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;

    /// <summary>
    /// The current status of this presentation.
    /// Possible values: "OPEN", "DRAFT", "ARCHIVED", "PENDING", "DELETED".
    /// </summary>
    function GetStatusCode: TYFPresentationTypes.statusCode;
    procedure SetStatusCode(const Value: TYFPresentationTypes.statusCode);
    property StatusCode: TYFPresentationTypes.statusCode read GetStatusCode write SetStatusCode;

    /// <summary>
    /// GMT datetime of last modification, format YYYYMMDDHHmmss.
    /// </summary>
    function GetLastModifiedDateTime: TDateTime;
    procedure SetLastModifiedDateTime(const Value: TDateTime);
    property LastModifiedDateTime: TDateTime read GetLastModifiedDateTime write SetLastModifiedDateTime;

    /// <summary>
    /// Formatted string of last modification datetime (user's preferred format).
    /// </summary>
    function GetFormattedLastModifiedDateTime: string;
    procedure SetFormattedLastModifiedDateTime(const Value: string);
    property FormattedLastModifiedDateTime: string read GetFormattedLastModifiedDateTime write SetFormattedLastModifiedDateTime;

    /// <summary>
    /// GMT datetime of publication, format YYYYMMDDHHmmss converted to TDateTIme.
    /// </summary>
    function GetPublishedDateTime: TDateTime;
    procedure SetPublishedDateTime(const Value: TDateTime);
    property PublishedDateTime: TDateTime read GetPublishedDateTime write SetPublishedDateTime;

    /// <summary>
    /// Formatted string of publication datetime (user's preferred format).
    /// </summary>
    function GetFormattedPublishedDateTime: string;
    procedure SetFormattedPublishedDateTime(const Value: string);
    property FormattedPublishedDateTime: string read GetFormattedPublishedDateTime write SetFormattedPublishedDateTime;

    /// <summary>
    /// The internal Yellowfin ID of the user who created this presentation.
    /// </summary>
    function GetCreatorId: Int64;
    procedure SetCreatorId(const Value: Int64);
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;

    /// <summary>
    /// The name of the user who created this presentation.
    /// </summary>
    function GetCreatorName: string;
    procedure SetCreatorName(const Value: string);
    property CreatorName: string read GetCreatorName write SetCreatorName;

    /// <summary>
    /// The internal Yellowfin ID of the user who last modified this presentation.
    /// </summary>
    function GetLastModifierId: Int64;
    procedure SetLastModifierId(const Value: Int64);
    property LastModifierId: Int64 read GetLastModifierId write SetLastModifierId;

    /// <summary>
    /// The name of the user who last modified this presentation.
    /// </summary>
    function GetLastModifierName: string;
    procedure SetLastModifierName(const Value: string);
    property LastModifierName: string read GetLastModifierName write SetLastModifierName;

    /// <summary>
    /// Indicates whether the currently logged-in user has favourited this presentation.
    /// </summary>
    function GetIsFavouritedByUser: Boolean;
    procedure SetIsFavouritedByUser(const Value: Boolean);
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
  end;


  IYFPresentationsList = interface(IYFModelList<IYFPresentationListItemModel>)
    ['{351C9629-CBFF-460E-A5BF-A991981705B8}']
  end;

  /// <summary>
  /// Interface representing a Yellowfin Report on a Presentation Slide.
  /// </summary>
  IYFPresentationReportModel = interface(IYFLoadFromJSON)
  ['{B7F1D4C9-2F3A-4A58-B7F8-2E7F1C6EFA12}']

    function GetSlideId: Int64;
    procedure SetSlideId(const Value: Int64);
    /// <summary>
    /// The internal Yellowfin ID of the slide that the report appears on.
    /// </summary>
    property SlideId: Int64 read GetSlideId write SetSlideId;

    function GetDefaultDisplay: TYFPresentationTypes.defaultDisplay;
    procedure SetDefaultDisplay(const Value: TYFPresentationTypes.defaultDisplay);
    /// <summary>
    /// How the report is displayed on the slide: "CANVAS", "CHART", or "REPORT".
    /// </summary>
    property DefaultDisplay: TYFPresentationTypes.defaultDisplay read GetDefaultDisplay write SetDefaultDisplay;

    function GetEntityUUID: string;
    procedure SetEntityUUID(const Value: string);
    /// <summary>
    /// The UUID of the slide entity (widget) containing the report.
    /// </summary>
    property EntityUUID: string read GetEntityUUID write SetEntityUUID;

    function GetReportId: Int64;
    procedure SetReportId(const Value: Int64);
    /// <summary>
    /// The internal Yellowfin ID of this report.
    /// </summary>
    property ReportId: Int64 read GetReportId write SetReportId;

    function GetReportPublishUUID: string;
    procedure SetReportPublishUUID(const Value: string);
    /// <summary>
    /// The UUID of this report.
    /// </summary>
    property ReportPublishUUID: string read GetReportPublishUUID write SetReportPublishUUID;

    function GetName: string;
    procedure SetName(const Value: string);
    /// <summary>
    /// The name of this report (translated if applicable).
    /// </summary>
    property Name: string read GetName write SetName;

    function GetDescription: string;
    procedure SetDescription(const Value: string);
    /// <summary>
    /// The description of this report (translated if applicable).
    /// </summary>
    property Description: string read GetDescription write SetDescription;

    function GetCategoryCode: string;
    procedure SetCategoryCode(const Value: string);
    /// <summary>
    /// The code for the parent category (content folder), unique string with uppercase letters and numbers.
    /// </summary>
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;

    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);
    /// <summary>
    /// The display name for the parent category (translated if applicable).
    /// </summary>
    property CategoryName: string read GetCategoryName write SetCategoryName;

    function GetSubCategoryCode: string;
    procedure SetSubCategoryCode(const Value: string);
    /// <summary>
    /// The code for the subcategory (content folder), unique string with uppercase letters and numbers.
    /// </summary>
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;

    function GetSubCategoryName: string;
    procedure SetSubCategoryName(const Value: string);
    /// <summary>
    /// The display name for the subcategory (translated if applicable).
    /// </summary>
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;

    function GetStatusCode: TYFPresentationTypes.statusCode;
    procedure SetStatusCode(const Value: TYFPresentationTypes.statusCode);
    /// <summary>
    /// The current status of this report.
    /// Possible values: "OPEN", "DRAFT", "ARCHIVED", "PENDING", "DELETED".
    /// </summary>
    property StatusCode: TYFPresentationTypes.statusCode read GetStatusCode write SetStatusCode;

    function GetViewId: Int64;
    procedure SetViewId(const Value: Int64);
    /// <summary>
    /// The internal Yellowfin ID of the view this report is based upon.
    /// </summary>
    property ViewId: Int64 read GetViewId write SetViewId;

    function GetViewName: string;
    procedure SetViewName(const Value: string);
    /// <summary>
    /// The name of the view this report is based upon (translated if applicable).
    /// </summary>
    property ViewName: string read GetViewName write SetViewName;

    function GetSourceId: Int64;
    procedure SetSourceId(const Value: Int64);
    /// <summary>
    /// The internal Yellowfin ID of the data source this report is based upon.
    /// </summary>
    property SourceId: Int64 read GetSourceId write SetSourceId;

    function GetSourceName: string;
    procedure SetSourceName(const Value: string);
    /// <summary>
    /// The name of the data source this report is based upon (translated if applicable).
    /// </summary>
    property SourceName: string read GetSourceName write SetSourceName;

    function GetAccessTypeCode: TYFPresentationTypes.accessTypeCode;
    procedure SetAccessTypeCode(const Value: TYFPresentationTypes.accessTypeCode);
    /// <summary>
    /// Access level of the report: "PERSONAL" or "CORPORATE".
    /// </summary>
    property AccessTypeCode: TYFPresentationTypes.accessTypeCode read GetAccessTypeCode write SetAccessTypeCode;

    /// <summary>
    /// GMT date/time of publication, format YYYYMMDDHHmmss.
    /// </summary>
    function GetPublishedDate: TDateTime;
    procedure SetPublishedDate(const Value: TDateTime);
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;

    /// <summary>
    /// Formatted string of publication date (user's preferred format).
    /// </summary>
    function GetFormattedPublishDate: string;
    procedure SetFormattedPublishDate(const Value: string);
    property FormattedPublishDate: string read GetFormattedPublishDate write SetFormattedPublishDate;

    /// <summary>
    /// GMT date/time of last update, format YYYYMMDDHHmmss.
    /// </summary>
    function GetUpdatedDate: TDateTime;
    procedure SetUpdatedDate(const Value: TDateTime);
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;

    /// <summary>
    /// Formatted string of last update date (user's preferred format).
    /// </summary>
    function GetFormattedUpdatedDate: string;
    procedure SetFormattedUpdatedDate(const Value: string);
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;

    /// <summary>
    /// The internal Yellowfin ID of the user who created this report.
    /// </summary>
    function GetCreatorId: Int64;
    procedure SetCreatorId(const Value: Int64);
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;

    /// <summary>
    /// The name of the user who created this report.
    /// </summary>
    function GetCreatorName: string;
    procedure SetCreatorName(const Value: string);
    property CreatorName: string read GetCreatorName write SetCreatorName;

    /// <summary>
    /// The internal Yellowfin ID of the user who last updated this report.
    /// </summary>
    function GetLastUpdaterId: Int64;
    procedure SetLastUpdaterId(const Value: Int64);
    property LastUpdaterId: Int64 read GetLastUpdaterId write SetLastUpdaterId;

    /// <summary>
    /// The name of the user who last updated this report.
    /// </summary>
    function GetLastUpdaterName: string;
    procedure SetLastUpdaterName(const Value: string);
    property LastUpdaterName: string read GetLastUpdaterName write SetLastUpdaterName;

    /// <summary>
    /// Indicates whether the currently logged-in user has favourited this report.
    /// </summary>
    function GetIsFavouritedByUser: Boolean;
    procedure SetIsFavouritedByUser(const Value: Boolean);
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;

    /// <summary>
    /// The number of comments made on this report.
    /// </summary>
    function GetCommentCount: Int64;
    procedure SetCommentCount(const Value: Int64);
    property CommentCount: Int64 read GetCommentCount write SetCommentCount;
  end;


  IYFPresentationReportList = interface(IYFModelList<IYFPresentationReportModel>)
    ['{351C9629-CBFF-460E-A5BF-A991981705B8}']
  end;


implementation

end.
