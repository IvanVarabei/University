object Form1: TForm1
  Left = 297
  Top = 172
  Width = 345
  Height = 384
  AutoSize = True
  Caption = 'lab11.1'
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
  object btn1: TButton
    Left = 24
    Top = 312
    Width = 177
    Height = 33
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 281
    Caption = 'pnl1'
    Color = clYellow
    TabOrder = 1
    object shp1: TShape
      Left = 128
      Top = 224
      Width = 41
      Height = 25
    end
    object img1: TImage
      Left = 32
      Top = 40
      Width = 265
      Height = 193
      Stretch = True
      Transparent = True
    end
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 8
    Top = 352
  end
end
