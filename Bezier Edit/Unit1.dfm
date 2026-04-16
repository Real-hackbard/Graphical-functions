object Form1: TForm1
  Left = 468
  Top = 157
  Width = 600
  Height = 500
  BiDiMode = bdLeftToRight
  Caption = 'Bezier Edit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 121
    Top = 0
    Width = 463
    Height = 442
    Align = alClient
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Shape1: TShape
    Left = 392
    Top = 24
    Width = 25
    Height = 17
    Cursor = crHandPoint
    Hint = '????????? ?????'
    Brush.Color = clLime
    ParentShowHint = False
    Shape = stSquare
    ShowHint = True
    OnMouseDown = Shape1MouseDown
  end
  object Shape2: TShape
    Left = 190
    Top = 402
    Width = 25
    Height = 17
    Cursor = crHandPoint
    Hint = '???????? ?????'
    Brush.Color = clRed
    ParentShowHint = False
    Shape = stSquare
    ShowHint = True
    OnMouseDown = Shape2MouseDown
  end
  object Shape3: TShape
    Left = 168
    Top = 128
    Width = 25
    Height = 17
    Cursor = crHandPoint
    Hint = '????? 1'
    Brush.Color = clNavy
    ParentShowHint = False
    Shape = stCircle
    ShowHint = True
    OnMouseDown = Shape3MouseDown
  end
  object Shape4: TShape
    Left = 520
    Top = 376
    Width = 25
    Height = 17
    Cursor = crHandPoint
    Hint = '????? 2'
    Brush.Color = clNavy
    ParentShowHint = False
    Shape = stCircle
    ShowHint = True
    OnMouseDown = Shape4MouseDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 442
    Align = alLeft
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 167
      Width = 25
      Height = 13
      Caption = 'Pen :'
    end
    object Label2: TLabel
      Left = 16
      Top = 224
      Width = 46
      Height = 13
      Caption = 'Random :'
    end
    object Label3: TLabel
      Left = 16
      Top = 276
      Width = 34
      Height = 13
      Caption = 'Count :'
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 32
      Width = 51
      Height = 17
      TabStop = False
      Caption = 'Points'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 56
      Width = 97
      Height = 17
      TabStop = False
      Caption = 'Connecting line'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object Button1: TButton
      Left = 16
      Top = 376
      Width = 75
      Height = 25
      Caption = 'Random'
      TabOrder = 2
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 16
      Top = 408
      Width = 75
      Height = 25
      Caption = 'Bitmap'
      TabOrder = 3
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 16
      Top = 344
      Width = 75
      Height = 25
      Caption = 'BGR Color'
      TabOrder = 4
      TabStop = False
      OnClick = Button3Click
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 96
      Width = 73
      Height = 17
      TabStop = False
      Caption = 'Antialiasing'
      TabOrder = 5
      OnClick = CheckBox3Click
    end
    object SpinEdit1: TSpinEdit
      Left = 32
      Top = 120
      Width = 57
      Height = 22
      TabStop = False
      Enabled = False
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 6
      Value = 20
    end
    object Button4: TButton
      Left = 16
      Top = 312
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 7
      TabStop = False
      OnClick = Button4Click
    end
    object ScrollBar1: TScrollBar
      Left = 8
      Top = 184
      Width = 105
      Height = 17
      Min = 1
      PageSize = 0
      Position = 2
      TabOrder = 8
      TabStop = False
      OnChange = ScrollBar1Change
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 240
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 9
      TabStop = False
      Text = 'Bezier'
      Items.Strings = (
        'Bezier'
        'Line'
        'Polygon')
    end
    object SpinEdit2: TSpinEdit
      Left = 56
      Top = 272
      Width = 57
      Height = 22
      TabStop = False
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      TabOrder = 10
      Value = 20
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 442
    Width = 584
    Height = 19
    Panels = <
      item
        Text = 'Image X/Y : '
        Width = 70
      end
      item
        Width = 100
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 160
    Top = 40
  end
  object ColorDialog1: TColorDialog
    Left = 200
    Top = 40
  end
end
