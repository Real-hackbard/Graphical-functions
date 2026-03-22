object Form1: TForm1
  Left = 358
  Top = 147
  Width = 873
  Height = 639
  Caption = 'Gear Drawer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 680
    Top = 0
    Width = 177
    Height = 600
    Align = alRight
    TabOrder = 0
    object Label1: TLabel
      Left = 64
      Top = 84
      Width = 60
      Height = 13
      Caption = 'Iner Radius :'
    end
    object Label2: TLabel
      Left = 38
      Top = 108
      Width = 86
      Height = 13
      Caption = 'Number of Teeth :'
    end
    object Label3: TLabel
      Left = 56
      Top = 60
      Width = 68
      Height = 13
      Caption = 'Outer Radius :'
    end
    object MaskEdit2: TMaskEdit
      Left = 132
      Top = 80
      Width = 37
      Height = 21
      TabStop = False
      EditMask = '000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      Text = '220'
    end
    object MaskEdit1: TMaskEdit
      Left = 132
      Top = 104
      Width = 37
      Height = 21
      TabStop = False
      EditMask = '0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 1
      Text = '0128'
    end
    object Button1: TButton
      Left = 14
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Draw'
      TabOrder = 2
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 94
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 3
      TabStop = False
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 56
      Top = 152
      Width = 89
      Height = 17
      Caption = 'Type of Teeth'
      TabOrder = 4
    end
    object MaskEdit3: TMaskEdit
      Left = 132
      Top = 56
      Width = 34
      Height = 21
      TabStop = False
      EditMask = '000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 5
      Text = '299'
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 184
      Width = 161
      Height = 105
      Caption = ' Middle Hole '
      TabOrder = 6
      object Label4: TLabel
        Left = 58
        Top = 51
        Width = 39
        Height = 13
        Caption = 'Radius :'
      end
      object Label5: TLabel
        Left = 48
        Top = 75
        Width = 50
        Height = 13
        Caption = 'Definition :'
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 24
        Width = 113
        Height = 17
        TabStop = False
        Caption = 'Enabled/Disebled'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox2Click
      end
      object MaskEdit4: TMaskEdit
        Left = 104
        Top = 48
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Text = '050'
      end
      object MaskEdit5: TMaskEdit
        Left = 104
        Top = 72
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        Text = '064'
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 304
      Width = 161
      Height = 233
      Caption = ' Extras '
      TabOrder = 7
      object Shape1: TShape
        Left = 8
        Top = 96
        Width = 145
        Height = 65
      end
      object Shape2: TShape
        Left = 104
        Top = 128
        Width = 49
        Height = 2
        Brush.Color = clMenuText
      end
      object Label6: TLabel
        Left = 40
        Top = 48
        Width = 68
        Height = 13
        Caption = 'Outer Radius :'
      end
      object Label7: TLabel
        Left = 48
        Top = 72
        Width = 60
        Height = 13
        Caption = 'Iner Radius :'
      end
      object Label8: TLabel
        Left = 40
        Top = 120
        Width = 59
        Height = 13
        Caption = 'Proportions :'
      end
      object Label9: TLabel
        Left = 56
        Top = 176
        Width = 50
        Height = 13
        Caption = 'Definition :'
      end
      object Label10: TLabel
        Left = 60
        Top = 200
        Width = 47
        Height = 13
        Caption = 'Sections :'
      end
      object MaskEdit6: TMaskEdit
        Left = 112
        Top = 48
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        Text = '210'
      end
      object MaskEdit7: TMaskEdit
        Left = 112
        Top = 72
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
        Text = '060'
      end
      object MaskEdit8: TMaskEdit
        Left = 112
        Top = 104
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 2
        Text = '001'
      end
      object MaskEdit9: TMaskEdit
        Left = 112
        Top = 136
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 3
        Text = '010'
      end
      object MaskEdit10: TMaskEdit
        Left = 112
        Top = 168
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 4
        Text = '360'
      end
      object MaskEdit11: TMaskEdit
        Left = 112
        Top = 200
        Width = 31
        Height = 21
        TabStop = False
        EditMask = '000;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 5
        Text = '006'
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Enabled/Disabled'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = CheckBox3Click
      end
    end
    object Button3: TButton
      Left = 80
      Top = 560
      Width = 75
      Height = 25
      Caption = 'Save image'
      TabOrder = 8
      OnClick = Button3Click
    end
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 48
    Top = 32
  end
end
