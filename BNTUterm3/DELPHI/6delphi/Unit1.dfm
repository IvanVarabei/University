object Form1: TForm1
  Left = 229
  Top = 185
  Width = 480
  Height = 449
  Caption = 'DataBase'
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
  object lbl1: TLabel
    Left = 16
    Top = 16
    Width = 49
    Height = 23
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 56
    Width = 65
    Height = 23
    Caption = 'Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 16
    Top = 96
    Width = 182
    Height = 23
    Caption = 'Number of  workshop'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edt1: TEdit
    Left = 208
    Top = 16
    Width = 137
    Height = 21
    TabOrder = 0
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 208
    Top = 96
    Width = 137
    Height = 21
    TabOrder = 1
    Text = 'edt2'
  end
  object edt3: TEdit
    Left = 208
    Top = 56
    Width = 137
    Height = 21
    TabOrder = 2
    Text = 'edt3'
  end
  object mmo1: TMemo
    Left = 32
    Top = 144
    Width = 401
    Height = 193
    Lines.Strings = (
      'mmo1')
    TabOrder = 3
  end
  object btn2: TButton
    Left = 24
    Top = 352
    Width = 57
    Height = 25
    Caption = 'Create'
    TabOrder = 4
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 96
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 5
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 184
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Sort'
    TabOrder = 6
    OnClick = btn4Click
  end
  object btn1: TButton
    Left = 368
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Enter record'
    TabOrder = 7
    OnClick = btn1Click
  end
  object btn5: TButton
    Left = 272
    Top = 352
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 8
    OnClick = btn5Click
  end
  object btn6: TBitBtn
    Left = 360
    Top = 352
    Width = 75
    Height = 25
    TabOrder = 9
    OnClick = btn6Click
    Kind = bkClose
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '.dat.'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.dat|'#1042#1089#1077' '#1092#1072#1081#1083#1099' |*.*'
    Left = 392
    Top = 8
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '.txt.'
    Filter = #1060#1072#1081#1083' '#1076#1072#1085#1085#1099#1093'|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Left = 392
    Top = 48
  end
end
