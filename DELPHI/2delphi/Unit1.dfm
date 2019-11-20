object Form1: TForm1
  Left = 222
  Top = 181
  Width = 488
  Height = 387
  Caption = 'Calk'
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
    Top = 8
    Width = 81
    Height = 25
    Caption = 'Enter x :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 56
    Width = 83
    Height = 25
    Caption = 'Enter p :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 8
    Top = 160
    Width = 202
    Height = 25
    Caption = 'Result of calculation :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edt1: TEdit
    Left = 104
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '5'
  end
  object edt2: TEdit
    Left = 104
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object mmo1: TMemo
    Left = 8
    Top = 208
    Width = 233
    Height = 121
    Lines.Strings = (
      'mmo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object btn1: TButton
    Left = 272
    Top = 248
    Width = 155
    Height = 65
    Caption = 'CARRY OUT'
    TabOrder = 3
    OnClick = btn1Click
  end
  object rg1: TRadioGroup
    Left = 288
    Top = 88
    Width = 121
    Height = 89
    Caption = 'U(x)'
    Items.Strings = (
      'f(x)=sh(x)'
      'f(x)=e^x'
      'f(x)=x^2')
    TabOrder = 4
  end
  object chk1: TCheckBox
    Left = 312
    Top = 40
    Width = 97
    Height = 17
    Caption = 'MaxAbs'
    TabOrder = 5
  end
end
