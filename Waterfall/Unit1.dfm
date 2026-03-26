object Form1: TForm1
  Left = 355
  Top = 208
  Width = 649
  Height = 331
  Caption = 'Waterfall'
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
  object Fond: TPaintBox
    Left = 0
    Top = 33
    Width = 633
    Height = 240
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    OnMouseDown = FondMouseDown
    OnMouseMove = FondMouseMove
    OnMouseUp = FondMouseUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 11
      Width = 34
      Height = 13
      Caption = 'Speed:'
    end
    object Label2: TLabel
      Left = 288
      Top = 12
      Width = 26
      Height = 13
      Caption = 'Size :'
    end
    object Label3: TLabel
      Left = 376
      Top = 12
      Width = 36
      Height = 13
      Caption = 'Ellipse :'
    end
    object Edit1: TEdit
      Left = 46
      Top = 7
      Width = 46
      Height = 21
      Hint = 'Nombre de gougouttes'
      TabStop = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '150'
    end
    object Button1: TButton
      Left = 115
      Top = 7
      Width = 50
      Height = 20
      Hint = 'Ouvrir le robinet ;-)'
      Caption = 'Start'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 224
      Top = 7
      Width = 50
      Height = 20
      Hint = 'Vire moi tou ca ! en vitesse !'
      Caption = 'Clear'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 573
      Top = 7
      Width = 53
      Height = 20
      Hint = 'Good bye...'
      Caption = 'Exit'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      OnClick = Button4Click
    end
    object Button3: TButton
      Left = 168
      Top = 7
      Width = 50
      Height = 20
      Caption = 'Stop'
      TabOrder = 4
      TabStop = False
      OnClick = Button3Click
    end
    object SpinEdit1: TSpinEdit
      Left = 320
      Top = 8
      Width = 41
      Height = 22
      TabStop = False
      MaxLength = 2
      MaxValue = 20
      MinValue = 1
      TabOrder = 5
      Value = 5
    end
    object SpinEdit2: TSpinEdit
      Left = 416
      Top = 8
      Width = 49
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 6
      Value = 5
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 273
    Width = 633
    Height = 19
    Panels = <
      item
        Text = 'Click on the panel to stop the water.'
        Width = 50
      end>
  end
end
