object Form1: TForm1
  Left = 189
  Top = 127
  Width = 496
  Height = 679
  Caption = 'Lab3'
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
  object lbl5: TLabel
    Left = 40
    Top = 184
    Width = 166
    Height = 23
    Caption = #1042#1099#1074#1086#1076' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 16
    Top = 80
    Width = 21
    Height = 18
    Caption = 'Y='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 24
    Width = 20
    Height = 18
    Caption = 'X='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object mmo1: TMemo
    Left = 40
    Top = 208
    Width = 401
    Height = 313
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'mmo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object btn1: TButton
    Left = 64
    Top = 560
    Width = 147
    Height = 49
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 272
    Top = 560
    Width = 147
    Height = 49
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btn2Click
  end
  object edt1: TEdit
    Left = 40
    Top = 80
    Width = 233
    Height = 21
    TabOrder = 3
    Text = '27'
  end
  object edt2: TEdit
    Left = 40
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object rg1: TRadioGroup
    Left = 304
    Top = 24
    Width = 153
    Height = 137
    Caption = 'f(x)'
    Color = clMenu
    Items.Strings = (
      'sh(x)'
      'x^2'
      'e^x')
    ParentColor = False
    TabOrder = 5
  end
  object btn3: TButton
    Left = 40
    Top = 128
    Width = 137
    Height = 33
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1092#1086#1088#1084#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btn3Click
  end
end
