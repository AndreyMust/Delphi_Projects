unit DataExport;

interface

uses
  Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient, System.SysUtils,
  Generics.Collections, Vcl.Dialogs, ICalculator, IBusinessAPI1;

type

  IDataExport = interface
    function testSumm(x:integer; y: integer): integer;
    function EntityAdd(x:string): string;
    function EntityListAdd(list: TList<String>): TList<String>;
  end;

 TBaseExport = class(TInterfacedObject, IDataExport)
  private
    resultList: TList<String>;
  public
    constructor Create;
    destructor Destroy; override;
    function testSumm(x:integer; y: integer): integer; Virtual; Abstract;
    function EntityAdd(x:string): string; Virtual; Abstract;
    function EntityListAdd(list: TList<String>): TList<String>; Virtual; Abstract;
  end;

  TSOAPCalculator = class(TBaseExport)
  private
  public
    function testSumm(x:integer; y: integer): integer; Override;
    function EntityAdd(x:string): string; Override;
    function EntityListAdd(list: TList<String>): TList<String>; Override;
  end;

  TSOAPMekashron =  class(TBaseExport)
  private
  public
    function testSumm(x: integer; y: integer): integer; Override;
    function EntityAdd(x: string): string; Override;
    function EntityListAdd(list: TList<String>): TList<String>;  Override;
  end;

implementation


constructor TBaseExport.Create;
begin
  inherited;
  resultList := TList<String>.Create;
//  ShowMessage('TBaseExport Create');
end;

destructor TBaseExport.Destroy;
begin
//  ShowMessage('TBaseExport Destroy');
  resultList.Free;
  inherited;
end;

function TSOAPCalculator.testSumm(x: integer; y: integer): integer;
var
  Calculator: CalculatorSoap;
  res: integer;
begin
  Calculator := GetCalculatorSoap(false,'http://dneonline.com/calculator.asmx', nil);
  result := Calculator.Add(x, y);
end;

function TSOAPCalculator.EntityAdd(x:string): string;
begin
  result := 'test : TSOAPCalculator not support EntityAdd';
end;

function TSOAPCalculator.EntityListAdd(list: TList<String>): TList<String>;
begin
  resultList.Add('test : TSOAPCalculator not support EntityListAdd');
  result := resultList;
end;

function TSOAPMekashron.testSumm(x:integer; y: integer): integer;
begin
  result := x + y;
end;


function TSOAPMekashron.EntityAdd(x: string): string;
var
  BusinessAPI: IBusinessAPI;
begin
  BusinessAPI := GetIBusinessAPI(false,'', nil);
  result := BusinessAPI.Entity_Add(1, 'ol_UserName', 'ol_Password', 1, 1, 1,
                                   'Email', 'Password', 'FirstName', 'LastName',
                                   'Mobile', 'CountryISO', 1);
end;

function TSOAPMekashron.EntityListAdd(list: TList<String>): TList<String>;
var
  BusinessAPI: IBusinessAPI;
  res: string;
  i: integer;
begin
  BusinessAPI := GetIBusinessAPI(false,'', nil);
  for i := 0 to list.Count - 1 do
  begin
    res := BusinessAPI.Entity_Add(1, 'ol_UserName', 'ol_Password', 1, 1, 1,
                                   'Email', 'Password', 'FirstName', 'LastName',
                                   'Mobile', 'CountryISO', 1);
    resultList.Add(res);
  end;
  result := resultList;
end;

end.
