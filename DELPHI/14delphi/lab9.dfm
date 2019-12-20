object Form2: TForm2
  Left = 944
  Top = 176
  Width = 490
  Height = 357
  Caption = 'Form'#39's settings'
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
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 465
    Height = 313
    ActivePage = ts3
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'color settings'
      object lbl1: TLabel
        Left = 256
        Top = 240
        Width = 15
        Height = 29
        Caption = 'R'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 320
        Top = 240
        Width = 16
        Height = 29
        Caption = 'G'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl3: TLabel
        Left = 384
        Top = 240
        Width = 14
        Height = 29
        Caption = 'B'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 224
        Top = 120
        Width = 10
        Height = 23
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl5: TLabel
        Left = 288
        Top = 120
        Width = 10
        Height = 23
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl6: TLabel
        Left = 352
        Top = 120
        Width = 10
        Height = 23
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btn1: TButton
        Left = 72
        Top = 208
        Width = 105
        Height = 33
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        TabOrder = 0
        OnClick = btn1Click
      end
      object rg1: TRadioGroup
        Left = 24
        Top = 40
        Width = 185
        Height = 105
        Caption = #1044#1077#1081#1089#1090#1074#1080#1077
        ItemIndex = 0
        Items.Strings = (
          #1080#1079#1084#1077#1085#1080#1090#1100' '#1094#1074#1077#1090' '#1092#1086#1088#1084#1099
          #1080#1079#1084#1077#1085#1080#1090#1100' '#1094#1074#1077#1090' memo')
        TabOrder = 1
      end
      object scrlbr1: TScrollBar
        Left = 256
        Top = 40
        Width = 25
        Height = 193
        Kind = sbVertical
        LargeChange = 5
        Max = 255
        PageSize = 0
        SmallChange = 5
        TabOrder = 2
        OnChange = scrlbr1Change
      end
      object scrlbr2: TScrollBar
        Left = 320
        Top = 40
        Width = 25
        Height = 193
        Kind = sbVertical
        LargeChange = 5
        Max = 255
        PageSize = 0
        SmallChange = 5
        TabOrder = 3
        OnChange = scrlbr2Change
      end
      object scrlbr3: TScrollBar
        Left = 384
        Top = 40
        Width = 25
        Height = 193
        Kind = sbVertical
        LargeChange = 5
        Max = 255
        PageSize = 0
        SmallChange = 5
        TabOrder = 4
        OnChange = scrlbr3Change
      end
    end
    object ts2: TTabSheet
      Caption = 'Font settings'
      ImageIndex = 1
      object btn2: TButton
        Left = 168
        Top = 200
        Width = 97
        Height = 25
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1088#1080#1092#1090
        TabOrder = 0
        OnClick = btn2Click
      end
      object rg2: TRadioGroup
        Left = 120
        Top = 48
        Width = 185
        Height = 105
        Caption = 'Fonts'
        ItemIndex = 0
        Items.Strings = (
          #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1088#1080#1092#1090' pagecontrol'
          #1048#1079#1084#1077#1085#1080#1090#1100' '#1096#1088#1080#1092#1090' '#1092#1086#1088#1084#1099)
        TabOrder = 1
      end
    end
    object ts3: TTabSheet
      Caption = 'animation settings'
      ImageIndex = 2
      object lbl7: TLabel
        Left = 112
        Top = 88
        Width = 44
        Height = 21
        Caption = 'speed'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edt1: TEdit
        Left = 160
        Top = 88
        Width = 121
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'edt1'
        OnExit = edt1Exit
      end
      object btn3: TButton
        Left = 176
        Top = 152
        Width = 89
        Height = 25
        Caption = 'Set color'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btn3Click
      end
    end
  end
  object dlgFont1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 20
    Top = 24
  end
  object dlgColor1: TColorDialog
    Left = 52
    Top = 24
  end
end
