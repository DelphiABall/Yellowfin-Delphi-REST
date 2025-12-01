unit formMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.TabControl, FMX.StdCtrls, FMX.Layouts, FMX.Controls.Presentation,
  FMX.MultiView, FMX.ListBox, FMX.WebBrowser, frameYFUser, yellowfinbi.api.security.tokenManager,
  yellowfinbi.api.common, yellowfinbi.api.transport, yellowfinbi.api.transport.classes,
  FMX.Effects, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.JSON;

type
  TForm1 = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    ToolBar1: TToolBar;
    btnMenu: TButton;
    tcContent: TTabControl;
    tabSettings: TTabItem;
    tabData: TTabItem;
    Button2: TButton;
    Button4: TButton;
    edtEndPoint: TEdit;
    Label5: TLabel;
    Layout3: TLayout;
    cbVerb: TComboBox;
    Layout4: TLayout;
    Layout5: TLayout;
    Label6: TLabel;
    Layout6: TLayout;
    btnExecute: TButton;
    YFUserFrame1: TYFUserFrame;
    lblCode: TLabel;
    lblStatus: TLabel;
    tcOutput: TTabControl;
    tabBrowser: TTabItem;
    tabSource: TTabItem;
    memoSource: TMemo;
    WebBrowserData: TWebBrowser;
    tabBody: TTabItem;
    memoBody: TMemo;
    GlowEffectURL: TInnerGlowEffect;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cbVerbChange(Sender: TObject);
    procedure edtEndPointKeyDown(Sender: TObject; var Key: Word; var KeyChar:
        WideChar; Shift: TShiftState);
    procedure btnExecuteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MultiView1Hidden(Sender: TObject);
    procedure MultiView1StartShowing(Sender: TObject);
  private
    //WebBrowserData : TWebBrowser;

    FRefreshTokenManager : TYFRefreshTokenManager;
    FAccessTokenManager : TYFAccessTokenManager;
    FConfigData : TYellowfinServerConfig;

    procedure SetStatus(IsOK : Boolean; aCode : string; aMessage: string);
    procedure LoadJSONView(aContent : string; aURL : string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses REST.Types, System.IOUtils, System.NetEncoding, System.Threading;

procedure TForm1.FormCreate(Sender: TObject);
begin
  tcContent.TabPosition := TTabPosition.None;

  YFUserFrame1.LoadFromFile;

  if (lowercase(YFUserFrame1.YF_ADMIN_USER) = 'admin@yellowfinbi.com.au') or (YFUserFrame1.YF_ADMIN_USER.IsEmpty) then
    tcContent.ActiveTab := tabSettings
  else
    tcContent.ActiveTab := tabData;

  tcOutput.ActiveTab := tabBrowser;
  cbVerbChange(cbVerb); // Set the tabs visbility
end;

procedure TForm1.LoadJSONView(aContent : string; aURL : string);
begin
  var HTML := TStringList.Create;
  try
    HTML.Add('<!DOCTYPE html>');
    HTML.Add('<html>');
    HTML.Add('<head>');
    HTML.Add('<meta charset="utf-8">');
    HTML.Add('<meta name="color-scheme" content="light">');
    HTML.Add('<style>');
    HTML.Add('body { font-family: Consolas, monospace; padding: 5px; background-color: white; color: black;}');
    HTML.Add('.json-container { font-size: 14px; }');
    HTML.Add('</style>');

    // --- JSONViewer JavaScript ---
    HTML.Add('<script>');
    HTML.Add('function createTree(container, json) {');
    HTML.Add('  container.innerHTML = "";');
    HTML.Add('  const isArray = Array.isArray(json);');
    HTML.Add('  const root = document.createElement("ul");');
    HTML.Add('  root.style.listStyle = "none";');
    HTML.Add('  root.style.paddingLeft = "20px";');
    HTML.Add('  container.appendChild(root);');
    HTML.Add('  function build(node, obj) {');
    HTML.Add('    for (const key in obj) {');
    HTML.Add('      const item = document.createElement("li");');
    HTML.Add('      const value = obj[key];');
    HTML.Add('      let text = "";');
    HTML.Add('      const hasChildren = typeof value === "object" && value !== null;');
    HTML.Add('      const toggle = document.createElement("span");');
    HTML.Add('      toggle.style.cursor = "pointer";');
    HTML.Add('      toggle.style.color = "#007ACC";');
    HTML.Add('      toggle.style.marginRight = "4px";');
    HTML.Add('      toggle.innerHTML = hasChildren ? "[–]" : "&nbsp;&nbsp;";');
    HTML.Add('      item.appendChild(toggle);');
    HTML.Add('      if (!isArray) text += key + ": ";');
    HTML.Add('      if (hasChildren) text += (Array.isArray(value) ? "[ ]" : "{ }");');
    HTML.Add('      else text += JSON.stringify(value);');
    HTML.Add('      const label = document.createElement("span");');
    HTML.Add('      label.textContent = text;');
    HTML.Add('      item.appendChild(label);');
    HTML.Add('      node.appendChild(item);');
    HTML.Add('      if (hasChildren) {');
    HTML.Add('        const childList = document.createElement("ul");');
    HTML.Add('        childList.style.listStyle = "none";');
    HTML.Add('        childList.style.paddingLeft = "20px";');
    HTML.Add('        item.appendChild(childList);');
    HTML.Add('        build(childList, value);');
    HTML.Add('        toggle.onclick = function() {');
    HTML.Add('          if (childList.style.display === "none") {');
    HTML.Add('            childList.style.display = "block"; toggle.innerHTML = "[–]";');
    HTML.Add('          } else {');
    HTML.Add('            childList.style.display = "none"; toggle.innerHTML = "[+]";');
    HTML.Add('          }');
    HTML.Add('        };');
    HTML.Add('      }');
    HTML.Add('    }');
    HTML.Add('  }');
    HTML.Add('  build(root, json);');
    HTML.Add('}');
    HTML.Add('</script>');
    // --- End JSONViewer ---

    HTML.Add('</head><body>');
    HTML.Add('<div id="json" class="json-container"></div>');

    // Call viewer script
    HTML.Add('<script>');
    HTML.Add('var data = ' + aContent + ';');
    HTML.Add('createTree(document.getElementById("json"), data);');
    HTML.Add('</script>');

    HTML.Add('</body></html>');

    WebBrowserData.LoadFromStrings(HTML.Text, aURL);
  finally
    HTML.Free;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  tcContent.ActiveTab := tabSettings;
  MultiView1.HideMaster;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  tcContent.ActiveTab := tabData;
  MultiView1.HideMaster;
end;

procedure TForm1.cbVerbChange(Sender: TObject);
begin
  tabBody.Visible := cbVerb.ItemIndex in [1,2,3];
end;

procedure TForm1.edtEndPointKeyDown(Sender: TObject; var Key: Word; var
    KeyChar: WideChar; Shift: TShiftState);
begin
  if (Key in[10, 13]) then
    btnExecuteClick(btnExecute);
end;

procedure TForm1.btnExecuteClick(Sender: TObject);
begin
  // Check to see if the config has changed, if so we need new tokens
  if Assigned(FConfigData) and
    (
    (FConfigData.ServerDetails.HostURL <> YFUserFrame1.YF_URL) or
    (FConfigData.AdminCredentials.AdminUserName <> YFUserFrame1.YF_ADMIN_USER) or
    (FConfigData.AdminCredentials.AdminPassword <> YFUserFrame1.YF_ADMIN_PASSWORD) or
    (FConfigData.AdminCredentials.ClientOrg <> YFUserFrame1.YF_ORG)
    ) then
  begin
    // Clear
    FreeAndnil(FRefreshTokenManager);
    FreeAndnil(FAccessTokenManager);
    FreeAndnil(FConfigData);
  end;

  if not Assigned(FConfigData) then
  begin
    FConfigData := TYellowfinServerConfig.Create(
      YFUserFrame1.YF_URL,
      YFUserFrame1.YF_INSTANCE_NAME,
      YFUserFrame1.YF_ADMIN_USER,
      YFUserFrame1.YF_ADMIN_PASSWORD,
      YFUserFrame1.YF_ORG,
      YFUserFrame1.YF_TIMEOUT);
  end;

  GlowEffectURL.Enabled := False;

  if not Assigned(FRefreshTokenManager) then
    FRefreshTokenManager := TYFRefreshTokenManager.Create(FConfigData.ServerDetails, FConfigData.AdminCredentials);

  if not Assigned(FAccessTokenManager) then
    FAccessTokenManager := TYFAccessTokenManager.Create(FConfigData.ServerDetails, FRefreshTokenManager.RefreshToken.Token, True);

  var ReqVerb : TRESTRequestMethod :=  TYFTypes.GetValue<TRESTRequestMethod>('rm'+Uppercase(cbVerb.Text), TRESTRequestMethod.rmGET);

  var JBody := if ((memoBody.Lines.Text > '') and (tabBody.Visible)) then
                  TJSONObject.ParseJSONValue(memoBody.Lines.Text) as TJSONObject
               else
                  nil;

  var Transport := TYFTransport.Create(nil,
        ReqVerb,
        FConfigData.ServerDetails,
        edtEndPoint.Text,
        FAccessTokenManager.AccessToken,
        JBody); // no body required
  try
    try
      var R := Transport.Execute;

      SetStatus(R.Successful, R.Status.ToString, '');

      if not R.Successful then
      begin
        memoSource.Text := R.Data;

        var ErrorHTML := StringReplace(R.Data,'<head>','<head><meta name="color-scheme" content="light">',[TReplaceFlag.rfIgnoreCase]);
        ErrorHTML := StringReplace(ErrorHTML, 'body {', 'body {background-color: white; color: black;',[TReplaceFlag.rfIgnoreCase]);
        WebBrowserData.LoadFromStrings(ErrorHTML, edtEndPoint.Text);
        Exit;
      end;

      var JSONObject := TJSONObject.ParseJSONValue(R.Data) as TJSONObject;
      try
        var PrettyJSON : string := if Assigned(JSONObject) then
                               JSONObject.Format(2)
                             else
                               R.Data;
        MemoSource.Text := R.Data;

        LoadJSONView(PrettyJSON, edtEndPoint.Text);
      finally
        JSONObject.Free;
      end;

    finally
      Transport.Free;
    end;
  except
    on e:exception do
    begin
      SetStatus(False, 'Error', E.Message);
    end;
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if WebBrowserData.URL = '' then
  begin
    var Task := TTask.Create(procedure ()
       begin
         sleep (500); // 0.5 seconds while browser initiates
         var JSON := TJSONObject.Create;
          try
            Application.ProcessMessages;
            JSON.AddPair('Welcome to the', 'Yellowfin API Explorer');
            TThread.Synchronize(nil, procedure ()
            begin
              LoadJSONView(JSON.Format(2),'/welcome');
            end);
            Self.Caption := 'Loaded';
          finally
            JSON.Free
          end;
       end);
    Task.Start;
  end;
end;

procedure TForm1.MultiView1Hidden(Sender: TObject);
begin
  WebBrowserData.Visible := True;
end;

procedure TForm1.MultiView1StartShowing(Sender: TObject);
begin
  WebBrowserData.Visible := False;
end;

procedure TForm1.SetStatus(IsOK: Boolean; aCode, aMessage: string);
begin
  if IsOK then
    GlowEffectURL.GlowColor := TAlphaColorRec.Green
  else
    GlowEffectURL.GlowColor := TAlphaColorRec.Darkred;

  GlowEffectURL.Enabled := True;

  lblCode.Text := aCode;
  lblStatus.Text := aMessage;

end;

end.
