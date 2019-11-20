object Form2: TForm2
  Left = 360
  Top = 207
  Width = 331
  Height = 193
  Caption = 'Alert1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 16
    Width = 305
    Height = 23
    Caption = 'Key and n are not mutually simple!!!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 56
    Top = 64
    Width = 191
    Height = 23
    Caption = 'Do you want to go on?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btn1: TButton
    Left = 32
    Top = 104
    Width = 105
    Height = 33
    Caption = 'OK'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 176
    Top = 104
    Width = 105
    Height = 33
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btn2Click
  end
end
