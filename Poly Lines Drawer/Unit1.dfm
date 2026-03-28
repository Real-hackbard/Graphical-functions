object PolyLineDemoForm: TPolyLineDemoForm
  Left = 352
  Top = 188
  AutoScroll = False
  Caption = 'Poly Line Drawer'
  ClientHeight = 515
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 400
    Top = 0
    Width = 183
    Height = 515
    Align = alRight
    TabOrder = 0
    object LineColorLabel: TLabel
      Left = 8
      Top = 112
      Width = 49
      Height = 13
      Caption = 'Line color:'
    end
    object LineWidthLabel: TLabel
      Left = 8
      Top = 64
      Width = 51
      Height = 13
      Caption = 'Line width:'
    end
    object InfoMemo: TMemo
      Left = 1
      Top = 304
      Width = 176
      Height = 201
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      Lines.Strings = (
        'Left click to select a line.'
        ''
        'Drag a line to move the line.'
        ''
        'Drag a line node to move the '
        'linenode.'
        ''
        'Right click a selected line to '
        'add a linenode.'
        ''
        'Right click a linenode to '
        'delete the linenode.'
        ''
        'Press DEL to delete a '
        'selected line.')
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object ClearButton: TButton
      Left = 8
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 1
      OnClick = ClearButtonClick
    end
    object SaveButton: TButton
      Left = 96
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      OnClick = SaveButtonClick
    end
    object LoadLinesButton: TButton
      Left = 8
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 3
      OnClick = LoadLinesButtonClick
    end
    object AllowMoveEndPointsCheckBox: TCheckBox
      Left = 8
      Top = 216
      Width = 123
      Height = 17
      Caption = 'Allow move endpoints'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = AllowMoveEndPointsCheckBoxClick
    end
    object AllowMoveLineCheckBox: TCheckBox
      Left = 8
      Top = 192
      Width = 99
      Height = 17
      Caption = 'Allow move lines'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = AllowMoveLineCheckBoxClick
    end
    object ButtonCreateNewLine: TButton
      Left = 96
      Top = 16
      Width = 75
      Height = 25
      Caption = 'New line'
      TabOrder = 6
      OnClick = ButtonCreateNewLineClick
    end
    object LineColorBox: TColorBox
      Left = 8
      Top = 128
      Width = 145
      Height = 22
      ItemHeight = 16
      TabOrder = 7
    end
    object LineWidthComboBox: TComboBox
      Left = 8
      Top = 80
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 8
      Text = '2'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5')
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'lin'
    Filter = 'Line files (*.lin)|*.lin|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Title = 'Select a line file'
    Left = 41
    Top = 33
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'lin'
    Filter = 'Line files (*.lin)|*.lin'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing, ofDontAddToRecent]
    Title = 'Save line file as'
    Left = 81
    Top = 33
  end
end
