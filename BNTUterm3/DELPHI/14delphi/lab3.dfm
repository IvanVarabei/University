object Form1: TForm1
  Left = 189
  Top = 127
  Width = 496
  Height = 236
  Caption = 'Lab3'
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
    Left = 16
    Top = 80
    Width = 25
    Height = 18
    Caption = 'res:'
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
  object edt1: TEdit
    Left = 40
    Top = 80
    Width = 233
    Height = 21
    TabOrder = 0
    Text = '27'
  end
  object edt2: TEdit
    Left = 40
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 1
    Text = '1'
    OnEnter = edt2Enter
  end
  object rg1: TRadioGroup
    Left = 304
    Top = 24
    Width = 153
    Height = 137
    Caption = 'f(x)'
    Color = clMenu
    ItemIndex = 0
    Items.Strings = (
      'f(x)'
      'sin(x)'
      'cos(x)'
      'tg(x)'
      'ctg(x)')
    ParentColor = False
    TabOrder = 2
  end
end
