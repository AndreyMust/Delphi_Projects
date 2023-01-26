unit DBSettings;

interface

uses System.SysUtils, Generics.Collections, IniFiles, Vcl.Dialogs;

type

  IDBSettings = interface
    procedure initialLoading;
    function getDriverName: string;
    function getServer: string;
    //function getPort(): string;
    //function getDatabase(): string;
    //function getUser_Name(): string;
    //function getPassword(): string;
  end;

  THardCodeSettings = class(TInterfacedObject, IDBSettings)
  public
    { Public declarations }
    procedure initialLoading;
    function getDriverName: string;
    function getServer: string;
    //function getPort(): string;
    //function getDatabase(): string;
    //function getUser_Name(): string;
    //function getPassword(): string;
  end;

  TIniFileSettings = class(TInterfacedObject, IDBSettings)
  private
    settings : TDictionary<string,string>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure initialLoading;
    function getDriverName(): string;
    function getServer(): string;
    //function getPort(): string;
    //function getDatabase(): string;
    //function getUser_Name(): string;
    //function getPassword(): string;
  end;

implementation

procedure THardCodeSettings.initialLoading();
begin
end;

function THardCodeSettings.getDriverName():string;
begin
  result := 'MySQL';
end;

function THardCodeSettings.getServer():string;
begin
  result := 'localhost';
end;


constructor TIniFileSettings.Create;
begin
  inherited;
  settings := TDictionary<string,string>.Create;
end;

destructor TIniFileSettings.Destroy;
begin
//  ShowMessage('TIniFileSettings Destroy');
  inherited;
end;

procedure TIniFileSettings.initialLoading();
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(extractfilepath(paramstr(0))+'Mekashron.ini');
  try
    settings.Add('DriverName', Ini.ReadString('MySQL','DriverName', 'MySQL'));
    settings.Add('Server', Ini.ReadString('MySQL','Server', 'localhost'));
    settings.Add('Port', Ini.ReadString('MySQL','Port', '3306'));
    settings.Add('Database', Ini.ReadString('MySQL','Database', 'base1'));
    settings.Add('User_Name', Ini.ReadString('MySQL','User_Name', 'root'));
    settings.Add('Password', Ini.ReadString('MySQL','Password', ''));
  finally
    ini.Free;
  end;
end;

function TIniFileSettings.getDriverName():string;
begin
  result := settings.Items['DriverName'];  //'MySQL';
end;

function TIniFileSettings.getServer():string;
begin
  result := settings.Items['Server']; //'localhost';
end;


end.
