object Form1: TForm1
  Left = 251
  Top = 97
  Width = 870
  Height = 640
  Caption = 'Pendulum'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 728
    Top = 0
    Width = 126
    Height = 601
    Align = alRight
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 16
      Width = 87
      Height = 13
      Caption = 'Cyclic Frequency :'
    end
    object Label2: TLabel
      Left = 8
      Top = 76
      Width = 105
      Height = 13
      Caption = 'Attenuation Constant :'
    end
    object Label3: TLabel
      Left = 16
      Top = 139
      Width = 33
      Height = 13
      Caption = 'Angle :'
    end
    object Button1: TButton
      Left = 16
      Top = 224
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 32
      Top = 42
      Width = 57
      Height = 21
      TabStop = False
      TabOrder = 1
      Text = '4'
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 32
      Top = 100
      Width = 57
      Height = 21
      TabStop = False
      TabOrder = 2
      Text = '0.5'
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      Left = 40
      Top = 163
      Width = 57
      Height = 21
      TabStop = False
      TabOrder = 3
      Text = '90'
      OnChange = Edit3Change
    end
  end
end
