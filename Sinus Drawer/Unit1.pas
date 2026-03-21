unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, ShellApi, StdCtrls, Spin, XPman;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    SinButton: TSpeedButton;
    CosButton: TSpeedButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SaveDialog1: TSaveDialog;
    ColorDialog1: TColorDialog;
    Shape4: TShape;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button1: TButton;
    procedure SinButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CosButtonClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SinButtonClick(Sender: TObject);
var
  x: real;
  sx,sy: integer;
begin
  Screen.Cursor := crHourGlass;
  Image1.Canvas.Brush.Color := Shape4.Brush.Color;
  Image1.Canvas.FillRect(Image1.ClientRect);

  if CheckBox2.Checked = true then
  begin
    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  end;

  if CheckBox1.Checked = true then
  begin
    Image1.Canvas.Pen.Color := Shape1.Brush.Color;
    Image1.Canvas.MoveTo(0,Image1.Height div 2);
    Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
    Image1.Canvas.MoveTo(Image1.Width div 2,0);
    Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
  end;

  x:= SpinEdit1.Value;
  sy := Image1.Height div SpinEdit3.Value;
  sx := Image1.Width div SpinEdit4.Value;
  while x < SpinEdit2.Value do
    begin
    Image1.Canvas.Pixels[trunc(sx*x)+Image1.Width div 2,
      Image1.Height div 2-trunc(sy*sin(x))]:= Shape2.Brush.Color;
    case ComboBox1.ItemIndex of
    0 : x:=x+0.001;
    1 : x:=x+0.111;
    2 : x:=x+0.301;
    end;

  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Canvas.Brush.Color := Shape4.Brush.Color;
  Image1.Canvas.FloodFill(Form1.Width div 2,Form1.Height div 2,
                                              clWhite,fsSurface);
  Image1.Canvas.Pen.Color:= Shape1.Brush.Color;
  Image1.Canvas.MoveTo(0,Image1.Height div 2);
  Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
  Image1.Canvas.MoveTo(Image1.Width div 2,0);
  Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
end;

procedure TForm1.CosButtonClick(Sender: TObject);
var
  x: real;
  sx,sy: integer;
begin
  Screen.Cursor := crHourGlass;
  Image1.Canvas.Brush.Color := Shape4.Brush.Color;
  Image1.Canvas.FillRect(Image1.ClientRect);

  if CheckBox2.Checked = true then
  begin
    Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);
  end;

  if CheckBox1.Checked = true then
  begin
    Image1.Canvas.Pen.Color := Shape1.Brush.Color;
    Image1.Canvas.MoveTo(0,Image1.Height div 2);
    Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
    Image1.Canvas.MoveTo(Image1.Width div 2,0);
    Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
  end;

  x:= SpinEdit1.Value;
  sy:=Image1.Height div SpinEdit3.Value;
  sx:=Image1.Width div SpinEdit4.Value;

  while x < SpinEdit2.Value do
  begin
    Image1.Canvas.Pixels[trunc(sx*x)+Image1.Width div 2,
      Image1.Height div 2-trunc(sy*cos(x))]:= Shape3.Brush.Color;
    case ComboBox1.ItemIndex of
    0 : x:=x+0.001;
    1 : x:=x+0.111;
    2 : x:=x+0.301;
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
    Image1.Canvas.Pen.Color := Shape1.Brush.Color;
    Image1.Canvas.MoveTo(0,Image1.Height div 2);
    Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
    Image1.Canvas.MoveTo(Image1.Width div 2,0);
    Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
  end else begin
    Image1.Canvas.Brush.Color := Shape4.Brush.Color;
    Image1.Canvas.FillRect(Image1.ClientRect);
  end;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape1.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape2.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape3.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  Image1.Canvas.Brush.Color := Shape4.Brush.Color;
  Image1.Canvas.FloodFill(Form1.Width div 2,Form1.Height div 2,
                                              clWhite,fsSurface);
  Image1.Canvas.Pen.Color:= Shape1.Brush.Color;
  Image1.Canvas.MoveTo(0,Image1.Height div 2);
  Image1.Canvas.LineTo(Image1.Width,Image1.Height div 2);
  Image1.Canvas.MoveTo(Image1.Width div 2,0);
  Image1.Canvas.LineTo(Image1.Width div 2,Image1.Height);
  Label11.Caption := IntToStr(Image1.Height) + ' x ' + IntToStr(Image1.Width);
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ColorDialog1.Execute then
    Shape4.Brush.Color := ColorDialog1.Color;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  try
    bmp := TBitmap.Create;
    bmp.Assign(Image1.Picture.Bitmap);
    bmp.PixelFormat := pf24bit;

    if SaveDialog1.Execute then
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
  finally
    bmp.Free;
  end;
end;

end.
