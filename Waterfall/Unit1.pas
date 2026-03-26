unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, XPMan, ComCtrls, Spin;

type
  TForm1 = class(TForm)
    Fond: TPaintBox;
    Panel1: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Label1: TLabel;
    Button3: TButton;
    StatusBar1: TStatusBar;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    SpinEdit2: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FondMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button4Click(Sender: TObject);
    procedure FondMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FondMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    abort : boolean;
    procedure water;
    procedure Init;
  public
    { Public declarations }
  end;

type
 Tgto = record  // Drip type
  x: integer;
  Y: integer;
  Col: integer;
 end;

var
  Form1: TForm1;
  gto: array of Tgto;      // Drop chart
  gtoOLD: array of Tgto;   // Drop chart
  walk: boolean;
  Bouton: byte;
  nmbr: integer;

implementation

{$R *.DFM}

//------------Initializing arrays--------------
procedure TForm1.Init;
begin
 nmbr:=strtoint(edit1.text);
 setlength(gto,nmbr);
 setlength(gtoold,nmbr);
end;

//---------------------Engine-------------------
procedure TForm1.water;
var
 u: integer;
 a: integer;
begin
 repeat // infinite loop
 for a:=0 to pred(nmbr) do // For every drop
  begin
   if fond.Canvas.Pixels[Gto[a].x, Gto[a].y + 1]= clwhite
   then // If there's a white pixel under the droplet
     Gto[a].y := Gto[a].y + 1 //That makes her go down, that's all.
   else // Sinon
    begin
     u := round(Random(2)); // We choose which side she will leave from.
     case u of
      0:u := -1;
      1:u := 1;
     end;
     if fond.Canvas.Pixels[Gto[a].x + u, Gto[a].y] = clwhite
     then // If there's nothing on the side she's going towards, then it's fine.
       Gto[a].x := Gto[a].x + u // That shifts it to the chosen side.
     else // Otherwise, if there's nothing on the other side, it shifts it to the other side.
       if fond.Canvas.pixels[Gto[a].x + (-u), Gto[a].y] = clwhite
       then Gto[a].x := Gto[a].x + (-u); // Otherwise, well, she doesn't move.
     end;
     fond.canvas.pixels[GtoOLD[a].x, GtoOLD[a].y]:= clwhite;// erase the old drop
     fond.canvas.pixels[Gto[a].x, Gto[a].y]:= gto[a].Col;   // Trace the news
     GtoOLD[a]:=gto[a]; // saves positions
    end;
  Application.ProcessMessages;    // In order to retrieve system events
  if abort = true then Exit;
 until walk=false; // Create an infinite loop until `march` equals false.
  Showmessage('Finish');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 fond.Canvas.Brush.Style:= bssolid;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a : integer;
begin
  abort := false;
  init; // initialize
  for a:=0 to pred(nmbr) do // place the drops
  begin
   Gto[a].x:= fond.width div 2;
   Gto[a].y:= 1;
   gto[a].col := clnavy;
  end;
  walk:=true; // launch the machine
  water;
end;

procedure TForm1.FondMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 // DRAW A WHITE OR RED CIRCLE FOLLOWING THE MOUSE BUTTON PRESS
 if button=mbleft
 then
  begin
   fond.Canvas.Brush.Color:=clmaroon;
   fond.Canvas.Pen.Color:=clmaroon;
   bouton:=1;
  end;
 if button=mbright
 then
  begin
   fond.Canvas.Brush.Color:=clwhite;
   fond.Canvas.Pen.Color:=clwhite;
   bouton:=2;
  end;

 fond.Canvas.Ellipse(x-SpinEdit1.Value,y-SpinEdit1.Value,x+SpinEdit1.Value,
                     y+SpinEdit2.Value);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  walk:=false;
  Application.Terminate;
end;

procedure TForm1.FondMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 bouton:=0;
end;

procedure TForm1.FondMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 // Draw the circles
 if bouton=0
 then Exit;
 if bouton=1
 then
  begin
   fond.Canvas.Brush.Color:=clmaroon;
   fond.Canvas.Pen.Color:=clmaroon;
  end;
 if bouton=2
 then
  begin
   fond.Canvas.Brush.Color:=clwhite;
   fond.Canvas.Pen.Color:=clwhite;
  end;

 fond.Canvas.Ellipse(x-SpinEdit1.Value,y-SpinEdit1.Value,x+SpinEdit1.Value,
                     y+SpinEdit2.Value);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 // Clear
 fond.Canvas.Brush.Color:=clwhite;
 fond.Canvas.Pen.Color:=clwhite;
 fond.Canvas.Rectangle(0,0,fond.Width,fond.Height);
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
 Button2Click(Sender);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 walk:=false;
 Application.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  abort := true;
end;

end.
