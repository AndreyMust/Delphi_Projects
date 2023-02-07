unit DataProvider;

interface

uses
  Vcl.ComCtrls, Vcl.Dialogs, System.SysUtils, Ora, OraCall, System.Generics.Collections;

type

  TEmployee = record
    Name: string;
    Id: integer;
  end;

  IDataProvider = interface
    function GetChildEmployeesList(managerId:integer): TList<TEmployee>;
    procedure Connect;
  end;

  TOracleDataProvider = class (TInterfacedObject, IDataProvider)
    private
      OraSession: TOraSession;
      OraQuery: TOraQuery;
      function MakeSQL(managerId: integer):string;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Connect;
      function GetChildEmployeesList(managerId:integer): TList<TEmployee>;
  end;

implementation

constructor TOracleDataProvider.Create;
begin
  OraSession := TOraSession.Create(nil);
  OraQuery := TOraQuery.Create(nil);
  OraQuery.Session := OraSession;
end;

destructor TOracleDataProvider.Destroy;
begin
//  ShowMessage('TOracleDataProvider.Destroy');
  OraSession.Free;
  OraQuery.Free;
end;

procedure TOracleDataProvider.Connect;
begin
  OraSession.ConnectString := 'Direct=True;' +
                              'Home Name=orcl' +
                              'Host=localhost;' +
                              'User ID=;' +
                              'Password=;' +
                              'Login Prompt=False';
  OraSession.Connect;
end;

function TOracleDataProvider.MakeSQL(managerId: integer):string;
begin
  if (managerId = -1) then
    result := 'select * from scott.emp where mgr is null'
  else
    result := 'select * from scott.emp where mgr = ' + IntToStr(managerId);
end;

function TOracleDataProvider.GetChildEmployeesList(managerId:integer): TList<TEmployee>;
var
  employeeList: TList<TEmployee>;
  employeeNode: TEmployee;
  i: integer;
begin
  employeeList := TList<TEmployee>.Create;

  OraQuery.SQL.Add(MakeSQL(managerId));
  OraQuery.Open;

  for i := 0 to OraQuery.RecordCount - 1 do
  begin
    employeeNode.Name := OraQuery.FieldByName('ename').AsString;
    employeeNode.Id := OraQuery.FieldByName('empno').AsInteger;
    employeeList.Add(employeeNode);
    OraQuery.Next;
  end;

  result := employeeList;
  OraQuery.Close;
  OraQuery.SQL.Clear;
end;

end.
