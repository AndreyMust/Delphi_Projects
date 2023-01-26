unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Generics.Collections,
  DataBase, DataExport;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  SQLLoader : ISQLLoader;
  DataExport: IDataExport;
  SOAPCalculator: TSOAPCalculator;
  SOAPMekashron:TSOAPMekashron;
  res: string;
  listEntities: TList<String>;
  listResults: TList<String>;
  value: string;
begin
  SQLLoader := TMySQLLoader.Create();

  listEntities := SQLLoader.getEntities();

  //DataExport := TSOAPCalculator.Create;
  DataExport := TSOAPMekashron.Create;

  Memo.Lines.Add(DataExport.EntityAdd('one'));
  listResults := DataExport.EntityListAdd(listEntities);

  if Assigned(listResults) then
  begin
    for res in listResults do
    begin
      Memo.Lines.Add(res);
    end;
  end;

end;

end.
