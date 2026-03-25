object Form1: TForm1
  Left = 330
  Top = 191
  Width = 696
  Height = 480
  Caption = 'XY Graph'
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
  object Chart1: TChart
    Left = 0
    Top = 89
    Width = 680
    Height = 352
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Least Squares Fit Approximation')
    BottomAxis.Title.Caption = 'Independent [ X ]'
    LeftAxis.Title.Caption = 'Dependent [ Y ]'
    View3D = False
    Align = alClient
    TabOrder = 0
    object Series2: TPointSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Sample'
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
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Fitted'
      LinePen.Color = clRed
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 89
    Align = alTop
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 89
      Height = 57
      Caption = 'Data points'
      TabOrder = 0
      object SpeedButton1: TSpeedButton
        Left = 48
        Top = 24
        Width = 33
        Height = 22
        Caption = 'Go'
        OnClick = SpeedButton1Click
      end
      object MaskEdit1: TMaskEdit
        Left = 8
        Top = 24
        Width = 30
        Height = 21
        TabStop = False
        EditMask = '99;1;_'
        MaxLength = 2
        TabOrder = 0
        Text = '10'
      end
    end
    object GroupBox2: TGroupBox
      Left = 112
      Top = 16
      Width = 201
      Height = 57
      Caption = 'Fit-Method'
      TabOrder = 1
      object SpeedButton2: TSpeedButton
        Left = 160
        Top = 24
        Width = 31
        Height = 22
        Caption = 'Go'
        OnClick = SpeedButton2Click
      end
      object ComboBox1: TComboBox
        Left = 8
        Top = 24
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        TabStop = False
        Text = 'Y=c+X*b1'
        OnSelect = ComboBox1Select
        Items.Strings = (
          'Y=c+X*b1'
          'Y=c+X*b1+X*X*b2'
          'Y=c+X*b1+X^2*b2+X^3*b3'
          'Y=Exp(c+X*b1)'
          'Y=c+Ln(X*b1)')
      end
    end
    object GroupBox3: TGroupBox
      Left = 344
      Top = 16
      Width = 321
      Height = 57
      Caption = 'Result'
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 16
        Width = 18
        Height = 13
        Caption = 'c=?'
      end
      object Label2: TLabel
        Left = 9
        Top = 32
        Width = 24
        Height = 13
        Caption = 'b1=?'
      end
      object Label3: TLabel
        Left = 169
        Top = 16
        Width = 24
        Height = 13
        Caption = 'b2=?'
      end
      object Label4: TLabel
        Left = 169
        Top = 32
        Width = 24
        Height = 13
        Caption = 'b3=?'
      end
    end
  end
end
