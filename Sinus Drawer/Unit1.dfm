object Form1: TForm1
  Left = 329
  Top = 206
  Width = 777
  Height = 510
  Caption = 'Sinus Drawer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 177
    Top = 0
    Width = 584
    Height = 471
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 471
    Align = alLeft
    TabOrder = 0
    object SinButton: TSpeedButton
      Left = 8
      Top = 432
      Width = 50
      Height = 25
      Caption = 'Sin'
      OnClick = SinButtonClick
    end
    object CosButton: TSpeedButton
      Left = 64
      Top = 432
      Width = 50
      Height = 25
      Caption = 'Cos'
      OnClick = CosButtonClick
    end
    object Label1: TLabel
      Left = 45
      Top = 35
      Width = 33
      Height = 13
      Caption = 'Mode :'
    end
    object Label2: TLabel
      Left = 53
      Top = 78
      Width = 24
      Height = 13
      Caption = 'Left :'
    end
    object Label3: TLabel
      Left = 46
      Top = 100
      Width = 31
      Height = 13
      Caption = 'Right :'
    end
    object Label4: TLabel
      Left = 41
      Top = 138
      Width = 37
      Height = 13
      Caption = 'Height :'
    end
    object Label5: TLabel
      Left = 44
      Top = 163
      Width = 34
      Height = 13
      Caption = 'Width :'
    end
    object Shape1: TShape
      Left = 84
      Top = 264
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clSilver
      OnMouseDown = Shape1MouseDown
    end
    object Shape2: TShape
      Left = 84
      Top = 296
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clLime
      OnMouseDown = Shape2MouseDown
    end
    object Shape3: TShape
      Left = 84
      Top = 328
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clRed
      OnMouseDown = Shape3MouseDown
    end
    object Label6: TLabel
      Left = 45
      Top = 267
      Width = 32
      Height = 13
      Caption = 'Cross :'
    end
    object Label7: TLabel
      Left = 52
      Top = 299
      Width = 24
      Height = 13
      Caption = 'SIN :'
    end
    object Label8: TLabel
      Left = 48
      Top = 331
      Width = 28
      Height = 13
      Caption = 'COS :'
    end
    object Shape4: TShape
      Left = 84
      Top = 360
      Width = 20
      Height = 20
      Cursor = crHandPoint
      Brush.Color = clBlack
      OnMouseDown = Shape4MouseDown
    end
    object Label9: TLabel
      Left = 12
      Top = 364
      Width = 64
      Height = 13
      Caption = 'Background :'
    end
    object Label10: TLabel
      Left = 37
      Top = 400
      Width = 39
      Height = 13
      Caption = 'Picture :'
    end
    object Label11: TLabel
      Left = 88
      Top = 400
      Width = 23
      Height = 13
      Caption = '0 x 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 84
      Top = 32
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      TabStop = False
      Text = 'Line'
      Items.Strings = (
        'Line'
        'Point'
        'Distance')
    end
    object SpinEdit1: TSpinEdit
      Left = 84
      Top = 72
      Width = 81
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      MaxValue = 0
      MinValue = -15
      ParentFont = False
      TabOrder = 1
      Value = -15
    end
    object SpinEdit2: TSpinEdit
      Left = 84
      Top = 96
      Width = 81
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      MaxValue = 15
      MinValue = 0
      ParentFont = False
      TabOrder = 2
      Value = 15
    end
    object SpinEdit3: TSpinEdit
      Left = 84
      Top = 136
      Width = 81
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 2
      MaxValue = 50
      MinValue = 1
      ParentFont = False
      TabOrder = 3
      Value = 3
    end
    object SpinEdit4: TSpinEdit
      Left = 84
      Top = 160
      Width = 81
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      MaxValue = 500
      MinValue = 1
      ParentFont = False
      TabOrder = 4
      Value = 30
    end
    object CheckBox1: TCheckBox
      Left = 84
      Top = 208
      Width = 47
      Height = 17
      TabStop = False
      Caption = 'Cross'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 84
      Top = 232
      Width = 49
      Height = 17
      TabStop = False
      Caption = 'Frame'
      TabOrder = 6
    end
    object Button1: TButton
      Left = 120
      Top = 432
      Width = 50
      Height = 25
      Caption = 'Save'
      TabOrder = 7
      TabStop = False
      OnClick = Button1Click
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 216
    Top = 32
  end
  object ColorDialog1: TColorDialog
    Left = 272
    Top = 32
  end
end
