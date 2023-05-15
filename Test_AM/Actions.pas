unit Actions;

interface

uses
  Vcl.ComCtrls, Vcl.Dialogs, System.SysUtils, System.Generics.Collections,
  DateUtils;

type

  TParam = record
    description: string;
    value: string;
  end;

  TFunct_1par_Ref = reference to function(A: String): String;
  TFunct_2par_Ref = reference to function(A, B: String): String;
  TFunct_3par_Ref = reference to function(A, B, C: String): String;
  TFunct_4par_Ref = reference to function(A, B, C, D: String): String;

  TAction = class
    shortName: string;
    description: string;
    params: TList<TParam>;
  private
    Funct_1par: TFunct_1par_Ref;
    Funct_2par: TFunct_2par_Ref;
    Funct_3par: TFunct_3par_Ref;
    Funct_4par: TFunct_4par_Ref;
    function checkParam: boolean;
  public
    constructor Create(desc: string);
    procedure AddParam(desc: string);
    function Calculate: string;
  end;

  TActionsProvider = class
  private
    actionList: TList<TAction>;
    desciptionList: TList<String>;
    paramList: TList<String>;
    actionDictionary: TDictionary<String, TAction>;
  public
    constructor Create;
    function ExecuteByName(funcName: string; values: array of string): string;overload;
    function GetDesciptionList:TList<String>;
    function GetParamList(index: integer):TList<String>;
    procedure SetParamValues(index: integer; values:TList<String>);
    function ExecuteByID(index: integer):string;
  end;

implementation


constructor TAction.Create(desc: string);
begin
  self.description := desc;
  self.params := TList<TParam>.Create;
end;

procedure TAction.AddParam(desc: string);
var
  param : TParam;
begin
  param.description := desc;
  params.Add(param);
end;

function TAction.checkParam:boolean;
var
  str: String;
  param: TParam;
  i: Integer;
begin
  result := false;

  for param in self.params do
  begin
    str := param.value;
    if (str = '') then
    begin
      ShowMessage('Не задан параметер '+ param.description);
      exit;
    end;

    for i := 1 to str.Length do
    begin
      if not (ANSIChar(str[i]) in ['0'..'9', '.', ',','-']) then
      begin
        ShowMessage('Недопустимые символы в параметре ' + param.description);
        exit;
      end;
    end;
  end;

  result := true;
end;

function TAction.Calculate:string;
begin
  result := '';

  if (checkParam) then
  begin

    if (params.Count = 1) and assigned(Funct_1par) then
      result := Funct_1par(params.Items[0].value);

    if (params.Count = 2) and assigned(Funct_2par) then
      result := Funct_2par(params.Items[0].value, params.Items[1].value);

    if (params.Count = 3) and assigned(Funct_3par) then
      result := Funct_3par(params.Items[0].value,
                           params.Items[1].value,
                           params.Items[2].value
                           );

    if (params.Count = 4) and assigned(Funct_4par) then
      result := Funct_4par(params.Items[0].value,
                           params.Items[1].value,
                           params.Items[2].value,
                           params.Items[3].value
                           );
  end
end;


function TActionsProvider.ExecuteByID(index: integer):string;
begin
  result := actionList.List[index].Calculate;
end;

function TActionsProvider.ExecuteByName(funcName: string; values: array of String): string;
var
  action: TAction;
  i: integer;
begin
  if (actionDictionary.TryGetValue(funcName, action) = True) then
  begin
    if (action.params.Count <= length(values)) then
    begin
      for i := 1 to action.params.Count do
        action.params.List[i-1].value := values[i-1];

      result := action.Calculate;
    end
    else
      result := 'Не указаны обязательные параметры';
  end
  else
    result := 'Действие '+ funcName + 'не найдено.';

end;

function TActionsProvider.GetDesciptionList:TList<String>;
begin
  result := desciptionList;
end;

function TActionsProvider.GetParamList(index: integer):TList<String>;
var
  param:TParam;
begin
  paramList.Clear;
  for param in actionList.List[index].params do
    paramList.Add(param.description);

  result := paramList;
end;

procedure TActionsProvider.SetParamValues(index: integer; values:TList<String>);
var
  i: Integer;
begin
  if (actionList.List[index].params.Count >= values.Count) then
    for i := 1 to values.Count do
      actionList.List[index].params.List[i-1].value := values.List[i-1];
end;

constructor TActionsProvider.Create;
var
  action: TAction;
  action1: TAction;
  action2: TAction;
  action3: TAction;
  summ: TFunct_2par_Ref;
  sqr: TFunct_1par_Ref;
begin
  action1 := TAction.Create('Извлечение квадратного корня');
  action1.shortName := 'sqrt';
  action1.AddParam('Число');

  sqr := function (X: string): string
  begin
    try
      Result := FloatToStr(sqrt(StrToInt(X)));
    except
     on e:exception do
      ShowMessage('Ошибка преобразования: ' + e.Message);
    end;
  end;
  action1.Funct_1par := sqr;

  action2 := TAction.Create('Расчет суммы чисел');
  action2.shortName := 'sum';
  action2.AddParam('Число1');
  action2.AddParam('Число2');
  summ := function (X, Y: string): string
  begin
    try
      Result := FloatToStr(StrToFloat(X) + StrToFloat(Y));
    except
     on e:exception do
      ShowMessage('Ошибка преобразования: ' + e.Message);
    end;
  end;
  action2.Funct_2par := summ;

  action3 := TAction.Create('Изменение даты');
  action3.shortName := 'dateAdd';
  action3.AddParam('Нач дата');
  action3.AddParam('День');
  action3.AddParam('Месяц');

  action3.Funct_3par := function (A, B, C: string): string
  begin
    try
      Result := DateToStr(IncMonth(IncDay(StrToDate(A), StrToInt(B)),StrToInt(C)));
    except
     on e:exception do
      ShowMessage('Ошибка преобразования: ' + e.Message);
    end;
  end;

  actionList := TList<TAction>.Create;
  actionList.Add(action1);
  actionList.Add(action2);
  actionList.Add(action3);

  actionDictionary := TDictionary<String, TAction>.Create;
  actionDictionary.Add(action1.shortName, action1);
  actionDictionary.Add(action2.shortName, action2);
  actionDictionary.Add(action3.shortName, action3);

  desciptionList := TList<String>.Create;
  for action in actionList do
    desciptionList.Add(action.description);

  paramList := TList<String>.Create;
end;


end.



