object Form1: TForm1
  Left = 388
  Top = 159
  Width = 686
  Height = 558
  Caption = 'Curve Fitting'
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 549
    Top = 0
    Height = 519
    Align = alRight
  end
  object Panel1: TPanel
    Left = 552
    Top = 0
    Width = 118
    Height = 519
    Align = alRight
    Constraints.MinWidth = 118
    TabOrder = 0
    TabStop = True
    DesignSize = (
      118
      519)
    object LaPosition: TLabel
      Left = 8
      Top = 8
      Width = 49
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'LaPosition'
    end
    object Label1: TLabel
      Left = 30
      Top = 316
      Width = 27
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MinX:'
    end
    object Label2: TLabel
      Left = 27
      Top = 342
      Width = 30
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MaxX:'
    end
    object Label3: TLabel
      Left = 30
      Top = 390
      Width = 27
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MinY:'
    end
    object Label4: TLabel
      Left = 27
      Top = 412
      Width = 30
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MaxY:'
    end
    object Label5: TLabel
      Left = 21
      Top = 366
      Width = 35
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Step X:'
    end
    object Label6: TLabel
      Left = 22
      Top = 436
      Width = 35
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Step Y:'
    end
    object Label7: TLabel
      Left = 31
      Top = 260
      Width = 26
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Grad:'
    end
    object LaZusammenhang: TLabel
      Left = 8
      Top = 288
      Width = 57
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Connection:'
    end
    object BtnLoeschen: TButton
      Left = 8
      Top = 60
      Width = 105
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Clear Point'
      TabOrder = 0
      TabStop = False
      OnClick = BtnLoeschenClick
    end
    object CbPunkteVerbinden: TCheckBox
      Left = 8
      Top = 24
      Width = 89
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Connect dots'
      TabOrder = 1
      OnClick = CbPunkteVerbindenClick
    end
    object RgFunktionen: TRadioGroup
      Left = 8
      Top = 104
      Width = 105
      Height = 145
      Anchors = [akTop, akRight]
      Caption = 'Function'
      Items.Strings = (
        'y = a * x'
        'y = a * x'#178
        'y = a / x'
        'y = a * SQR(x)'
        'y = a * LN(x)'
        'y = e^(a * x)')
      TabOrder = 2
      OnClick = RgFunktionenClick
    end
    object CbKurveZeichnen: TCheckBox
      Left = 8
      Top = 40
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Draw Curve'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = CbKurveZeichnenClick
    end
    object EdMinX: TEdit
      Left = 64
      Top = 312
      Width = 49
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 4
      Text = 'EdMinX'
      OnChange = EdMinXChange
      OnExit = EdXExit
      OnKeyPress = EdMinKeyPress
    end
    object EdMaxX: TEdit
      Left = 65
      Top = 336
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 5
      Text = 'EdMaxX'
      OnChange = EdMaxXChange
      OnExit = EdXExit
      OnKeyPress = EdMaxKeyPress
    end
    object EdSchrittX: TEdit
      Left = 65
      Top = 360
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 6
      Text = 'EdSchrittX'
      OnChange = EdSchrittXChange
      OnKeyPress = EdSchrittKeyPress
    end
    object EdMinY: TEdit
      Left = 65
      Top = 384
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 7
      Text = 'EdMinY'
      OnChange = EdMinYChange
      OnExit = EdYExit
      OnKeyPress = EdMinKeyPress
    end
    object EdMaxY: TEdit
      Left = 65
      Top = 408
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 8
      Text = 'EdMaxY'
      OnChange = EdMaxYChange
      OnExit = EdYExit
      OnKeyPress = EdMaxKeyPress
    end
    object EdSchrittY: TEdit
      Left = 65
      Top = 432
      Width = 48
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 9
      Text = 'EdSchrittY'
      OnChange = EdSchrittYChange
      OnKeyPress = EdSchrittKeyPress
    end
    object EdGrad: TSpinEdit
      Left = 64
      Top = 256
      Width = 49
      Height = 22
      Enabled = False
      MaxLength = 3
      MaxValue = 25
      MinValue = 0
      TabOrder = 10
      Value = 0
      OnChange = EdGradChange
    end
    object MeParameter: TMemo
      Left = 8
      Top = 456
      Width = 105
      Height = 73
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 11
      WordWrap = False
    end
    object BtnDrucken: TButton
      Left = 8
      Top = 80
      Width = 105
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Print'
      TabOrder = 12
      TabStop = False
      OnClick = BtnDruckenClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 549
    Height = 519
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 549
      Height = 460
      Align = alClient
      TabOrder = 0
      DesignSize = (
        549
        460)
      object Image: TImage
        Left = 8
        Top = 96
        Width = 544
        Height = 371
        Anchors = [akLeft, akTop, akRight, akBottom]
        OnDblClick = PaintBoxDblClick
        OnMouseDown = PaintBoxMouseDown
        OnMouseMove = PaintBoxMouseMove
        OnMouseUp = PaintBoxMouseUp
      end
      object StringGrid: TStringGrid
        Left = 8
        Top = 8
        Width = 548
        Height = 81
        Anchors = [akLeft, akTop, akRight]
        DefaultDrawing = False
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        PopupMenu = PopupMenu
        ScrollBars = ssHorizontal
        TabOrder = 0
        OnDblClick = StringGridDblClick
        OnMouseMove = StringGridMouseMove
        OnSelectCell = StringGridSelectCell
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 460
      Width = 549
      Height = 59
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        549
        59)
      object EdFormel: TEdit
        Left = 6
        Top = 8
        Width = 545
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object EdExcelFormel: TEdit
        Left = 6
        Top = 32
        Width = 458
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 1
      end
      object Button1: TButton
        Left = 468
        Top = 32
        Width = 83
        Height = 21
        Anchors = [akTop, akRight]
        Caption = 'Excel-Table'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 472
    Top = 16
    object Menu_PunktLoeschen: TMenuItem
      Caption = 'Punkt L'#246'schen'
      OnClick = Menu_PunktLoeschenClick
    end
  end
end
