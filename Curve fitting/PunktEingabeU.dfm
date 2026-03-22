object FPunktEingabe: TFPunktEingabe
  Left = 277
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Punkteingabe'
  ClientHeight = 98
  ClientWidth = 172
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
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object EdX: TEdit
    Left = 24
    Top = 8
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object EdY: TEdit
    Left = 24
    Top = 32
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object BtnOK: TButton
    Left = 8
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object BtnAbbruch: TButton
    Left = 88
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
