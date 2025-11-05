unit yellowfinbi.api.dashboards.intf;

interface

uses System.Generics.Collections,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics,
  yellowfinbi.api.reports.intf, yellowfinbi.api.common;

type
  TYFDashboardTypes = class(TYFTypes)
  type
    DefaultDisplay = (CANVAS, CHART, REPORT);
  end;

  IYFDashboardListItemModel = interface(IYFLoadFromJSON)
    ['{77D7153C-E7B9-4FE9-B785-FE83420D2779}']
    /// <summary>The internal numeric ID of the dashboard.</summary>
    function GetDashboardId: Int64;
    /// <summary>The UUID used to uniquely identify the published dashboard.</summary>
    function GetDashboardPublishUUID: string;
    /// <summary>The display name of the dashboard.</summary>
    function GetName: string;
    /// <summary>A short description of the dashboard purpose or content.</summary>
    function GetDescription: string;
    /// <summary>The category code under which the dashboard is grouped.</summary>
    function GetCategoryCode: string;
    /// <summary>The display name of the dashboard category.</summary>
    function GetCategoryName: string;
    /// <summary>The subcategory code of the dashboard, if applicable.</summary>
    function GetSubCategoryCode: string;
    /// <summary>The subcategory display name.</summary>
    function GetSubCategoryName: string;
    /// <summary>The current status of the dashboard (e.g., OPEN, DRAFT).</summary>
    function GetStatusCode: string;
    /// <summary>The timestamp (as TDateTime) of the last modification.</summary>
    function GetLastModifiedDateTime: TDateTime;
    /// <summary>The formatted last modified date as returned by Yellowfin.</summary>
    function GetFormattedLastModifiedDateTime: string;
    /// <summary>The timestamp (as TDateTime) when the dashboard was first published.</summary>
    function GetPublishedDateTime: TDateTime;
    /// <summary>The formatted published date as returned by Yellowfin.</summary>
    function GetFormattedPublishedDateTime: string;
    /// <summary>The internal ID of the dashboard creator.</summary>
    function GetCreatorId: Int64;
    /// <summary>The name of the dashboard creator.</summary>
    function GetCreatorName: string;
    /// <summary>The internal ID of the last user who modified the dashboard.</summary>
    function GetLastModifierId: Int64;
    /// <summary>The name of the last user who modified the dashboard.</summary>
    function GetLastModifierName: string;
    /// <summary>Indicates whether the current user has marked this dashboard as a favourite.</summary>
    function GetIsFavouritedByUser: Boolean;
    /// <summary>The sequence number used to order favourites.</summary>
    function GetFavouriteSequenceNumber: Int64;

    // Properties
    property DashboardId: Int64 read GetDashboardId;
    property DashboardPublishUUID: string read GetDashboardPublishUUID;
    property Name: string read GetName;
    property Description: string read GetDescription;
    property CategoryCode: string read GetCategoryCode;
    property CategoryName: string read GetCategoryName;
    property SubCategoryCode: string read GetSubCategoryCode;
    property SubCategoryName: string read GetSubCategoryName;
    property StatusCode: string read GetStatusCode;
    property LastModifiedDateTime: TDateTime read GetLastModifiedDateTime;
    property FormattedLastModifiedDateTime: string read GetFormattedLastModifiedDateTime;
    property PublishedDateTime: TDateTime read GetPublishedDateTime;
    property FormattedPublishedDateTime: string read GetFormattedPublishedDateTime;
    property CreatorId: Int64 read GetCreatorId;
    property CreatorName: string read GetCreatorName;
    property LastModifierId: Int64 read GetLastModifierId;
    property LastModifierName: string read GetLastModifierName;
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser;
    property FavouriteSequenceNumber: Int64 read GetFavouriteSequenceNumber;
  end;

  IYFDashboardsList = interface(IYFModelList<IYFDashboardListItemModel>)
    ['{4AF7A427-8959-4BF1-BFD5-77875623EF26}']
  end;

  IYFDashboardReportModel = interface(IYFReportListItemModel)
    ['{E008CED7-CF79-43C0-B663-D9419EF84CCD}']
    function GetTabID : Int64;
    function GetEntityUUID: string;
    function GetDefaultDisplay: TYFDashboardTypes.DefaultDisplay;

    property tabId: Int64 read GetTabID;
    property entityUUID: string read GetEntityUUID;
    property defaultDisplay: TYFDashboardTypes.DefaultDisplay read GetDefaultDisplay;
  end;

  IYFDashboardReportList = interface(IYFModelList<IYFDashboardReportModel>)
    ['{4AF7A427-8959-4BF1-BFD5-77875623EF26}']
  end;


implementation

end.
