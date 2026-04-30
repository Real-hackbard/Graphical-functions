object Form1: TForm1
  Left = 324
  Top = 182
  Width = 721
  Height = 597
  Caption = 'Math Parser'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 225
    Height = 558
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 7
      Width = 77
      Height = 13
      Caption = 'Expressions: '
    end
    object Label3: TLabel
      Left = 7
      Top = 193
      Width = 46
      Height = 13
      Caption = 'Results:'
    end
    object Label2: TLabel
      Left = 8
      Top = 367
      Width = 32
      Height = 13
      Caption = 'F(x)='
    end
    object Memo1: TMemo
      Left = 7
      Top = 24
      Width = 210
      Height = 153
      TabStop = False
      Lines.Strings = (
        '2+2*3'
        '2(15+25)'
        '-1+3'
        '1.3'
        '1,3'
        '-(2+3)'
        'var1=25'
        'var2=70'
        'var1+var2')
      TabOrder = 0
      OnChange = Memo1Change
    end
    object Memo2: TMemo
      Left = 7
      Top = 212
      Width = 210
      Height = 141
      TabStop = False
      TabOrder = 1
    end
    object Memo3: TMemo
      Left = 6
      Top = 387
      Width = 211
      Height = 94
      TabStop = False
      Lines.Strings = (
        'x'
        '1/x'
        'x*x')
      TabOrder = 2
      OnChange = Memo3Change
    end
    object Button1: TButton
      Left = 136
      Top = 520
      Width = 75
      Height = 25
      Caption = 'Bitmap'
      TabOrder = 3
      TabStop = False
      OnClick = Button1Click
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 496
      Width = 57
      Height = 17
      TabStop = False
      Caption = 'Frame'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 514
      Width = 50
      Height = 17
      TabStop = False
      Caption = 'Axes'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBox2Click
    end
  end
  object Panel2: TPanel
    Left = 225
    Top = 0
    Width = 480
    Height = 558
    Align = alClient
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 478
      Height = 515
      Align = alClient
      OnMouseDown = Image1MouseDown
      OnMouseUp = Image1MouseUp
    end
    object Panel3: TPanel
      Left = 1
      Top = 516
      Width = 478
      Height = 41
      Align = alBottom
      TabOrder = 0
      DesignSize = (
        478
        41)
      object Label4: TLabel
        Left = 10
        Top = 16
        Width = 38
        Height = 13
        Caption = 'Zoom:'
      end
      object Label5: TLabel
        Left = 432
        Top = 15
        Width = 37
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Label5'
      end
      object TrackBar1: TTrackBar
        Left = 50
        Top = 14
        Width = 375
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Max = 100
        Min = 1
        Position = 60
        TabOrder = 0
        TabStop = False
        ThumbLength = 15
        TickStyle = tsNone
        OnChange = Memo3Change
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 265
    Top = 48
  end
end
