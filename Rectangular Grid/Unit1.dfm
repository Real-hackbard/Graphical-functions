object Form1: TForm1
  Left = 300
  Top = 128
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Paths in a rectangular grid'
  ClientHeight = 600
  ClientWidth = 784
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 184
    Top = 0
    Width = 600
    Height = 600
    Align = alClient
    OnMouseDown = PaintBox1MouseDown
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 600
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 128
      Width = 15
      Height = 16
      Caption = '...'
    end
    object Label2: TLabel
      Left = 24
      Top = 28
      Width = 55
      Height = 16
      Caption = 'Size X ='
    end
    object Label3: TLabel
      Left = 24
      Top = 60
      Width = 55
      Height = 16
      Caption = 'Size Y ='
    end
    object Label7: TLabel
      Left = 24
      Top = 200
      Width = 136
      Height = 64
      Caption = 
        'Set and delete '#13#10'of blocked ones '#13#10'Crossroads'#13#10'with left mouse c' +
        'lick'
    end
    object Label4: TLabel
      Left = 16
      Top = 104
      Width = 91
      Height = 16
      Caption = 'Possible ways'
    end
    object SpinEdit1: TSpinEdit
      Left = 104
      Top = 24
      Width = 57
      Height = 26
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      MaxValue = 10
      MinValue = 1
      ParentFont = False
      TabOrder = 0
      Value = 4
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 104
      Top = 56
      Width = 57
      Height = 26
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      MaxValue = 10
      MinValue = 1
      ParentFont = False
      TabOrder = 1
      Value = 4
      OnChange = SpinEdit1Change
    end
    object Button2: TButton
      Left = 24
      Top = 280
      Width = 137
      Height = 25
      Caption = 'Reset'
      TabOrder = 2
      TabStop = False
      OnClick = Button2Click
    end
    object RadioButton1: TRadioButton
      Left = 24
      Top = 320
      Width = 129
      Height = 17
      Caption = 'Delannoy-Ways'
      Checked = True
      TabOrder = 3
      OnClick = PaintBox1Paint
    end
    object RadioButton2: TRadioButton
      Left = 24
      Top = 344
      Width = 137
      Height = 17
      Caption = 'Schr'#246'der-Ways'
      TabOrder = 4
      OnClick = PaintBox1Paint
    end
  end
end
