program Test;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  Actions in 'Actions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
