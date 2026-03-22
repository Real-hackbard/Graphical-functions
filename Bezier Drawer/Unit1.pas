unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math, ComCtrls, ExtCtrls, XPMan;

type
  Point = record
          X, Y, Z: real;
          end;
  TForm1 = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    ComboBox1: TComboBox;
    Label3: TLabel;
    procedure StopFlicker(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure DrawBeizer(A, D, V1, V2: Point);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  P1, P2, Vv1, Vv2: Point;
  Drag: integer;

implementation


{$R *.DFM}
procedure TForm1.StopFlicker(var Msg: TWMEraseBkgnd);
begin
   Msg.Result := 0;
end;

procedure TForm1.DrawBeizer(A, D, V1, V2: Point);
Var
  B, C, P: Point;
  aa, bb, T: real;
  I: integer;

begin
  B.x := (A.x+ V1.x);
  B.y := (A.y+ V1.y);
  //B.z := (A.z+ V1.z);

  C.x := (D.x+ V2.x);
  C.y := (D.y+ V2.y);
  //C.z := (D.z+ V2.z);
  Image1.Canvas.Brush.Color := clRed;
  Image1.canvas.Ellipse(round(A.x-5),round(A.y-5),round(A.x+5),round(A.y+5));
  Image1.canvas.Ellipse(round(B.x-5),round(B.y-5),round(B.x+5),round(B.y+5));
  Image1.canvas.Ellipse(round(C.x-5),round(C.y-5),round(C.x+5),round(C.y+5));
  Image1.canvas.Ellipse(round(D.x-5),round(D.y-5),round(D.x+5),round(D.y+5));

  Image1.canvas.moveto(round(A.x), round(A.y));
  Image1.canvas.lineto(round(b.x), round(b.y));
  Image1.canvas.moveto(round(D.x), round(D.y));
  Image1.canvas.lineto(round(C.x), round(C.y));
  Image1.canvas.moveto(round(A.x), round(A.y));
  for I := 0 to TrackBar1.position do
  begin
       T := I / TrackBar1.position ;
       aa := T;
       bb := 1- T;
       P.x := a.X*power(bb,3) + 3*B.X*sqr(bb)*aa +
                                3*C.X*bb*sqr(aa) + D.x*Power(aa, 3);
       P.y := a.y*power(bb,3) + 3*B.y*sqr(bb)*aa +
                                3*C.y*bb*sqr(aa) + D.y*Power(aa, 3);

       Image1.Canvas.Pen.Color := clNavy;

       case ComboBox1.ItemIndex of
       0 : Image1.canvas.LineTo(round(P.X), round(P.y));
       1 : Image1.canvas.Ellipse(round(P.x-2),round(P.y-2),
                                 round(P.x+2),round(P.y+2));
       end;

  end;
end;

function Col(P: Point; X, Y, R: integer): boolean;
begin
  Col := false;
  if (X >= P.x - R) and (X <= P.x + R) then
  if (Y >= P.y - R) and (Y <= P.y + R) then
  Col := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 DoubleBuffered := true;
 P1.x := 100;
 P1.Y := 100;
 P2.X := 200;
 P2.Y := 200;
 Vv1.X := 0;
 Vv1.Y := -100;
 vv2.X := 0;
 vv2.Y := 100;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  S: TShiftState;
begin
 Mousemove(s, 0, 0);
 Label3.Caption := IntToStr(TrackBar1.Position) + ' %';
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  T1, T2: point;
begin
  Drag := 0;
  if Col(P1, X, Y, 5) then
  Drag := 1;
  if Col(P2, X, Y, 5) then
  Drag := 2;

  T1.x := P1.x + Vv1.x;
  T1.y := P1.y + Vv1.y;
  if Col(T1, X, Y, 5) then
  Drag := 3;

  T2.x := P2.x + Vv2.x;
  T2.y := P2.y + Vv2.y;
  if Col(T2, X, Y, 5) then
  Drag := 4;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Pp1, Pp2, VVv1, Vvv2: point;
begin
 Image1.Picture.Graphic := nil;

 if Drag = 1 then
 begin
 P1.x := X;
 P1.Y := Y;
 end;
 if Drag = 2 then
 begin
 P2.X := X;
 P2.Y := Y;
 end;
 if Drag = 3 then
 begin
 Vv1.X := X - P1.x;
 Vv1.Y := Y - P1.y;
 end;
 if Drag = 4 then
 begin
 Vv2.X := X - P2.x;
 Vv2.Y := Y - P2.y;
 end;
 PatBlt(Canvas.Handle, 0, 0, Width, Height, WHITENESS);
 DrawBeizer(P1, P2, Vv1, Vv2);
 pp2.X := p1.x;
 pp2.Y := p1.Y;
 pp1.X := p2.x;
 pp1.Y := p2.Y;
 Vvv1.x := -Vv2.x;
 Vvv1.Y := -Vv2.y;
 Vvv2.x := -Vv1.x;
 Vvv2.Y := -Vv1.y;

 StatusBar1.Panels[1].Text := IntToStr(X) + 'x' + IntToStr(Y);
 DrawBeizer(Pp1, Pp2, Vvv1, Vvv2);
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Drag := 0;
end;

end.
