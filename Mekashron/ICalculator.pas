// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Tools\Delphi_Projects\Project_3\Calculator.xml
//  >Import : C:\Tools\Delphi_Projects\Project_3\Calculator.xml>0
// Codegen  : [wfSkipUnusedTypes-]
// (23.01.2023 15:01:43 - - $Rev: 93209 $)
// ************************************************************************ //

unit ICalculator;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : CalculatorSoap
  // service   : Calculator
  // port      : CalculatorSoap
  // URL       : http://dneonline.com/calculator.asmx
  // ************************************************************************ //
  CalculatorSoap = interface(IInvokable)
  ['{42FA0556-A79E-45A1-65B8-EDB9F7C6702F}']
    function  Add(const intA: Integer; const intB: Integer): Integer; stdcall;
    function  Subtract(const intA: Integer; const intB: Integer): Integer; stdcall;
    function  Multiply(const intA: Integer; const intB: Integer): Integer; stdcall;
    function  Divide(const intA: Integer; const intB: Integer): Integer; stdcall;
  end;

function GetCalculatorSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CalculatorSoap;


implementation
  uses System.SysUtils;

function GetCalculatorSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CalculatorSoap;
const
  defWSDL = 'C:\Tools\Delphi_Projects\Project_3\Calculator.xml';
  defURL  = 'http://dneonline.com/calculator.asmx';
  defSvc  = 'Calculator';
  defPrt  = 'CalculatorSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as CalculatorSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { CalculatorSoap }
  InvRegistry.RegisterInterface(TypeInfo(CalculatorSoap), 'http://tempuri.org/', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CalculatorSoap), 'http://tempuri.org/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CalculatorSoap), ioDocument);
  { CalculatorSoap.Add }
  InvRegistry.RegisterMethodInfo(TypeInfo(CalculatorSoap), 'Add', '',
                                 '[ReturnName="AddResult"]');
  { CalculatorSoap.Subtract }
  InvRegistry.RegisterMethodInfo(TypeInfo(CalculatorSoap), 'Subtract', '',
                                 '[ReturnName="SubtractResult"]');
  { CalculatorSoap.Multiply }
  InvRegistry.RegisterMethodInfo(TypeInfo(CalculatorSoap), 'Multiply', '',
                                 '[ReturnName="MultiplyResult"]');
  { CalculatorSoap.Divide }
  InvRegistry.RegisterMethodInfo(TypeInfo(CalculatorSoap), 'Divide', '',
                                 '[ReturnName="DivideResult"]');

end.