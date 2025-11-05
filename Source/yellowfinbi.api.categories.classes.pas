unit yellowfinbi.api.categories.classes;

interface

uses System.JSON, System.SysUtils, System.Generics.Collections,
  yellowfinbi.api.JSON, Yellowfinbi.api.JSON.generics,
  yellowfinbi.api.categories.intf;

type
  TYFSimpleCategoryModel = class(TInterfacedObject, IYFSimpleCategoryModel)
  private
    FCategoryName: string;
    FCategoryDescription: string;
    FCategoryUUID: string;
    FParentCategoryUUID: string;

    function GetCategoryName: string;
    procedure SetCategoryName(const AValue: string);

    function GetCategoryDescription: string;
    procedure SetCategoryDescription(const AValue: string);

    function GetCategoryUUID: string;
    procedure SetCategoryUUID(const AValue: string);

    function GetParentCategoryUUID: string;
    procedure SetParentCategoryUUID(const AValue: string);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);
    /// <summary>
    /// The name of the category.
    /// </summary>
    property CategoryName: string read GetCategoryName write SetCategoryName;

    /// <summary>
    /// A description of the category.
    /// </summary>
    property CategoryDescription: string read GetCategoryDescription write SetCategoryDescription;

    /// <summary>
    /// The unique UUID of the category.
    /// </summary>
    property CategoryUUID: string read GetCategoryUUID write SetCategoryUUID;

    /// <summary>
    /// The UUID of the parent category (only applies to subcategories).
    /// </summary>
    property ParentCategoryUUID: string read GetParentCategoryUUID write SetParentCategoryUUID;
  end;


  TYFSimpleCategoryModelList = class(TYFModelList<IYFSimpleCategoryModel>, IYFSimpleCategoryModelList)
  private
    FParentCategories : TList<IYFSimpleCategoryModel>;
    function GetParentCategories: TList<IYFSimpleCategoryModel>;
    function GetChildCategories(const aParentCategoryUUID: string): TArray<IYFSimpleCategoryModel>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromJSON(const AJSON: TJSONObject); override;

    /// <summary>
    /// List of top-level (parent) categories.
    /// </summary>
    property ParentCategories: TList<IYFSimpleCategoryModel> read GetParentCategories;

    /// <summary>
    /// Array of child categories for a given parent UUID.
    /// </summary>
    property ChildCategories[const ParentCategoryUUID: string]: TArray<IYFSimpleCategoryModel> read GetChildCategories;
  end;


  /// <summary>
  /// User/group access entry for categories.
  /// </summary>
  TYFUsersAccess = class(TInterfacedObject, IYFUsersAccess)
  private
    FAccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess;
    FSubjectId: string;
    FSubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType;
    FSubjectName: string;

    function GetAccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess;
    procedure SetAccessLevel(const Value: TYFCategoriesTypes.CategoryUsersWithAccess);
    function GetSubjectId: string;
    procedure SetSubjectId(const Value: string);
    function GetSubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType;
    procedure SetSubjectType(const Value: TYFCategoriesTypes.CategoryAccessLevelSubjectType);
    function GetSubjectName: string;
    procedure SetSubjectName(const Value: string);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);
    function ToJSON: string;
    function AsJSON: TJSONValue;

    property AccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess read GetAccessLevel write SetAccessLevel;
    property SubjectId: string read GetSubjectId write SetSubjectId;
    property SubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType read GetSubjectType write SetSubjectType;
    property SubjectName: string read GetSubjectName write SetSubjectName;
  end;


  /// <summary>
  /// Class representing Yellowfin Category - Implements IYFCategory.
  /// </summary>
  TYFCategory = class(TInterfacedObject, IYFCategory)
  private
    FCategoryUUID: string;
    FCategoryOrgId: Int64;
    FCategoryName: string;
    FCategoryDescription: string;
    FParentCategoryUUID: string;
    FVersionHistoryType: TYFCategoriesTypes.CategoryVersionHistoryType;
    FContentMaxSize: Int64;
    FMaxHistoricalVersions: Int64;
    FMaxContentAge: Int64;
    FMaxContentAgeUnit: TYFCategoriesTypes.CategoryMaxContentAgeUnit;
    FSortOrder: Int64;
    FApprovalRequired: Boolean;
    FApproverId: Int64;
    FDraftDefaultCategory: Boolean;
    FViewDefaultCategory: Boolean;
    FCategoryAccessLevel: TYFCategoriesTypes.CategoryAccessLevel;
    FUsersWithAccess: IYFModelList<IYFUsersAccess>;

    function GetCategoryUUID: string;
    procedure SetCategoryUUID(const Value: string);

    function GetCategoryOrgId: Int64;
    procedure SetCategoryOrgId(const Value: Int64);

    function GetCategoryName: string;
    procedure SetCategoryName(const Value: string);

    function GetCategoryDescription: string;
    procedure SetCategoryDescription(const Value: string);

    function GetParentCategoryUUID: string;
    procedure SetParentCategoryUUID(const Value: string);

    function GetVersionHistoryType: TYFCategoriesTypes.CategoryVersionHistoryType;
    procedure SetVersionHistoryType(const Value: TYFCategoriesTypes.CategoryVersionHistoryType);

    function GetContentMaxSize: Int64;
    procedure SetContentMaxSize(const Value: Int64);

    function GetMaxHistoricalVersions: Int64;
    procedure SetMaxHistoricalVersions(const Value: Int64);

    function GetMaxContentAge: Int64;
    procedure SetMaxContentAge(const Value: Int64);

    function GetMaxContentAgeUnit: TYFCategoriesTypes.CategoryMaxContentAgeUnit;
    procedure SetMaxContentAgeUnit(const Value: TYFCategoriesTypes.CategoryMaxContentAgeUnit);

    function GetSortOrder: Int64;
    procedure SetSortOrder(const Value: Int64);

    function GetApprovalRequired: Boolean;
    procedure SetApprovalRequired(const Value: Boolean);

    function GetApproverId: Int64;
    procedure SetApproverId(const Value: Int64);

    function GetDraftDefaultCategory: Boolean;
    procedure SetDraftDefaultCategory(const Value: Boolean);

    function GetViewDefaultCategory: Boolean;
    procedure SetViewDefaultCategory(const Value: Boolean);

    function GetCategoryAccessLevel: TYFCategoriesTypes.CategoryAccessLevel;
    procedure SetCategoryAccessLevel(const Value: TYFCategoriesTypes.CategoryAccessLevel);

    function GetUsersWithAccess: IYFModelList<IYFUsersAccess>;
    procedure SetUsersWithAccess(const Value: IYFModelList<IYFUsersAccess>);
  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromJSON(const AJSON: TJSONObject);
    function ToJSON: string;
    function AsJSON: TJSONValue;

    property CategoryUUID: string read GetCategoryUUID write SetCategoryUUID;
    property CategoryOrgId: Int64 read GetCategoryOrgId write SetCategoryOrgId;
    property CategoryName: string read GetCategoryName write SetCategoryName;
    property CategoryDescription: string read GetCategoryDescription write SetCategoryDescription;
    property ParentCategoryUUID: string read GetParentCategoryUUID write SetParentCategoryUUID;
    property VersionHistoryType: TYFCategoriesTypes.CategoryVersionHistoryType read GetVersionHistoryType write SetVersionHistoryType;
    property ContentMaxSize: Int64 read GetContentMaxSize write SetContentMaxSize;
    property MaxHistoricalVersions: Int64 read GetMaxHistoricalVersions write SetMaxHistoricalVersions;
    property MaxContentAge: Int64 read GetMaxContentAge write SetMaxContentAge;
    property MaxContentAgeUnit: TYFCategoriesTypes.CategoryMaxContentAgeUnit read GetMaxContentAgeUnit write SetMaxContentAgeUnit;
    property SortOrder: Int64 read GetSortOrder write SetSortOrder;
    property ApprovalRequired: Boolean read GetApprovalRequired write SetApprovalRequired;
    property ApproverId: Int64 read GetApproverId write SetApproverId;
    property DraftDefaultCategory: Boolean read GetDraftDefaultCategory write SetDraftDefaultCategory;
    property ViewDefaultCategory: Boolean read GetViewDefaultCategory write SetViewDefaultCategory;
    property CategoryAccessLevel: TYFCategoriesTypes.CategoryAccessLevel read GetCategoryAccessLevel write SetCategoryAccessLevel;
    property UsersWithAccess: IYFModelList<IYFUsersAccess> read GetUsersWithAccess write SetUsersWithAccess;
  end;

implementation

uses  yellowfinbi.api.classfactory;


{ TYFCategory }

function TYFCategory.AsJSON: TJSONValue;
begin
  var JSON := TJSONObject.Create;

  JSON.AddPair('categoryUUID', CategoryUUID);
  JSON.AddPair('categoryOrgId', TJSONNumber.Create(CategoryOrgId));
  JSON.AddPair('categoryName', CategoryName);
  JSON.AddPair('categoryDescription', CategoryDescription);
  JSON.AddPair('parentCategoryUUID', ParentCategoryUUID);
  JSON.AddPair('versionHistoryType', TYFCategoriesTypes.ValueToString<TYFCategoriesTypes.CategoryVersionHistoryType>(VersionHistoryType));
  JSON.AddPair('contentMaxSize', TJSONNumber.Create(ContentMaxSize));
  JSON.AddPair('maxHistoricalVersions', TJSONNumber.Create(MaxHistoricalVersions));
  JSON.AddPair('maxContentAge', TJSONNumber.Create(MaxContentAge));
  JSON.AddPair('maxContentAgeUnit', TYFCategoriesTypes.ValueToString<TYFCategoriesTypes.CategoryMaxContentAgeUnit>(MaxContentAgeUnit));
  JSON.AddPair('sortOrder', TJSONNumber.Create(SortOrder));
  JSON.AddPair('approvalRequired', TJSONBool.Create(ApprovalRequired));
  JSON.AddPair('approverId', TJSONNumber.Create(ApproverId));
  JSON.AddPair('draftDefaultCategory', TJSONBool.Create(DraftDefaultCategory));
  JSON.AddPair('viewDefaultCategory', TJSONBool.Create(ViewDefaultCategory));
  JSON.AddPair('categoryAccessLevel', TYFCategoriesTypes.ValueToString<TYFCategoriesTypes.CategoryAccessLevel>(CategoryAccessLevel));

  // Users with access
  var UsersArray := TJSONArray.Create;
  try
    if UsersWithAccess.Items.Count > 0 then
    begin
      for var CurrUserAccess in UsersWithAccess.Items do
        UsersArray.AddElement(CurrUserAccess.AsJSON);
      JSON.AddPair('usersWithAccess', UsersArray);
    end;
  finally
    UsersArray.Free;
  end;

  Result := JSON;
end;

constructor TYFCategory.Create;
begin
  inherited Create;
  FUsersWithAccess := TYFModelList<IYFUsersAccess>.Create('usersWithAccess');
end;

destructor TYFCategory.Destroy;
begin
  inherited;
end;

procedure TYFCategory.LoadFromJSON(const AJSON: TJSONObject);
var
  V: TJSONValue;
begin
  if AJSON = nil then Exit;

  try
    if AJSON.TryGetValue('categoryUUID', V) then
      CategoryUUID := V.Value;

    if AJSON.TryGetValue('categoryOrgId', V) then
      CategoryOrgId := StrToInt64Def(V.Value, 0);

    if AJSON.TryGetValue('categoryName', V) then
      CategoryName := V.Value;

    if AJSON.TryGetValue('categoryDescription', V) then
      CategoryDescription := V.Value;

    if AJSON.TryGetValue('parentCategoryUUID', V) then
      ParentCategoryUUID := V.Value;

    if AJSON.TryGetValue('versionHistoryType', V) then
      VersionHistoryType := TYFCategoriesTypes.GetValue<TYFCategoriesTypes.CategoryVersionHistoryType>(
        V.Value, TYFCategoriesTypes.CategoryVersionHistoryType.LATEST);

    if AJSON.TryGetValue('contentMaxSize', V) then
      ContentMaxSize := StrToInt64Def(V.Value, 1000);

    if AJSON.TryGetValue('maxHistoricalVersions', V) then
      MaxHistoricalVersions := StrToInt64Def(V.Value, 20);

    if AJSON.TryGetValue('maxContentAge', V) then
      MaxContentAge := StrToInt64Def(V.Value, 5);

    if AJSON.TryGetValue('maxContentAgeUnit', V) then
      MaxContentAgeUnit := TYFCategoriesTypes.GetValue<TYFCategoriesTypes.CategoryMaxContentAgeUnit>(
        V.Value, TYFCategoriesTypes.CategoryMaxContentAgeUnit.YEAR);

    if AJSON.TryGetValue('sortOrder', V) then
      SortOrder := StrToInt64Def(V.Value, 0);

    if AJSON.TryGetValue('approvalRequired', V) then
      ApprovalRequired := SameText(V.Value, 'true');

    if AJSON.TryGetValue('approverId', V) then
      ApproverId := StrToInt64Def(V.Value, 0);

    if AJSON.TryGetValue('draftDefaultCategory', V) then
      DraftDefaultCategory := SameText(V.Value, 'true');

    if AJSON.TryGetValue('viewDefaultCategory', V) then
      ViewDefaultCategory := SameText(V.Value, 'true');

    if AJSON.TryGetValue('categoryAccessLevel', V) then
      CategoryAccessLevel := TYFCategoriesTypes.GetValue<TYFCategoriesTypes.CategoryAccessLevel>(
        V.Value, TYFCategoriesTypes.CategoryAccessLevel.PUBLIC);

    FUsersWithAccess.LoadFromJSON(AJSON);
  finally
    V := nil;
  end;
end;


function TYFCategory.GetCategoryUUID: string;
begin
  Result := FCategoryUUID;
end;

procedure TYFCategory.SetCategoryUUID(const Value: string);
begin
  FCategoryUUID := Value;
end;

function TYFCategory.GetCategoryOrgId: Int64;
begin
  Result := FCategoryOrgId;
end;

procedure TYFCategory.SetCategoryOrgId(const Value: Int64);
begin
  FCategoryOrgId := Value;
end;

function TYFCategory.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TYFCategory.SetCategoryName(const Value: string);
begin
  FCategoryName := Value;
end;

function TYFCategory.GetCategoryDescription: string;
begin
  Result := FCategoryDescription;
end;

procedure TYFCategory.SetCategoryDescription(const Value: string);
begin
  FCategoryDescription := Value;
end;

function TYFCategory.GetParentCategoryUUID: string;
begin
  Result := FParentCategoryUUID;
end;

procedure TYFCategory.SetParentCategoryUUID(const Value: string);
begin
  FParentCategoryUUID := Value;
end;

function TYFCategory.GetVersionHistoryType: TYFCategoriesTypes.CategoryVersionHistoryType;
begin
  Result := FVersionHistoryType;
end;

procedure TYFCategory.SetVersionHistoryType(const Value: TYFCategoriesTypes.CategoryVersionHistoryType);
begin
  FVersionHistoryType := Value;
end;

function TYFCategory.GetContentMaxSize: Int64;
begin
  Result := FContentMaxSize;
end;

procedure TYFCategory.SetContentMaxSize(const Value: Int64);
begin
  FContentMaxSize := Value;
end;

function TYFCategory.GetMaxHistoricalVersions: Int64;
begin
  Result := FMaxHistoricalVersions;
end;

procedure TYFCategory.SetMaxHistoricalVersions(const Value: Int64);
begin
  FMaxHistoricalVersions := Value;
end;

function TYFCategory.GetMaxContentAge: Int64;
begin
  Result := FMaxContentAge;
end;

procedure TYFCategory.SetMaxContentAge(const Value: Int64);
begin
  FMaxContentAge := Value;
end;

function TYFCategory.GetMaxContentAgeUnit: TYFCategoriesTypes.CategoryMaxContentAgeUnit;
begin
  Result := FMaxContentAgeUnit;
end;

procedure TYFCategory.SetMaxContentAgeUnit(const Value: TYFCategoriesTypes.CategoryMaxContentAgeUnit);
begin
  FMaxContentAgeUnit := Value;
end;

function TYFCategory.GetSortOrder: Int64;
begin
  Result := FSortOrder;
end;

procedure TYFCategory.SetSortOrder(const Value: Int64);
begin
  FSortOrder := Value;
end;

function TYFCategory.GetApprovalRequired: Boolean;
begin
  Result := FApprovalRequired;
end;

procedure TYFCategory.SetApprovalRequired(const Value: Boolean);
begin
  FApprovalRequired := Value;
end;

function TYFCategory.GetApproverId: Int64;
begin
  Result := FApproverId;
end;

procedure TYFCategory.SetApproverId(const Value: Int64);
begin
  FApproverId := Value;
end;

function TYFCategory.GetDraftDefaultCategory: Boolean;
begin
  Result := FDraftDefaultCategory;
end;

procedure TYFCategory.SetDraftDefaultCategory(const Value: Boolean);
begin
  FDraftDefaultCategory := Value;
end;

function TYFCategory.GetViewDefaultCategory: Boolean;
begin
  Result := FViewDefaultCategory;
end;

procedure TYFCategory.SetViewDefaultCategory(const Value: Boolean);
begin
  FViewDefaultCategory := Value;
end;

function TYFCategory.ToJSON: string;
begin
  var JSON := Self.AsJSON;
  try
    Result := JSON.ToString;
  finally
    JSON.Free;
  end;
end;

function TYFCategory.GetCategoryAccessLevel: TYFCategoriesTypes.CategoryAccessLevel;
begin
  Result := FCategoryAccessLevel;
end;

procedure TYFCategory.SetCategoryAccessLevel(const Value: TYFCategoriesTypes.CategoryAccessLevel);
begin
  FCategoryAccessLevel := Value;
end;

function TYFCategory.GetUsersWithAccess: IYFModelList<IYFUsersAccess>;
begin
  Result := FUsersWithAccess;
end;

procedure TYFCategory.SetUsersWithAccess(const Value: IYFModelList<IYFUsersAccess>);
begin
  FUsersWithAccess := Value;
end;

{ TYFSimpleCategoryModel }

function TYFSimpleCategoryModel.GetCategoryName: string;
begin
  Result := FCategoryName;
end;

procedure TYFSimpleCategoryModel.SetCategoryName(const AValue: string);
begin
  FCategoryName := AValue;
end;

function TYFSimpleCategoryModel.GetCategoryDescription: string;
begin
  Result := FCategoryDescription;
end;

procedure TYFSimpleCategoryModel.SetCategoryDescription(const AValue: string);
begin
  FCategoryDescription := AValue;
end;

function TYFSimpleCategoryModel.GetCategoryUUID: string;
begin
  Result := FCategoryUUID;
end;

procedure TYFSimpleCategoryModel.SetCategoryUUID(const AValue: string);
begin
  FCategoryUUID := AValue;
end;

function TYFSimpleCategoryModel.GetParentCategoryUUID: string;
begin
  Result := FParentCategoryUUID;
end;

procedure TYFSimpleCategoryModel.LoadFromJSON(const AJSON: TJSONObject);
var
  jv: TJSONValue;
begin
  if AJSON.TryGetValue('categoryName', jv) then
    CategoryName := jv.Value;

  if AJSON.TryGetValue('categoryDescription', jv) then
    CategoryDescription := jv.Value;

  if AJSON.TryGetValue('categoryUUID', jv) then
    CategoryUUID := jv.Value;

  if AJSON.TryGetValue('parentCategoryUUID', jv) then
    ParentCategoryUUID := jv.Value
  else
    ParentCategoryUUID := '';

end;

procedure TYFSimpleCategoryModel.SetParentCategoryUUID(const AValue: string);
begin
  FParentCategoryUUID := AValue;
end;

{ TYFSimpleCategoryModelList }

constructor TYFSimpleCategoryModelList.Create;
begin
  inherited Create(nil, 'items');
  FParentCategories := TList<IYFSimpleCategoryModel>.Create;
end;

destructor TYFSimpleCategoryModelList.Destroy;
begin
  FParentCategories.Free;
  inherited;
end;

function TYFSimpleCategoryModelList.GetChildCategories(
  const aParentCategoryUUID: string): TArray<IYFSimpleCategoryModel>;
begin
  SetLength(Result , 0);

  if aParentCategoryUUID = '' then
    Exit;

  for var Obj in Self.Items do
  begin
    if Obj.ParentCategoryUUID = aParentCategoryUUID  then
    begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := Obj;
    end;
  end;

end;

function TYFSimpleCategoryModelList.GetParentCategories: TList<IYFSimpleCategoryModel>;
begin
  Result := FParentCategories;
end;

procedure TYFSimpleCategoryModelList.LoadFromJSON(const AJSON: TJSONObject);
begin
  FParentCategories.Clear;

  inherited LoadFromJSON(AJSON);

  // Populate the Parent Categories from the list.

  for var Obj in Self.Items do
  begin
    if Obj.ParentCategoryUUID = ''  then
      FParentCategories.Add(Obj);
  end;

end;

{ TYFUsersAccess }

function TYFUsersAccess.AsJSON: TJSONValue;
begin
  var JSON := TJSONObject.Create;

  JSON.AddPair('accessLevel', TYFCategoriesTypes.ValueToString<TYFCategoriesTypes.CategoryUsersWithAccess>(AccessLevel));
  JSON.AddPair('subjectId', SubjectId);
  JSON.AddPair('subjectType', TYFCategoriesTypes.ValueToString<TYFCategoriesTypes.CategoryAccessLevelSubjectType>(SubjectType));
  JSON.AddPair('subjectName', SubjectName);

  Result := JSON;
end;

function TYFUsersAccess.GetAccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess;
begin
  Result := FAccessLevel;
end;

procedure TYFUsersAccess.SetAccessLevel(const Value: TYFCategoriesTypes.CategoryUsersWithAccess);
begin
  FAccessLevel := Value;
end;

function TYFUsersAccess.GetSubjectId: string;
begin
  Result := FSubjectId;
end;

procedure TYFUsersAccess.SetSubjectId(const Value: string);
begin
  FSubjectId := Value;
end;

function TYFUsersAccess.GetSubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType;
begin
  Result := FSubjectType;
end;

procedure TYFUsersAccess.SetSubjectType(const Value: TYFCategoriesTypes.CategoryAccessLevelSubjectType);
begin
  FSubjectType := Value;
end;

function TYFUsersAccess.ToJSON: string;
begin
  var AJSON := Self.AsJSON;
  try
    Result := AJSON.ToString;
  finally
    AJSON.Free;
  end;
end;

function TYFUsersAccess.GetSubjectName: string;
begin
  Result := FSubjectName;
end;

procedure TYFUsersAccess.SetSubjectName(const Value: string);
begin
  FSubjectName := Value;
end;

procedure TYFUsersAccess.LoadFromJSON(const AJSON: TJSONObject);
var
  V: TJSONValue;
begin
  if AJSON = nil then
    Exit;

  if AJSON.TryGetValue('accessLevel', V) then
    AccessLevel := TYFCategoriesTypes.GetValue<TYFCategoriesTypes.CategoryUsersWithAccess>(V.Value, TYFCategoriesTypes.CategoryUsersWithAccess.READ);

  if AJSON.TryGetValue('subjectId', V) then
    SubjectId := V.Value;

  if AJSON.TryGetValue('subjectType', V) then
    SubjectType := TYFCategoriesTypes.GetValue<TYFCategoriesTypes.CategoryAccessLevelSubjectType>(V.Value, TYFCategoriesTypes.CategoryAccessLevelSubjectType.PERSON);

  if AJSON.TryGetValue('subjectName', V) then
    SubjectName := V.Value;

end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFSimpleCategoryModel>(
    function: IYFSimpleCategoryModel
    begin
      Result := TYFSimpleCategoryModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFSimpleCategoryModelList>(
    function: IYFSimpleCategoryModelList
    begin
      Result := TYFSimpleCategoryModelList.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFCategory>(
    function: IYFCategory
    begin
      Result := TYFCategory.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUsersAccess>(
    function: IYFUsersAccess
    begin
      Result := TYFUsersAccess.Create;
    end
  );
end.
