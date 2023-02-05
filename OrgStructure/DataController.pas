unit DataController;

interface

uses
  Vcl.ComCtrls, Vcl.Dialogs, System.SysUtils, System.Generics.Collections,
  DataProvider;

type
  IDataController = interface
    procedure FillEmployeesList(TreeView: TTreeView);
  end;

  TDataController = class (TInterfacedObject, IDataController)
    private
      DataProvider: IDataProvider;
      function GetManagerID(Node: TTreeNode): integer;
      procedure AddEmployeesNode(startNode: TTreeNode; TreeView: TTreeView);
    public
      procedure FillEmployeesList(TreeView: TTreeView);
  end;

implementation

function  TDataController.GetManagerID(Node: TTreeNode): integer;
begin
  result := -1;
  if (assigned(Node)) then
    result := Integer(Node.Data);
end;

procedure TDataController.AddEmployeesNode(startNode: TTreeNode; TreeView: TTreeView);
var
  employeeList: TList<TEmployee>;
  employee: TEmployee;
  curNode: TTreeNode;
  managerId: integer;
begin
  managerId := GetManagerID(startNode);
  employeeList := DataProvider.GetChildEmployeesList(managerId);

  try
    for employee in employeeList do
    begin
      if not assigned(startNode) then
        curNode := TreeView.Items.AddObject(nil,
                                            employee.Name,
                                            pointer(employee.Id))
      else
        curNode := TreeView.Items.AddChildObject(startNode,
                                                 employee.Name,
                                                 pointer(employee.Id));

      AddEmployeesNode(curNode, TreeView);
    end;
  finally
    if (assigned(employeeList)) then
      employeeList.Free;
  end;

end;

procedure TDataController.FillEmployeesList(TreeView: TTreeView);
begin
  //Можно назначит любой поставщик SQL-данных
  DataProvider := TOracleDataProvider.Create;
  DataProvider.Connect;
  AddEmployeesNode(nil, TreeView);
end;

end.
