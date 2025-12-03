unit FormYFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.CategoryButtons, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, yellowfinbi.api.security.tokenManager,
  Frames.User.Login, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;

type
  TForm1 = class(TForm)
    SV: TSplitView;
    pnlToolbar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    catMenuItems: TCategoryButtons;
    pcMain: TPageControl;
    tabLogin: TTabSheet;
    tabEmbeddedContent: TTabSheet;
    ActionList1: TActionList;
    actLogon: TAction;
    actLogOff: TAction;
    actAdministration: TAction;
    actDashboards: TAction;
    actBrowse: TAction;
    actTimelines: TAction;
    actServerSettings: TAction;
    frameUserLogin1: TframeUserLogin;
    EdgeBrowser: TEdgeBrowser;
    actSSOOptions: TAction;
    tabOptions: TTabSheet;
    cbLogOff: TCheckBox;
    cbSideNavigator: TCheckBox;
    cbToolbar: TCheckBox;
    cbFooter: TCheckBox;
    cbHeader: TCheckBox;
    Label1: TLabel;
    FlowPanel1: TFlowPanel;
    procedure FormCreate(Sender: TObject);
    procedure actDashboardsExecute(Sender: TObject);
    procedure actLogOffExecute(Sender: TObject);
    procedure actLogonExecute(Sender: TObject);
    procedure actBrowseExecute(Sender: TObject);
    procedure actAdministrationExecute(Sender: TObject);
    procedure actServerSettingsExecute(Sender: TObject);
    procedure actStoriesExecute(Sender: TObject);
    procedure actTimelinesExecute(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
  private
    { Private declarations }
    procedure Logon(Sender : TComponent; ASuccess : Boolean);
    procedure LoadSSOParams(YF_Params : TStringList);
    procedure LoadYellowfin(aEntryPoint: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Yellowfin.Settings, yellowfinbi.api.common, Yellowfin.Settings.INI,
  yellowfinbi.api.security, Yellowfinbi.api.users;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Connect the Frame to the local event for post logon
  actLogOff.Execute;
  frameUserLogin1.Initialize(Logon);
end;

procedure TForm1.actDashboardsExecute(Sender: TObject);
begin
  // Launch Dashboards
  LoadYellowfin('DASHBOARDS');
end;

procedure TForm1.actLogOffExecute(Sender: TObject);
begin
  // Log Off & return to login Screen
  ClearYFTokens;

  pcMain.ActivePage := tabLogin;
  frameUserLogin1.pcUserLogin.ActivePage := frameUserLogin1.tabLogin;
end;

procedure TForm1.actLogonExecute(Sender: TObject);
begin
  pcMain.ActivePage := tabLogin;
  frameUserLogin1.pcUserLogin.ActivePage := frameUserLogin1.tabLogin;
end;

procedure TForm1.actBrowseExecute(Sender: TObject);
begin
  // Launch Presents
  LoadYellowfin('BROWSE');
end;

procedure TForm1.actAdministrationExecute(Sender: TObject);
begin
  // Launch Reports
  LoadYellowfin('ADMINISTRATION');
end;

procedure TForm1.actServerSettingsExecute(Sender: TObject);
begin
  pcMain.ActivePage := tabLogin;
  frameUserLogin1.pcUserLogin.ActivePage := frameUserLogin1.tabSettings;
end;

procedure TForm1.actStoriesExecute(Sender: TObject);
begin
  // Launch Stories
  LoadYellowfin('VIEWSTORYBOARD');
end;

procedure TForm1.actTimelinesExecute(Sender: TObject);
begin
  // Launch Timelines
  LoadYellowfin('TIMELINE');
end;

procedure TForm1.imgMenuClick(Sender: TObject);
begin
  if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TForm1.LoadSSOParams(YF_Params: TStringList);
begin
  // See  https://developers.yellowfinbi.com/dev/api-docs/current/#tag/login-tokens
  // There are many more for setting / hiding content
  if not cbLogOff.Checked then
    YF_Params.Add('DISABLELOGOFF=TRUE');

  if not cbToolbar.Checked then
    YF_Params.Add('YFTOOLBAR=FALSE'); // Hides the tool bar for navigation inside Yellowfin

  if not cbHeader.Checked then
    YF_Params.Add('DISABLEHEADER=TRUE'); // Hides the branding at the top / Header

  if not cbFooter.Checked then
    YF_Params.Add('DISABLEFOOTER=TRUE');

  if not cbSideNavigator.Checked then
    YF_Params.Add('DISABLESIDENAV=TRUE');
end;

procedure TForm1.Logon(Sender: TComponent; ASuccess: Boolean);
begin
  if ASuccess then
  begin
    pcMain.ActivePage := tabEmbeddedContent;
  end
  else
    pcMain.ActivePage := tabLogin;

  actDashboards.Execute;
end;

procedure TForm1.LoadYellowfin(aEntryPoint : string);
begin
  var YF_Params := TStringList.Create;
  try
    LoadSSOParams(YF_Params);
    YF_Params.Add('ENTRY='+aEntryPoint);  // Sets where you want to enter into Yellowfin

    var UserName := frameUserLogin1.UserName; // If your system users a different value, you need to pass in that - Default is email
    var userPassword := frameUserLogin1.UserPassword; // Default to '' for Single Sign On  / Empty Password requires SIMPLE_AUTHENTICATION = TRUE
    var OrgID := ConfigData.AdminCredentials.ClientOrg;

    var SSOToken := TYF_TokenRequests.GetLoginTokenSSO(ConfigData.ServerDetails,ConfigData.AdminCredentials, userName, userPassword, OrgID, YF_Params, '');
    var URL := ConfigData.ServerDetails.hostURL + '/logon.i4?LoginWebserviceId=' + SSOToken.Token;

    EdgeBrowser.Navigate(URL);
  finally
    YF_Params.Free;
  end;
end;

end.
