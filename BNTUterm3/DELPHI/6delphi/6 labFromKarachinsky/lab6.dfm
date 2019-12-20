object Form1: TForm1
  Left = 264
  Top = 129
  Width = 833
  Height = 452
  Caption = 'Vararbei Ivan laba6'
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
    Left = 16
    Top = 8
    Width = 169
    Height = 19
    Caption = 'Poke a name of person:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 40
    Width = 146
    Height = 19
    Caption = 'Enter office number:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 16
    Top = 72
    Width = 96
    Height = 19
    Caption = 'Enter degree:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 16
    Top = 112
    Width = 178
    Height = 19
    Caption = 'Enter date of enrollment:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 16
    Top = 176
    Width = 99
    Height = 19
    Caption = 'Before sorting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 432
    Top = 176
    Width = 89
    Height = 19
    Caption = 'After sorting'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object cbb1: TComboBox
    Left = 208
    Top = 8
    Width = 209
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'cbb1'
  end
  object cbb2: TComboBox
    Left = 208
    Top = 40
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'cbb2'
  end
  object cbb3: TComboBox
    Left = 208
    Top = 72
    Width = 201
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'cbb3'
  end
  object edt1: TEdit
    Left = 208
    Top = 112
    Width = 49
    Height = 21
    TabOrder = 3
    Text = 'edt1'
  end
  object edt2: TEdit
    Left = 280
    Top = 112
    Width = 49
    Height = 21
    TabOrder = 4
    Text = 'edt2'
  end
  object edt3: TEdit
    Left = 344
    Top = 112
    Width = 81
    Height = 21
    TabOrder = 5
    Text = 'edt3'
  end
  object btn1: TButton
    Left = 448
    Top = 120
    Width = 169
    Height = 33
    Caption = 'Add new person'
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
    Left = 632
    Top = 8
    Width = 169
    Height = 33
    Caption = 'Sort by offices'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 424
    Top = 208
    Width = 385
    Height = 193
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
    Left = 448
    Top = 64
    Width = 163
    Height = 33
    Caption = 'Create new file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 448
    Top = 8
    Width = 161
    Height = 33
    Caption = 'Open existing file'
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
    Left = 632
    Top = 64
    Width = 169
    Height = 33
    Caption = 'Save to text file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnClick = btn5Click
  end
  object btn6: TBitBtn
    Left = 632
    Top = 120
    Width = 169
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    Kind = bkClose
  end
  object mmo2: TMemo
    Left = 8
    Top = 208
    Width = 385
    Height = 193
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
    Left = 264
    Top = 160
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '*.txt'
    FileName = 'C:\maze\DELPHI\6delphi\6 labFromKarachinsky\employees.txt'
    Left = 184
    Top = 152
  end
end
