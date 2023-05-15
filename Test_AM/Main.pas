unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections, DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Actions;

type

  TfrmMain = class(TForm)
    lblAction: TLabel;
    lblParam1: TLabel;
    lblParams: TLabel;
    lblResult: TLabel;
    edtParam1: TEdit;
    edtResult: TEdit;
    cbxActions: TComboBox;
    btnCalc: TButton;
    btnCleare: TButton;
    lblParam2: TLabel;
    edtParam2: TEdit;
    lblParam3: TLabel;
    edtParam3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure LoadActionsList;
    procedure ApplyParam;
    procedure cbxActionsChange(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure btnCleareClick(Sender: TObject);

  private
    { Private declarations }
    actionsProvider: TActionsProvider;
    paramList: TList<String>;
    procedure CalcByName;

  public
    { Public declarations }
  end;


var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.cbxActionsChange(Sender: TObject);
var
 i, paramCount: Integer;
 cmp: TComponent;
 paramList: TList<String>;
begin
  i:=cbxActions.ItemIndex;

  paramList := actionsProvider.GetParamList(i);
  paramCount := paramList.Count;

  edtParam2.Visible := paramCount >= 2;
  lblParam2.Visible := edtParam2.Visible;
  edtParam3.Visible := paramCount >= 3;
  lblParam3.Visible := edtParam3.Visible;

  for i := 1 to paramCount do
  begin
    cmp := FindComponent('lblParam'+IntToStr(i));
    (cmp as TLabel).Caption := paramList.List[i-1];
  end;
end;

procedure TfrmMain.ApplyParam;
var
  i, actionIndex: Integer;
  cmp: TComponent;
begin
  paramList.Clear;
  actionIndex := cbxActions.ItemIndex;
  for i := 1 to actionsProvider.GetParamList(actionIndex).Count do
  begin
    cmp := FindComponent('edtParam'+IntToStr(i));
    paramList.Add((cmp as TEdit).Text);
  end;
  actionsProvider.SetParamValues(actionIndex, paramList);
end;

procedure TfrmMain.btnCalcClick(Sender: TObject);
begin
  ApplyParam;
  edtResult.Text := actionsProvider.ExecuteByID(cbxActions.ItemIndex);
end;

procedure TfrmMain.btnCleareClick(Sender: TObject);
var
  i: Integer;
  cmp: TComponent;
begin
  for i := 1 to 3 do
  begin
    cmp := FindComponent('edtParam'+IntToStr(i));
    (cmp as TEdit).Text:= '';
  end;
  edtResult.Text := '';
end;


procedure TfrmMain.LoadActionsList;
var
  desc: string;
begin
  cbxActions.Items.Clear;

  for desc in actionsProvider.GetDesciptionList do
  begin
    cbxActions.Items.Add(desc);
  end;

  cbxActions.ItemIndex:=0;
  cbxActionsChange(self);
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Constraints.MinWidth := 465;
  Constraints.MinHeight := 200;

  actionsProvider := TActionsProvider.Create;
  paramList := TList<String>.Create;

  LoadActionsList;
  edtResult.Text := '';
end;

procedure TfrmMain.CalcByName;
var
  res: string;
begin
  res := actionsProvider.ExecuteByName('sum', ['1','2']);
  ShowMessage(res);
end;

end.
