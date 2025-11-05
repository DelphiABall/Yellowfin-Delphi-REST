unit yellowfinbi.api.dashboards.classes;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, Yellowfinbi.api.JSON.generics,
  yellowfinbi.api.dashboards.intf,
  yellowfinbi.api.reports.classes;

type
  TYFDashboard = class(TInterfacedObject, IYFDashboardListItemModel)
  private
    FDashboardId: Int64;
    FDashboardPublishUUID: string;
    FName: string;
    FDescription: string;
    FCategoryCode: string;
    FCategoryName: string;
    FSubCategoryCode: string;
    FSubCategoryName: string;
    FStatusCode: string;
    FLastModifiedDateTime: TDateTime;
    FFormattedLastModifiedDateTime: string;
    FPublishedDateTime: TDateTime;
    FFormattedPublishedDateTime: string;
    FCreatorId: Int64;
    FCreatorName: string;
    FLastModifierId: Int64;
    FLastModifierName: string;
    FIsFavouritedByUser: Boolean;
    FFavouriteSequenceNumber: Integer;

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
  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

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

  /// <summary>
  ///   List of Yellowfin Dashboards, default implementation of IYFdashboards
  /// </summary>
  TYFDashboardsList = class(TYFModelList<IYFDashboardListItemModel>, IYFDashboardsList)
    constructor Create; overload;
  end;

  TYFDashboardReportModel = class(TYFReportListItemModel, IYFDashboardReportModel)
  private
    FTabID : Int64;
    FEntityUUID: string;
    FDefaultDisplay: TYFDashboardTypes.DefaultDisplay;

    function GetTabID : Int64;
    function GetEntityUUID: string;
    function GetDefaultDisplay: TYFDashboardTypes.DefaultDisplay;

  public
    procedure LoadFromJSON(const AJSON: TJSONObject); override;

    property tabId: Int64 read GetTabID;
    property entityUUID: string read GetEntityUUID;
    property defaultDisplay: TYFDashboardTypes.DefaultDisplay read GetDefaultDisplay;
  end;

  TYFDashboardReportList = class(TYFModelList<IYFDashboardReportModel>, IYFDashboardReportList)
    constructor Create; overload;
  end;

implementation

uses  yellowfinbi.api.classfactory;

{ TYFDashboard }

function TYFDashboard.GetCategoryCode: string;
begin
  Result := FCategoryCode;
end;

function TYFDashboard.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

function TYFDashboard.GetCreatorId: Int64;
begin
  Result := FCreatorId;
end;

function TYFDashboard.GetCreatorName: string;
begin
  Result := FCreatorName;
end;

function TYFDashboard.GetDashboardId: Int64;
begin
  Result := FDashboardId;
end;

function TYFDashboard.GetDashboardPublishUUID: string;
begin
  Result := FDashboardPublishUUID;
end;

function TYFDashboard.GetDescription: string;
begin
  Result := FDescription;
end;

function TYFDashboard.GetFavouriteSequenceNumber: Int64;
begin
  Result := FFavouriteSequenceNumber;
end;

function TYFDashboard.GetFormattedLastModifiedDateTime: string;
begin
  Result := FFormattedLastModifiedDateTime;
end;

function TYFDashboard.GetFormattedPublishedDateTime: string;
begin
  Result := FFormattedPublishedDateTime;
end;

function TYFDashboard.GetIsFavouritedByUser: Boolean;
begin
  Result := FIsFavouritedByUser;
end;

function TYFDashboard.GetLastModifiedDateTime: TDateTime;
begin
  Result := FLastModifiedDateTime;
end;

function TYFDashboard.GetLastModifierId: Int64;
begin
  Result := FLastModifierId;
end;

function TYFDashboard.GetLastModifierName: string;
begin
  Result := FLastModifierName;
end;

function TYFDashboard.GetName: string;
begin
  Result := FName;
end;

function TYFDashboard.GetPublishedDateTime: TDateTime;
begin
  Result := FPublishedDateTime;
end;

function TYFDashboard.GetStatusCode: string;
begin
  Result := FStatusCode;
end;

function TYFDashboard.GetSubCategoryCode: string;
begin
  Result := FSubCategoryCode;
end;

function TYFDashboard.GetSubCategoryName: string;
begin
  Result := FSubCategoryName;
end;

procedure TYFDashboard.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON = nil then
    Exit;

  if AJSON.TryGetValue('dashboardId', jv) then
    FDashboardId := StrToInt64Def(jv.Value, 0);

  if AJSON.TryGetValue('dashboardPublishUUID', jv) then
    FDashboardPublishUUID := jv.Value;

  if AJSON.TryGetValue('name', jv) then
    FName := jv.Value;

  if AJSON.TryGetValue('description', jv) then
    FDescription := jv.Value;

  if AJSON.TryGetValue('categoryCode', jv) then
    FCategoryCode := jv.Value;

  if AJSON.TryGetValue('categoryName', jv) then
    FCategoryName := jv.Value;

  if AJSON.TryGetValue('subCategoryCode', jv) then
    FSubCategoryCode := jv.Value;

  if AJSON.TryGetValue('subCategoryName', jv) then
    FSubCategoryName := jv.Value;

  if AJSON.TryGetValue('statusCode', jv) then
    FStatusCode := jv.Value;

  if AJSON.TryGetValue('lastModifiedDateTime', jv) then
    FLastModifiedDateTime := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedLastModifiedDateTime', jv) then
    FFormattedLastModifiedDateTime := jv.Value;

  if AJSON.TryGetValue('publishedDateTime', jv) then
    FPublishedDateTime := YFDateStrToTDateTime(jv.Value);

  if AJSON.TryGetValue('formattedPublishedDateTime', jv) then
    FFormattedPublishedDateTime := jv.Value;

  if AJSON.TryGetValue('creatorId', jv) then
    FCreatorId := StrToInt64Def(jv.Value, 0);

  if AJSON.TryGetValue('creatorName', jv) then
    FCreatorName := jv.Value;

  if AJSON.TryGetValue('lastModifierId', jv) then
    FLastModifierId := StrToInt64Def(jv.Value, 0);

  if AJSON.TryGetValue('lastModifierName', jv) then
    FLastModifierName := jv.Value;

  if AJSON.TryGetValue('isFavouritedByUser', jv) then
    FIsFavouritedByUser := JSONToBool(jv);

  if AJSON.TryGetValue('favouriteSequenceNumber', jv) then
    FFavouriteSequenceNumber := StrToIntDef(jv.Value, 0);
end;

{ TYFDashboardsList }

constructor TYFDashboardsList.Create;
begin
  inherited Create(nil, 'items');
end;


{ TYFDashboardReportModelList }

constructor TYFDashboardReportList.Create;
begin
  inherited Create(nil, 'items');
end;

{ TYFDashboardReportModel }

function TYFDashboardReportModel.GetDefaultDisplay: TYFDashboardTypes.DefaultDisplay;
begin
  Result := FDefaultDisplay;
end;

function TYFDashboardReportModel.GetEntityUUID: string;
begin
  Result := FEntityUUID;
end;

function TYFDashboardReportModel.GetTabID: Int64;
begin
  Result := FTabID;
end;

procedure TYFDashboardReportModel.LoadFromJSON(const AJSON: TJSONObject);
var
  jv : TJSONValue;
begin
  inherited;
  if AJSON.TryGetValue('tabId', jv) then
    FtabId := StrToInt64Def(jv.Value, 0);

  if AJSON.TryGetValue('entityUUID', jv) then
    FEntityUUID := jv.Value;


  if AJSON.TryGetValue('defaultDisplay', jv) then
    FDefaultDisplay := TYFDashboardTypes.GetValue<TYFDashboardTypes.DefaultDisplay>(
                    jv.Value,
                    TYFDashboardTypes.DefaultDisplay.CANVAS
                  )
  else
    FDefaultDisplay := TYFDashboardTypes.DefaultDisplay.CANVAS;

end;

initialization
   TYFFactoryRegistry.RegisterFactory<IYFDashboardListItemModel>(
    function: IYFDashboardListItemModel
    begin
      Result := TYFDashboard.Create;
    end
  );

   TYFFactoryRegistry.RegisterFactory<IYFDashboardsList>(
    function: IYFDashboardsList
    begin
      Result := TYFDashboardsList.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFDashboardReportModel>(
    function: IYFDashboardReportModel
    begin
      Result := TYFDashboardReportModel.Create;
    end
  );

   TYFFactoryRegistry.RegisterFactory<IYFDashboardReportList>(
    function: IYFDashboardReportList
    begin
      Result := TYFDashboardReportList.Create;
    end
  );
end.
