object Form1: TForm1
  Left = 260
  Top = 129
  Width = 862
  Height = 615
  Caption = 'Triangle artistt'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 185
    Top = 0
    Width = 661
    Height = 576
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 576
    Align = alLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 28
      Width = 20
      Height = 16
      Caption = 'A :'
    end
    object Label2: TLabel
      Left = 16
      Top = 60
      Width = 19
      Height = 16
      Caption = 'B :'
    end
    object Label3: TLabel
      Left = 16
      Top = 92
      Width = 20
      Height = 16
      Caption = 'C :'
    end
    object Label4: TLabel
      Left = 16
      Top = 160
      Width = 40
      Height = 16
      Caption = 'shift :'
    end
    object Label5: TLabel
      Left = 16
      Top = 256
      Width = 113
      Height = 16
      Caption = 'rotation around :'
    end
    object Label6: TLabel
      Left = 104
      Top = 312
      Width = 7
      Height = 16
      Caption = #176
    end
    object Label7: TLabel
      Left = 16
      Top = 384
      Width = 107
      Height = 16
      Caption = 'transformation :'
    end
    object Edit1: TEdit
      Left = 40
      Top = 24
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '2'
    end
    object Edit2: TEdit
      Left = 104
      Top = 24
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0'
    end
    object Edit3: TEdit
      Left = 40
      Top = 56
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '0'
    end
    object Edit4: TEdit
      Left = 104
      Top = 56
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '2'
    end
    object Edit5: TEdit
      Left = 40
      Top = 88
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '-1'
    end
    object Edit6: TEdit
      Left = 104
      Top = 88
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '-3'
    end
    object Edit7: TEdit
      Left = 40
      Top = 184
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = '1'
    end
    object Edit8: TEdit
      Left = 104
      Top = 184
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = '1'
    end
    object Edit9: TEdit
      Left = 40
      Top = 280
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Text = '-2'
    end
    object Edit10: TEdit
      Left = 104
      Top = 280
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      Text = '0'
    end
    object Edit11: TEdit
      Left = 40
      Top = 312
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      Text = '30'
    end
    object Button1: TButton
      Left = 40
      Top = 216
      Width = 121
      Height = 25
      Caption = 'Execute'
      TabOrder = 11
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 40
      Top = 344
      Width = 121
      Height = 25
      Caption = 'Execute'
      TabOrder = 12
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 40
      Top = 120
      Width = 121
      Height = 25
      Caption = 'Reset'
      TabOrder = 13
      TabStop = False
      OnClick = Button3Click
    end
    object Edit12: TEdit
      Left = 40
      Top = 408
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      Text = '1'
    end
    object Edit13: TEdit
      Left = 40
      Top = 440
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      Text = '0'
    end
    object Edit14: TEdit
      Left = 104
      Top = 440
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      Text = '2'
    end
    object Edit15: TEdit
      Left = 104
      Top = 408
      Width = 57
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      Text = '0'
    end
    object Button4: TButton
      Left = 40
      Top = 480
      Width = 121
      Height = 25
      Caption = 'Execute'
      TabOrder = 18
      TabStop = False
      OnClick = Button4Click
    end
  end
end
