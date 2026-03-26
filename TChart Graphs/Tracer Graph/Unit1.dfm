object Form1: TForm1
  Left = 500
  Top = 158
  Width = 627
  Height = 458
  Caption = 'Multi-Segment Trace [Demonstration]'
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
  object pnlBottom: TPanel
    Left = 0
    Top = 368
    Width = 611
    Height = 51
    Align = alBottom
    TabOrder = 0
    object btnTrace: TButton
      Left = 32
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Trace'
      TabOrder = 0
      TabStop = False
      OnClick = btnTraceClick
    end
    object btnTraceMore: TButton
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Trace Rest'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btnTraceMoreClick
    end
    object Button1: TButton
      Left = 512
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      TabStop = False
      OnClick = Button1Click
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 611
    Height = 368
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Tracer Graph')
    BottomAxis.LabelStyle = talValue
    Align = alClient
    TabOrder = 1
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Jpeg (*.jpeg)|*.jpeg|Bitmap (*.bmp)|*.bmp'
    Left = 80
    Top = 96
  end
end
