object Form1: TForm1
  Left = 237
  Top = 152
  Width = 872
  Height = 631
  Caption = 'Fibonacci Sunflowers'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 241
    Top = 0
    Width = 615
    Height = 592
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 241
    Height = 592
    Align = alLeft
    TabOrder = 0
    TabStop = True
    object Label1: TLabel
      Left = 176
      Top = 407
      Width = 30
      Height = 13
      Caption = 'Color :'
    end
    object Shape1: TShape
      Left = 208
      Top = 403
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clTeal
      OnMouseDown = Shape1MouseDown
    end
    object Label2: TLabel
      Left = 176
      Top = 432
      Width = 29
      Height = 13
      Caption = 'BGR :'
    end
    object Shape2: TShape
      Left = 208
      Top = 427
      Width = 20
      Height = 20
      Cursor = crHandPoint
      OnMouseDown = Shape2MouseDown
    end
    object Label3: TLabel
      Left = 152
      Top = 484
      Width = 26
      Height = 13
      Caption = 'Size :'
    end
    object Label4: TLabel
      Left = 40
      Top = 485
      Width = 34
      Height = 13
      Caption = 'Count :'
    end
    object Label5: TLabel
      Left = 40
      Top = 514
      Width = 33
      Height = 13
      Caption = 'Angle :'
    end
    object DrawBtn: TButton
      Left = 24
      Top = 552
      Width = 99
      Height = 25
      Caption = 'Draw Sunflower'
      TabOrder = 0
      TabStop = False
      OnClick = DrawBtnClick
    end
    object Memo1: TMemo
      Left = 8
      Top = 8
      Width = 225
      Height = 241
      TabStop = False
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      Lines.Strings = (
        'A Fibonacci series of integers '
        'starts '
        'with 0,1 '
        'and each member thereafter is '
        'the '
        'sum of the '
        'previous two.  Thus '
        '0,1,1,2,3,5,8,13,21.. '
        'etc.'
        ''
        'The ratio of any two consectutive '
        'Fibonacci '
        'numbers approaches the "Golden '
        'Ratio",  '
        '(1+sqrt(5))/2 = 1.618033... , '
        'commonly '
        'denoted  by the Greek letter Phi '
        '(pronounced "fee").'
        ''
        'The Golden Ratio has the unique '
        'property '
        'that Phi-1=1/Phi   and appears '
        'often in art and '
        'nature.'
        ''
        'In particular, sunflowers seeds '
        'tend '
        'to be '
        'displaced from each other by Phi '
        '(or '
        'identically, Phi-1, or 1/Phi) '
        'fraction '
        'of a circle, '
        'approximately 222.5 degrees.  '
        'For '
        'common '
        'sized sunflower heads, the '
        'approximations of '
        'phi represented by 21/34 and '
        '34/55 are close '
        'enough to phi, (21/34  < phi and '
        '34/55 '
        '>phi), that we see the optical '
        'illlusion of spirals '
        'overlapping and moving in '
        'opposite '
        'directions.'
        ''
        'Definitely worth further '
        'investigation.'
        '')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object RotateRBox: TRadioGroup
      Left = 8
      Top = 264
      Width = 137
      Height = 129
      Caption = 'Rotate for each seed'
      ItemIndex = 0
      Items.Strings = (
        '360*Phi degrees'
        '360*(21/34) degress '
        '360*(34/55) degrees'
        'Custom')
      TabOrder = 2
      OnClick = RotateRBoxClick
    end
    object StyleBox: TRadioGroup
      Left = 8
      Top = 400
      Width = 137
      Height = 65
      Caption = 'Style'
      ItemIndex = 0
      Items.Strings = (
        'Fixed seed '
        'Increasing ')
      TabOrder = 3
    end
    object Button1: TButton
      Left = 152
      Top = 552
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 4
      TabStop = False
      OnClick = Button1Click
    end
    object CheckBox1: TCheckBox
      Left = 178
      Top = 366
      Width = 49
      Height = 17
      Caption = 'Frame'
      TabOrder = 5
    end
    object SpinEdit1: TSpinEdit
      Left = 184
      Top = 480
      Width = 41
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 25
      MinValue = 1
      TabOrder = 6
      Value = 8
    end
    object SpinEdit2: TSpinEdit
      Left = 80
      Top = 480
      Width = 57
      Height = 22
      TabStop = False
      MaxLength = 4
      MaxValue = 5000
      MinValue = 1
      TabOrder = 7
      Value = 900
    end
    object ComboBox1: TComboBox
      Left = 80
      Top = 512
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 8
      Text = 'Sqrt'
      Items.Strings = (
        'Sin'
        'Cos'
        'Sqrt')
    end
    object SpinEdit3: TSpinEdit
      Left = 168
      Top = 272
      Width = 65
      Height = 22
      Enabled = False
      MaxLength = 1
      MaxValue = 9
      MinValue = 1
      TabOrder = 9
      Value = 3
    end
    object SpinEdit4: TSpinEdit
      Left = 168
      Top = 296
      Width = 65
      Height = 22
      Enabled = False
      MaxLength = 4
      MaxValue = 1000
      MinValue = 1
      TabOrder = 10
      Value = 93
    end
    object SpinEdit5: TSpinEdit
      Left = 168
      Top = 320
      Width = 65
      Height = 22
      Enabled = False
      MaxLength = 4
      MaxValue = 1000
      MinValue = 1
      TabOrder = 11
      Value = 50
    end
  end
  object ColorDialog1: TColorDialog
    Left = 280
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 320
    Top = 40
  end
end
