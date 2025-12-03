program YF_VCL_Sample;



uses
  Vcl.Forms,
  REST.Transport in '..\..\Source\REST.Transport.pas',
  yellowfinbi.api.cache.intf in '..\..\Source\yellowfinbi.api.cache.intf.pas',
  yellowfinbi.api.cache in '..\..\Source\yellowfinbi.api.cache.pas',
  yellowfinbi.api.categories.classes in '..\..\Source\yellowfinbi.api.categories.classes.pas',
  yellowfinbi.api.categories.intf in '..\..\Source\yellowfinbi.api.categories.intf.pas',
  yellowfinbi.api.categories in '..\..\Source\yellowfinbi.api.categories.pas',
  yellowfinbi.api.classes in '..\..\Source\yellowfinbi.api.classes.pas',
  yellowfinbi.api.classfactory in '..\..\Source\yellowfinbi.api.classfactory.pas',
  yellowfinbi.api.common in '..\..\Source\yellowfinbi.api.common.pas',
  yellowfinbi.api.content.classes in '..\..\Source\yellowfinbi.api.content.classes.pas',
  yellowfinbi.api.content.intf in '..\..\Source\yellowfinbi.api.content.intf.pas',
  yellowfinbi.api.content in '..\..\Source\yellowfinbi.api.content.pas',
  yellowfinbi.api.dashboards.classes in '..\..\Source\yellowfinbi.api.dashboards.classes.pas',
  yellowfinbi.api.dashboards.intf in '..\..\Source\yellowfinbi.api.dashboards.intf.pas',
  yellowfinbi.api.dashboards in '..\..\Source\yellowfinbi.api.dashboards.pas',
  yellowfinbi.api.datasources.classes in '..\..\Source\yellowfinbi.api.datasources.classes.pas',
  yellowfinbi.api.datasources.intf in '..\..\Source\yellowfinbi.api.datasources.intf.pas',
  yellowfinbi.api.datasources in '..\..\Source\yellowfinbi.api.datasources.pas',
  yellowfinbi.api.filters.classes in '..\..\Source\yellowfinbi.api.filters.classes.pas',
  yellowfinbi.api.filters.intf in '..\..\Source\yellowfinbi.api.filters.intf.pas',
  yellowfinbi.api.health.classes in '..\..\Source\yellowfinbi.api.health.classes.pas',
  yellowfinbi.api.health.intf in '..\..\Source\yellowfinbi.api.health.intf.pas',
  yellowfinbi.api.health in '..\..\Source\yellowfinbi.api.health.pas',
  yellowfinbi.api.images.classes in '..\..\Source\yellowfinbi.api.images.classes.pas',
  yellowfinbi.api.images.intf in '..\..\Source\yellowfinbi.api.images.intf.pas',
  yellowfinbi.api.images in '..\..\Source\yellowfinbi.api.images.pas',
  yellowfinbi.api.intf in '..\..\Source\yellowfinbi.api.intf.pas',
  yellowfinbi.api.json.generics in '..\..\Source\yellowfinbi.api.json.generics.pas',
  yellowfinbi.api.json in '..\..\Source\yellowfinbi.api.json.pas',
  yellowfinbi.api.orgs.classes in '..\..\Source\yellowfinbi.api.orgs.classes.pas',
  yellowfinbi.api.orgs.intf in '..\..\Source\yellowfinbi.api.orgs.intf.pas',
  yellowfinbi.api.orgs in '..\..\Source\yellowfinbi.api.orgs.pas',
  yellowfinbi.api in '..\..\Source\yellowfinbi.api.pas',
  yellowfinbi.api.presentations.classes in '..\..\Source\yellowfinbi.api.presentations.classes.pas',
  yellowfinbi.api.presentations.intf in '..\..\Source\yellowfinbi.api.presentations.intf.pas',
  yellowfinbi.api.presentations in '..\..\Source\yellowfinbi.api.presentations.pas',
  yellowfinbi.api.reports.classes in '..\..\Source\yellowfinbi.api.reports.classes.pas',
  yellowfinbi.api.reports.intf in '..\..\Source\yellowfinbi.api.reports.intf.pas',
  yellowfinbi.api.reports in '..\..\Source\yellowfinbi.api.reports.pas',
  yellowfinbi.api.roles.classes in '..\..\Source\yellowfinbi.api.roles.classes.pas',
  yellowfinbi.api.roles.intf in '..\..\Source\yellowfinbi.api.roles.intf.pas',
  yellowfinbi.api.roles in '..\..\Source\yellowfinbi.api.roles.pas',
  yellowfinbi.api.security in '..\..\Source\yellowfinbi.api.security.pas',
  yellowfinbi.api.security.tokenManager.intf in '..\..\Source\yellowfinbi.api.security.tokenManager.intf.pas',
  yellowfinbi.api.security.tokenManager in '..\..\Source\yellowfinbi.api.security.tokenManager.pas',
  yellowfinbi.api.template in '..\..\Source\yellowfinbi.api.template.pas',
  yellowfinbi.api.transport.classes in '..\..\Source\yellowfinbi.api.transport.classes.pas',
  yellowfinbi.api.transport.generics in '..\..\Source\yellowfinbi.api.transport.generics.pas',
  yellowfinbi.api.transport in '..\..\Source\yellowfinbi.api.transport.pas',
  yellowfinbi.api.transport.token in '..\..\Source\yellowfinbi.api.transport.token.pas',
  yellowfinbi.api.userGroups.classes in '..\..\Source\yellowfinbi.api.userGroups.classes.pas',
  yellowfinbi.api.userGroups.intf in '..\..\Source\yellowfinbi.api.userGroups.intf.pas',
  yellowfinbi.api.userGroups in '..\..\Source\yellowfinbi.api.userGroups.pas',
  yellowfinbi.api.users.classes in '..\..\Source\yellowfinbi.api.users.classes.pas',
  yellowfinbi.api.users.intf in '..\..\Source\yellowfinbi.api.users.intf.pas',
  yellowfinbi.api.users in '..\..\Source\yellowfinbi.api.users.pas',
  FormYFMain in 'FormYFMain.pas' {Form1},
  Frames.User.Login in 'Frames.User.Login.pas' {frameUserLogin: TFrame},
  Yellowfin.Settings in 'Yellowfin.Settings.pas',
  Yellowfin.Settings.INI in 'Yellowfin.Settings.INI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
