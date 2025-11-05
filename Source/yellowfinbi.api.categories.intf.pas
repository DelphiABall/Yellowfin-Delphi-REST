unit yellowfinbi.api.categories.intf;

interface

uses System.Generics.Collections, yellowfinbi.api.common,
  yellowfinbi.api.JSON, yellowfinbi.api.JSON.generics;

type
  TYFCategoriesTypes = class(TYFTypes)
  type
    {$SCOPEDENUMS ON}
    CategoryVersionHistoryType = (LATEST, CUSTOM);
    CategoryMaxContentAgeUnit =(DAY, WEEK, FORTNIGHT, MONTH, YEAR);
    CategoryAccessLevel = (&PRIVATE, &PUBLIC, UNSECURE);
    CategoryUsersWithAccess = (READ, UPDATE, DELETE);
    CategoryAccessLevelSubjectType = (PERSON, GROUP);
    {$SCOPEDENUMS OFF}
  end;

  /// <summary>
  /// Represents a simple category model with name, description, and UUID information.
  /// </summary>
  IYFSimpleCategoryModel = interface(IYFLoadFromJSON)
    ['{6C6B73B3-66DA-4E2A-AE42-6D4E33E3F961}']

    function GetCategoryName: string;
    procedure SetCategoryName(const AValue: string);

    function GetCategoryDescription: string;
    procedure SetCategoryDescription(const AValue: string);

    function GetCategoryUUID: string;
    procedure SetCategoryUUID(const AValue: string);

    function GetParentCategoryUUID: string;
    procedure SetParentCategoryUUID(const AValue: string);

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


  IYFSimpleCategoryModelList = interface(IYFModelList<IYFSimpleCategoryModel>)
    ['{8A97C120-A3D5-4046-9597-7035829C4BAE}']

    function GetParentCategories: TList<IYFSimpleCategoryModel>;
    function GetChildCategories(const ParentCategoryUUID: string): TArray<IYFSimpleCategoryModel>;

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
  /// Represents a user or group with access permissions to a category.
  /// </summary>
  IYFUsersAccess = interface(IYFJSON)
    ['{76F04B5E-0805-4B94-B2AF-44DF9E54AE1F}']
    function GetAccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess;
    procedure SetAccessLevel(const Value: TYFCategoriesTypes.CategoryUsersWithAccess);
    function GetSubjectId: string;
    procedure SetSubjectId(const Value: string);
    function GetSubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType;
    procedure SetSubjectType(const Value: TYFCategoriesTypes.CategoryAccessLevelSubjectType);
    function GetSubjectName: string;
    procedure SetSubjectName(const Value: string);

    /// <summary>
    /// Access level granted (READ, UPDATE, DELETE).
    /// At least one user must have DELETE access.
    /// </summary>
    property AccessLevel: TYFCategoriesTypes.CategoryUsersWithAccess read GetAccessLevel write SetAccessLevel;

    /// <summary>
    /// Unique identifier of the subject (user or group).
    /// </summary>
    property SubjectId: string read GetSubjectId write SetSubjectId;

    /// <summary>
    /// Type of the subject (e.g. PERSON, GROUP).
    /// </summary>
    property SubjectType: TYFCategoriesTypes.CategoryAccessLevelSubjectType read GetSubjectType write SetSubjectType;

    /// <summary>
    /// Display name of the subject.
    /// </summary>
    property SubjectName: string read GetSubjectName write SetSubjectName;
  end;


  IYFCategoryPatch = interface(IYFJSON)
    ['{2DF64AF4-29D3-43CE-9620-33CE8D73E832}']
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

    /// <summary>
    /// Organisation ID for the category.
    /// </summary>
    property CategoryOrgId: Int64 read GetCategoryOrgId write SetCategoryOrgId;
    /// <summary>
    /// Name of the category.
    /// </summary>
    property CategoryName: string read GetCategoryName write SetCategoryName;
    /// <summary>
    /// Description of the category.
    /// </summary>
    property CategoryDescription: string read GetCategoryDescription write SetCategoryDescription;
    /// <summary>
    /// UUID of parent category, if this is a subcategory.
    /// </summary>
    property ParentCategoryUUID: string read GetParentCategoryUUID write SetParentCategoryUUID;
    /// <summary>
    /// Versioning strategy (LATEST = default, CUSTOM requires extra limits).
    /// </summary>
    property VersionHistoryType: TYFCategoriesTypes.CategoryVersionHistoryType read GetVersionHistoryType write SetVersionHistoryType;
    /// <summary>
    /// Maximum content size in KB (default 1000, only if CUSTOM).
    /// </summary>
    property ContentMaxSize: Int64 read GetContentMaxSize write SetContentMaxSize;
    /// <summary>
    /// Maximum number of historical versions (default 20, only if CUSTOM).
    /// </summary>
    property MaxHistoricalVersions: Int64 read GetMaxHistoricalVersions write SetMaxHistoricalVersions;
    /// <summary>
    /// Maximum content age before deletion (default 5, only if CUSTOM).
    /// </summary>
    property MaxContentAge: Int64 read GetMaxContentAge write SetMaxContentAge;
    /// <summary>
    /// Unit of content age (DAY, WEEK, etc.). Default YEAR.
    /// </summary>
    property MaxContentAgeUnit: TYFCategoriesTypes.CategoryMaxContentAgeUnit read GetMaxContentAgeUnit write SetMaxContentAgeUnit;
    /// <summary>
    /// Sorting order (lowest to highest).
    /// </summary>
    property SortOrder: Int64 read GetSortOrder write SetSortOrder;
    /// <summary>
    /// True if content requires approval (default false).
    /// </summary>
    property ApprovalRequired: Boolean read GetApprovalRequired write SetApprovalRequired;
    /// <summary>
    /// ID of user/group approver (only if ApprovalRequired = true).
    /// </summary>
    property ApproverId: Int64 read GetApproverId write SetApproverId;
    /// <summary>
    /// True if this is the default draft category (default false).
    /// </summary>
    property DraftDefaultCategory: Boolean read GetDraftDefaultCategory write SetDraftDefaultCategory;
    /// <summary>
    /// True if this is the default view category (default false).
    /// </summary>
    property ViewDefaultCategory: Boolean read GetViewDefaultCategory write SetViewDefaultCategory;
     /// <summary>
    /// Access level (PRIVATE requires usersWithAccess, default PUBLIC).
    /// </summary>
   property CategoryAccessLevel: TYFCategoriesTypes.CategoryAccessLevel read GetCategoryAccessLevel write SetCategoryAccessLevel;
    /// <summary>
    /// Users/groups with explicit access (required if PRIVATE).
    /// </summary>
    property UsersWithAccess: IYFModelList<IYFUsersAccess> read GetUsersWithAccess write SetUsersWithAccess;
  end;

  /// <summary>
  /// Represents a Category in Yellowfin, including settings and access control.
  /// </summary>
  IYFCategory = interface(IYFCategoryPatch)
    function GetCategoryUUID: string;
    procedure SetCategoryUUID(const Value: string);
    /// <summary>
    /// Unique identifier of the category.
    /// </summary>
    property CategoryUUID: string read GetCategoryUUID write SetCategoryUUID;
  end;


implementation

end.
