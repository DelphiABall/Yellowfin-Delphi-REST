unit yellowfinbi.api.users.intf;

interface

uses System.JSON, System.Generics.Collections, yellowfinbi.api.json,
  yellowfinbi.api.json.generics, yellowfinbi.api.common;

type
  TYFUserTypes = class(TYFTypes)
    type
      {$SCOPEDENUMS ON}
      userConnectionStatus = (NOT_CONNECTED, PENDING, CONNECTED);
      allowUsersToConnect = (REQUIREAPPROVAL, ALLOW);
      allowUsersToViewTimeline = (REQUIRECONNECTION, ALLOW);
      allowUsersToPostOnTimeline = (REQUIRECONNECTION, ALLOW);
      status = (ACTIVE, INACTIVE, INACTIVEWITHEMAIL);
      entryPage = (DASHBOARD, BROWSE, FAVOURITES, TIMELINE);
      {$SCOPEDENUMS OFF}
    public
  end;

  IYFUserID = interface
  ['{7D60FA94-6FD4-4C57-B6DA-7449F5432375}']
    function GetUserID: Int64;
    procedure SetUserID(const Value: Int64);

    property UserID: Int64 read GetUserID write SetUserID;
  end;

  IYFUserPreferences = interface(IYFLoadFromJSON)
  ['{15E77739-2F84-47EB-AC6E-D2CF605F767C}']
    function GetEntryPage: string;
    procedure SetEntryPage(const Value: string);

    function GetDraftContentItemCount: Integer;
    procedure SetDraftContentItemCount(const Value: Integer);

    function GetRecentContentItemCount: Integer;
    procedure SetRecentContentItemCount(const Value: Integer);

    function GetRetainContentTypeFilterOnBrowsePage: Boolean;
    procedure SetRetainContentTypeFilterOnBrowsePage(const Value: Boolean);

    function GetAllowUsersToConnect: TYFUserTypes.allowUsersToConnect;
    procedure SetAllowUsersToConnect(const Value: TYFUserTypes.allowUsersToConnect);

    function GetAllowUsersToViewTimeline: TYFUserTypes.allowUsersToViewTimeline;
    procedure SetAllowUsersToViewTimeline(const Value: TYFUserTypes.allowUsersToViewTimeline);

    function GetAllowUsersToPostOnTimeline: TYFUserTypes.allowUsersToPostOnTimeline;
    procedure SetAllowUsersToPostOnTimeline(const Value: TYFUserTypes.allowUsersToPostOnTimeline);

    procedure AddToJSON(ASON : TJSONObject);

    /// <summary>
    /// A Yellowfin Entry Page code. This must match a code that already exists in the system.
    /// </summary>
    property EntryPage: string read GetEntryPage write SetEntryPage;

    /// <summary>A user setting for restricting the number of draft content items visible.</summary>
    property DraftContentItemCount: Integer read GetDraftContentItemCount write SetDraftContentItemCount;

    /// <summary>A user setting for restricting the number of "recent" content items visible.</summary>
    property RecentContentItemCount: Integer read GetRecentContentItemCount write SetRecentContentItemCount;

    /// <summary>
    /// A user setting which indicates whether the content type filter should persist on the user's browse page.
    /// </summary>
    property RetainContentTypeFilterOnBrowsePage: Boolean read GetRetainContentTypeFilterOnBrowsePage write SetRetainContentTypeFilterOnBrowsePage;

    /// <summary>
    /// A setting which describes how other Yellowfin users can connect to this one.
    /// Enum: "REQUIREAPPROVAL", "ALLOW"
    /// </summary>
    property AllowUsersToConnect: TYFUserTypes.allowUsersToConnect read GetAllowUsersToConnect write SetAllowUsersToConnect;

    /// <summary>
    /// A setting which describes what other Yellowfin users can see on this user's Timeline.
    /// Enum: "REQUIRECONNECTION", "ALLOW"
    /// </summary>
    property AllowUsersToViewTimeline: TYFUserTypes.allowUsersToViewTimeline read GetAllowUsersToViewTimeline write SetAllowUsersToViewTimeline;

    /// <summary>
    /// A setting which describes whether other Yellowfin users can post on this user's Timeline.
    /// Enum: "REQUIRECONNECTION", "ALLOW"
    /// </summary>
    property AllowUsersToPostOnTimeline: TYFUserTypes.allowUsersToPostOnTimeline read GetAllowUsersToPostOnTimeline write SetAllowUsersToPostOnTimeline;
  end;

  /// <summary>
  /// Interface representing a Yellowfin user's profile and personalisation settings.
  /// </summary>
  IYFUserPatch = interface(IYFLoadFromJSON)
  ['{E49E48ED-B99D-42F0-AC1F-598D0AFCBB56}']
    function GetFirstName: string;
    procedure SetFirstName(const Value: string);

    function GetLastName: string;
    procedure SetLastName(const Value: string);

    function GetTitle: string;
    procedure SetTitle(const Value: string);

    function GetDescription: string;
    procedure SetDescription(const Value: string);

    function GetPreferredLanguageCode: string;
    procedure SetPreferredLanguageCode(const Value: string);

    function GetTimeZoneCode: string;
    procedure SetTimeZoneCode(const Value: string);

    function GetUserPreferences : IYFUserPreferences;
    procedure SetUserPreferences(const Value : IYFUserPreferences);

    /// <summary>The Yellowfin User's first name.</summary>
    property FirstName: string read GetFirstName write SetFirstName;

    /// <summary>The Yellowfin User's last name.</summary>
    property LastName: string read GetLastName write SetLastName;

    /// <summary>The user's job title.</summary>
    property Title: string read GetTitle write SetTitle;

    /// <summary>Text describing the user's job.</summary>
    property Description: string read GetDescription write SetDescription;

    /// <summary>A language code for displaying content.</summary>
    property PreferredLanguageCode: string read GetPreferredLanguageCode write SetPreferredLanguageCode;

    /// <summary>
    /// A string code that defines a timezone region and zone name together, separated by a "/".
    /// When left empty, it defaults to the current organisation's time zone.
    /// </summary>
    property TimeZoneCode: string read GetTimeZoneCode write SetTimeZoneCode;

    property UserPreferences : IYFUserPreferences read GetUserPreferences write SetUserPreferences;
  end;

  IYFUserAdminPatch = interface(IYFUserPatch)
  ['{D769305B-5B6E-49C4-A781-4785075D69DC}']
    function GetEmail : string;
    procedure SetEmail(const value : string);

    property Email : string read GetEmail write SetEmail;
  end;

  // Returned after creating a new user.
  IYFUserAdminListItemModel = interface(IYFUserAdminPatch)
  ['{1DDC4947-D995-43CD-A054-B4CC1D083BA6}']
    // Getters
    function GetUserID: Int64;
    function GetUserName: string;
    function GetRoleCode: string;

    // Setters
    procedure SetUserName(const Value: string);
    procedure SetRoleCode(const Value: string);
    procedure SetUserID(const Value: Int64);

    // Properties
    property UserName: string read GetUserName write SetUserName;
    property RoleCode: string read GetRoleCode write SetRoleCode;
    property UserID: Int64 read GetUserID write SetUserID;

  end;

  IYFUser = interface(IYFUserAdminListItemModel)
  ['{DF9B0E17-2A85-44C5-87E9-B72B7310B4CB}']
    function GetStatus : TYFUserTypes.status;
    procedure SetStatus(const value : TYFUserTypes.status);

    function GetIsCurrentUser : Boolean;
    procedure SetIsCurrentUser(const value : Boolean);

    function GetNumStories : Int64;
    procedure SetNumStories(const value : Int64);

    function GetNumFollowers : Int64;
    procedure SetNumFollowers(const value : Int64);

    function GetNumFollowing : int64;
    procedure SetNumFollowing(const value : int64);

    function GetNumDiscussionStreams : Int64;
    procedure SetNumDiscussionStreams(const value : Int64);

    property Status : TYFUserTypes.status read GetStatus write SetStatus;
    property IsCurrentUser : Boolean read GetIsCurrentUser write SetIsCurrentUser;
    property NumStories : Int64 read GetNumStories write SetNumStories;
    property NumFollowers : Int64 read GetNumFollowers write SetNumFollowers;
    property NumFollowing : int64 read GetNumFollowing write SetNumFollowing;
    property NumDiscussionStreams : Int64 read GetNumDiscussionStreams write SetNumDiscussionStreams;
  end;

  IYFSimpleUserModel = interface(IYFLoadFromJSON)
    ['{B314119A-7AAB-4C2F-B469-2EE9EDD9A605}']

    // userId
    function GetUserId: Int64;
    procedure SetUserId(const Value: Int64);

    // name
    function GetName: string;
    procedure SetName(const Value: string);

    // title
    function GetTitle: string;
    procedure SetTitle(const Value: string);

    // userConnectionStatus
    function GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
    procedure SetUserConnectionStatus(const Value: TYFUserTypes.userConnectionStatus);

    // Properties
    property userId: Int64 read GetUserId write SetUserId;
    property name: string read GetName write SetName;
    property title: string read GetTitle write SetTitle;
    property userConnectionStatus: TYFUserTypes.userConnectionStatus read GetUserConnectionStatus write SetUserConnectionStatus;
  end;

  /// <summary>
  /// List of TYFUsersUser, one object per person returned from a user list search
  /// </summary>
  IYFSimpleUserModelList = interface(IYFModelList<IYFSimpleUserModel>)
  end;


  IYFNewUser = interface
  ['{D25CDF96-F7BF-4C9D-957A-706253620BCF}']
    // Getters
    function GetUserName: string;
    function GetEmail: string;
    function GetRoleCode: string;
    function GetStatus: TYFUserTypes.status;
    function GetPassword: string;
    function GetFirstName: string;
    function GetLastName: string;
    function GetTitle: string;
    function GetDescription: string;
    function GetTimeZoneCode: string;
    function GetPreferredLanguageCode: string;

    function GetUserPreferences : IYFUserPreferences;

    // Setters
    procedure SetUserName(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetRoleCode(const Value: string);
    procedure SetStatus(const Value: TYFUserTypes.status);
    procedure SetPassword(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetTimeZoneCode(const Value: string);
    procedure SetPreferredLanguageCode(const Value: string);

    procedure SetUserPreferences(const Value : IYFUserPreferences);

     // JSON Output and Refresh
    function ToJSON: TJSONObject;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    // Properties
    property UserName: string read GetUserName write SetUserName;
    property Email: string read GetEmail write SetEmail;
    property RoleCode: string read GetRoleCode write SetRoleCode;
    property Status: TYFUserTypes.status read GetStatus write SetStatus;
    property Password: string read GetPassword write SetPassword;
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property TimeZoneCode: string read GetTimeZoneCode write SetTimeZoneCode;
    property PreferredLanguageCode: string read GetPreferredLanguageCode write SetPreferredLanguageCode;

    property UserPreferences : IYFUserPreferences read GetUserPreferences write SetUserPreferences;
  end;

  TYFNewUserList = TArray<IYFNewUser>;

  // Following
  IYFUserFollowRequest = interface(IYFLoadFromJSON)
    ['{7B08124E-A566-431B-A4BB-80F69125F237}']

    function GetSubjectUserId: Int64;
    procedure SetSubjectUserId(Value: Int64);

    function GetObjectUserId: Int64;
    procedure SetObjectUserId(Value: Int64);

    function GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
    procedure SetUserConnectionStatus(Value: TYFUserTypes.userConnectionStatus);

    property SubjectUserId: Int64 read GetSubjectUserId write SetSubjectUserId;
    property ObjectUserId: Int64 read GetObjectUserId write SetObjectUserId;
    property UserConnectionStatus: TYFUserTypes.userConnectionStatus read GetUserConnectionStatus write SetUserConnectionStatus;
  end;

  IYFFavouriteModel = interface(IYFLoadFromJSON)
    ['{934FCDE4-FF95-4D62-AA23-A046C572DC4F}']

    // Getters
    function GetUserId: Int64;
    function GetName: string;
    function GetContentType: string;
    function GetTitle: string;
    function GetDescription: string;
    function GetContentId: Int64;
    function GetContentUuid: string;
    function GetPublishedDate: TDateTime;

    // Setters
    procedure SetUserId(const Value: Int64);
    procedure SetName(const Value: string);
    procedure SetContentType(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetContentId(const Value: Int64);
    procedure SetContentUuid(const Value: string);
    procedure SetPublishedDate(const Value: TDateTime);

    // Properties
    property UserId: Int64 read GetUserId write SetUserId;
    property Name: string read GetName write SetName;
    property ContentType: string read GetContentType write SetContentType;
    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property ContentId: Int64 read GetContentId write SetContentId;
    property ContentUuid: string read GetContentUuid write SetContentUuid;
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;
  end;

  IYFFavouriteModels = interface(IYFModelList<IYFFavouriteModel>)
  end;


implementation

end.
