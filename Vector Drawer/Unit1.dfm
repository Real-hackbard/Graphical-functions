object Form1: TForm1
  Left = 381
  Top = 197
  Width = 686
  Height = 461
  Caption = 'Vector Drawer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 41
    Width = 670
    Height = 362
    Align = alClient
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Rectangle'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Circle'
      TabOrder = 1
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Picture'
      TabOrder = 2
      TabStop = False
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 440
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      TabStop = False
      OnClick = Button4Click
    end
    object CheckBox1: TCheckBox
      Left = 264
      Top = 13
      Width = 49
      Height = 17
      Caption = 'Frame'
      TabOrder = 4
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 403
    Width = 670
    Height = 19
    Panels = <
      item
        Text = 'Pos :'
        Width = 30
      end
      item
        Width = 50
      end>
  end
  object PictureDialog: TOpenPictureDialog
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 27
    Top = 73
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 72
    Top = 72
  end
end
