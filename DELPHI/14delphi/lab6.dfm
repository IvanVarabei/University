object Form1: TForm1
  Left = 318
  Top = 143
  Width = 882
  Height = 623
  Caption = 'Lab6'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 96
    Top = 32
    Width = 45
    Height = 19
    Caption = #1060'.'#1048'.'#1054
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 248
    Top = 32
    Width = 101
    Height = 19
    Caption = #1085#1086#1084#1077#1088' '#1086#1090#1076#1077#1083#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 432
    Top = 32
    Width = 82
    Height = 19
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 640
    Top = 32
    Width = 150
    Height = 19
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1073#1086#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object cbb1: TComboBox
    Left = 24
    Top = 56
    Width = 209
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'cbb1'
  end
  object cbb2: TComboBox
    Left = 264
    Top = 56
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'cbb2'
  end
  object cbb3: TComboBox
    Left = 368
    Top = 56
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'cbb3'
  end
  object edt1: TEdit
    Left = 616
    Top = 56
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 680
    Top = 56
    Width = 49
    Height = 21
    TabOrder = 4
    Text = 'edt2'
  end
  object edt3: TEdit
    Left = 744
    Top = 56
    Width = 81
    Height = 21
    TabOrder = 5
    Text = 'edt3'
  end
  object btn1: TButton
    Left = 656
    Top = 104
    Width = 169
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 384
    Top = 528
    Width = 169
    Height = 33
    Caption = #1074#1099#1074#1077#1089#1090#1080' '#1089#1087#1080#1089#1082#1080' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 424
    Top = 168
    Width = 417
    Height = 337
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'mmo1')
    ParentFont = False
    TabOrder = 8
  end
  object btn3: TButton
    Left = 200
    Top = 528
    Width = 163
    Height = 33
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1092#1072#1081#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 16
    Top = 528
    Width = 161
    Height = 33
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 576
    Top = 528
    Width = 153
    Height = 33
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = btn5Click
  end
  object btn6: TBitBtn
    Left = 752
    Top = 528
    Width = 97
    Height = 33
    TabOrder = 12
    Kind = bkClose
  end
  object mmo2: TMemo
    Left = 16
    Top = 168
    Width = 401
    Height = 337
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'mmo2')
    ParentFont = False
    TabOrder = 13
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '.dat'
    FileName = 'C:\Program Files (x86)\Borland\Delphi7\Projects\'#1092#1072#1081#1083#1099'\denis'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '*.txt'
    FileName = 
      'C:\Program Files (x86)\Borland\Delphi7\Projects\'#1092#1072#1081#1083#1099'\workers4.t' +
      'xt'
    Left = 24
  end
end
