unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, DataController;

type
  TfrmMain = class(TForm)
    btnStart: TButton;
    OrgStructureTree: TTreeView;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnStartClick(Sender: TObject);
var
  DataController: IDataController;
begin
  DataController := TDataController.Create;
  DataController.FillEmployeesList(OrgStructureTree);
end;

end.
