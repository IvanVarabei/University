object Form1: TForm1
  Left = 324
  Top = 117
  Width = 616
  Height = 679
  Caption = 'Lab 5'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 64
    Top = 56
    Width = 105
    Height = 18
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object cbb1: TComboBox
    Left = 64
    Top = 80
    Width = 481
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnKeyPress = cbb1KeyPress
  end
  object mmo1: TMemo
    Left = 64
    Top = 280
    Width = 481
    Height = 169
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'mmo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn1: TButton
    Left = 176
    Top = 568
    Width = 249
    Height = 41
    Caption = #1071#1074#1083#1103#1077#1090#1089#1103' '#1083#1080' '#1089#1090#1088#1086#1082#1072' '#1087#1086#1083#1080#1085#1076#1088#1086#1084#1086#1084'?'
    TabOrder = 2
    OnClick = btn1Click
  end
  object btn2: TBitBtn
    Left = 496
    Top = 24
    Width = 97
    Height = 25
    TabOrder = 3
    Kind = bkClose
  end
  object edt1: TEdit
    Left = 64
    Top = 128
    Width = 481
    Height = 21
    TabOrder = 4
  end
  object btn3: TButton
    Left = 176
    Top = 504
    Width = 249
    Height = 41
    Caption = #1053#1072#1081#1090#1080' '#1087#1086#1076#1089#1090#1088#1086#1082#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 64
    Top = 176
    Width = 137
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1092#1086#1088#1084#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btn4Click
  end
end
