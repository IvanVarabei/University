object Form1: TForm1
  Left = 257
  Top = 268
  Width = 448
  Height = 415
  Caption = 'CYCLE'
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
    Left = 8
    Top = 16
    Width = 84
    Height = 19
    Caption = 'SHOVE x1 :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 64
    Width = 84
    Height = 19
    Caption = 'SHOVE x2 :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 224
    Top = 16
    Width = 76
    Height = 19
    Caption = 'SHOVE n :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edt1: TEdit
    Left = 96
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0,1'
  end
  object edt2: TEdit
    Left = 96
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object edt3: TEdit
    Left = 304
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '14'
  end
  object mmo1: TMemo
    Left = 16
    Top = 104
    Width = 393
    Height = 193
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object btn1: TButton
    Left = 144
    Top = 320
    Width = 121
    Height = 41
    Caption = 'EXECUTE'
    TabOrder = 4
    OnClick = btn1Click
  end
end
