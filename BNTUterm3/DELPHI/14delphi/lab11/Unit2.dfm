object Form2: TForm2
  Left = 253
  Top = 191
  Width = 340
  Height = 443
  Caption = 'lab11.2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object shp1: TShape
    Left = 32
    Top = 8
    Width = 257
    Height = 169
    Brush.Color = clRed
    Shape = stEllipse
  end
  object rg1: TRadioGroup
    Left = 72
    Top = 200
    Width = 185
    Height = 145
    Caption = #1042#1099#1073#1080#1088#1077#1090#1077' '#1092#1080#1075#1091#1088#1091
    ItemIndex = 0
    Items.Strings = (
      #1082#1088#1091#1075
      #1082#1074#1072#1076#1088#1072#1090
      #1087#1088#1103#1084#1086#1091#1075#1086#1083#1100#1085#1080#1082
      #1089#1082#1088#1091#1075#1083#1077#1085#1085#1099#1081' '#1082#1074#1072#1076#1088#1072#1090)
    TabOrder = 0
  end
  object btn1: TButton
    Left = 120
    Top = 368
    Width = 91
    Height = 25
    Caption = #1053#1072#1088#1080#1089#1086#1074#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btn1Click
  end
end
