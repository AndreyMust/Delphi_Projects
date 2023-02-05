program OrgStructure;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  DataProvider in 'DataProvider.pas',
  DataController in 'DataController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
