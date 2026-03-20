object Form1: TForm1
  Left = 430
  Top = 132
  AutoScroll = False
  Caption = 'Cellular'
  ClientHeight = 508
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    666
    508)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 475
    Height = 467
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    FullRepaint = False
    TabOrder = 0
    object Img: TImage
      Left = 13
      Top = 12
      Width = 300
      Height = 300
      AutoSize = True
      OnMouseDown = ImgMouseDown
      OnMouseMove = ImgMouseMove
      OnMouseUp = ImgMouseUp
    end
    object ImgBack: TImage
      Left = 171
      Top = 204
      Width = 300
      Height = 300
      Visible = False
    end
  end
  object GroupBox1: TGroupBox
    Left = 483
    Top = 2
    Width = 175
    Height = 472
    Anchors = [akTop, akRight, akBottom]
    Caption = 'Rules'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 1
    object Label4: TLabel
      Left = 6
      Top = 20
      Width = 130
      Height = 32
      AutoSize = False
      Caption = 'Neighbour Count Range: (Cells from current cell:)'
      WordWrap = True
    end
    object Label11: TLabel
      Left = 6
      Top = 330
      Width = 103
      Height = 13
      Caption = 'Influence of cell level:'
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 358
      Width = 159
      Height = 15
      TabStop = False
      Caption = 'Die if >=               neighbours'
      TabOrder = 9
      OnClick = CheckBox2Click
    end
    object Button1: TButton
      Left = 5
      Top = 427
      Width = 88
      Height = 25
      Caption = 'Start Simulation'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 8
      Top = 50
      Width = 41
      Height = 21
      TabStop = False
      TabOrder = 1
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 49
      Top = 50
      Width = 15
      Height = 21
      Associate = Edit1
      Min = 1
      Max = 10
      Position = 1
      TabOrder = 2
      OnClick = UpDown1Click
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 76
      Width = 161
      Height = 128
      Caption = 'If Alive: '
      Color = clWhite
      Ctl3D = True
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 3
      object Label1: TLabel
        Left = 8
        Top = 18
        Width = 125
        Height = 13
        Caption = 'Continue to live if between'
      end
      object Label5: TLabel
        Left = 54
        Top = 38
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label6: TLabel
        Left = 10
        Top = 56
        Width = 100
        Height = 13
        Caption = 'Neighbours are alive.'
      end
      object Label9: TLabel
        Left = 10
        Top = 81
        Width = 86
        Height = 13
        Caption = 'Level up if at least'
      end
      object Label10: TLabel
        Left = 10
        Top = 98
        Width = 100
        Height = 13
        Caption = 'Neighbours are alive.'
      end
      object Edit2: TEdit
        Left = 10
        Top = 34
        Width = 25
        Height = 21
        TabStop = False
        TabOrder = 0
        Text = '2'
      end
      object UpDown2: TUpDown
        Left = 35
        Top = 34
        Width = 14
        Height = 21
        Associate = Edit2
        Min = 1
        Max = 50
        Position = 2
        TabOrder = 1
        OnClick = UpDown2Click
      end
      object Edit3: TEdit
        Left = 78
        Top = 34
        Width = 25
        Height = 21
        TabStop = False
        TabOrder = 2
        Text = '3'
      end
      object UpDown3: TUpDown
        Left = 103
        Top = 34
        Width = 15
        Height = 21
        Associate = Edit3
        Min = 1
        Max = 50
        Position = 3
        TabOrder = 3
        OnClick = UpDown3Click
      end
      object Edit6: TEdit
        Left = 103
        Top = 78
        Width = 25
        Height = 21
        TabStop = False
        TabOrder = 4
        Text = '5'
      end
      object UpDown6: TUpDown
        Left = 128
        Top = 78
        Width = 15
        Height = 21
        Associate = Edit6
        Min = 1
        Max = 50
        Position = 5
        TabOrder = 5
        OnClick = UpDown6Click
      end
    end
    object GroupBox3: TGroupBox
      Left = 6
      Top = 211
      Width = 161
      Height = 108
      Caption = 'If Empty: '
      Color = clWhite
      Ctl3D = True
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 4
      object Label3: TLabel
        Left = 8
        Top = 18
        Width = 112
        Height = 13
        Caption = 'A cell is born if between'
      end
      object Label7: TLabel
        Left = 54
        Top = 38
        Width = 18
        Height = 13
        Caption = 'and'
      end
      object Label8: TLabel
        Left = 10
        Top = 59
        Width = 100
        Height = 13
        Caption = 'Neighbours are alive.'
      end
      object Edit4: TEdit
        Left = 10
        Top = 34
        Width = 25
        Height = 21
        TabStop = False
        TabOrder = 0
        Text = '3'
      end
      object UpDown4: TUpDown
        Left = 35
        Top = 34
        Width = 12
        Height = 21
        Associate = Edit4
        Min = 1
        Max = 50
        Position = 3
        TabOrder = 1
        OnClick = UpDown4Click
      end
      object Edit5: TEdit
        Left = 78
        Top = 34
        Width = 25
        Height = 21
        TabStop = False
        TabOrder = 2
        Text = '3'
      end
      object UpDown5: TUpDown
        Left = 103
        Top = 34
        Width = 15
        Height = 21
        Associate = Edit5
        Min = 1
        Max = 50
        Position = 3
        TabOrder = 3
        OnClick = UpDown5Click
      end
      object CheckBox1: TCheckBox
        Left = 10
        Top = 80
        Width = 123
        Height = 13
        TabStop = False
        Caption = 'Reset Level if Empty'
        TabOrder = 4
        OnClick = CheckBox1Click
      end
    end
    object Edit7: TEdit
      Left = 112
      Top = 327
      Width = 25
      Height = 21
      TabStop = False
      TabOrder = 5
      Text = '1'
    end
    object UpDown7: TUpDown
      Left = 137
      Top = 327
      Width = 13
      Height = 21
      Associate = Edit7
      Max = 50
      Position = 1
      TabOrder = 6
      OnClick = UpDown7Click
    end
    object UpDown8: TUpDown
      Left = 93
      Top = 355
      Width = 15
      Height = 21
      Associate = Edit8
      Min = 1
      Position = 14
      TabOrder = 7
      OnClick = UpDown8Click
    end
    object Edit8: TEdit
      Left = 73
      Top = 355
      Width = 20
      Height = 21
      TabStop = False
      TabOrder = 8
      Text = '14'
    end
    object Button2: TButton
      Left = 95
      Top = 427
      Width = 73
      Height = 25
      Caption = 'Clear'
      TabOrder = 10
      TabStop = False
      OnClick = Button2Click
    end
    object ComboBox1: TComboBox
      Left = 6
      Top = 394
      Width = 123
      Height = 21
      ItemHeight = 13
      TabOrder = 11
      TabStop = False
      Text = 'Presets'
      OnChange = ComboBox1Change
    end
    object Button3: TButton
      Left = 134
      Top = 392
      Width = 35
      Height = 23
      Caption = 'Add'
      TabOrder = 12
      TabStop = False
      OnClick = Button3Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 490
    Width = 666
    Height = 18
    Panels = <
      item
        Text = 'Living Cells: 0'
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 446
    Top = 462
  end
  object Timer2: TTimer
    Interval = 300
    OnTimer = Timer2Timer
    Left = 484
    Top = 466
  end
end
