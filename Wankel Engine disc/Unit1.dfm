object Form1: TForm1
  Left = 475
  Top = 206
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Wankel Engine disc'
  ClientHeight = 627
  ClientWidth = 544
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 544
    Height = 586
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 586
    Width = 544
    Height = 41
    Align = alBottom
    BevelOuter = bvSpace
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 52
      Height = 16
      Caption = 'Speed :'
    end
    object Label2: TLabel
      Left = 160
      Top = 12
      Width = 38
      Height = 16
      Caption = 'Size :'
    end
    object Button1: TButton
      Left = 400
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Simulation'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 72
      Top = 8
      Width = 49
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '2'
      OnChange = Edit1Change
    end
    object UpDown1: TUpDown
      Left = 121
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 1
      Max = 10
      Position = 2
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 208
      Top = 8
      Width = 49
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Text = '15'
      OnChange = Edit1Change
    end
    object UpDown2: TUpDown
      Left = 257
      Top = 8
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 5
      Max = 25
      Position = 15
      TabOrder = 4
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 24
    Top = 32
  end
end
