unit Frames.User.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Data.Bind.GenData, Vcl.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Vcl.Samples.Bind.Editors, Vcl.Samples.Spin;

type
  TOnLoginEvent = procedure(Sender : TComponent; ASuccess : Boolean) of Object;

  TframeUserLogin = class(TFrame)
    pcUserLogin: TPageControl;
    tabLogin: TTabSheet;
    tabSettings: TTabSheet;
    gbLogin: TGroupBox;
    edtPassword: TLabeledEdit;
    btnLogIn: TButton;
    gbSystemDetails: TGroupBox;
    edtAdminLogin: TLabeledEdit;
    edtAdminPassword: TLabeledEdit;
    edtBaseURL: TLabeledEdit;
    edtUserName: TLabeledEdit;
    edtTenant: TLabeledEdit;
    edtAppName: TLabeledEdit;
    Label1: TLabel;
    seTimeout: TSpinEdit;
    btnUpdate: TButton;
    cbSingleSignOn: TCheckBox;
    Label2: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure btnLogInClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure cbSingleSignOnClick(Sender: TObject);
  private
    FOnLogin: TOnLoginEvent;
    function GetUserName: string;
    function GetUserPassword: string;
    { Private declarations }
  public
    { Public declarations }
    procedure Initialize(AOnLogin: TOnLoginEvent);
    property OnLogin : TOnLoginEvent read FOnLogin write FOnLogin;
    property UserName : string read GetUserName;
    property UserPassword : string read GetUserPassword;
  end;

implementation

{$R *.dfm}
uses Yellowfin.Settings, Yellowfinbi.api.common, Yellowfin.Settings.INI;

procedure TframeUserLogin.btnLogInClick(Sender: TObject);
begin
  Assert(Assigned(FOnLogin),'No Logon Event Assigned');

  // Clear and refresh the token
  ClearYFTokens;
  RefreshToken;

  // Get the Access Token.

  OnLogin(Self,RefreshTokenObj.Successful);

end;

procedure TframeUserLogin.btnUpdateClick(Sender: TObject);
begin
  ConfigData.ServerDetails.HostURL :=  edtBaseURL.Text;
  ConfigData.ServerDetails.AppName :=  edtAppName.Text;
  ConfigData.ServerDetails.Timeout :=  seTimeout.Value;
  ConfigData.AdminCredentials.AdminUserName :=  edtAdminLogin.Text;
  ConfigData.AdminCredentials.AdminPassword := edtAdminPassword.Text;
  ConfigData.AdminCredentials.ClientOrg :=  edtTenant.Text;

  ConfigData.SaveToFile(ConfigData.FileName);
  ClearYFTokens; // Ready to refresh

  pcUserLogin.ActivePage := tabLogin;
end;

procedure TframeUserLogin.cbSingleSignOnClick(Sender: TObject);
begin
  edtPassword.Visible := not cbSingleSignOn.Checked;
end;

procedure TframeUserLogin.FrameResize(Sender: TObject);
begin
  // Center the login
  gbLogin.Left  := (gbLogin.Parent.ClientWidth - gbLogin.Width) div 2;
  gbLogin.Top   := (gbLogin.Parent.ClientHeight - gbLogin.Height) div 2;

  gbSystemDetails.Left  := (gbSystemDetails.Parent.ClientWidth - gbSystemDetails.Width) div 2;
  gbSystemDetails.Top   := (gbSystemDetails.Parent.ClientHeight - gbSystemDetails.Height) div 2;
end;

function TframeUserLogin.GetUserName: string;
begin
  Result := edtUserName.Text;
end;

function TframeUserLogin.GetUserPassword: string;
begin
  if cbSingleSignOn.Checked then
    Result := edtPassword.Text
  else
    Result := '';
end;

procedure TframeUserLogin.Initialize(AOnLogin: TOnLoginEvent);
begin
  ConfigData.LoadFromFile(ConfigData.FileName);

  edtBaseURL.Text := ConfigData.ServerDetails.HostURL;
  edtAppName.Text := ConfigData.ServerDetails.AppName;
  seTimeout.Value := ConfigData.ServerDetails.Timeout;
  edtAdminLogin.Text := ConfigData.AdminCredentials.AdminUserName;
  edtAdminPassword.Text := ConfigData.AdminCredentials.AdminPassword;

  // User Details
  edtUserName.Text := ConfigData.AdminCredentials.AdminUserName;
  edtPassword.Text := '';

  edtTenant.Text := ConfigData.AdminCredentials.ClientOrg;

  // This sets up the UI and Links the Login to the host.
  OnLogin := AOnLogin;

  if ConfigData.AdminCredentials.AdminUserName = '' then
    pcUserLogin.ActivePage := tabSettings
  else
    pcUserLogin.ActivePage := tabLogin;

  // Setup SingleSignOn and Position Content in the screen.
  FrameResize(Self);
  cbSingleSignOnClick(nil);
end;

end.
