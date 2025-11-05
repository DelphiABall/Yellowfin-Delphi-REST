unit yellowfinbi.api.users.classes;

interface

uses System.JSON, System.Generics.Collections, yellowfinbi.api.json,
  yellowfinbi.api.json.generics, yellowfinbi.api.common,
  yellowfinbi.api.users.intf;

type
  TYFUserPreferences = class(TInterfacedObject, IYFUserPreferences)
  private
    FDraftContentItemCount: Int64;
    FRecentContentItemCount: Int64;
    FRetainContentTypeFilterOnBrowsePage: Boolean;
    FAllowUsersToConnect: TYFUserTypes.allowUsersToConnect;
    FAllowUsersToViewTimeline: TYFUserTypes.allowUsersToViewTimeline;
    FAllowUsersToPostOnTimeline: TYFUserTypes.allowUsersToPostOnTimeline;
    FEntryPage: string;

    function GetAllowUsersToConnect: TYFUserTypes.allowUsersToConnect;
    function GetAllowUsersToPostOnTimeline: TYFUserTypes.allowUsersToPostOnTimeline;
    function GetAllowUsersToViewTimeline: TYFUserTypes.allowUsersToViewTimeline;
    function GetDraftContentItemCount: Integer;
    function GetEntryPage: string;
    function GetRecentContentItemCount: Integer;
    function GetRetainContentTypeFilterOnBrowsePage: Boolean;
    procedure SetAllowUsersToConnect(
      const Value: TYFUserTypes.allowUsersToConnect);
    procedure SetAllowUsersToPostOnTimeline(
      const Value: TYFUserTypes.allowUsersToPostOnTimeline);
    procedure SetAllowUsersToViewTimeline(
      const Value: TYFUserTypes.allowUsersToViewTimeline);
    procedure SetDraftContentItemCount(const Value: Integer);
    procedure SetEntryPage(const Value: string);
    procedure SetRecentContentItemCount(const Value: Integer);
    procedure SetRetainContentTypeFilterOnBrowsePage(const Value: Boolean);

  public
    procedure AddToJSON(AJSON : TJSONObject); virtual;
    procedure LoadFromJSON(const AJSON : TJSONObject); virtual;

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
  /// ID and name for a user returned from searching for a Yellowfin User
  /// </summary>
  TYFSimpleUserModel = class(TInterfacedObject, IYFUserID, IYFSimpleUserModel)
  private
    FuserId : Int64;
    Fname : string;
    Ftitle : string;
    FuserConnectionStatus: TYFUserTypes.userConnectionStatus;

    function GetUserId: Int64;
    procedure SetUserId(const Value: Int64);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
    procedure SetUserConnectionStatus(const Value: TYFUserTypes.userConnectionStatus);

  public
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property userId: Int64 read GetUserId write SetUserId;
    property name: string read Fname write Fname;
    property title : string read Ftitle write Ftitle;
    property userConnectionStatus: TYFUserTypes.userConnectionStatus read FuserConnectionStatus write FuserConnectionStatus;
  end;

  /// <summary>
  /// List of IYFSimpleUserModelList, one object per person returned from a user list search
  /// </summary>
  TYFSimpleUserModelList = class(TYFModelList<IYFSimpleUserModel>, IYFSimpleUserModelList)
    constructor Create; overload;
  end;


  TYFUserPatch = class(TInterfacedObject, IYFUserPatch, IYFUserPreferences)
  private
    // Patch Variabless
    FFirstName: string;
    FLastName: string;
    FTitle: string;
    FDescription: string;
    FPreferredLanguageCode: string;
    FTimeZoneCode: string;
    FUserPreferences : IYFUserPreferences;

    // Patch Methods
    function GetDescription: string;
    function GetFirstName: string;
    function GetLastName: string;
    function GetPreferredLanguageCode: string;
    function GetTimeZoneCode: string;
    function GetTitle: string;

    procedure SetDescription(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetPreferredLanguageCode(const Value: string);
    procedure SetTimeZoneCode(const Value: string);
    procedure SetTitle(const Value: string);
    function GetUserPreferences: IYFUserPreferences;
    procedure SetUserPreferences(const Value: IYFUserPreferences);
  public
    // IYFUserPost
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property PreferredLanguageCode: string read GetPreferredLanguageCode write SetPreferredLanguageCode;
    property TimeZoneCode: string read GetTimeZoneCode write SetTimeZoneCode;
    property UserPreferences : IYFUserPreferences read GetUserPreferences write SetUserPreferences implements IYFUserPreferences;

    procedure LoadFromJSON(const AJSON: TJSONObject); virtual;

  end;

  TYFUserAdminPatch = class(TYFUserPatch, IYFUserAdminPatch)
  private
    FEmail : string;
  public
    function GetEmail: string;
    procedure SetEmail(const Value: string);

    property Email : string read GetEmail write SetEmail;

    procedure LoadFromJSON(const AJSON: TJSONObject); override;
  end;

  TYFUserAdminListItemModel = class(TYFUserAdminPatch, IYFUserAdminListItemModel, IYFUserID)
  private
    FUserID : Int64;
    FUserName : string;
    FRoleCode : string;
  public
    function GetUserID: Int64;
    function GetUserName: string;
    function GetRoleCode: string;

    // Setters
    procedure SetUserID(const Value: Int64);
    procedure SetUserName(const Value: string);
    procedure SetRoleCode(const Value: string);

    // Properties
    property UserID: Int64 read GetUserID write SetUserID;
    property UserName: string read GetUserName write SetUserName;
    property RoleCode: string read GetRoleCode write SetRoleCode;

    procedure LoadFromJSON(const AJSON: TJSONObject); override;
  end;

  /// <summary>
  /// TYFUser full details of a User. Cast as IYFUserProfile for items that can be updated in a PATCH
  ///
  /// </summary>
  TYFUser = class(TYFUserPatch, IYFUser, IYFUserID)
  private
    // Full User Variabless
    FUserId : Int64;
    FUserName : string;
    FEmail : string;
    FStatus : TYFUserTypes.status;
    FRoleCode : string;
    FIsCurrentUser : Boolean;
    FNumStories : Int64;
    FNumFollowers : Int64;
    FNumFollowing : int64;
    FNumDiscussionStreams : Int64;

    // Full User Methods
    function GetUserId : Int64;
    procedure SetUserId(const value : Int64);
    function GetUserName : string;
    procedure SetUserName(const value : string);
    function GetEmail : string;
    procedure SetEmail(const value : string);
    function GetStatus : TYFUserTypes.status;
    procedure SetStatus(const value : TYFUserTypes.status);
    function GetRoleCode : string;
    procedure SetRoleCode(const value : string);
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
  public
    // IYFUser
    property UserId : Int64 read GetUserId write SetUserId;
    property UserName : string read GetUserName write SetUserName;
    property Email : string read GetEmail write SetEmail;
    property Status : TYFUserTypes.status read GetStatus write SetStatus;
    property RoleCode : string read GetRoleCode write SetRoleCode;
    property IsCurrentUser : Boolean read GetIsCurrentUser write SetIsCurrentUser;
    property NumStories : Int64 read GetNumStories write SetNumStories;
    property NumFollowers : Int64 read GetNumFollowers write SetNumFollowers;
    property NumFollowing : int64 read GetNumFollowing write SetNumFollowing;
    property NumDiscussionStreams : Int64 read GetNumDiscussionStreams write SetNumDiscussionStreams;

    procedure LoadFromJSON(const AJSON: TJSONObject);  override;
  end;

  TYFNewUser = class(TInterfacedObject, IYFNewUser, IYFUserID, IYFUserPreferences)
  private
    FUserName: string;
    FEmail: string;
    FRoleCode: string;
    FStatus: TYFUserTypes.status;
    FPassword: string;
    FFirstName: string;
    FLastName: string;
    FTitle: string;
    FDescription: string;
    FTimeZoneCode: string;
    FPreferredLanguageCode: string;
    FUserPreferences : IYFUserPreferences;
    FUserID : Int64;

    // Getters and Setters
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetEmail: string;
    procedure SetEmail(const Value: string);
    function GetRoleCode: string;
    procedure SetRoleCode(const Value: string);
    function GetStatus: TYFUserTypes.status;
    procedure SetStatus(const Value: TYFUserTypes.status);
    function GetPassword: string;
    procedure SetPassword(const Value: string);
    function GetFirstName: string;
    procedure SetFirstName(const Value: string);
    function GetLastName: string;
    procedure SetLastName(const Value: string);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetTimeZoneCode: string;
    procedure SetTimeZoneCode(const Value: string);
    function GetPreferredLanguageCode: string;
    procedure SetPreferredLanguageCode(const Value: string);
    function GetUserPreferences: IYFUserPreferences;
    procedure SetUserPreferences(const Value: IYFUserPreferences);

    procedure SetUserID(const Value : Int64);
    function GetUserID : Int64;
  public
    constructor Create;
    // JSON Output
    function ToJSON: TJSONObject;
    procedure LoadFromJSON(const AJSON: TJSONObject); virtual;

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

    property UserPreferences : IYFUserPreferences read GetUserPreferences write SetUserPreferences implements IYFUserPreferences;
    // Summary

    property UserID : Int64 read GetUserID write setUserID;
  end;

  TYFUserList = TList<IYFUser>;

  TYFUserFollowRequest = class(TInterfacedObject, IYFUserFollowRequest)
  private
    FSubjectUserId: Int64;
    FObjectUserId: Int64;
    FUserConnectionStatus: TYFUserTypes.userConnectionStatus;

    function GetSubjectUserId: Int64;
    procedure SetSubjectUserId(Value: Int64);

    function GetObjectUserId: Int64;
    procedure SetObjectUserId(Value: Int64);

    function GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
    procedure SetUserConnectionStatus(Value: TYFUserTypes.userConnectionStatus);

  public
    constructor Create;
    procedure LoadFromJSON(const AJSON: TJSONObject);

    property SubjectUserId: Int64 read GetSubjectUserId write SetSubjectUserId;
    property ObjectUserId: Int64 read GetObjectUserId write SetObjectUserId;
    property UserConnectionStatus: TYFUserTypes.userConnectionStatus read GetUserConnectionStatus write SetUserConnectionStatus;
  end;

  TYFFavouriteModel = class(TInterfacedObject, IYFFavouriteModel)
  private
    FUserId: Int64;
    FName: string;
    FContentType: string;
    FTitle: string;
    FDescription: string;
    FContentId: Int64;
    FContentUuid: string;
    FPublishedDate: TDateTime;

    function GetUserId: Int64;
    function GetName: string;
    function GetContentType: string;
    function GetTitle: string;
    function GetDescription: string;
    function GetContentId: Int64;
    function GetContentUuid: string;
    function GetPublishedDate: TDateTime;

    procedure SetUserId(const Value: Int64);
    procedure SetName(const Value: string);
    procedure SetContentType(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetContentId(const Value: Int64);
    procedure SetContentUuid(const Value: string);
    procedure SetPublishedDate(const Value: TDateTime);

  public
    property UserId: Int64 read GetUserId write SetUserId;
    property Name: string read GetName write SetName;
    property ContentType: string read GetContentType write SetContentType;
    property Title: string read GetTitle write SetTitle;
    property Description: string read GetDescription write SetDescription;
    property ContentId: Int64 read GetContentId write SetContentId;
    property ContentUuid: string read GetContentUuid write SetContentUuid;
    property PublishedDate: TDateTime read GetPublishedDate write SetPublishedDate;

    procedure LoadFromJSON(const AJSON: TJSONObject);
  end;

  TYFFavouriteModels = class(TYFModelList<IYFFavouriteModel>, IYFFavouriteModels)
    constructor Create; overload;
  end;


implementation

uses System.SysUtils, System.TypInfo, System.RTTI, System.DateUtils,
  yellowfinbi.api.classfactory;

{ TYFUsersUser }

function TYFSimpleUserModel.GetName: string;
begin
  Result := Fname;
end;

function TYFSimpleUserModel.GetTitle: string;
begin
  Result := Ftitle;
end;

function TYFSimpleUserModel.GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
begin
  Result := FuserConnectionStatus;
end;

function TYFSimpleUserModel.GetUserId: Int64;
begin
  Result := FUserID;
end;

procedure TYFSimpleUserModel.LoadFromJSON(const AJSON: TJSONObject);
begin
  userId := AJSON.GetValue<Int64>('userId', 0);
  Name := AJSON.GetValue<string>('name', '');

  // Optional field
  userConnectionStatus := TYFUserTypes.GetValue<TYFUserTypes.userConnectionStatus>(AJSON.GetValue<string>('userConnectionStatus', ''),TYFUserTypes.userConnectionStatus.NOT_CONNECTED);

end;

procedure TYFSimpleUserModel.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TYFSimpleUserModel.SetTitle(const Value: string);
begin
  Ftitle := Value;
end;

procedure TYFSimpleUserModel.SetUserConnectionStatus(
  const Value: TYFUserTypes.userConnectionStatus);
begin
  FuserConnectionStatus := Value;
end;

procedure TYFSimpleUserModel.SetUserId(const Value: Int64);
begin
  FUserID := Value;
end;

{ TYFUsers }

function TYFUser.GetEmail: string;
begin
  Result := FEmail;
end;

function TYFUser.GetIsCurrentUser: Boolean;
begin
  Result := FIsCurrentUser;
end;

function TYFUser.GetNumDiscussionStreams: Int64;
begin
  Result := FNumDiscussionStreams;
end;

function TYFUser.GetNumFollowers: Int64;
begin
  Result := FNumFollowers;
end;

function TYFUser.GetNumFollowing: int64;
begin
  Result := FNumFollowing;
end;

function TYFUser.GetNumStories: Int64;
begin
  Result := FNumStories;
end;

function TYFUser.GetRoleCode: string;
begin
  Result := FRoleCode;
end;

function TYFUser.GetStatus: TYFUserTypes.status;
begin
  Result := FStatus;
end;

function TYFUser.GetUserId: Int64;
begin
  Result := FUserId;
end;

function TYFUser.GetUserName: string;
begin
  Result := FUserName;
end;

procedure TYFUser.LoadFromJSON(const AJSON: TJSONObject);
begin
  inherited;
  UserId := AJSon.GetValue<Int64>('userId', 0);
  UserName := AJSon.GetValue<string>('userName', '');
  Email := AJSon.GetValue<string>('email', '');
  Status := TYFUserTypes.GetValue<TYFUserTypes.status>(AJSon.GetValue<string>('status', ''),TYFUserTypes.status.ACTIVE);
  RoleCode := AJSon.GetValue<string>('roleCode', '');
  IsCurrentUser := AJSon.GetValue<Boolean>('isCurrentUser', False);
  NumStories := AJSon.GetValue<Int64>('numStories', 0);
  NumFollowers := AJSon.GetValue<Int64>('numFollowers', 0);
  NumFollowing := AJSon.GetValue<int64>('numFollowing', 0);
  NumDiscussionStreams := AJSon.GetValue<Int64>('numDiscussionStreams', 0);
end;

procedure TYFUser.SetEmail(const value: string);
begin
  FEmail := Value;
end;

procedure TYFUser.SetIsCurrentUser(const value: Boolean);
begin
  FIsCurrentUser := Value;
end;


procedure TYFUser.SetNumDiscussionStreams(const Value: Int64);
begin
  FNumDiscussionStreams := Value;
end;

procedure TYFUser.SetNumFollowers(const Value: Int64);
begin
  FNumFollowers := Value;
end;

procedure TYFUser.SetNumFollowing(const Value: Int64);
begin
  FNumFollowing := Value;
end;

procedure TYFUser.SetNumStories(const Value: Int64);
begin
  FNumStories := Value;
end;

procedure TYFUser.SetRoleCode(const value: string);
begin
  FRoleCode := Value;
end;

procedure TYFUser.SetStatus(const value: TYFUserTypes.status);
begin
  FStatus := Value;
end;

procedure TYFUser.SetUserId(const Value: Int64);
begin
  FUserId := Value;
end;

procedure TYFUser.SetUserName(const value: string);
begin
  FUserName := Value;
end;

{ TYFNewUser }

function TYFNewUser.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('userName', FUserName);
  Result.AddPair('email', FEmail);
  Result.AddPair('roleCode', FRoleCode);
  Result.AddPair('status', TYFUserTypes.ValueToString<TYFUserTypes.status>(FStatus));
  Result.AddPair('password', FPassword);
  Result.AddPair('firstName', FFirstName);
  Result.AddPair('lastName', FLastName);
  Result.AddPair('title', FTitle);
  Result.AddPair('description', FDescription);
  Result.AddPair('timeZoneCode', FTimeZoneCode);
  Result.AddPair('preferredLanguageCode', FPreferredLanguageCode);
  UserPreferences.AddToJSON(Result);
end;

function TYFNewUser.GetUserID: Int64;
begin
  Result := FUserID;
end;

function TYFNewUser.GetUserName: string;
begin
  Result := FUserName;
end;

function TYFNewUser.GetUserPreferences: IYFUserPreferences;
begin
  if not Assigned(FUserPreferences) then
    FUserPreferences := TYFUserPreferences.Create;

  Result := FUserPreferences;
end;

procedure TYFNewUser.LoadFromJSON(const AJSON: TJSONObject);
begin
  UserID := AJSON.GetValue<int64>('userId', 0);

  FirstName := AJSON.GetValue<string>('firstName', '');
  LastName := AJSON.GetValue<string>('lastName', '');

  Title := AJSON.GetValue<string>('title', '');
  Description := AJSON.GetValue<string>('description', '');
  PreferredLanguageCode := AJSON.GetValue<string>('preferredLanguageCode', '');
  TimeZoneCode := AJSON.GetValue<string>('timeZoneCode', '');

  Status := TYFUserTypes.GetValue<TYFUserTypes.status>(AJSON.GetValue<string>('status', ''),TYFUserTypes.status.ACTIVE);

  UserPreferences.LoadFromJSON(AJSON);
end;

procedure TYFNewUser.SetUserID(const Value: Int64);
begin
  FUserID := Value;
end;

procedure TYFNewUser.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

procedure TYFNewUser.SetUserPreferences(const Value: IYFUserPreferences);
begin
  FUserPreferences := Value;
end;

function TYFNewUser.GetEmail: string;
begin
  Result := FEmail;
end;

procedure TYFNewUser.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

function TYFNewUser.GetRoleCode: string;
begin
  Result := FRoleCode;
end;

procedure TYFNewUser.SetRoleCode(const Value: string);
begin
  FRoleCode := Value;
end;

function TYFNewUser.GetStatus: TYFUserTypes.status;
begin
  Result := FStatus;
end;

procedure TYFNewUser.SetStatus(const Value: TYFUserTypes.status);
begin
  FStatus := Value;
end;

function TYFNewUser.GetPassword: string;
begin
  Result := FPassword;
end;

procedure TYFNewUser.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

function TYFNewUser.GetFirstName: string;
begin
  Result := FFirstName;
end;

procedure TYFNewUser.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

function TYFNewUser.GetLastName: string;
begin
  Result := FLastName;
end;

procedure TYFNewUser.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

function TYFNewUser.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TYFNewUser.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

constructor TYFNewUser.Create;
begin
  inherited Create;
end;

function TYFNewUser.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TYFNewUser.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

function TYFNewUser.GetTimeZoneCode: string;
begin
  Result := FTimeZoneCode;
end;

procedure TYFNewUser.SetTimeZoneCode(const Value: string);
begin
  FTimeZoneCode := Value;
end;

function TYFNewUser.GetPreferredLanguageCode: string;
begin
  Result := FPreferredLanguageCode;
end;

procedure TYFNewUser.SetPreferredLanguageCode(const Value: string);
begin
  FPreferredLanguageCode := Value;
end;

{ TYFUserPatch }

function TYFUserPatch.GetDescription: string;
begin
  Result := FDescription;
end;

function TYFUserPatch.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TYFUserPatch.GetLastName: string;
begin
  Result := FLastName;
end;

function TYFUserPatch.GetPreferredLanguageCode: string;
begin
  Result := FPreferredLanguageCode;
end;

function TYFUserPatch.GetTimeZoneCode: string;
begin
  Result := FTimeZoneCode;
end;

function TYFUserPatch.GetTitle: string;
begin
  Result := FTitle;
end;

function TYFUserPatch.GetUserPreferences: IYFUserPreferences;
begin
  if not Assigned(FUserPreferences) then
    FUserPreferences := TYFUserPreferences.Create;

  Result := FUserPreferences;
end;

procedure TYFUserPatch.LoadFromJSON(const AJSON: TJSONObject);
begin
  FirstName := AJSON.GetValue<string>('firstName', '');
  LastName := AJSON.GetValue<string>('lastName', '');

  Title := AJSON.GetValue<string>('title', '');
  Description := AJSON.GetValue<string>('description', '');
  PreferredLanguageCode := AJSON.GetValue<string>('preferredLanguageCode', '');
  TimeZoneCode := AJSON.GetValue<string>('timeZoneCode', '');

  UserPreferences.LoadFromJSON(AJSON);
end;

procedure TYFUserPatch.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TYFUserPatch.SetFirstName(const Value: string);
begin
  FFirstName := Value;
end;

procedure TYFUserPatch.SetUserPreferences(const Value: IYFUserPreferences);
begin
  FUserPreferences := Value;
end;

procedure TYFUserPatch.SetLastName(const Value: string);
begin
  FLastName := Value;
end;

procedure TYFUserPatch.SetPreferredLanguageCode(const Value: string);
begin
  FPreferredLanguageCode := Value;
end;

procedure TYFUserPatch.SetTimeZoneCode(const Value: string);
begin
  FTimeZoneCode := Value;
end;

procedure TYFUserPatch.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

{ TYFUserAdminListItemModel }

function TYFUserAdminListItemModel.GetRoleCode: string;
begin
  Result := FRoleCode;
end;

function TYFUserAdminListItemModel.GetUserID: Int64;
begin
  Result := FUserID;
end;

function TYFUserAdminListItemModel.GetUserName: string;
begin
  Result := FUserName;
end;

procedure TYFUserAdminListItemModel.LoadFromJSON(const AJSON: TJSONObject);
begin
  inherited;
  UserId := AJSon.GetValue<Int64>('userId', 0);
  UserName := AJSon.GetValue<string>('userName', '');
  RoleCode := AJSon.GetValue<string>('roleCode', '');
end;

procedure TYFUserAdminListItemModel.SetRoleCode(const Value: string);
begin
  FRoleCode := Value;
end;

procedure TYFUserAdminListItemModel.SetUserID(const Value: Int64);
begin
  FUserID := Value;
end;

procedure TYFUserAdminListItemModel.SetUserName(const Value: string);
begin
  FUserName := Value;
end;

{ TYFUserAdminPatch }

function TYFUserAdminPatch.GetEmail: string;
begin
  Result := FEmail;
end;

procedure TYFUserAdminPatch.LoadFromJSON(const AJSON: TJSONObject);
begin
  inherited;
  Email := AJSon.GetValue<string>('email', '');
end;

procedure TYFUserAdminPatch.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

{ TUserPreferences }

procedure TYFUserPreferences.AddToJSON(AJSON: TJSONObject);
begin
  AJSON.AddPair('entryPage', EntryPage);
  AJSON.AddPair('draftContentItemCount', TJSONNumber.Create(DraftContentItemCount));
  AJSON.AddPair('recentContentItemCount', TJSONNumber.Create(RecentContentItemCount));
  AJSON.AddPair('allowUsersToViewTimeline', GetEnumName(TypeInfo(TYFUserTypes.allowUsersToViewTimeline), Ord(AllowUsersToViewTimeline)));
  AJSON.AddPair('allowUsersToConnect', GetEnumName(TypeInfo(TYFUserTypes.allowUsersToConnect), Ord(AllowUsersToConnect)));
  AJSON.AddPair('allowUsersToPostOnTimeline', GetEnumName(TypeInfo(TYFUserTypes.allowUsersToPostOnTimeline), Ord(AllowUsersToPostOnTimeline)));
  AJSON.AddPair('retainContentTypeFilterOnBrowsePage', TJSONBool.Create(RetainContentTypeFilterOnBrowsePage));
end;


function TYFUserPreferences.GetEntryPage: string;
begin
  Result := FEntryPage;
end;

procedure TYFUserPreferences.SetEntryPage(const Value: string);
begin
  FEntryPage := Value;
end;

function TYFUserPreferences.GetDraftContentItemCount: Integer;
begin
  Result := FDraftContentItemCount;
end;

procedure TYFUserPreferences.SetDraftContentItemCount(const Value: Integer);
begin
  FDraftContentItemCount := Value;
end;

function TYFUserPreferences.GetRecentContentItemCount: Integer;
begin
  Result := FRecentContentItemCount;
end;

procedure TYFUserPreferences.SetRecentContentItemCount(const Value: Integer);
begin
  FRecentContentItemCount := Value;
end;

function TYFUserPreferences.GetAllowUsersToViewTimeline: TYFUserTypes.allowUsersToViewTimeline;
begin
  Result := FAllowUsersToViewTimeline;
end;

procedure TYFUserPreferences.SetAllowUsersToViewTimeline(const Value: TYFUserTypes.allowUsersToViewTimeline);
begin
  FAllowUsersToViewTimeline := Value;
end;

function TYFUserPreferences.GetAllowUsersToConnect: TYFUserTypes.allowUsersToConnect;
begin
  Result := FAllowUsersToConnect;
end;

procedure TYFUserPreferences.SetAllowUsersToConnect(const Value: TYFUserTypes.allowUsersToConnect);
begin
  FAllowUsersToConnect := Value;
end;

function TYFUserPreferences.GetAllowUsersToPostOnTimeline: TYFUserTypes.allowUsersToPostOnTimeline;
begin
  Result := FAllowUsersToPostOnTimeline;
end;

procedure TYFUserPreferences.SetAllowUsersToPostOnTimeline(const Value: TYFUserTypes.allowUsersToPostOnTimeline);
begin
  FAllowUsersToPostOnTimeline := Value;
end;

function TYFUserPreferences.GetRetainContentTypeFilterOnBrowsePage: Boolean;
begin
  Result := FRetainContentTypeFilterOnBrowsePage;
end;

procedure TYFUserPreferences.LoadFromJSON(const AJSON: TJSONObject);
var
  prefs: TJSONObject;
begin
  if AJSON.TryGetValue<TJSONObject>('userPreferences', prefs) then
  begin
    EntryPage := prefs.GetValue<string>('entryPage',EntryPage);
    DraftContentItemCount := prefs.GetValue<Integer>('draftContentItemCount', 0);
    RecentContentItemCount := prefs.GetValue<Integer>('recentContentItemCount', 0);
    RetainContentTypeFilterOnBrowsePage := prefs.GetValue<Boolean>('retainContentTypeFilterOnBrowsePage',false);
    AllowUsersToConnect := TYFUserTypes.GetValue<TYFUserTypes.AllowUsersToConnect>(prefs.GetValue<string>('allowUsersToConnect',''),TYFUserTypes.allowUsersToConnect.REQUIREAPPROVAL);
    AllowUsersToViewTimeline := TYFUserTypes.GetValue<TYFUserTypes.AllowUsersToViewTimeline>(prefs.GetValue<string>('allowUsersToViewTimeline',''),TYFUserTypes.allowUsersToViewTimeline.REQUIRECONNECTION);
    AllowUsersToPostOnTimeline := TYFUserTypes.GetValue<TYFUserTypes.AllowUsersToPostOnTimeline>(prefs.GetValue<string>('allowUsersToPostOnTimeline',''),TYFUserTypes.allowUsersToPostOnTimeline.REQUIRECONNECTION);
  end;
end;

procedure TYFUserPreferences.SetRetainContentTypeFilterOnBrowsePage(const Value: Boolean);
begin
  FRetainContentTypeFilterOnBrowsePage := Value;
end;


{ TYFUserFollowRequest }
{ TYFUserFollowRequest }

constructor TYFUserFollowRequest.Create;
begin
  inherited Create;
  UserConnectionStatus := TYFUserTypes.userConnectionStatus.NOT_CONNECTED;
end;

function TYFUserFollowRequest.GetSubjectUserId: Int64;
begin
  Result := FSubjectUserId;
end;

procedure TYFUserFollowRequest.SetSubjectUserId(Value: Int64);
begin
  FSubjectUserId := Value;
end;

function TYFUserFollowRequest.GetObjectUserId: Int64;
begin
  Result := FObjectUserId;
end;

procedure TYFUserFollowRequest.SetObjectUserId(Value: Int64);
begin
  FObjectUserId := Value;
end;

function TYFUserFollowRequest.GetUserConnectionStatus: TYFUserTypes.userConnectionStatus;
begin
  Result := FUserConnectionStatus;
end;

procedure TYFUserFollowRequest.SetUserConnectionStatus(Value: TYFUserTypes.userConnectionStatus);
begin
  FUserConnectionStatus := Value;
end;

procedure TYFUserFollowRequest.LoadFromJSON(const AJSON: TJSONObject);
begin
  AJSON.TryGetValue<Int64>('subjectUserId', FSubjectUserId);
  AJSON.TryGetValue<Int64>('objectUserId', FObjectUserId);
  userConnectionStatus := TYFUserTypes.GetValue<TYFUserTypes.userConnectionStatus>(AJSON.GetValue<string>('userConnectionStatus', ''),TYFUserTypes.userConnectionStatus.NOT_CONNECTED);
end;


{ TYFFavouriteModel }

function TYFFavouriteModel.GetUserId: Int64;
begin
  Result := FUserId;
end;

procedure TYFFavouriteModel.LoadFromJSON(const AJSON: TJSONObject);
var
  DateStr : string;
begin
  AJSON.TryGetValue<Int64>('userId', FUserId);
  AJSON.TryGetValue<string>('name', FName);
  AJSON.TryGetValue<string>('contentType', FContentType);
  AJSON.TryGetValue<string>('title', FTitle);
  AJSON.TryGetValue<string>('description', FDescription);
  AJSON.TryGetValue<Int64>('contentId', FContentId);
  AJSON.TryGetValue<string>('contentUuid', FContentUuid);
  if AJSON.TryGetValue<string>('publishedDate', DateStr) then
    PublishedDate := YFDateStrToTDateTime(DateStr);
end;

function TYFFavouriteModel.GetName: string;
begin
  Result := FName;
end;

function TYFFavouriteModel.GetContentType: string;
begin
  Result := FContentType;
end;

function TYFFavouriteModel.GetTitle: string;
begin
  Result := FTitle;
end;

function TYFFavouriteModel.GetDescription: string;
begin
  Result := FDescription;
end;

function TYFFavouriteModel.GetContentId: Int64;
begin
  Result := FContentId;
end;

function TYFFavouriteModel.GetContentUuid: string;
begin
  Result := FContentUuid;
end;

function TYFFavouriteModel.GetPublishedDate: TDateTime;
begin
  Result := FPublishedDate;
end;

procedure TYFFavouriteModel.SetUserId(const Value: Int64);
begin
  FUserId := Value;
end;

procedure TYFFavouriteModel.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TYFFavouriteModel.SetContentType(const Value: string);
begin
  FContentType := Value;
end;

procedure TYFFavouriteModel.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TYFFavouriteModel.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TYFFavouriteModel.SetContentId(const Value: Int64);
begin
  FContentId := Value;
end;

procedure TYFFavouriteModel.SetContentUuid(const Value: string);
begin
  FContentUuid := Value;
end;

procedure TYFFavouriteModel.SetPublishedDate(const Value: TDateTime);
begin
  FPublishedDate := Value;
end;

{ TYFFavouriteModels }

constructor TYFFavouriteModels.Create;
begin
//  var Func : TFunc<IYFFavouriteModel>  :=
//  function() : IYFFavouriteModel
//  begin
//    Result := TYFFavouriteModel.Create;
//  end;

  inherited Create('items');
end;

{ TYFSimpleUserModelList }

constructor TYFSimpleUserModelList.Create;
begin
//  var Func : TFunc<IYFSimpleUserModel>  :=
//  function() : IYFSimpleUserModel
//  begin
//    Result := TYFSimpleUserModel.Create;
//  end;

  inherited Create('items');
end;

initialization
  TYFFactoryRegistry.RegisterFactory<IYFUserPreferences>(
    function: IYFUserPreferences
    begin
      Result := TYFUserPreferences.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFSimpleUserModel>(
    function: IYFSimpleUserModel
    begin
      Result := TYFSimpleUserModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFSimpleUserModelList>(
    function: IYFSimpleUserModelList
    begin
      Result := TYFSimpleUserModelList.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserPatch>(
    function: IYFUserPatch
    begin
      Result := TYFUserPatch.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserAdminPatch>(
    function: IYFUserAdminPatch
    begin
      Result := TYFUserAdminPatch.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserAdminListItemModel>(
    function: IYFUserAdminListItemModel
    begin
      Result := TYFUserAdminListItemModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUser>(
    function: IYFUser
    begin
      Result := TYFUser.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFNewUser>(
    function: IYFNewUser
    begin
      Result := TYFNewUser.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFUserFollowRequest>(
    function: IYFUserFollowRequest
    begin
      Result := TYFUserFollowRequest.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFFavouriteModel>(
    function: IYFFavouriteModel
    begin
      Result := TYFFavouriteModel.Create;
    end
  );

  TYFFactoryRegistry.RegisterFactory<IYFFavouriteModels>(
    function: IYFFavouriteModels
    begin
      Result := TYFFavouriteModels.Create;
    end
  );


end.
