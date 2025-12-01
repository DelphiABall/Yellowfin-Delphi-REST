program YFAPIExplorer;

uses
  System.StartUpCopy,
  FMX.Forms,
  formMain in 'formMain.pas' {Form1},
  frameYFUser in 'frameYFUser.pas' {YFUserFrame: TFrame},
  REST.Transport in '..\..\Source\REST.Transport.pas',
  yellowfinbi.api.common in '..\..\Source\yellowfinbi.api.common.pas',
  yellowfinbi.api.security in '..\..\Source\yellowfinbi.api.security.pas',
  yellowfinbi.api.security.tokenManager.intf in '..\..\Source\yellowfinbi.api.security.tokenManager.intf.pas',
  yellowfinbi.api.security.tokenManager in '..\..\Source\yellowfinbi.api.security.tokenManager.pas',
  yellowfinbi.api.transport in '..\..\Source\yellowfinbi.api.transport.pas',
  yellowfinbi.api.transport.token in '..\..\Source\yellowfinbi.api.transport.token.pas',
  yellowfinbi.api.transport.classes in '..\..\Source\yellowfinbi.api.transport.classes.pas',
  yellowfinbi.api.json in '..\..\Source\yellowfinbi.api.json.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
