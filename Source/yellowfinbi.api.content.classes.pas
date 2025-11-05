unit yellowfinbi.api.content.classes;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, Yellowfinbi.api.JSON.generics,
  yellowfinbi.api.content.intf;

type
  TYFContent = class(TInterfacedObject, IYFContent)
  private
    FContentId: Int64;
    FContentUUID: string;
    FPublishUUID: string;
    FTitle: string;
    FDescription: string;
    FContentTypeDescription: string;
    FContentType: TYFContentTypes.contentType;
    FCategoryCode: string;
    FCategoryName: string;
    FSubCategoryCode: string;
    FSubCategoryName: string;
    FIsFavouritedByUser: Boolean;
    FShareable: Boolean;
    FDeletable: Boolean;
    FCopyable: Boolean;
    FApproved: Boolean;
    FEditable: Boolean;
    FStatusCode: TYFContentTypes.statusCode;
    FViewId: Int64;
    FViewName: string;
    FSourceId: Int64;
    FIpOrg: Int64;
    FSourceName: string;
    FTags: TArray<string>;
    FPublishedDate: TDateTime;
    FFormattedPublishDate: string;
    FUpdatedDate: TDateTime;
    FFormattedUpdatedDate: string;
    FCreatorId: Int64;
    FCreatorName: string;
    FLastModifierId: Int64;
    FLastModifierName: string;

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

  public
    /// <summary>Unique identifier for the content item.</summary>
    property ContentId: Int64 read GetContentId write SetContentId;

    /// <summary>UUID of this content item.</summary>
    property ContentUUID: string read GetContentUUID write SetContentUUID;

    /// <summary>UUID of the published version, or same as ContentUUID if not separate.</summary>
    property PublishUUID: string read GetPublishUUID write SetPublishUUID;

    /// <summary>Title of the content item (translated if available).</summary>
    property Title: string read GetTitle write SetTitle;

    /// <summary>Description of the content item (translated if available).</summary>
    property Description: string read GetDescription write SetDescription;

    /// <summary>Translated description of the content type.</summary>
    property ContentTypeDescription: string read GetContentTypeDescription write SetContentTypeDescription;

    /// <summary>Type of content (e.g., REPORT, DASHBOARD).</summary>
    property ContentType: TYFContentTypes.contentType read GetContentType write SetContentType;

    /// <summary>Code for the parent category (folder).</summary>
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;

    /// <summary>Translated display name of the parent category.</summary>
    property CategoryName: string read GetCategoryName write SetCategoryName;

    /// <summary>Code for the subcategory (subfolder).</summary>
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;

    /// <summary>Translated display name of the subcategory.</summary>
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;

    /// <summary>True if this content is favourited by the user.</summary>
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;

    /// <summary>True if user can share this content item.</summary>
    property Shareable: Boolean read GetShareable write SetShareable;

    /// <summary>True if user can delete this content item.</summary>
    property Deletable: Boolean read GetDeletable write SetDeletable;

    /// <summary>True if user can copy this content item.</summary>
    property Copyable: Boolean read GetCopyable write SetCopyable;

    /// <summary>True if content has passed approval.</summary>
    property Approved: Boolean read GetApproved write SetApproved;

    /// <summary>True if user can edit this content item.</summary>
    property Editable: Boolean read GetEditable write SetEditable;

    /// <summary>Status code (OPEN, DRAFT, ARCHIVED, etc.).</summary>
    property StatusCode: TYFContentTypes.StatusCode read GetStatusCode write SetStatusCode;

    /// <summary>Internal Yellowfin ID of the associated view.</summary>
    property ViewId: Int64 read GetViewId write SetViewId;

    /// <summary>Translated name of the associated view.</summary>
    property ViewName: string read GetViewName write SetViewName;

    /// <summary>Internal Yellowfin ID of the associated data source.</summary>
    property SourceId: Int64 read GetSourceId write SetSourceId;

    /// <summary>Yellowfin ID of the owning organisation.</summary>
    property IpOrg: Int64 read GetIpOrg write SetIpOrg;

    /// <summary>Translated name of the data source.</summary>
    property SourceName: string read GetSourceName write SetSourceName;

    /// <summary>List of tags applied to this content item.</summary>
    property Tags: TArray<string> read GetTags write SetTags;

    /// <summary>Date/time when content was published (converted from JSON).</summary>
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;

    /// <summary>Formatted string of published date (user’s locale).</summary>
    property FormattedPublishDate: string read GetFormattedPublishDate write SetFormattedPublishDate;

    /// <summary>Date/time when content was last updated (converted from JSON).</summary>
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;

    /// <summary>Formatted string of last update date (user’s locale).</summary>
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;

    /// <summary>ID of the creator of this content item.</summary>
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;

    /// <summary>Name of the creator of this content item.</summary>
    property CreatorName: string read GetCreatorName write SetCreatorName;

    /// <summary>ID of the last user who modified this content.</summary>
    property LastModifierId: Int64 read GetLastModifierId write SetLastModifierId;

    /// <summary>Name of the last user who modified this content.</summary>
    property LastModifierName: string read GetLastModifierName write SetLastModifierName;

    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;


  /// <summary>
  ///   List of Yellowfin Content, default implementation of IYFcontent
  /// </summary>
  TYFContentList = class(TYFModelList<IYFContent>, IYFContentList)
    constructor Create; overload;
    function Count(AContentType : TYFContentTypes.contentType): Integer;
    procedure AssignItemsByType(ATarget : IYFContentList; AContentType : TYFContentTypes.contentType);
  end;

implementation

uses  yellowfinbi.api.classfactory;

{ TYFContent }

function TYFContent.GetContentId: Int64;
begin
  Result := FContentId;
end;

procedure TYFContent.SetContentId(const Value: Int64);
begin
  FContentId := Value;
end;

function TYFContent.GetContentUUID: string;
begin
  Result := FContentUUID;
end;

procedure TYFContent.SetContentUUID(const Value: string);
begin
  FContentUUID := Value;
end;

function TYFContent.GetPublishUUID: string;
begin
  Result := FPublishUUID;
end;

procedure TYFContent.SetPublishUUID(const Value: string);
begin
  FPublishUUID := Value;
end;

function TYFContent.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TYFContent.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TYFContent.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TYFContent.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TYFContent.GetContentTypeDescription: string;
begin
  Result := FContentTypeDescription;
end;

procedure TYFContent.SetContentTypeDescription(const Value: string);
begin
  FContentTypeDescription := Value;
end;

function TYFContent.GetContentType: TYFContentTypes.contentType;
begin
  Result := FContentType;
end;

procedure TYFContent.SetContentType(const Value: TYFContentTypes.contentType);
begin
  FContentType := Value;
end;

function TYFContent.GetCategoryCode: string;
begin
  Result := FCategoryCode;
end;

procedure TYFContent.SetCategoryCode(const Value: string);
begin
  FCategoryCode := Value;
end;

function TYFContent.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TYFContent.SetCategoryName(const Value: string);
begin
  FCategoryName := Value;
end;

function TYFContent.GetSubCategoryCode: string;
begin
  Result := FSubCategoryCode;
end;

procedure TYFContent.SetSubCategoryCode(const Value: string);
begin
  FSubCategoryCode := Value;
end;

function TYFContent.GetSubCategoryName: string;
begin
  Result := FSubCategoryName;
end;

procedure TYFContent.SetSubCategoryName(const Value: string);
begin
  FSubCategoryName := Value;
end;

function TYFContent.GetIsFavouritedByUser: Boolean;
begin
  Result := FIsFavouritedByUser;
end;

procedure TYFContent.SetIsFavouritedByUser(const Value: Boolean);
begin
  FIsFavouritedByUser := Value;
end;

function TYFContent.GetShareable: Boolean;
begin
  Result := FShareable;
end;

procedure TYFContent.SetShareable(const Value: Boolean);
begin
  FShareable := Value;
end;

function TYFContent.GetDeletable: Boolean;
begin
  Result := FDeletable;
end;

procedure TYFContent.SetDeletable(const Value: Boolean);
begin
  FDeletable := Value;
end;

function TYFContent.GetCopyable: Boolean;
begin
  Result := FCopyable;
end;

procedure TYFContent.SetCopyable(const Value: Boolean);
begin
  FCopyable := Value;
end;

function TYFContent.GetApproved: Boolean;
begin
  Result := FApproved;
end;

procedure TYFContent.SetApproved(const Value: Boolean);
begin
  FApproved := Value;
end;

function TYFContent.GetEditable: Boolean;
begin
  Result := FEditable;
end;

procedure TYFContent.SetEditable(const Value: Boolean);
begin
  FEditable := Value;
end;

function TYFContent.GetStatusCode: TYFContentTypes.statusCode;
begin
  Result := FStatusCode;
end;

procedure TYFContent.SetStatusCode(const Value: TYFContentTypes.statusCode);
begin
  FStatusCode := Value;
end;

function TYFContent.GetViewId: Int64;
begin
  Result := FViewId;
end;

procedure TYFContent.SetViewId(const Value: Int64);
begin
  FViewId := Value;
end;

function TYFContent.GetViewName: string;
begin
  Result := FViewName;
end;

procedure TYFContent.SetViewName(const Value: string);
begin
  FViewName := Value;
end;

function TYFContent.GetSourceId: Int64;
begin
  Result := FSourceId;
end;

procedure TYFContent.SetSourceId(const Value: Int64);
begin
  FSourceId := Value;
end;

function TYFContent.GetIpOrg: Int64;
begin
  Result := FIpOrg;
end;

procedure TYFContent.SetIpOrg(const Value: Int64);
begin
  FIpOrg := Value;
end;

function TYFContent.GetSourceName: string;
begin
  Result := FSourceName;
end;

procedure TYFContent.SetSourceName(const Value: string);
begin
  FSourceName := Value;
end;

function TYFContent.GetTags: TArray<string>;
begin
  Result := FTags;
end;

procedure TYFContent.SetTags(const Value: TArray<string>);
begin
  FTags := Value;
end;

function TYFContent.GetPublishedDate: TDateTime;
begin
  Result := FPublishedDate;
end;

procedure TYFContent.SetPublishedDate(const Value: TDateTime);
begin
  FPublishedDate := Value;
end;

function TYFContent.GetFormattedPublishDate: string;
begin
  Result := FFormattedPublishDate;
end;

procedure TYFContent.SetFormattedPublishDate(const Value: string);
begin
  FFormattedPublishDate := Value;
end;

function TYFContent.GetUpdatedDate: TDateTime;
begin
  Result := FUpdatedDate;
end;

procedure TYFContent.SetUpdatedDate(const Value: TDateTime);
begin
  FUpdatedDate := Value;
end;

function TYFContent.GetFormattedUpdatedDate: string;
begin
  Result := FFormattedUpdatedDate;
end;

procedure TYFContent.SetFormattedUpdatedDate(const Value: string);
begin
  FFormattedUpdatedDate := Value;
end;

function TYFContent.GetCreatorId: Int64;
begin
  Result := FCreatorId;
end;

procedure TYFContent.SetCreatorId(const Value: Int64);
begin
  FCreatorId := Value;
end;

function TYFContent.GetCreatorName: string;
begin
  Result := FCreatorName;
end;

procedure TYFContent.SetCreatorName(const Value: string);
begin
  FCreatorName := Value;
end;

function TYFContent.GetLastModifierId: Int64;
begin
  Result := FLastModifierId;
end;

procedure TYFContent.SetLastModifierId(const Value: Int64);
begin
  FLastModifierId := Value;
end;

function TYFContent.GetLastModifierName: string;
begin
  Result := FLastModifierName;
end;

procedure TYFContent.SetLastModifierName(const Value: string);
begin
  FLastModifierName := Value;
end;

procedure TYFContent.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
  ja: TJSONArray;
  i: Integer;
begin
  if AJSON.TryGetValue('contentId', jv) then
    ContentId := jv.Value.ToInt64;

  if AJSON.TryGetValue('contentUUID', jv) then
    ContentUUID := jv.Value;

  if AJSON.TryGetValue('publishUUID', jv) then
    PublishUUID := jv.Value;

  if AJSON.TryGetValue('title', jv) then
    Title := jv.Value;

  if AJSON.TryGetValue('description', jv) then
    Description := jv.Value;

  if AJSON.TryGetValue('contentTypeDescription', jv) then
    ContentTypeDescription := jv.Value;

  if AJSON.TryGetValue('contentType', jv) then
    ContentType := TYFContentTypes.GetValue<TYFContentTypes.contentType>(
      jv.Value, TYFContentTypes.contentType.REPORT);

  if AJSON.TryGetValue('categoryCode', jv) then
    CategoryCode := jv.Value;

  if AJSON.TryGetValue('categoryName', jv) then
    CategoryName := jv.Value;

  if AJSON.TryGetValue('subCategoryCode', jv) then
    SubCategoryCode := jv.Value;

  if AJSON.TryGetValue('subCategoryName', jv) then
    SubCategoryName := jv.Value;

  if AJSON.TryGetValue('isFavouritedByUser', jv) then
    IsFavouritedByUser := JSONToBool(jv);

  if AJSON.TryGetValue('shareable', jv) then
    Shareable := JSONToBool(jv);

  if AJSON.TryGetValue('deletable', jv) then
    Deletable := JSONToBool(jv);

  if AJSON.TryGetValue('copyable', jv) then
    Copyable := JSONToBool(jv);

  if AJSON.TryGetValue('approved', jv) then
    Approved := JSONToBool(jv);

  if AJSON.TryGetValue('editable', jv) then
    Editable := JSONToBool(jv);

  if AJSON.TryGetValue('statusCode', jv) then
    StatusCode := TYFContentTypes.GetValue<TYFContentTypes.statusCode>(
      jv.Value, TYFContentTypes.statusCode.OPEN);

  if AJSON.TryGetValue('viewId', jv) then
    ViewId := jv.Value.ToInt64;

  if AJSON.TryGetValue('viewName', jv) then
    ViewName := jv.Value;

  if AJSON.TryGetValue('sourceId', jv) then
    SourceId := jv.Value.ToInt64;

  if AJSON.TryGetValue('ipOrg', jv) then
    IpOrg := jv.Value.ToInt64;

  if AJSON.TryGetValue('sourceName', jv) then
    SourceName := jv.Value;

  if AJSON.TryGetValue('tags', jv) and (jv is TJSONArray) then
  begin
    ja := jv as TJSONArray;
    SetLength(FTags, ja.Count);
    for i := 0 to ja.Count - 1 do
      FTags[i] := ja.Items[i].Value;
  end;

  if AJSON.TryGetValue('publishedDate', jv) then
    PublishedDate := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedPublishDate', jv) then
    FormattedPublishDate := jv.Value;

  if AJSON.TryGetValue('updatedDate', jv) then
    UpdatedDate := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedUpdatedDate', jv) then
    FormattedUpdatedDate := jv.Value;

  if AJSON.TryGetValue('creatorId', jv) then
    CreatorId := jv.Value.ToInt64;

  if AJSON.TryGetValue('creatorName', jv) then
    CreatorName := jv.Value;

  if AJSON.TryGetValue('lastModifierId', jv) then
    LastModifierId := jv.Value.ToInt64;

  if AJSON.TryGetValue('lastModifierName', jv) then
    LastModifierName := jv.Value;
end;

{ TYFContentList }

procedure TYFContentList.AssignItemsByType(ATarget: IYFContentList;
  AContentType: TYFContentTypes.contentType);
begin
  Assert(Assigned(ATarget));

  ATarget.Items.Clear;

  for var CurrItem in Self.Items do
  begin
    if CurrItem.ContentType = AContentType then
      ATarget.Items.Add(CurrItem);
  end;

end;

function TYFContentList.Count(
  AContentType: TYFContentTypes.contentType): Integer;
begin
  var Total : Integer := 0;
  for var CurrItem in Self.Items do
  begin
    if CurrItem.ContentType = AContentType then
      Total := Total+1;
  end;
  Result := Total;
end;

constructor TYFContentList.Create;
begin
  inherited Create(nil, 'items');
end;


initialization
   TYFFactoryRegistry.RegisterFactory<IYFContent>(
    function: IYFContent
    begin
      Result := TYFContent.Create;
    end
  );

   TYFFactoryRegistry.RegisterFactory<IYFContentList>(
    function: IYFContentList
    begin
      Result := TYFContentList.Create;
    end
  );
end.
