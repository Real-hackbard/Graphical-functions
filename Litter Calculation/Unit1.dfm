object Form1: TForm1
  Left = 303
  Top = 333
  Width = 923
  Height = 654
  Caption = 'Litter calculation'
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    907
    615)
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 8
    Top = 8
    Width = 697
    Height = 560
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = PaintBox1Paint
  end
  object ScrollBar1: TScrollBar
    Left = 8
    Top = 582
    Width = 697
    Height = 16
    Anchors = [akLeft, akRight, akBottom]
    PageSize = 0
    TabOrder = 0
    TabStop = False
    OnChange = ScrollBar1Change
  end
  object ScrollBar2: TScrollBar
    Left = 717
    Top = 8
    Width = 16
    Height = 560
    Anchors = [akTop, akRight, akBottom]
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    TabStop = False
    OnChange = ScrollBar2Change
  end
  object Panel1: TPanel
    Left = 744
    Top = 0
    Width = 163
    Height = 615
    Align = alRight
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 272
      Width = 39
      Height = 13
      Caption = 'v0 [m/s]'
    end
    object Label2: TLabel
      Left = 4
      Top = 320
      Width = 29
      Height = 13
      Caption = 'h0 [m]'
    end
    object Label3: TLabel
      Left = 3
      Top = 416
      Width = 54
      Height = 13
      Caption = 'g [m/(sec'#178')]'
    end
    object Label4: TLabel
      Left = 3
      Top = 368
      Width = 40
      Height = 13
      Caption = 'Angle ['#176']'
    end
    object lblMax_s: TLabel
      Left = 5
      Top = 472
      Width = 82
      Height = 13
      Caption = 'Throwing Range:'
    end
    object lblMax_h: TLabel
      Left = 6
      Top = 496
      Width = 65
      Height = 13
      Caption = 'Throw height:'
    end
    object lblTime: TLabel
      Left = 6
      Top = 520
      Width = 46
      Height = 13
      Caption = 'Rise time:'
    end
    object Label5: TLabel
      Left = 10
      Top = 9
      Width = 79
      Height = 13
      Caption = 'Table of values :'
    end
    object lbls_h_max: TLabel
      Left = 6
      Top = 544
      Width = 69
      Height = 13
      Caption = 'Highest Point: '
    end
    object btnDraw: TButton
      Left = 0
      Top = 576
      Width = 57
      Height = 25
      Caption = 'Draw'
      TabOrder = 0
      TabStop = False
      OnClick = btnDrawClick
    end
    object ListBox1: TListBox
      Left = 0
      Top = 32
      Width = 145
      Height = 233
      TabStop = False
      ItemHeight = 13
      TabOrder = 1
    end
    object btnClear: TButton
      Left = 64
      Top = 576
      Width = 57
      Height = 25
      Caption = 'Clear'
      TabOrder = 2
      TabStop = False
      OnClick = btnClearClick
    end
    object edtv0: TSpinEdit
      Left = 0
      Top = 288
      Width = 145
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 3
      Value = 50
    end
    object edtHeight: TSpinEdit
      Left = 0
      Top = 336
      Width = 145
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 4
      Value = 0
    end
    object edtGrav: TEdit
      Left = 0
      Top = 432
      Width = 145
      Height = 21
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = '9,81'
      OnKeyPress = edtGravKeyPress
    end
    object edtAngel: TSpinEdit
      Left = 0
      Top = 384
      Width = 145
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 6
      Value = 45
    end
  end
end
