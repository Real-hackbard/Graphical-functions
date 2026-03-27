object Form1: TForm1
  Left = 563
  Top = 161
  Width = 570
  Height = 468
  AlphaBlendValue = 210
  Caption = 'Canvas Stars'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 25
    OnTimer = Timer1Timer
    Left = 8
    Top = 64
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 96
    object N1: TMenuItem
      Caption = 'File'
      object N3: TMenuItem
        Caption = 'Close'
        OnClick = N3Click
      end
    end
    object O1: TMenuItem
      Caption = 'Options'
      object S1: TMenuItem
        Caption = 'Stars'
        OnClick = S1Click
      end
    end
  end
end
