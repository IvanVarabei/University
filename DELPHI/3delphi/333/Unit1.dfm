object Form1: TForm1
  Left = 198
  Top = 151
  Width = 337
  Height = 321
  Caption = 'Additioner'
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
    Width = 87
    Height = 23
    Caption = 'Shove n : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edt1: TEdit
    Left = 144
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '365234'
  end
  object mmo1: TMemo
    Left = 16
    Top = 72
    Width = 289
    Height = 129
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object btn1: TButton
    Tag = 1
    Left = 104
    Top = 224
    Width = 129
    Height = 33
    Cancel = True
    Caption = 'Execute'
    Default = True
    TabOrder = 2
  end
end
