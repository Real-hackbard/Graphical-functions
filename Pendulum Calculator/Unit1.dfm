object Form1: TForm1
  Left = 500
  Top = 168
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pendulum Calculator'
  ClientHeight = 386
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 23
    Caption = '&Start'
    Default = True
    TabOrder = 0
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 88
    Top = 8
    Width = 75
    Height = 23
    Caption = '&Stop'
    TabOrder = 1
    TabStop = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 168
    Top = 8
    Width = 75
    Height = 23
    Caption = '&Reset'
    TabOrder = 2
    TabStop = False
    OnClick = Button3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 367
    Width = 320
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 80
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 8
    Top = 38
    Width = 304
    Height = 304
    BevelInner = bvLowered
    TabOrder = 4
    object Image1: TImage
      Left = 2
      Top = 2
      Width = 300
      Height = 300
      Align = alClient
    end
  end
  object StatusBar2: TStatusBar
    Left = 0
    Top = 348
    Width = 320
    Height = 19
    Panels = <
      item
        Width = 120
      end
      item
        Width = 120
      end
      item
        Width = 50
      end>
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 280
    Top = 8
  end
end
