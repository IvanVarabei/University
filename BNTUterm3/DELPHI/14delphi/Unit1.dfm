object Form1: TForm1
  Left = 202
  Top = 211
  Width = 437
  Height = 442
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
  object img1: TImage
    Left = 16
    Top = 16
    Width = 385
    Height = 289
    Center = True
    Proportional = True
  end
  object btn1: TButton
    Left = 120
    Top = 352
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
  object dlgOpenPic1: TOpenPictureDialog
    Left = 8
    Top = 352
  end
end
