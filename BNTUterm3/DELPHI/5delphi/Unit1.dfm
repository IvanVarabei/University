object Form1: TForm1
  Left = 207
  Top = 187
  Width = 372
  Height = 343
  Caption = 'Group Counter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 8
    Width = 132
    Height = 23
    Caption = 'Write a string : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 224
    Width = 90
    Height = 23
    Caption = 'Answere : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 112
    Top = 224
    Width = 10
    Height = 23
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 160
    Width = 156
    Height = 19
    Caption = 'Enter searched word :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 8
    Top = 192
    Width = 90
    Height = 19
    Caption = 'It is facing : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl6: TLabel
    Left = 104
    Top = 192
    Width = 55
    Height = 19
    Caption = 'number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btn1: TBitBtn
    Left = 80
    Top = 256
    Width = 169
    Height = 33
    TabOrder = 0
    Kind = bkClose
  end
  object cbb1: TComboBox
    Left = 16
    Top = 40
    Width = 321
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'Looking for amont of substrings which contain only 5 symbols '
    OnClick = cbb1Click
    OnKeyPress = cbb1KeyPress
  end
  object edt1: TEdit
    Left = 184
    Top = 160
    Width = 137
    Height = 21
    TabOrder = 2
    Text = 'edt1'
  end
end
