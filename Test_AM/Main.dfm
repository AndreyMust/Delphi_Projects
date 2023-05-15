object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #1058#1077#1089#1090#1086#1074#1086#1077' '#1047#1072#1076#1072#1085#1080#1077
  ClientHeight = 141
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAction: TLabel
    Left = 16
    Top = 16
    Width = 67
    Height = 16
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblParam1: TLabel
    Left = 64
    Top = 60
    Width = 35
    Height = 16
    Alignment = taRightJustify
    Caption = #1063#1080#1089#1083#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblParams: TLabel
    Left = 16
    Top = 38
    Width = 83
    Height = 16
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblResult: TLabel
    Left = 25
    Top = 82
    Width = 74
    Height = 16
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblParam2: TLabel
    Left = 199
    Top = 60
    Width = 35
    Height = 16
    Alignment = taRightJustify
    Caption = #1063#1080#1089#1083#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblParam3: TLabel
    Left = 336
    Top = 60
    Width = 35
    Height = 16
    Alignment = taRightJustify
    Caption = #1063#1080#1089#1083#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtParam1: TEdit
    Left = 105
    Top = 55
    Width = 56
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object edtResult: TEdit
    Left = 105
    Top = 82
    Width = 328
    Height = 21
    Enabled = False
    TabOrder = 4
    Text = 'edtResult'
  end
  object cbxActions: TComboBox
    Left = 105
    Top = 16
    Width = 328
    Height = 21
    TabOrder = 0
    Text = 'cbxActions'
    OnChange = cbxActionsChange
    Items.Strings = (
      #1048#1079#1074#1083#1077#1095#1077#1085#1080#1077' '#1082#1074#1072#1076#1088#1072#1090#1085#1086#1075#1086' '#1082#1086#1088#1085#1103
      #1059#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1076#1072#1090#1099)
  end
  object btnCalc: TButton
    Left = 105
    Top = 108
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Default = True
    TabOrder = 5
    OnClick = btnCalcClick
  end
  object btnCleare: TButton
    Left = 358
    Top = 108
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = btnCleareClick
  end
  object edtParam2: TEdit
    Left = 240
    Top = 55
    Width = 56
    Height = 21
    TabOrder = 2
    Text = '2'
  end
  object edtParam3: TEdit
    Left = 377
    Top = 55
    Width = 56
    Height = 21
    TabOrder = 3
    Text = '3'
  end
end
