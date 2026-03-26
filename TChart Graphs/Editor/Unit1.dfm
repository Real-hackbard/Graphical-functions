object Form1: TForm1
  Left = 349
  Top = 151
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Editor'
  ClientHeight = 632
  ClientWidth = 728
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
  object Label1: TLabel
    Left = 8
    Top = 320
    Width = 21
    Height = 13
    Caption = 'X,Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 208
    Top = 520
    Width = 48
    Height = 13
    Caption = 'Chart Title'
  end
  object countLbl: TLabel
    Left = 16
    Top = 600
    Width = 41
    Height = 13
    Caption = '0 Points '
  end
  object Chart1: TChart
    Left = 208
    Top = 16
    Width = 505
    Height = 449
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Sample Test Chart')
    Legend.LegendStyle = lsValues
    Legend.Visible = False
    TabOrder = 0
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TBarSeries
      Marks.ArrowLength = 20
      Marks.Visible = True
      SeriesColor = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series3: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clYellow
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Memo1: TMemo
    Left = 8
    Top = 16
    Width = 185
    Height = 289
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'The trick to defining a TChart chart is '
      'to use the'
      'TChart Editor which is invoked by '
      'double clicking '
      'on the TChart component you have '
      'dropped on '
      'the form.  All of the normally used '
      'design '
      'parameters can be defined via the '
      'editor.'
      ''
      'In this demo I have defined 3 "series" '
      'representing different chart types '
      'which plots X '
      'and Y values defined in a TMemo '
      'control.  Only '
      'one of these chart formats is active at '
      'a time.'
      ''
      'Additons, deletions or changes you '
      'make to the '
      'data lines will be relfected in the '
      'charts.  Each '
      'data line must consist of X and Y '
      'values '
      'separated by a comma.  Invalid input '
      'data is '
      'ignored.  (When running under the '
      'IDE, an debug '
      'error message may be displayed as '
      'data is '
      'changed.  These messages will not '
      'show when '
      'runnjng the program  outside of the '
      'Delphi '
      'environment.) ')
    ParentFont = False
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 8
    Top = 344
    Width = 185
    Height = 241
    TabStop = False
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = Memo2Change
  end
  object TitleEdt: TEdit
    Left = 208
    Top = 536
    Width = 201
    Height = 21
    TabStop = False
    TabOrder = 3
    Text = 'Sample Test Chart'
    OnChange = TitleEdtChange
  end
  object TypeGrp: TRadioGroup
    Left = 504
    Top = 512
    Width = 89
    Height = 73
    Caption = 'Chart Type'
    ItemIndex = 0
    Items.Strings = (
      'Line'
      'Bar'
      'Scatter')
    TabOrder = 4
    OnClick = TypeGrpClick
  end
end
