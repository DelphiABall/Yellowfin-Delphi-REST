unit yellowfinbi.api.presentations.classes;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, Yellowfinbi.api.JSON.generics,
  yellowfinbi.api.presentations.intf;

type
/// <summary>
  /// Implementation of IPresentationListItemModel.
  /// Represents a Yellowfin Presentation List Item Model.
  /// </summary>
  TYFPresentation = class(TInterfacedObject, IYFPresentationListItemModel)
  private
    FPresentationId: Int64;
    FPresentationPublishUUID: string;
    FThemeId: Int64;
    FName: string;
    FDescription: string;
    FCategoryCode: string;
    FCategoryName: string;
    FSubCategoryCode: string;
    FSubCategoryName: string;
    FStatusCode: TYFPresentationTypes.statusCode;
    FLastModifiedDateTime: TDateTime;
    FFormattedLastModifiedDateTime: string;
    FPublishedDateTime: TDateTime;
    FFormattedPublishedDateTime: string;
    FCreatorId: Int64;
    FCreatorName: string;
    FLastModifierId: Int64;
    FLastModifierName: string;
    FIsFavouritedByUser: Boolean;

    // Getters and Setters
    function GetPresentationId: Int64;
    procedure SetPresentationId(const Value: Int64);

    function GetPresentationPublishUUID: string;
    procedure SetPresentationPublishUUID(const Value: string);

    function GetThemeId: Int64;
    procedure SetThemeId(const Value: Int64);

    function GetName: string;
    procedure SetName(const Value: string);

    function GetDescription: string;
    procedure SetDescription(const Value: string);

    function GetCategoryCode: string;
    procedure SetCategoryCode(const Value: string);

    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);

    function GetSubCategoryCode: string;
    procedure SetSubCategoryCode(const Value: string);

    function GetSubCategoryName: string;
    procedure SetSubCategoryName(const Value: string);

    function GetStatusCode: TYFPresentationTypes.statusCode;
    procedure SetStatusCode(const Value: TYFPresentationTypes.statusCode);

    function GetLastModifiedDateTime: TDateTime;
    procedure SetLastModifiedDateTime(const Value: TDateTime);

    function GetFormattedLastModifiedDateTime: string;
    procedure SetFormattedLastModifiedDateTime(const Value: string);

    function GetPublishedDateTime: TDateTime;
    procedure SetPublishedDateTime(const Value: TDateTime);

    function GetFormattedPublishedDateTime: string;
    procedure SetFormattedPublishedDateTime(const Value: string);

    function GetCreatorId: Int64;
    procedure SetCreatorId(const Value: Int64);

    function GetCreatorName: string;
    procedure SetCreatorName(const Value: string);

    function GetLastModifierId: Int64;
    procedure SetLastModifierId(const Value: Int64);

    function GetLastModifierName: string;
    procedure SetLastModifierName(const Value: string);

    function GetIsFavouritedByUser: Boolean;
    procedure SetIsFavouritedByUser(const Value: Boolean);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property PresentationId: Int64 read GetPresentationId write SetPresentationId;
    property PresentationPublishUUID: string read GetPresentationPublishUUID write SetPresentationPublishUUID;
    property ThemeId: Int64 read GetThemeId write SetThemeId;
    property Name: string read GetName write SetName;
    property Description: string read GetDescription write SetDescription;
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;
    property CategoryName: string read GetCategoryName write SetCategoryName;
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;
    property StatusCode: TYFPresentationTypes.statusCode read GetStatusCode write SetStatusCode;
    property LastModifiedDateTime: TDateTime read GetLastModifiedDateTime write SetLastModifiedDateTime;
    property FormattedLastModifiedDateTime: string read GetFormattedLastModifiedDateTime write SetFormattedLastModifiedDateTime;
    property PublishedDateTime: TDateTime read GetPublishedDateTime write SetPublishedDateTime;
    property FormattedPublishedDateTime: string read GetFormattedPublishedDateTime write SetFormattedPublishedDateTime;
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;
    property CreatorName: string read GetCreatorName write SetCreatorName;
    property LastModifierId: Int64 read GetLastModifierId write SetLastModifierId;
    property LastModifierName: string read GetLastModifierName write SetLastModifierName;
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
  end;

  /// <summary>
  ///   List of Yellowfin Presentations, default implementation of IYFPresentationListItemModel
  /// </summary>
  TYFPresentationsList = class(TYFModelList<IYFPresentationListItemModel>, IYFPresentationsList)
    constructor Create; overload;
  end;

  TYFPresentationReportModel = class(TInterfacedObject, IYFPresentationReportModel)
  private
    FSlideId: Int64;
    FDefaultDisplay: TYFPresentationTypes.defaultDisplay;
    FEntityUUID: string;
    FReportId: Int64;
    FReportPublishUUID: string;
    FName: string;
    FDescription: string;
    FCategoryCode: string;
    FCategoryName: string;
    FSubCategoryCode: string;
    FSubCategoryName: string;
    FStatusCode: TYFPresentationTypes.statusCode;
    FViewId: Int64;
    FViewName: string;
    FSourceId: Int64;
    FSourceName: string;
    FAccessTypeCode: TYFPresentationTypes.accessTypeCode;
    FPublishedDate: TDateTime;
    FFormattedPublishDate: string;
    FUpdatedDate: TDateTime;
    FFormattedUpdatedDate: string;
    FCreatorId: Int64;
    FCreatorName: string;
    FLastUpdaterId: Int64;
    FLastUpdaterName: string;
    FIsFavouritedByUser: Boolean;
    FCommentCount: Int64;

    { Getters/Setters }
    function GetSlideId: Int64; inline;
    procedure SetSlideId(const Value: Int64); inline;

    function GetDefaultDisplay: TYFPresentationTypes.defaultDisplay; inline;
    procedure SetDefaultDisplay(const Value: TYFPresentationTypes.defaultDisplay); inline;

    function GetEntityUUID: string; inline;
    procedure SetEntityUUID(const Value: string); inline;

    function GetReportId: Int64; inline;
    procedure SetReportId(const Value: Int64); inline;

    function GetReportPublishUUID: string; inline;
    procedure SetReportPublishUUID(const Value: string); inline;

    function GetName: string; inline;
    procedure SetName(const Value: string); inline;

    function GetDescription: string; inline;
    procedure SetDescription(const Value: string); inline;

    function GetCategoryCode: string; inline;
    procedure SetCategoryCode(const Value: string); inline;

    function GetCategoryName: string; inline;
    procedure SetCategoryName(const Value: string); inline;

    function GetSubCategoryCode: string; inline;
    procedure SetSubCategoryCode(const Value: string); inline;

    function GetSubCategoryName: string; inline;
    procedure SetSubCategoryName(const Value: string); inline;

    function GetStatusCode: TYFPresentationTypes.statusCode; inline;
    procedure SetStatusCode(const Value: TYFPresentationTypes.statusCode); inline;

    function GetViewId: Int64; inline;
    procedure SetViewId(const Value: Int64); inline;

    function GetViewName: string; inline;
    procedure SetViewName(const Value: string); inline;

    function GetSourceId: Int64; inline;
    procedure SetSourceId(const Value: Int64); inline;

    function GetSourceName: string; inline;
    procedure SetSourceName(const Value: string); inline;

    function GetAccessTypeCode: TYFPresentationTypes.accessTypeCode; inline;
    procedure SetAccessTypeCode(const Value: TYFPresentationTypes.accessTypeCode); inline;

    function GetPublishedDate: TDateTime; inline;
    procedure SetPublishedDate(const Value: TDateTime); inline;

    function GetFormattedPublishDate: string; inline;
    procedure SetFormattedPublishDate(const Value: string); inline;

    function GetUpdatedDate: TDateTime; inline;
    procedure SetUpdatedDate(const Value: TDateTime); inline;

    function GetFormattedUpdatedDate: string; inline;
    procedure SetFormattedUpdatedDate(const Value: string); inline;

    function GetCreatorId: Int64; inline;
    procedure SetCreatorId(const Value: Int64); inline;

    function GetCreatorName: string; inline;
    procedure SetCreatorName(const Value: string); inline;

    function GetLastUpdaterId: Int64; inline;
    procedure SetLastUpdaterId(const Value: Int64); inline;

    function GetLastUpdaterName: string; inline;
    procedure SetLastUpdaterName(const Value: string); inline;

    function GetIsFavouritedByUser: Boolean; inline;
    procedure SetIsFavouritedByUser(const Value: Boolean); inline;

    function GetCommentCount: Int64; inline;
    procedure SetCommentCount(const Value: Int64); inline;

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    { Properties }
    property SlideId: Int64 read GetSlideId write SetSlideId;
    property DefaultDisplay: TYFPresentationTypes.defaultDisplay read GetDefaultDisplay write SetDefaultDisplay;
    property EntityUUID: string read GetEntityUUID write SetEntityUUID;
    property ReportId: Int64 read GetReportId write SetReportId;
    property ReportPublishUUID: string read GetReportPublishUUID write SetReportPublishUUID;
    property Name: string read GetName write SetName;
    property Description: string read GetDescription write SetDescription;
    property CategoryCode: string read GetCategoryCode write SetCategoryCode;
    property CategoryName: string read GetCategoryName write SetCategoryName;
    property SubCategoryCode: string read GetSubCategoryCode write SetSubCategoryCode;
    property SubCategoryName: string read GetSubCategoryName write SetSubCategoryName;
    property StatusCode: TYFPresentationTypes.statusCode read GetStatusCode write SetStatusCode;
    property ViewId: Int64 read GetViewId write SetViewId;
    property ViewName: string read GetViewName write SetViewName;
    property SourceId: Int64 read GetSourceId write SetSourceId;
    property SourceName: string read GetSourceName write SetSourceName;
    property AccessTypeCode: TYFPresentationTypes.accessTypeCode read GetAccessTypeCode write SetAccessTypeCode;
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;
    property FormattedPublishDate: string read GetFormattedPublishDate write SetFormattedPublishDate;
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;
    property CreatorName: string read GetCreatorName write SetCreatorName;
    property LastUpdaterId: Int64 read GetLastUpdaterId write SetLastUpdaterId;
    property LastUpdaterName: string read GetLastUpdaterName write SetLastUpdaterName;
    property IsFavouritedByUser: Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
    property CommentCount: Int64 read GetCommentCount write SetCommentCount;
  end;


    /// <summary>
  ///   List of Yellowfin Presentations, default implementation of IYFPresentationListItemModel
  /// </summary>
  TYFPresentationReportList = class(TYFModelList<IYFPresentationReportModel>, IYFPresentationReportList)
    constructor Create; overload;
  end;


implementation

uses  yellowfinbi.api.classfactory;

constructor TYFPresentationsList.Create;
begin
  inherited Create(nil, 'items');
end;


{ TYFPresentation }

function TYFPresentation.GetPresentationId: Int64;
begin
  Result := FPresentationId;
end;

procedure TYFPresentation.SetPresentationId(const Value: Int64);
begin
  FPresentationId := Value;
end;

function TYFPresentation.GetPresentationPublishUUID: string;
begin
  Result := FPresentationPublishUUID;
end;

procedure TYFPresentation.SetPresentationPublishUUID(const Value: string);
begin
  FPresentationPublishUUID := Value;
end;

function TYFPresentation.GetThemeId: Int64;
begin
  Result := FThemeId;
end;

procedure TYFPresentation.SetThemeId(const Value: Int64);
begin
  FThemeId := Value;
end;

function TYFPresentation.GetName: string;
begin
  Result := FName;
end;

procedure TYFPresentation.SetName(const Value: string);
begin
  FName := Value;
end;

function TYFPresentation.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TYFPresentation.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TYFPresentation.GetCategoryCode: string;
begin
  Result := FCategoryCode;
end;

procedure TYFPresentation.SetCategoryCode(const Value: string);
begin
  FCategoryCode := Value;
end;

function TYFPresentation.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TYFPresentation.SetCategoryName(const Value: string);
begin
  FCategoryName := Value;
end;

function TYFPresentation.GetSubCategoryCode: string;
begin
  Result := FSubCategoryCode;
end;

procedure TYFPresentation.SetSubCategoryCode(const Value: string);
begin
  FSubCategoryCode := Value;
end;

function TYFPresentation.GetSubCategoryName: string;
begin
  Result := FSubCategoryName;
end;

procedure TYFPresentation.SetSubCategoryName(const Value: string);
begin
  FSubCategoryName := Value;
end;

function TYFPresentation.GetStatusCode: TYFPresentationTypes.statusCode;
begin
  Result := FStatusCode;
end;

procedure TYFPresentation.SetStatusCode(const Value: TYFPresentationTypes.statusCode);
begin
  FStatusCode := Value;
end;

function TYFPresentation.GetLastModifiedDateTime: TDateTime;
begin
  Result := FLastModifiedDateTime;
end;

procedure TYFPresentation.SetLastModifiedDateTime(const Value: TDateTime);
begin
  FLastModifiedDateTime := Value;
end;

function TYFPresentation.GetFormattedLastModifiedDateTime: string;
begin
  Result := FFormattedLastModifiedDateTime;
end;

procedure TYFPresentation.SetFormattedLastModifiedDateTime(const Value: string);
begin
  FFormattedLastModifiedDateTime := Value;
end;

function TYFPresentation.GetPublishedDateTime: TDateTime;
begin
  Result := FPublishedDateTime;
end;

procedure TYFPresentation.SetPublishedDateTime(const Value: TDateTime);
begin
  FPublishedDateTime := Value;
end;

function TYFPresentation.GetFormattedPublishedDateTime: string;
begin
  Result := FFormattedPublishedDateTime;
end;

procedure TYFPresentation.SetFormattedPublishedDateTime(const Value: string);
begin
  FFormattedPublishedDateTime := Value;
end;

function TYFPresentation.GetCreatorId: Int64;
begin
  Result := FCreatorId;
end;

procedure TYFPresentation.SetCreatorId(const Value: Int64);
begin
  FCreatorId := Value;
end;

function TYFPresentation.GetCreatorName: string;
begin
  Result := FCreatorName;
end;

procedure TYFPresentation.SetCreatorName(const Value: string);
begin
  FCreatorName := Value;
end;

function TYFPresentation.GetLastModifierId: Int64;
begin
  Result := FLastModifierId;
end;

procedure TYFPresentation.SetLastModifierId(const Value: Int64);
begin
  FLastModifierId := Value;
end;

function TYFPresentation.GetLastModifierName: string;
begin
  Result := FLastModifierName;
end;

procedure TYFPresentation.SetLastModifierName(const Value: string);
begin
  FLastModifierName := Value;
end;

function TYFPresentation.GetIsFavouritedByUser: Boolean;
begin
  Result := FIsFavouritedByUser;
end;

procedure TYFPresentation.SetIsFavouritedByUser(const Value: Boolean);
begin
  FIsFavouritedByUser := Value;
end;

procedure TYFPresentation.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  // presentationId
  if AJSON.TryGetValue('presentationId', jv) then
    PresentationId := jv.Value.ToInt64
  else
    PresentationId := 0;

  // presentationPublishUUID
  if AJSON.TryGetValue('presentationPublishUUID', jv) then
    PresentationPublishUUID := jv.Value
  else
    PresentationPublishUUID := '';

  // themeId
  if AJSON.TryGetValue('themeId', jv) then
    ThemeId := jv.Value.ToInt64
  else
    ThemeId := 0;

  // name
  if AJSON.TryGetValue('name', jv) then
    Name := jv.Value
  else
    Name := '';

  // description
  if AJSON.TryGetValue('description', jv) then
    Description := jv.Value
  else
    Description := '';

  // categoryCode
  if AJSON.TryGetValue('categoryCode', jv) then
    CategoryCode := jv.Value
  else
    CategoryCode := '';

  // categoryName
  if AJSON.TryGetValue('categoryName', jv) then
    CategoryName := jv.Value
  else
    CategoryName := '';

  // subCategoryCode
  if AJSON.TryGetValue('subCategoryCode', jv) then
    SubCategoryCode := jv.Value
  else
    SubCategoryCode := '';

  // subCategoryName
  if AJSON.TryGetValue('subCategoryName', jv) then
    SubCategoryName := jv.Value
  else
    SubCategoryName := '';

  // statusCode with default fallback
  if AJSON.TryGetValue('statusCode', jv) then
    StatusCode := TYFPresentationTypes.GetValue<TYFPresentationTypes.statusCode>(
                    jv.Value,
                    TYFPresentationTypes.statusCode.DRAFT
                  )
  else
    StatusCode := TYFPresentationTypes.statusCode.DRAFT;

  // lastModifiedDateTime
  if AJSON.TryGetValue('lastModifiedDateTime', jv) then
    LastModifiedDateTime := YFDateStrToTDateTime(jv.Value)
  else
    LastModifiedDateTime := 0;

  // formattedLastModifiedDateTime
  if AJSON.TryGetValue('formattedLastModifiedDateTime', jv) then
    FormattedLastModifiedDateTime := jv.Value
  else
    FormattedLastModifiedDateTime := '';

  // publishedDateTime
  if AJSON.TryGetValue('publishedDateTime', jv) then
    PublishedDateTime := YFDateStrToTDateTime(jv.Value)
  else
    PublishedDateTime := 0;

  // formattedPublishedDateTime
  if AJSON.TryGetValue('formattedPublishedDateTime', jv) then
    FormattedPublishedDateTime := jv.Value
  else
    FormattedPublishedDateTime := '';

  // creatorId
  if AJSON.TryGetValue('creatorId', jv) then
    CreatorId := jv.Value.ToInt64
  else
    CreatorId := 0;

  // creatorName
  if AJSON.TryGetValue('creatorName', jv) then
    CreatorName := jv.Value
  else
    CreatorName := '';

  // lastModifierId
  if AJSON.TryGetValue('lastModifierId', jv) then
    LastModifierId := jv.Value.ToInt64
  else
    LastModifierId := 0;

  // lastModifierName
  if AJSON.TryGetValue('lastModifierName', jv) then
    LastModifierName := jv.Value
  else
    LastModifierName := '';

  // isFavouritedByUser
  if AJSON.TryGetValue('isFavouritedByUser', jv) then
    IsFavouritedByUser := jv.Value.ToLower = 'true'
  else
    IsFavouritedByUser := False;
end;

{ TYFPresentationReportModel }

function TYFPresentationReportModel.GetSlideId: Int64;
begin
  Result := FSlideId;
end;

procedure TYFPresentationReportModel.SetSlideId(const Value: Int64);
begin
  FSlideId := Value;
end;

function TYFPresentationReportModel.GetDefaultDisplay: TYFPresentationTypes.defaultDisplay;
begin
  Result := FDefaultDisplay;
end;

procedure TYFPresentationReportModel.SetDefaultDisplay(const Value: TYFPresentationTypes.defaultDisplay);
begin
  FDefaultDisplay := Value;
end;

function TYFPresentationReportModel.GetEntityUUID: string;
begin
  Result := FEntityUUID;
end;

procedure TYFPresentationReportModel.SetEntityUUID(const Value: string);
begin
  FEntityUUID := Value;
end;

function TYFPresentationReportModel.GetReportId: Int64;
begin
  Result := FReportId;
end;

procedure TYFPresentationReportModel.SetReportId(const Value: Int64);
begin
  FReportId := Value;
end;

function TYFPresentationReportModel.GetReportPublishUUID: string;
begin
  Result := FReportPublishUUID;
end;

procedure TYFPresentationReportModel.SetReportPublishUUID(const Value: string);
begin
  FReportPublishUUID := Value;
end;

function TYFPresentationReportModel.GetName: string;
begin
  Result := FName;
end;

procedure TYFPresentationReportModel.SetName(const Value: string);
begin
  FName := Value;
end;

function TYFPresentationReportModel.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TYFPresentationReportModel.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TYFPresentationReportModel.GetCategoryCode: string;
begin
  Result := FCategoryCode;
end;

procedure TYFPresentationReportModel.SetCategoryCode(const Value: string);
begin
  FCategoryCode := Value;
end;

function TYFPresentationReportModel.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TYFPresentationReportModel.SetCategoryName(const Value: string);
begin
  FCategoryName := Value;
end;

function TYFPresentationReportModel.GetSubCategoryCode: string;
begin
  Result := FSubCategoryCode;
end;

procedure TYFPresentationReportModel.SetSubCategoryCode(const Value: string);
begin
  FSubCategoryCode := Value;
end;

function TYFPresentationReportModel.GetSubCategoryName: string;
begin
  Result := FSubCategoryName;
end;

procedure TYFPresentationReportModel.SetSubCategoryName(const Value: string);
begin
  FSubCategoryName := Value;
end;

function TYFPresentationReportModel.GetStatusCode: TYFPresentationTypes.statusCode;
begin
  Result := FStatusCode;
end;

procedure TYFPresentationReportModel.SetStatusCode(const Value: TYFPresentationTypes.statusCode);
begin
  FStatusCode := Value;
end;

function TYFPresentationReportModel.GetViewId: Int64;
begin
  Result := FViewId;
end;

procedure TYFPresentationReportModel.SetViewId(const Value: Int64);
begin
  FViewId := Value;
end;

function TYFPresentationReportModel.GetViewName: string;
begin
  Result := FViewName;
end;

procedure TYFPresentationReportModel.SetViewName(const Value: string);
begin
  FViewName := Value;
end;

function TYFPresentationReportModel.GetSourceId: Int64;
begin
  Result := FSourceId;
end;

procedure TYFPresentationReportModel.SetSourceId(const Value: Int64);
begin
  FSourceId := Value;
end;

function TYFPresentationReportModel.GetSourceName: string;
begin
  Result := FSourceName;
end;

procedure TYFPresentationReportModel.SetSourceName(const Value: string);
begin
  FSourceName := Value;
end;

function TYFPresentationReportModel.GetAccessTypeCode: TYFPresentationTypes.accessTypeCode;
begin
  Result := FAccessTypeCode;
end;

procedure TYFPresentationReportModel.SetAccessTypeCode(const Value: TYFPresentationTypes.accessTypeCode);
begin
  FAccessTypeCode := Value;
end;

function TYFPresentationReportModel.GetPublishedDate: TDateTime;
begin
  Result := FPublishedDate;
end;

procedure TYFPresentationReportModel.SetPublishedDate(const Value: TDateTime);
begin
  FPublishedDate := Value;
end;

function TYFPresentationReportModel.GetFormattedPublishDate: string;
begin
  Result := FFormattedPublishDate;
end;

procedure TYFPresentationReportModel.SetFormattedPublishDate(const Value: string);
begin
  FFormattedPublishDate := Value;
end;

function TYFPresentationReportModel.GetUpdatedDate: TDateTime;
begin
  Result := FUpdatedDate;
end;

procedure TYFPresentationReportModel.SetUpdatedDate(const Value: TDateTime);
begin
  FUpdatedDate := Value;
end;

function TYFPresentationReportModel.GetFormattedUpdatedDate: string;
begin
  Result := FFormattedUpdatedDate;
end;

procedure TYFPresentationReportModel.SetFormattedUpdatedDate(const Value: string);
begin
  FFormattedUpdatedDate := Value;
end;

function TYFPresentationReportModel.GetCreatorId: Int64;
begin
  Result := FCreatorId;
end;

procedure TYFPresentationReportModel.SetCreatorId(const Value: Int64);
begin
  FCreatorId := Value;
end;

function TYFPresentationReportModel.GetCreatorName: string;
begin
  Result := FCreatorName;
end;

procedure TYFPresentationReportModel.SetCreatorName(const Value: string);
begin
  FCreatorName := Value;
end;

function TYFPresentationReportModel.GetLastUpdaterId: Int64;
begin
  Result := FLastUpdaterId;
end;

procedure TYFPresentationReportModel.SetLastUpdaterId(const Value: Int64);
begin
  FLastUpdaterId := Value;
end;

function TYFPresentationReportModel.GetLastUpdaterName: string;
begin
  Result := FLastUpdaterName;
end;

procedure TYFPresentationReportModel.SetLastUpdaterName(const Value: string);
begin
  FLastUpdaterName := Value;
end;

function TYFPresentationReportModel.GetIsFavouritedByUser: Boolean;
begin
  Result := FIsFavouritedByUser;
end;

procedure TYFPresentationReportModel.SetIsFavouritedByUser(const Value: Boolean);
begin
  FIsFavouritedByUser := Value;
end;

function TYFPresentationReportModel.GetCommentCount: Int64;
begin
  Result := FCommentCount;
end;

procedure TYFPresentationReportModel.SetCommentCount(const Value: Int64);
begin
  FCommentCount := Value;
end;

procedure TYFPresentationReportModel.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then Exit;

  // Integer / Int64 fields
  if AJSON.TryGetValue('slideId', jv) then SlideId := jv.Value.ToInt64;
  if AJSON.TryGetValue('reportId', jv) then ReportId := jv.Value.ToInt64;
  if AJSON.TryGetValue('viewId', jv) then ViewId := jv.Value.ToInt64;
  if AJSON.TryGetValue('sourceId', jv) then SourceId := jv.Value.ToInt64;
  if AJSON.TryGetValue('creatorId', jv) then CreatorId := jv.Value.ToInt64;
  if AJSON.TryGetValue('lastUpdaterId', jv) then LastUpdaterId := jv.Value.ToInt64;
  if AJSON.TryGetValue('commentCount', jv) then CommentCount := jv.Value.ToInt64;

  // String fields
  if AJSON.TryGetValue('entityUUID', jv) then EntityUUID := jv.Value;
  if AJSON.TryGetValue('reportPublishUUID', jv) then ReportPublishUUID := jv.Value;
  if AJSON.TryGetValue('name', jv) then Name := jv.Value;
  if AJSON.TryGetValue('description', jv) then Description := jv.Value;
  if AJSON.TryGetValue('categoryCode', jv) then CategoryCode := jv.Value;
  if AJSON.TryGetValue('categoryName', jv) then CategoryName := jv.Value;
  if AJSON.TryGetValue('subCategoryCode', jv) then SubCategoryCode := jv.Value;
  if AJSON.TryGetValue('subCategoryName', jv) then SubCategoryName := jv.Value;
  if AJSON.TryGetValue('viewName', jv) then ViewName := jv.Value;
  if AJSON.TryGetValue('sourceName', jv) then SourceName := jv.Value;
  if AJSON.TryGetValue('formattedPublishDate', jv) then FormattedPublishDate := jv.Value;
  if AJSON.TryGetValue('formattedUpdatedDate', jv) then FormattedUpdatedDate := jv.Value;
  if AJSON.TryGetValue('creatorName', jv) then CreatorName := jv.Value;
  if AJSON.TryGetValue('lastUpdaterName', jv) then LastUpdaterName := jv.Value;

  // Boolean
  if AJSON.TryGetValue('isFavouritedByUser', jv) then
    IsFavouritedByUser := jv.Value.ToBoolean
  else
    IsFavouritedByUser := False;

  // Enums using TYFPresentationTypes.GetValue
  if AJSON.TryGetValue('statusCode', jv) then
    StatusCode := TYFPresentationTypes.GetValue<TYFPresentationTypes.statusCode>(
                    jv.Value,
                    TYFPresentationTypes.statusCode.DRAFT
                  )
  else
    StatusCode := TYFPresentationTypes.statusCode.DRAFT;

  if AJSON.TryGetValue('defaultDisplay', jv) then
    DefaultDisplay := TYFPresentationTypes.GetValue<TYFPresentationTypes.defaultDisplay>(
                        jv.Value,
                        TYFPresentationTypes.defaultDisplay.CANVAS
                      )
  else
    DefaultDisplay := TYFPresentationTypes.defaultDisplay.CANVAS;

  if AJSON.TryGetValue('accessTypeCode', jv) then
    AccessTypeCode := TYFPresentationTypes.GetValue<TYFPresentationTypes.accessTypeCode>(
                        jv.Value,
                        TYFPresentationTypes.accessTypeCode.CORPORATE
                      )
  else
    AccessTypeCode := TYFPresentationTypes.accessTypeCode.CORPORATE;

  // Dates
  if AJSON.TryGetValue('publishedDate', jv) then
    PublishedDate := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('updatedDate', jv) then
    UpdatedDate := YFDateStrToTDateTime(jv.Value);

end;


{ TYFPresentationReportList }

constructor TYFPresentationReportList.Create;
begin
  inherited Create(nil, 'items');
end;

initialization
   TYFFactoryRegistry.RegisterFactory<IYFPresentationListItemModel>(
    function: IYFPresentationListItemModel
    begin
      Result := TYFPresentation.Create;
    end
  );

   TYFFactoryRegistry.RegisterFactory<IYFPresentationsList>(
    function: IYFPresentationsList
    begin
      Result := TYFPresentationsList.Create;
    end
  );
end.
