unit yellowfinbi.api.reports.classes;

interface

uses
  System.SysUtils, yellowfinbi.api.json,  yellowfinbi.api.common, System.JSON,
  System.Generics.Collections, yellowfinbi.api.json.generics,
  yellowfinbi.api.reports.intf;

type
  TYFReportListItemModel = class(TInterfacedObject, IYFReportListItemModel)
  private
    FReportId: Int64;
    FReportPublishUUID: string;
    FName: string;
    FDescription: string;
    FCategoryCode: string;
    FCategoryName: string;
    FSubCategoryCode: string;
    FSubCategoryName: string;
    FStatusCode: TYFReportTypes.statusCode;
    FViewId: Int64;
    FViewName: string;
    FSourceId: Int64;
    FSourceName: string;
    FAccessTypeCode: string;
    FUpdatedDate: TDateTime;
    FFormattedUpdatedDate: string;
    FPublishedDate: TDateTime;
    FFormattedPublishedDate: string;

    FCreatorId: Int64;
    FCreatorName: string;
    FLastUpdaterId: Int64;
    FLastUpdaterName: string;
    FCommentCount: Int64;
    FIsFavouritedByUser: Boolean;

    function GetReportId: Int64;
    procedure SetReportId(const Value: Int64);

    function GetReportPublishUUID: string;
    procedure SetReportPublishUUID(const Value: string);

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

    function GetStatusCode: TYFReportTypes.statusCode;
    procedure SetStatusCode(const Value: TYFReportTypes.statusCode);

    function GetViewId: Int64;
    procedure SetViewId(const Value: Int64);

    function GetViewName: string;
    procedure SetViewName(const Value: string);

    function GetSourceId: Int64;
    procedure SetSourceId(const Value: Int64);

    function GetSourceName: string;
    procedure SetSourceName(const Value: string);

    function GetAccessTypeCode: string;
    procedure SetAccessTypeCode(const Value: string);

    function GetUpdatedDate: TDateTime;
    procedure SetUpdatedDate(const Value: TDateTime);

    function GetFormattedUpdatedDate: string;
    procedure SetFormattedUpdatedDate(const Value: string);

    function GetCreatorId: Int64;
    procedure SetCreatorId(const Value: Int64);

    function GetCreatorName: string;
    procedure SetCreatorName(const Value: string);

    function GetLastUpdaterId: Int64;
    procedure SetLastUpdaterId(const Value: Int64);

    function GetLastUpdaterName: string;
    procedure SetLastUpdaterName(const Value: string);

    function GetIsFavouritedByUser: Boolean;
    procedure SetIsFavouritedByUser(const Value: Boolean);

    function GetCommentCount: Int64;
    procedure SetCommentCount(const Value: Int64);

    function GetPublishedDate: TDateTime;
    function GetFormattedPublishedDate: string;

    procedure SetPublishedDate(const Value: TDateTime);
    procedure SetFormattedPublishedDate(const Value: string);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject); virtual;

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
    property UpdatedDate: TDateTime read GetUpdatedDate write SetUpdatedDate;
    property FormattedUpdatedDate: string read GetFormattedUpdatedDate write SetFormattedUpdatedDate;
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;
    property FormattedPublishedDate: string read GetFormattedPublishedDate write SetFormattedPublishedDate;
    property CreatorId: Int64 read GetCreatorId write SetCreatorId;
    property CreatorName: string read GetCreatorName write SetCreatorName;
    property LastUpdaterId: Int64 read GetLastUpdaterId write SetLastUpdaterId;
    property LastUpdaterName: string read GetLastUpdaterName write SetLastUpdaterName;
    property IsFavouritedByUser : Boolean read GetIsFavouritedByUser write SetIsFavouritedByUser;
    property CommentCount: Int64 read GetCommentCount write SetCommentCount;
  end;

  TYFReportListItems = class(TYFModelList<IYFReportListItemModel>, IYFReportListItems)
    constructor Create; overload;
  end;

implementation

uses yellowfinbi.api.classfactory;

{ TYFReportListItemModel }


procedure TYFReportListItemModel.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON.TryGetValue('reportId', jv) then
    ReportId := jv.Value.ToInt64;

  if AJSON.TryGetValue('reportPublishUUID', jv) then
    ReportPublishUUID := jv.Value;

  if AJSON.TryGetValue('name', jv) then
    Name := jv.Value;

  if AJSON.TryGetValue('description', jv) then
    Description := jv.Value;

  if AJSON.TryGetValue('categoryCode', jv) then
    CategoryCode := jv.Value;

  if AJSON.TryGetValue('categoryName', jv) then
    CategoryName := jv.Value;

  if AJSON.TryGetValue('subCategoryCode', jv) then
    SubCategoryCode := jv.Value;

  if AJSON.TryGetValue('subCategoryName', jv) then
    SubCategoryName := jv.Value;

  if AJSON.TryGetValue('statusCode', jv) then
    StatusCode := TYFTypes.GetValue<TYFReportTypes.statusCode>(jv.Value, TYFReportTypes.statusCode.DRAFT);

  if AJSON.TryGetValue('viewId', jv) then
    ViewId := jv.Value.ToInt64;

  if AJSON.TryGetValue('viewName', jv) then
    ViewName := jv.Value;

  if AJSON.TryGetValue('sourceId', jv) then
    SourceId := jv.Value.ToInt64;

  if AJSON.TryGetValue('sourceName', jv) then
    SourceName := jv.Value;

  if AJSON.TryGetValue('accessTypeCode', jv) then
    AccessTypeCode := jv.Value;

  if AJSON.TryGetValue('updatedDate', jv) then
    UpdatedDate := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedUpdatedDate', jv) then
    FormattedUpdatedDate := jv.Value;

  if AJSON.TryGetValue('publishedDate', jv) then
    PublishedDate := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedPublishedDate', jv) then
    FormattedPublishedDate := jv.Value;

  if AJSON.TryGetValue('creatorId', jv) then
    CreatorId := jv.Value.ToInt64;

  if AJSON.TryGetValue('creatorName', jv) then
    CreatorName := jv.Value;

  if AJSON.TryGetValue('lastUpdaterId', jv) then
    LastUpdaterId := jv.Value.ToInt64;

  if AJSON.TryGetValue('lastUpdaterName', jv) then
    LastUpdaterName := jv.Value;

  if AJSON.TryGetValue('commentCount', jv) then
    CommentCount := jv.Value.ToInt64;

  if AJSON.TryGetValue('isFavouritedByUser', jv) then
    IsFavouritedByUser := JSONToBool(jv, False);
end;



function TYFReportListItemModel.GetReportId: Int64;
begin
  Result := FReportId;
end;

procedure TYFReportListItemModel.SetReportId(const Value: Int64);
begin
  FReportId := Value;
end;

function TYFReportListItemModel.GetReportPublishUUID: string;
begin
  Result := FReportPublishUUID;
end;

procedure TYFReportListItemModel.SetReportPublishUUID(const Value: string);
begin
  FReportPublishUUID := Value;
end;

function TYFReportListItemModel.GetName: string;
begin
  Result := FName;
end;

function TYFReportListItemModel.GetPublishedDate: TDateTime;
begin
  Result := FPublishedDate;
end;

procedure TYFReportListItemModel.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TYFReportListItemModel.SetPublishedDate(const Value: TDateTime);
begin
  FPublishedDate := Value;
end;

function TYFReportListItemModel.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TYFReportListItemModel.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TYFReportListItemModel.GetCategoryCode: string;
begin
  Result := FCategoryCode;
end;

procedure TYFReportListItemModel.SetCategoryCode(const Value: string);
begin
  FCategoryCode := Value;
end;

function TYFReportListItemModel.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

function TYFReportListItemModel.GetCommentCount: Int64;
begin
  Result := FCommentCount;
end;

procedure TYFReportListItemModel.SetCategoryName(const Value: string);
begin
  FCategoryName := Value;
end;

procedure TYFReportListItemModel.SetCommentCount(const Value: Int64);
begin
  FCommentCount := Value;
end;

function TYFReportListItemModel.GetSubCategoryCode: string;
begin
  Result := FSubCategoryCode;
end;

procedure TYFReportListItemModel.SetSubCategoryCode(const Value: string);
begin
  FSubCategoryCode := Value;
end;

function TYFReportListItemModel.GetSubCategoryName: string;
begin
  Result := FSubCategoryName;
end;

procedure TYFReportListItemModel.SetSubCategoryName(const Value: string);
begin
  FSubCategoryName := Value;
end;

function TYFReportListItemModel.GetStatusCode: TYFReportTypes.statusCode;
begin
  Result := FStatusCode;
end;

procedure TYFReportListItemModel.SetStatusCode(const Value: TYFReportTypes.statusCode);
begin
  FStatusCode := Value;
end;

function TYFReportListItemModel.GetViewId: Int64;
begin
  Result := FViewId;
end;

procedure TYFReportListItemModel.SetViewId(const Value: Int64);
begin
  FViewId := Value;
end;

function TYFReportListItemModel.GetViewName: string;
begin
  Result := FViewName;
end;

procedure TYFReportListItemModel.SetViewName(const Value: string);
begin
  FViewName := Value;
end;

function TYFReportListItemModel.GetSourceId: Int64;
begin
  Result := FSourceId;
end;

procedure TYFReportListItemModel.SetSourceId(const Value: Int64);
begin
  FSourceId := Value;
end;

function TYFReportListItemModel.GetSourceName: string;
begin
  Result := FSourceName;
end;

procedure TYFReportListItemModel.SetSourceName(const Value: string);
begin
  FSourceName := Value;
end;

function TYFReportListItemModel.GetAccessTypeCode: string;
begin
  Result := FAccessTypeCode;
end;

procedure TYFReportListItemModel.SetAccessTypeCode(const Value: string);
begin
  FAccessTypeCode := Value;
end;

function TYFReportListItemModel.GetUpdatedDate: TDateTime;
begin
  Result := FUpdatedDate;
end;

procedure TYFReportListItemModel.SetUpdatedDate(const Value: TDateTime);
begin
  FUpdatedDate := Value;
end;

function TYFReportListItemModel.GetFormattedPublishedDate: string;
begin
  Result := FFormattedPublishedDate;
end;

function TYFReportListItemModel.GetFormattedUpdatedDate: string;
begin
  Result := FFormattedUpdatedDate;
end;

function TYFReportListItemModel.GetIsFavouritedByUser: Boolean;
begin
  Result := FIsFavouritedByUser
end;

procedure TYFReportListItemModel.SetFormattedPublishedDate(const Value: string);
begin
  FFormattedPublishedDate := Value;
end;

procedure TYFReportListItemModel.SetFormattedUpdatedDate(const Value: string);
begin
  FFormattedUpdatedDate := Value;
end;

procedure TYFReportListItemModel.SetIsFavouritedByUser(const Value: Boolean);
begin
  FIsFavouritedByUser := Value;
end;

function TYFReportListItemModel.GetCreatorId: Int64;
begin
  Result := FCreatorId;
end;

procedure TYFReportListItemModel.SetCreatorId(const Value: Int64);
begin
  FCreatorId := Value;
end;

function TYFReportListItemModel.GetCreatorName: string;
begin
  Result := FCreatorName;
end;

procedure TYFReportListItemModel.SetCreatorName(const Value: string);
begin
  FCreatorName := Value;
end;

function TYFReportListItemModel.GetLastUpdaterId: Int64;
begin
  Result := FLastUpdaterId;
end;

procedure TYFReportListItemModel.SetLastUpdaterId(const Value: Int64);
begin
  FLastUpdaterId := Value;
end;

function TYFReportListItemModel.GetLastUpdaterName: string;
begin
  Result := FLastUpdaterName;
end;

procedure TYFReportListItemModel.SetLastUpdaterName(const Value: string);
begin
  FLastUpdaterName := Value;
end;

{ TYFReportListItems }

constructor TYFReportListItems.Create;
begin
  inherited Create('items');
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFReportListItemModel>(
    function: IYFReportListItemModel
    begin
      Result := TYFReportListItemModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFReportListItems>(
    function: IYFReportListItems
    begin
      Result := TYFReportListItems.Create;
    end
  );


end.
