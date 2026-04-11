object Form2: TForm2
  Left = 456
  Top = 188
  Width = 277
  Height = 336
  Caption = 'About '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 55
    Top = 8
    Width = 184
    Height = 13
    Caption = 'Bezier Curve Path Generator (OpenGL)'
  end
  object Label2: TLabel
    Left = 8
    Top = 7
    Width = 26
    Height = 13
    Caption = 'Title :'
  end
  object Label3: TLabel
    Left = 8
    Top = 24
    Width = 37
    Height = 13
    Caption = 'Author :'
  end
  object Label4: TLabel
    Left = 55
    Top = 24
    Width = 94
    Height = 13
    Caption = 'Maarten Kronberger'
  end
  object Label12: TLabel
    Left = 8
    Top = 78
    Width = 59
    Height = 13
    Caption = 'Description :'
  end
  object Label13: TLabel
    Left = 40
    Top = 100
    Width = 149
    Height = 13
    Caption = 'Bezier Curve Generator/Creator'
  end
  object Label14: TLabel
    Left = 8
    Top = 122
    Width = 76
    Height = 13
    Caption = 'Special thanks :'
  end
  object Label15: TLabel
    Left = 40
    Top = 142
    Width = 179
    Height = 52
    Caption = 
      'Thanks to Digiben and the guys at www.gametutorials.com for the ' +
      'bezier curve source. :D                            and  to Nitro' +
      'gen for the math help.'
    WordWrap = True
  end
  object Label16: TLabel
    Left = 8
    Top = 56
    Width = 41
    Height = 13
    Caption = 'Version :'
  end
  object Label17: TLabel
    Left = 56
    Top = 56
    Width = 15
    Height = 13
    Caption = '1.0'
  end
  object Label18: TLabel
    Left = 40
    Top = 208
    Width = 185
    Height = 26
    Caption = 
      'If you have any queries or bugs please send me a mail or visit s' +
      'ulaco.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 88
    Top = 256
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
end
