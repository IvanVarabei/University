object Form3: TForm3
  Left = 256
  Top = 179
  Width = 342
  Height = 445
  Caption = 'lab11.3'
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
  object pb1: TPaintBox
    Left = 24
    Top = 16
    Width = 281
    Height = 241
  end
  object rg1: TRadioGroup
    Left = 64
    Top = 280
    Width = 185
    Height = 105
    Caption = #1055#1077#1088#1080#1086#1076
    ItemIndex = 2
    Items.Strings = (
      '200 '#1084#1089
      '500 '#1084#1089
      '1000 '#1084#1089)
    TabOrder = 0
    OnClick = rg1Click
  end
  object tmr1: TTimer
    Interval = 500
    OnTimer = tmr1Timer
  end
end
