object Form1: TForm1
  Left = 415
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Binary search tree'
  ClientHeight = 571
  ClientWidth = 516
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = Init
  PixelsPerInch = 96
  TextHeight = 14
  object lblCount: TLabel
    Left = 32
    Top = 22
    Width = 75
    Height = 14
    Caption = '20 numbers'
  end
  object imgTree: TImage
    Left = 16
    Top = 264
    Width = 481
    Height = 289
  end
  object btnDelete: TButton
    Left = 120
    Top = 88
    Width = 180
    Height = 25
    Caption = 'Delete tree'
    TabOrder = 1
    TabStop = False
    OnClick = DeleteTree
  end
  object btnRandom: TButton
    Left = 120
    Top = 24
    Width = 180
    Height = 25
    Caption = 'Create new tree'
    TabOrder = 0
    TabStop = False
    OnClick = Init
  end
  object tbCount: TTrackBar
    Left = 24
    Top = 48
    Width = 81
    Height = 25
    Max = 20
    Min = 2
    Frequency = 2
    Position = 20
    TabOrder = 2
    TabStop = False
    ThumbLength = 16
    OnChange = Init
  end
  object memTree: TMemo
    Left = 16
    Top = 176
    Width = 481
    Height = 73
    TabStop = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Lines.Strings = (
      ''
      '')
    ParentFont = False
    TabOrder = 3
  end
  object panNum: TPanel
    Left = 320
    Top = 16
    Width = 179
    Height = 145
    BevelOuter = bvSpace
    BorderWidth = 3
    BorderStyle = bsSingle
    Color = 15790320
    TabOrder = 4
    object btnPath: TButton
      Left = 52
      Top = 40
      Width = 110
      Height = 25
      Caption = 'Trace path'
      TabOrder = 0
      TabStop = False
      OnClick = TracePath
    end
    object btnSearch: TButton
      Left = 52
      Top = 8
      Width = 110
      Height = 25
      Caption = 'Search'
      TabOrder = 1
      TabStop = False
      OnClick = SearchNode
    end
    object edtNum: TEdit
      Left = 8
      Top = 12
      Width = 33
      Height = 22
      TabStop = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '57'
    end
    object btnRemove: TButton
      Left = 52
      Top = 104
      Width = 110
      Height = 25
      Caption = 'Delete'
      TabOrder = 3
      TabStop = False
      OnClick = RemoveNode
    end
    object btnInsert: TButton
      Left = 52
      Top = 72
      Width = 110
      Height = 25
      Caption = 'Insert'
      TabOrder = 4
      TabStop = False
      OnClick = InsertNode
    end
  end
  object btnTraverse: TButton
    Left = 120
    Top = 56
    Width = 180
    Height = 25
    Caption = 'Traverse tree'
    TabOrder = 5
    TabStop = False
    OnClick = ShowTree
  end
  object btnLoad: TButton
    Left = 120
    Top = 120
    Width = 180
    Height = 25
    Caption = 'Load tree'
    TabOrder = 6
    TabStop = False
    OnClick = btnLoadClick
  end
end
