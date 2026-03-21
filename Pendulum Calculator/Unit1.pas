
// Solution by discretization of the ordinary system of differential equations
// for double pendulums
//
// The differential equations are the Lagrangian equations of motion of the
// system (details below).
// The boundary conditions (pendulum length) and gravity are in the
// Differential equation implicitly included.
// Angles and angular velocities serve as generalized coordinates.
// (See details below).
//
// Derivation of the equation of motion           sketch:
//  Pendulum coordinates:                          O- - - - - - -   |
//   x1 = l*cos(a1)                                \ a1             | g
//   y1 = l*sin(a1)                                 \              \|/
//   x2 = x1 + l*cos(a2)                             O - - - - -
//   y2 = y1 + l*sin(a2)                            / a2
//                                                 /
//  Designation of angles                         O
//   a1 = Winkel1 = u[0]
//   a2 = Winkel2 = u[1]
//   w1 = Winkelgeschw. = u'[0] = u[2]
//   w2 = Winkelgeschw. = u'[1] = u[3]
//
// Langrange state function
//  L := EKin - EPot
//  mit:
//   EKin = 1/2*m*v1^2 + 1/2*m*v2^2 = 1/2m*(x1°^2+y1°^2)+1/2m*(x2°^2+y2°^2)
//   EPot = -m*g*y1 - m*g*(y1+y2)
//  and:
//   x1° = -l*w1*sin(a1)
//   y1° =  l*w1*cos(a1)
//   x2° = -l*w1*sin(a1) - l*w2*sin(a2)
//   y2° =  l*w1*cos(a1) + l*w2*cos(a2)
//
// Equations of motion therefore:
//  (dL/da1)°=dL/dw1
//  (dL/da2)°=dL/dw2
//
// Solving for angular accelerations w1° and w2° yields the formula below.
// (see function f) 

unit Unit1;

interface

uses
  Forms, Controls, Classes,  SysUtils, Graphics,ExtCtrls, StdCtrls, ComCtrls,
  XPMan;

const
  RungeKutta = True; // true=RKM4 false=RKM1
  Dim = 4;           // dimension of the problem = 4

type
  TData = array[0..Dim-1] of Extended;

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Button3: TButton;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Image1: TImage;
    StatusBar2: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    t, x1, y1, x2, y2: Extended;
    u: TData;
    procedure Reset;
    procedure Start;
    procedure Stop;
    procedure Draw;
    procedure CalcTimeStep;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Math;

{$R *.dfm}

// calculation //

const
 u0 : TData = (-pi/4,-pi/2,0,0); // Initial condition (angle & angular velocity)

 fps = 60;      
 N = 256;      // Intermediate steps per frame (accuracy)
 dt = 1/fps/N;
 g = 9.81;     // Gravitation
 l = 1.0;      // length in m
 Scale = 70.0; // Pixel pro m

function f(u: TData; t: Extended): TData;
var
 c, s, a, b: Extended;
begin
 c := cos(u[0]-u[1]);
 s := sin(u[0]-u[1]);
 a := sqr(u[3])*s-2*g/l*cos(u[0]);
 b := -sqr(u[2])*s-g/l*cos(u[1]);

 Result[0] := u[2];
 Result[1] := u[3];
 Result[2] := (a-c*b)/(sqr(c)-2);
 Result[3] := (2*b-c*a)/(sqr(c)-2);
end;

function Mult(factor: Extended; u: TData): TData;
var
 I: Integer;
begin
  for I := 0 to length(u)-1 do
   Result[I] := factor*u[I];
end;

function Add(u, v: TData): TData;
var
 I: Integer;
begin
 for I := 0 to length(u)-1 do
  Result[I] := u[I]+v[I];
end;

function RKM1(u: TData; t: Extended; dt: Extended): TData; // Euler
var
 du: TData;
begin
  du := Mult(dt, f(u, t));
  Result := Add(u, du);
end;

function RKM4(u: TData; t: Extended; dt: Extended): TData; // Runge Kutta 4
var
 v, du: TData;
begin
  du := f(u, t);
  Result := du;
  v := Add(u, Mult(dt/2, du));
  du := f(v, t+dt/2);
  Result := Add(Result, Mult(2, du));
  v := Add(u, Mult(dt/2, du));
  du := f(v, t+dt/2);
  Result := Add(Result, Mult(2, du));
  v := Add(u, Mult(dt, du));
  du := f(v, t+dt);
  Result := Add(Result, du);
  Result := Add(u, Mult(dt/6 ,Result));
end;

procedure TForm1.CalcTimeStep;
var
 I: Integer;
begin
  for I := 1 to N do
  begin
   t := t + dt;
   if RungeKutta then
    u := RKM4(u, t, dt) else
    u := RKM1(u, t, dt);
  end;
end;

// Control & GUI //

procedure TForm1.Draw;
 procedure PointLine(Canvas: TCanvas; x, y: Integer);
 begin
   with Canvas do
   begin
    Brush.Color := clRed;
    LineTo(x,y);
    Rectangle(x-2,y-2,x+3,y+3);
   end;
 end;
var
 x0, y0: Integer;
begin
  with Image1, Image1.Canvas do
  begin
   x0 := Width div 2;
   y0 := Height div 2;
   x1 := l*cos(u[0]);
   y1 := l*sin(u[0]);
   x2 := x1+l*cos(u[1]);
   y2 := y1+l*sin(u[1]);
   Brush.Color := clWhite;
   FillRect(ClipRect);
   MoveTo(x0,y0);
   PointLine(Canvas, x0, y0);
   PointLine(Canvas, Round(x0+x1*Scale), Round(y0+y1*Scale));
   PointLine(Canvas, Round(x0+x2*Scale), Round(y0+y2*Scale));
   Brush.Color := clWhite;
   TextOut(2,2,Format('t = %.1f s',[t]));
   // Number of revolutions:
   with StatusBar2 do
   begin
    Panels[0].Text := Format('U. Pendulum 1: %d',[Floor(u[0]/pi/2+1/4)]);
    Panels[1].Text := Format('U. Pendulum 2: %d',[Floor(u[1]/pi/2+1/4)]);
   end;
  end;
end;

procedure TForm1.Reset;
var
 I: Integer;
begin
  t := 0;
  for I := 0 to Length(u0)-1 do
   u[I] := u0[I];
  Draw;
end;

procedure TForm1.Start;
begin
  Timer1.Interval := Round(dt*N*1000);
  Timer1.Enabled := True;
end;

procedure TForm1.Stop;
begin
  Timer1.Enabled := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ControlStyle := ControlStyle + [csOpaque];
  Reset;
  with StatusBar1 do
  begin
   Panels[0].Text := Format('1 m = %.0f Pixel',[Scale]);
   Panels[1].Text := Format('L = %.0f m',[l]);
   Panels[2].Text := Format('g = %.2f m/s²',[g]);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Start;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Stop;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Reset;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  CalcTimeStep;
  Draw;
end;

end.
