unit Unit1;
 {Just fooling around with Fibonacci sunflowers}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, XPMan, Spin;

type
  TForm1 = class(TForm)
    Image1: TImage;
    ColorDialog1: TColorDialog;
    SaveDialog1: TSaveDialog;
    Panel1: TPanel;
    DrawBtn: TButton;
    Memo1: TMemo;
    RotateRBox: TRadioGroup;
    StyleBox: TRadioGroup;
    Label1: TLabel;
    Shape1: TShape;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Shape2: TShape;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    SpinEdit2: TSpinEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    procedure DrawBtnClick(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure RotateRBoxClick(Sender: TObject);
  private
    { Private declarations }
    midx, midy:integer;
    procedure Circle(centerRadius,CenterAngle:real; r:integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}

procedure TForm1.Circle(centerRadius,CenterAngle:real; r:integer);
{Draw a circle centered at CenterRadius, CenterAngle from image center,
 radius of cirdle drawn is r}
var
  x,y:integer;
begin
  with image1,canvas do
  begin
    x:=trunc(midx+CenterRadius*cos(CenterAngle));
    y:=trunc(midy+CenterRadius*sin(CenterAngle));
    ellipse(x-r,y-r,x+r,y+r);
  end;
end;

procedure TForm1.DrawBtnClick(Sender: TObject);
{Draw a sunflower}
var
  i,j,k,r:integer;
  phi,IncA:real;
begin
  r := SpinEdit1.Value;

  case ComboBox1.ItemIndex of
  0 : phi:=(1+sin(5.0))/2;
  1 : phi:=(1+cos(5.0))/2;
  2 : phi:=(1+sqrt(5.0))/2;
  end;

  Image1.Picture.Graphic := nil;

  case rotateRbox.itemindex of {set angle increment for center of seed}
    0: IncA:= 2*Pi*Phi;
    1: IncA:= 2*pi*(21/34);
    2: IncA:= 2*pi*(34/55);
    3: IncA:= SpinEdit3.Value*pi*(SpinEdit4.Value/SpinEdit5.Value);
  end;

  midx:= image1.width div 2;
  midy:= image1.height div 2;
  Image1.canvas.brush.color := Shape2.Brush.Color; {clear the image area}

  with image1 do
  if CheckBox1.Checked = true then

  begin
    canvas.rectangle(clientrect);
  end;

  Image1.canvas.brush.color:= Shape1.Brush.Color;
  {Arbitrary big number of seeds to create}
  for i := 0 to SpinEdit2.Value do
  begin
    case stylebox.itemindex of
    {fixed seed size moving outward by sqrt(i)}
    0: circle(sqrt(i)*r,i*IncA,r);
    {increasing seed size - just trial and error numbers}
    1: circle(i*r/22,IncA*i,trunc(r*(i/500)));
    end;
    if i mod 16 = 0 then
    Application.Processmessages; {redraw once in a while}
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

procedure TForm1.RotateRBoxClick(Sender: TObject);
begin
  case RotateRBox.ItemIndex of
  3 : begin
        SpinEdit3.Enabled := true;
        SpinEdit4.Enabled := true;
        SpinEdit5.Enabled := true;
      end else begin
        SpinEdit3.Enabled := false;
        SpinEdit4.Enabled := false;
        SpinEdit5.Enabled := false;
      end;
  end;
end;

end.
