unit frameYFUser;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Effects;

type
  TYFUserFrame = class(TFrame)
    Layout2: TLayout;
    edtOrg: TEdit;
    Label1: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    edtURL: TEdit;
    Label4: TLabel;
    edtUserName: TEdit;
    Label2: TLabel;
    Save: TButton;
    PasswordEditButton1: TPasswordEditButton;
    edtInstanceName: TEdit;
    Label5: TLabel;
    GlowEffect1: TGlowEffect;
    procedure SaveClick(Sender: TObject);
    procedure SettingsChanged(Sender: TObject);
  private
    { Private declarations }
    FYF_URL            : string;
    FYF_INSTANCE_NAME  : string;
    FYF_ADMIN_USER     : string;
    FYF_ADMIN_PASSWORD : string;
    FYF_ORG            : string;
    FYF_TIMEOUT        : integer;
    function GetYF_ADMIN_PASSWORD: string;
    function GetYF_ADMIN_USER: string;
    function GetYF_INSTANCE_NAME: string;
    function GetYF_ORG: string;
    function GetYF_TIMEOUT: integer;
    function GetYF_URL: string;
    function ReadValue(aUI, aLoaded, aDefault: string): string;

  public
    { Public declarations }
    function SaveToFile : Boolean;
    function LoadFromFile : Boolean;

    function SettingsFilePath: string;

    property YF_URL            : string read GetYF_URL;
    property YF_INSTANCE_NAME  : string read GetYF_INSTANCE_NAME;
    property YF_ADMIN_USER     : string read GetYF_ADMIN_USER;
    property YF_ADMIN_PASSWORD : string read GetYF_ADMIN_PASSWORD;
    property YF_ORG            : string read GetYF_ORG;
    property YF_TIMEOUT        : integer read GetYF_TIMEOUT;

  end;

implementation

{$R *.fmx}

uses System.IniFiles, System.NetEncoding, System.IOUtils;

function TYFUserFrame.ReadValue(aUI, aLoaded, aDefault : string): string;
begin
  if Trim(aUI) > '' then
    Exit(Trim(aUI))
  else
  if Trim(aLoaded) > '' then
    Exit(aLoaded)
  else
    Result := aDefault
end;

function TYFUserFrame.GetYF_ADMIN_PASSWORD: string;
begin
  Result := ReadValue(edtPassword.Text, FYF_ADMIN_PASSWORD, '');
end;

function TYFUserFrame.GetYF_ADMIN_USER: string;
begin
  Result := ReadValue(edtUserName.Text, FYF_ADMIN_USER, '');
end;

function TYFUserFrame.GetYF_INSTANCE_NAME: string;
begin
  Result := ReadValue(edtInstanceName.Text, FYF_INSTANCE_NAME, 'YELLOWFIN');
end;

function TYFUserFrame.GetYF_ORG: string;
begin
  Result := ReadValue(edtOrg.Text, FYF_ORG, 'DEFAULT');
end;

function TYFUserFrame.GetYF_TIMEOUT: integer;
begin
  Result := FYF_TIMEOUT;
end;

function TYFUserFrame.GetYF_URL: string;
begin
  Result := ReadValue(edtURL.Text, FYF_URL, 'https://sandbox.yellowfinbi.com');
end;

function TYFUserFrame.LoadFromFile: Boolean;
begin
  try
    var INI := TIniFile.Create(SettingsFilePath);
    try
      FYF_URL            := INI.ReadString('SANDBOX', 'URL', 'https://sandbox.yellowfinbi.com');
      FYF_INSTANCE_NAME  := INI.ReadString('SANDBOX', 'INSTANCE_NAME', 'YELLOWFIN');
      FYF_ADMIN_USER     := INI.ReadString('SANDBOX', 'USERNAME' , '');
      FYF_ADMIN_PASSWORD := TNetEncoding.Base64.Decode(INI.ReadString('SANDBOX', 'PASSWORD', '')); // This isn't encrypted - just encoded. Don't use in production.
      FYF_ORG            := INI.ReadString('SANDBOX', 'TENANT', '');
      FYF_TIMEOUT        := INI.ReadInteger('SANDBOX', 'TIMEOUT', 6000);

      edtURL.Text := FYF_URL;
      edtUserName.Text := FYF_ADMIN_USER;
      edtPassword.Text := FYF_ADMIN_PASSWORD;
      edtOrg.Text := FYF_ORG;

      edtURL.Text := YF_URL;
      edtUserName.Text := YF_ADMIN_USER;
      edtPassword.Text := YF_ADMIN_PASSWORD;
      edtOrg.Text := YF_ORG;

      Result := True;

    finally
      INI.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TYFUserFrame.SaveClick(Sender: TObject);
begin
  if SaveToFile then
    GlowEffect1.GlowColor := TAlphaColorRec.Green
  else
    GlowEffect1.GlowColor := TAlphaColorRec.Darkred;

  GlowEffect1.Enabled := True;
end;

function TYFUserFrame.SaveToFile: Boolean;
begin
  try
    var INI := TIniFile.Create(SettingsFilePath);
    try
      INI.WriteString('SANDBOX', 'URL', edtURL.Text);
      INI.WriteString('SANDBOX', 'INSTANCE_NAME', edtInstanceName.Text);
      INI.WriteString('SANDBOX', 'USERNAME' , edtUserName.Text);
      INI.WriteString('SANDBOX', 'PASSWORD', TNetEncoding.Base64.Encode(edtPassword.Text)); // This isn't encrypted - just encoded. Don't use in production.
      INI.WriteString('SANDBOX', 'TENANT', edtOrg.Text);
      INI.WriteInteger('SANDBOX', 'TIMEOUT', YF_TIMEOUT);
    finally
      INI.Free;
    end;
    Result := LoadFromFile;
  except
    Result := False;
  end;
end;

procedure TYFUserFrame.SettingsChanged(Sender: TObject);
begin
  GlowEffect1.Enabled := False;
end;

function TYFUserFrame.SettingsFilePath: string;
begin
  var FPath : string;

  if (TOSVersion.Platform in [TOSVersion.TPlatform.pfWindows,
                             TOSVersion.TPlatform.pfWinRT,
                             //TOSVersion.TPlatform.pfMacOS,
                             TOSVersion.TPlatform.pfLinux]) then
    FPath := TPath.Combine(TPath.GetAppPath, 'YFSandbox.ini')
  else
    FPath := TPath.Combine(TPath.GetDocumentsPath, 'YFSandbox.ini');

  Result := FPath;
end;

end.
