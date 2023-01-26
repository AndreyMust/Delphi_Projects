unit DataBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Generics.Collections, DBSettings;
type

  ISQLLoader = interface
    function getEntities(): TList<String>;
  end;

  TMySQLLoader = class(TInterfacedObject, ISQLLoader)
  private
    connection: TFDConnection;
    entities: TList<String>;
    procedure getConnection();
  public
    constructor Create;
    destructor Destroy; override;
    function getEntities: TList<String>;
  end;

implementation


constructor TMySQLLoader.Create;
begin
  inherited;
  connection := TFDConnection.Create(nil);
  entities := TList<String>.Create;
  //ShowMessage('MySQLLoader Create');
end;

destructor TMySQLLoader.Destroy;
begin
  //ShowMessage('TMySQLLoader.Destroy');
  connection.Free;
  entities.Free;
  inherited;
end;


procedure  TMySQLLoader.getConnection;
var
  DBSettings: IDBSettings;
begin
  DBSettings := TIniFileSettings.Create;
  DBSettings.initialLoading;

  connection.DriverName := DBSettings.getDriverName();
  connection.Params.Values['Server'] := DBSettings.getServer();
  connection.Params.Values['Port'] := '3306';
  connection.Params.Values['Database'] := 'base1';
  connection.Params.Values['User_Name'] := 'root';
  connection.Params.Values['Password'] := '';
end;

function TMySQLLoader.getEntities: TList<String>;
var
  FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
  Query:TFDQuery;
  i: Integer;
begin
  FDPhysMySQLDriverLink:= TFDPhysMySQLDriverLink.Create(nil);
  getConnection();
  Query := TFDQuery.Create(nil);
  try
    Connection.Connected := True;
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT * FROM callback';
    Query.Open;
    for i := 0 to Query.RecordCount - 1 do
    begin
      entities.Add(Query.FieldByName('Prefix').AsString);
      Query.Next;
    end;
    result := entities;
  finally
    Query.Free;
    FDPhysMySQLDriverLink.Free;
  end;
end;

end.
