program Mekashron;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  DataBase in 'DataBase.pas',
  DBSettings in 'DBSettings.pas',
  DataExport in 'DataExport.pas',
  ICalculator in 'ICalculator.pas',
  IBusinessAPI1 in 'IBusinessAPI1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
