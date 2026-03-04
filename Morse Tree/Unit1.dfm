object Form1: TForm1
  Left = 320
  Top = 213
  Width = 661
  Height = 441
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Morse Tree'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = Init
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object imgTree: TImage
    Left = 16
    Top = 224
    Width = 617
    Height = 161
  end
  object Label1: TLabel
    Left = 16
    Top = 156
    Width = 31
    Height = 14
    Caption = 'Text:'
  end
  object Label2: TLabel
    Left = 80
    Top = 128
    Width = 138
    Height = 14
    Caption = 'Only lower case text :'
  end
  object panNum: TPanel
    Left = 16
    Top = 16
    Width = 297
    Height = 81
    BevelOuter = bvSpace
    BorderWidth = 3
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object btnPath: TButton
      Left = 56
      Top = 40
      Width = 112
      Height = 25
      Caption = 'Trace path'
      TabOrder = 0
      TabStop = False
      OnClick = TracePath
    end
    object btnSearch: TButton
      Left = 56
      Top = 8
      Width = 112
      Height = 25
      Caption = 'Morse code'
      TabOrder = 1
      TabStop = False
      OnClick = SearchNode
    end
    object edtNum: TEdit
      Left = 16
      Top = 10
      Width = 25
      Height = 22
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'b'
    end
    object edtPath: TEdit
      Left = 184
      Top = 40
      Width = 89
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtMorse: TEdit
      Left = 184
      Top = 8
      Width = 89
      Height = 24
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object edtPlain: TEdit
    Left = 72
    Top = 152
    Width = 561
    Height = 22
    TabStop = False
    TabOrder = 1
    Text = 'this is a morse code text'
  end
  object edtChiffre: TEdit
    Left = 16
    Top = 184
    Width = 617
    Height = 24
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object btnEncode: TButton
    Left = 376
    Top = 120
    Width = 121
    Height = 25
    Caption = 'Encrypt'
    TabOrder = 3
    TabStop = False
    OnClick = EncodeText
  end
  object btnDecode: TButton
    Left = 504
    Top = 120
    Width = 121
    Height = 25
    Caption = 'Decrypt'
    TabOrder = 4
    TabStop = False
    OnClick = DecodeText
  end
end
