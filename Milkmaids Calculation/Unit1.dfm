object Form1: TForm1
  Left = 298
  Top = 129
  HelpContext = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Milkmaids Calculation'
  ClientHeight = 685
  ClientWidth = 976
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object milchm: TPanel
    Left = 0
    Top = 0
    Width = 976
    Height = 685
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PaintB1: TPaintBox
      Left = 0
      Top = 0
      Width = 713
      Height = 685
      Align = alClient
      OnPaint = PaintB1Paint
    end
    object Panel1: TPanel
      Left = 713
      Top = 0
      Width = 263
      Height = 685
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 147
        Height = 14
        Caption = 'Volume of the milk cans'
      end
      object Label2: TLabel
        Left = 24
        Top = 44
        Width = 182
        Height = 14
        Caption = 'Pot    A           B                   C'
      end
      object Label3: TLabel
        Left = 24
        Top = 256
        Width = 113
        Height = 14
        Caption = 'Possible solutions'
      end
      object Label4: TLabel
        Left = 88
        Top = 100
        Width = 75
        Height = 14
        Caption = 'Zielvolumen'
      end
      object Label5: TLabel
        Left = 24
        Top = 408
        Width = 146
        Height = 28
        Caption = 'Selected solution'#13#10'pot     A          B          C'
      end
      object LBox1: TListBox
        Left = 24
        Top = 280
        Width = 217
        Height = 116
        IntegralHeight = True
        ItemHeight = 14
        TabOrder = 0
        TabWidth = 40
        OnClick = LBox1Click
      end
      object Memo1: TMemo
        Left = 24
        Top = 136
        Width = 217
        Height = 105
        Color = 15790320
        Lines.Strings = (
          'The contents of the '
          'completely filled jug A '
          'should be transferred '
          'to the empty jugs '
          'B and C in such a way '
          'that the target '
          'volume is reached in '
          'one of the jugs.')
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object LBox2: TListBox
        Left = 24
        Top = 442
        Width = 217
        Height = 144
        IntegralHeight = True
        ItemHeight = 14
        TabOrder = 2
        TabWidth = 24
      end
      object Edit1: TEdit
        Left = 24
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 3
        Text = '8'
        OnChange = rm1Change
      end
      object UpDown1: TUpDown
        Left = 65
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit1
        Min = 3
        Max = 15
        Position = 8
        TabOrder = 4
      end
      object Edit2: TEdit
        Left = 104
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 5
        Text = '5'
        OnChange = rm1Change
      end
      object UpDown2: TUpDown
        Left = 145
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit2
        Min = 1
        Max = 15
        Position = 5
        TabOrder = 6
      end
      object Edit3: TEdit
        Left = 184
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 7
        Text = '3'
        OnChange = rm1Change
      end
      object UpDown3: TUpDown
        Left = 225
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit3
        Min = 1
        Max = 15
        Position = 3
        TabOrder = 8
      end
      object Edit4: TEdit
        Left = 184
        Top = 96
        Width = 41
        Height = 22
        TabOrder = 9
        Text = '4'
        OnChange = rm1Change
      end
      object UpDown4: TUpDown
        Left = 225
        Top = 96
        Width = 16
        Height = 22
        Associate = Edit4
        Min = 1
        Max = 15
        Position = 4
        TabOrder = 10
      end
    end
  end
end
