unit yellowfinbi.api.content.intf;

interface

uses System.Generics.Collections, yellowfinbi.api.common,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics;

type

  TYFContentTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    contentType = (DASHBOARD, DISCUSSIONGROUP, ETLPROCESS, PRESENT, REPORT, STORY, STORYBOARD, THEME, VIEW);
    {$SCOPEDENUMS OFF}
  end;

  /// <Summary>
  /// IYFContent implements the Yellowfin ContentListItemModel
  /// </Summary>
  IYFContent = interface(IYFLoadFromJSON)
    ['{26D9AE67-62C5-4A55-B6F6-7A9A9F4F1880}']

    function GetContentId: Int64;
    procedure SetContentId(const Value: Int64);

    function GetContentUUID: string;
    procedure SetContentUUID(const Value: string);

    function GetPublishUUID: string;
    procedure SetPublishUUID(const Value: string);

    function GetTitle: string;
    procedure SetTitle(const Value: string);

    function GetDescription: string;
    procedure SetDescription(const Value: string);

    function GetContentTypeDescription: string;
    procedure SetContentTypeDescription(const Value: string);

    function GetContentType: TYFContentTypes.contentType;
    procedure SetContentType(const Value: TYFContentTypes.contentType);

    function GetCategoryCode: string;
    procedure SetCategoryCode(const Value: string);

    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);

    function GetSubCategoryCode: string;
    procedure SetSubCategoryCode(const Value: string);

    function GetSubCategoryName: string;
    procedure SetSubCategoryName(const Value: string);

    function GetIsFavouritedByUser: Boolean;
    procedure SetIsFavouritedByUser(const Value: Boolean);

    function GetShareable: Boolean;
    procedure SetShareable(const Value: Boolean);

    function GetDeletable: Boolean;
    procedure SetDeletable(const Value: Boolean);

    function GetCopyable: Boolean;
    procedure SetCopyable(const Value: Boolean);

    function GetApproved: Boolean;
    procedure SetApproved(const Value: Boolean);

    function GetEditable: Boolean;
    procedure SetEditable(const Value: Boolean);

    function GetStatusCode: TYFContentTypes.statusCode;
    procedure SetStatusCode(const Value: TYFContentTypes.statusCode);

    function GetViewId: Int64;
    procedure SetViewId(const Value: Int64);

    function GetViewName: string;
    procedure SetViewName(const Value: string);

    function GetSourceId: Int64;
    procedure SetSourceId(const Value: Int64);

    function GetIpOrg: Int64;
    procedure SetIpOrg(const Value: Int64);

    function GetSourceName: string;
    procedure SetSourceName(const Value: string);

    function GetTags: TArray<string>;
    procedure SetTags(const Value: TArray<string>);

    function GetPublishedDate: TDateTime;
    procedure SetPublishedDate(const Value: TDateTime);

    function GetFormattedPublishDate: string;
    procedure SetFormattedPublishDate(const Value: string);

    function GetUpdatedDate: TDateTime;
    procedure SetUpdatedDate(const Value: TDateTime);

    function GetFormattedUpdatedDate: string;
    procedure SetFormattedUpdatedDate(const Value: string);

    function GetCreatorId: Int64;
    procedure SetCreatorId(const Value: Int64);

    function GetCreatorName: string;
    procedure SetCreatorName(const Value: string);

    function GetLastModifierId: Int64;
    procedure SetLastModifierId(const Value: Int64);

    function GetLastModifierName: string;
    procedure SetLastModifierName(const Value: string);

    // Properties
    /// <summary>Unique identifier for the content item.</summary>
    property ContentId: Int64 read GetContentId write SetContentId;
    /// <summary>The UUID of this content item.</summary>
    property ContentUUID: string read GetContentUUID write SetContentUUID;
    /// <summary>UUID of the published version, or same as ContentUUID if not applicable.</summary>
    property PublishUUID: string read GetPublishUUID write SetPublishUUID;
    /// <summary>Title of the content item. May be translated.</summary>
    property Title: string read GetTitle write SetTitle;
    /// <summary>Description of the content item. May be translated.</summary>
    property Description: string read GetDescription write SetDescription;
    /// <summary>Description of the content type. May be translated.</summary>
    property ContentTypeDescription: string read GetContentTypeDescription write SetContentTypeDescription;
    /// <summary>Code representing the content type (e.g. REPORT, VIEW).</summary>
    property ContentType: TYFContentTypes.contentType read GetContentType write SetContentType;
    /// <summary>Unique code of the parent category.</summary>
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;
    /// <summary>Display name of the parent category. May be translated.</summary>
    property CategoryName: string read GetCategoryName write SetCategoryName;
    /// <summary>Unique code of the subcategory.</summary>
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;
    /// <summary>Display name of the subcategory. May be translated.</summary>
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;
    /// <summary>True if favourited by the current user. Default: true.</summary>
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
    /// <summary>True if user can share this content. Default: true.</summary>
    property Shareable: Boolean read GetShareable write SetShareable;
    /// <summary>True if user can delete this content. Default: true.</summary>
    property Deletable: Boolean read GetDeletable write SetDeletable;
    /// <summary>True if user can copy this content. Default: true.</summary>
    property Copyable: Boolean read GetCopyable write SetCopyable;
    /// <summary>True if the content has been approved. Default: true.</summary>
    property Approved: Boolean read GetApproved write SetApproved;
    /// <summary>True if user can edit this content. Default: true.</summary>
    property Editable: Boolean read GetEditable write SetEditable;
    /// <summary>Current status of the content (OPEN, DRAFT, ARCHIVED, etc).</summary>
    property StatusCode: TYFContentTypes.statusCode read GetStatusCode write SetStatusCode;
    /// <summary>Internal Yellowfin ID of the associated view.</summary>
    property ViewId: Int64 read GetViewId write SetViewId;
    /// <summary>Name of the associated view. May be translated.</summary>
    property ViewName: string read GetViewName write SetViewName;
    /// <summary>Internal Yellowfin ID of the data source.</summary>
    property SourceId: Int64 read GetSourceId write SetSourceId;
    /// <summary>Internal Yellowfin ID of the organisation.</summary>
    property IpOrg: Int64 read GetIpOrg write SetIpOrg;
    /// <summary>Name of the data source. May be translated.</summary>
    property SourceName: string read GetSourceName write SetSourceName;
    /// <summary>List of tags applied to this content item.</summary>
    property Tags: TArray<string> read GetTags write SetTags;
    /// <summary>Published date in GMT (format YYYYMMDDHHmmss).</summary>
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;
    /// <summary>Formatted publish date using user’s preferred format.</summary>
    property FormattedPublishDate: string read GetFormattedPublishDate write SetFormattedPublishDate;
    /// <summary>Last updated date in GMT (format YYYYMMDDHHmmss).</summary>
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;
    /// <summary>Formatted last updated date using user’s preferred format.</summary>
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;
    /// <summary>Internal Yellowfin ID of the content creator.</summary>
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;
    /// <summary>Name of the content creator.</summary>
    property CreatorName: string read GetCreatorName write SetCreatorName;
    /// <summary>Internal Yellowfin ID of the last modifier.</summary>
    property LastModifierId: Int64 read GetLastModifierId write SetLastModifierId;
    /// <summary>Name of the last modifier.</summary>
    property LastModifierName: string read GetLastModifierName write SetLastModifierName;
  end;


  IYFContentList = interface(IYFModelList<IYFContent>)
    ['{74F05B61-EC28-474E-82A7-075FAD42E264}']
    /// <summary>Total of a specific type of content in the list.</summary>
    function Count(AContentType : TYFContentTypes.contentType): Integer;
    procedure AssignItemsByType(ATarget : IYFContentList; AContentType : TYFContentTypes.contentType);
  end;

implementation

end.
