object Form1: TForm1
  Left = 297
  Top = 154
  Width = 808
  Height = 646
  Caption = 'Bezier Curve Generator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 587
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    OnMouseUp = Panel1MouseUp
    OnResize = Panel1Resize
  end
  object Panel2: TPanel
    Left = 576
    Top = 0
    Width = 216
    Height = 587
    Align = alRight
    Caption = 'Panel2'
    TabOrder = 1
    object Button1: TButton
      Left = 134
      Top = 536
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 0
      OnClick = Button1Click
    end
    object TTabControl1: TTabControl
      Left = 7
      Top = 0
      Width = 209
      Height = 521
      TabOrder = 1
      Tabs.Strings = (
        'Control Points')
      TabIndex = 0
      object GroupBox3: TGroupBox
        Left = 8
        Top = 240
        Width = 193
        Height = 97
        Caption = 'Control Point Three'
        TabOrder = 0
        OnClick = GroupBox3Click
        object Label7: TLabel
          Left = 16
          Top = 17
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label8: TLabel
          Left = 16
          Top = 41
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object Label9: TLabel
          Left = 16
          Top = 65
          Width = 10
          Height = 13
          Caption = 'Z:'
        end
        object txtPoint3Z: TEdit
          Left = 35
          Top = 64
          Width = 41
          Height = 21
          TabOrder = 0
          OnEnter = txtPoint3ZEnter
          OnExit = txtPoint3ZExit
        end
        object txtPoint3Y: TEdit
          Left = 35
          Top = 40
          Width = 41
          Height = 21
          TabOrder = 1
          OnEnter = txtPoint3YEnter
          OnExit = txtPoint3YExit
        end
        object txtPoint3X: TEdit
          Left = 35
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 2
          OnEnter = txtPoint3XEnter
          OnExit = txtPoint3XExit
        end
        object UpDown7: TUpDown
          Left = 75
          Top = 14
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 3
          OnClick = UpDown7Click
        end
        object UpDown8: TUpDown
          Left = 75
          Top = 38
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 4
          OnClick = UpDown8Click
        end
        object UpDown9: TUpDown
          Left = 75
          Top = 62
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 5
          OnClick = UpDown9Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 136
        Width = 193
        Height = 97
        Caption = 'Control Point Two'
        TabOrder = 1
        OnClick = GroupBox4Click
        object Label4: TLabel
          Left = 16
          Top = 19
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label5: TLabel
          Left = 16
          Top = 43
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object Label6: TLabel
          Left = 16
          Top = 67
          Width = 10
          Height = 13
          Caption = 'Z:'
        end
        object txtPoint2Z: TEdit
          Left = 35
          Top = 64
          Width = 41
          Height = 21
          TabOrder = 0
          OnEnter = txtPoint2ZEnter
          OnExit = txtPoint2ZExit
        end
        object txtPoint2Y: TEdit
          Left = 35
          Top = 40
          Width = 41
          Height = 21
          TabOrder = 1
          OnEnter = txtPoint2YEnter
          OnExit = txtPoint2YExit
        end
        object txtPoint2X: TEdit
          Left = 35
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 2
          OnEnter = txtPoint2XEnter
          OnExit = txtPoint2XExit
        end
        object UpDown4: TUpDown
          Left = 75
          Top = 14
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 3
          OnClick = UpDown4Click
        end
        object UpDown5: TUpDown
          Left = 75
          Top = 38
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 4
          OnClick = UpDown5Click
        end
        object UpDown6: TUpDown
          Left = 75
          Top = 62
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 5
          OnClick = UpDown6Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 344
        Width = 193
        Height = 97
        Caption = 'Control Point Four (End Point)'
        TabOrder = 2
        object Label10: TLabel
          Left = 16
          Top = 18
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label11: TLabel
          Left = 16
          Top = 43
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object Label12: TLabel
          Left = 16
          Top = 67
          Width = 10
          Height = 13
          Caption = 'Z:'
        end
        object txtPoint4Z: TEdit
          Left = 35
          Top = 64
          Width = 41
          Height = 21
          TabOrder = 0
          OnEnter = txtPoint4ZEnter
          OnExit = txtPoint4ZExit
        end
        object txtPoint4Y: TEdit
          Left = 35
          Top = 40
          Width = 41
          Height = 21
          TabOrder = 1
          OnEnter = txtPoint4YEnter
          OnExit = txtPoint4YExit
        end
        object txtPoint4X: TEdit
          Left = 35
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 2
          OnEnter = txtPoint4XEnter
          OnExit = txtPoint4XExit
        end
        object UpDown10: TUpDown
          Left = 75
          Top = 14
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 3
          OnClick = UpDown10Click
        end
        object UpDown11: TUpDown
          Left = 75
          Top = 38
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 4
          OnClick = UpDown11Click
        end
        object UpDown12: TUpDown
          Left = 75
          Top = 62
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 5
          OnClick = UpDown12Click
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 32
        Width = 193
        Height = 97
        Caption = 'Control point One (Start Point)'
        TabOrder = 3
        object Label1: TLabel
          Left = 16
          Top = 18
          Width = 10
          Height = 13
          Caption = 'X:'
        end
        object Label2: TLabel
          Left = 16
          Top = 42
          Width = 10
          Height = 13
          Caption = 'Y:'
        end
        object Label3: TLabel
          Left = 16
          Top = 66
          Width = 10
          Height = 13
          Caption = 'Z:'
        end
        object txtPoint1X: TEdit
          Left = 35
          Top = 16
          Width = 41
          Height = 21
          TabOrder = 0
          OnEnter = txtPoint1XEnter
          OnExit = txtPoint1XExit
        end
        object txtPoint1Y: TEdit
          Left = 35
          Top = 40
          Width = 41
          Height = 21
          TabOrder = 1
          OnEnter = txtPoint1YEnter
          OnExit = txtPoint1YExit
        end
        object txtPoint1Z: TEdit
          Left = 35
          Top = 64
          Width = 41
          Height = 21
          TabOrder = 2
          OnEnter = txtPoint1ZEnter
          OnExit = txtPoint1ZExit
        end
        object UpDown1: TUpDown
          Left = 75
          Top = 14
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 3
          OnClick = UpDown1Click
        end
        object UpDown2: TUpDown
          Left = 75
          Top = 38
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 4
          OnClick = UpDown2Click
        end
        object UpDown3: TUpDown
          Left = 75
          Top = 62
          Width = 16
          Height = 24
          Min = -10000
          Max = 10000
          TabOrder = 5
          OnClick = UpDown3Click
        end
      end
      object Button2: TButton
        Left = 128
        Top = 480
        Width = 75
        Height = 25
        Caption = 'Apply'
        TabOrder = 4
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 142
        Top = 451
        Width = 60
        Height = 25
        Caption = 'Next Curve'
        TabOrder = 5
        OnClick = Button3Click
      end
      object chkAllBeziers: TCheckBox
        Left = 16
        Top = 488
        Width = 97
        Height = 17
        Caption = 'Show All Curves'
        TabOrder = 7
      end
      object chkRotate: TCheckBox
        Left = 16
        Top = 464
        Width = 97
        Height = 17
        Caption = 'Rotate'
        Checked = True
        State = cbChecked
        TabOrder = 8
      end
      object Button4: TButton
        Left = 75
        Top = 451
        Width = 62
        Height = 25
        Caption = 'Prev Curve'
        TabOrder = 6
        OnClick = Button4Click
      end
    end
    object Button5: TButton
      Left = 80
      Top = 536
      Width = 51
      Height = 25
      Caption = 'Zoom -'
      TabOrder = 2
      OnMouseDown = Button5MouseDown
      OnMouseUp = Button5MouseUp
    end
    object Button6: TButton
      Left = 24
      Top = 536
      Width = 51
      Height = 25
      Caption = 'Zoom +'
      TabOrder = 3
      OnMouseDown = Button6MouseDown
      OnMouseUp = Button6MouseUp
    end
  end
  object MainMenu1: TMainMenu
    Left = 88
    Top = 16
    object File1: TMenuItem
      Caption = 'File'
      object New1: TMenuItem
        Caption = '&New'
        OnClick = New1Click
      end
      object OpenControlPointFile1: TMenuItem
        Caption = 'Open Control Point File'
        OnClick = OpenControlPointFile1Click
      end
      object Save1: TMenuItem
        Caption = 'Save To Array '
        OnClick = Save1Click
      end
      object SaveControlPoints1: TMenuItem
        Caption = 'Save Control Points'
        OnClick = SaveControlPoints1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object ShowStart1: TMenuItem
        Caption = 'Show Start'
        Checked = True
        OnClick = ShowStart1Click
      end
      object Rotate1: TMenuItem
        Caption = 'Rotate'
        Checked = True
        OnClick = Rotate1Click
      end
      object ShowAllCurves1: TMenuItem
        Caption = 'Show All Curves'
        OnClick = ShowAllCurves1Click
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 128
    Top = 16
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer2Timer
    Left = 168
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'pas'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 8
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Control Point File|*.TXT'
    Left = 48
    Top = 16
  end
end
