unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, XPMan, ComCtrls;

Const
 MaxSpeed = 100;
 G=4;

type
  PMass=^TMass;
  TMass=record
   mx,my:integer;
   fix:boolean;
   fx,fy:single;
  end;

  PLink=^TLink;
  TLink=record
   a,b:PMass;
   muscle:integer;
   Delta :integer;
   len:single;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    mAction: TComboBox;
    mMove: TComboBox;
    mGravity: TComboBox;
    mMass: TComboBox;
    Button3: TButton;
    Timer: TTimer;
    Image1: TImage;
    Panel2: TPanel;
    SpeedImage: TImage;
    MoveImage: TImage;
    PosImage: TImage;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDlg: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button3Click(Sender: TObject);
    procedure SpeedImageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SpeedImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure mActionChange(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mGravityChange(Sender: TObject);
    procedure PosImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MoveImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Declarations privates }
    Speed:integer;
    fMass:TList;
    fLink:TList;
    fActiveMass:PMass;
    fSourceMass:PMass;
    fActiveLink:PLink;
    fSourceLink:PLink;
    fStatus:(sNone,sLinkTo);
    MouseX,MouseY:integer;
    StartX,StartY:integer;
    MouseB:boolean;
    WasFix:boolean;
    Gravity:integer;
    MaxX,MaxY:integer;
    Cycle:byte;
    procedure PaintSpeed;
    procedure PaintMove;
    procedure PaintPos;
    procedure PaintSoda;
    function  GetMass(Index:integer):PMass;
    function  GetLink(Index:integer):PLink;
    function AddMass(x,y:integer; fixed :boolean):PMass;
    function AddLink(ma,mb:PMass; lmuscle:integer):integer;
    procedure DelMass(m:PMass);
    procedure DelLink(l:PLink);
    function MouseMass:PMass;
    function MouseLink:PLink;
    function CheckPoint:boolean;
    function LinkLen(i:integer):single;
  public
    { Declarations public }
    property Mass[Index:integer]:PMass read GetMass;
    property Link[Index:integer]:PLink read GetLink;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
procedure TForm1.FormCreate(Sender: TObject);
begin
 fMass:=TList.Create;
 fLink:=TList.Create;
 fActiveMass:=nil;
 fSourceMass:=nil;
 fActiveLink:=nil;
 fSourceLink:=nil;
 MouseB:=False;
 mAction.ItemIndex:=0;
 mMove.ItemIndex:=3;
 mGravity.ItemIndex:=0;
 mMass.ItemIndex:=0;
 Speed:=MaxSpeed div 2;
 Timer.Interval:=MaxSpeed-Speed+1;
 Gravity:=+G;
 Cycle:=0;
 PaintSpeed;
 PaintMove;
 PaintPos;
 PaintSoda;
end;

procedure TForm1.PaintSpeed;
 var
  x,y:integer;
 begin
  with SpeedImage,Canvas do begin
   Brush.Color:=clWhite;
   Pen.Color:=clRed;
   Rectangle(0,0,Width,Height);
   x:=Width div 2;
   y:=Height*Speed div MaxSpeed;
   MoveTo(x,0);
   LineTo(x,y);
   Moveto(0,y);
   LineTo(Width,y);
  end;
 end;

procedure TForm1.PaintMove;
 const
  k=5;
 var
  x,y:integer;
  w,h:integer;
  i:integer;
 begin
  with MoveImage,Canvas do begin
   Brush.Color:=clWhite;
   Pen.Color:=clNavy;
   Rectangle(0,0,Width,Height);
   w:=Width div 2;
   MoveTo(w,0);
   LineTo(w,Height);
   MoveTo(w,0);
   for y:=0 to Height div k do begin
    x:=w+Trunc(w*sin(((Cycle+4*k*y) and 255)*PI/128));
    LineTo(x,k*y);
   end;
   for i:=0 to fLink.Count-1 do with Link[i]^ do if Muscle>0 then begin
    MoveTo(0,Height-Muscle);
    Lineto(Width,Height-Muscle);
    Ellipse(w+Delta-2,Height-Muscle-2,w+Delta+2,Height-Muscle+2);
   end;
   if fSourceLink<>nil then with fSourceLink^ do begin
    Pen.Color:=clRed;
    MoveTo(0,Height-Muscle);
    Lineto(Width,Height-Muscle);
   end;
  end;
 end;

Procedure TForm1.PaintPos;
 var
  w,y,h:integer;
 begin
  with PosImage,Canvas do begin
   Brush.Color:=clWhite;
   Pen.Color:=clTeal;
   Rectangle(0,0,Width,Height);
   w:=Width;
   y:=0;   h:=  Height div 4; Rectangle(0,y,w,h);
   y:=h-1; h:=  Height div 2; Rectangle(0,y,w,h);
   y:=h-1; h:=3*Height div 4; Rectangle(0,y,w,h);
   y:=h-1; h:=  Height;       Rectangle(0,y,w,h);
  end;
 end;

procedure TForm1.PaintSoda;
 var
  i:integer;
 begin
  with Image1,Canvas do begin

   Brush.Color:=clWhite;
   Pen.Color:=clBlack;
   Rectangle(0,0,Width,Height);

   if mAction.ItemIndex=2 then begin
    for i:=0 to fLink.Count-1 do with Link[i]^ do begin
     with a^ do MoveTo(mx,my);
     with b^ do LineTo(mx,my);
    end;
   end else
    for i:=0 to fLink.Count-1 do with Link[i]^ do begin
     if Muscle<>0 then Pen.Color:=clRed else Pen.Color:=clBlack;
     with a^ do MoveTo(mx,my);
     with b^ do LineTo(mx,my);
    end;

   if fActiveLink<>nil then begin
    with fActiveLink^ do begin
     Pen.Color:=clGreen;
     Pen.Width:=3;
     with a^ do MoveTo(mx,my);
     with b^ do LineTo(mx,my);
     Pen.Width:=1;
    end;
   end;

   if fSourceLink<>nil then begin
    with fSourceLink^ do begin
     Pen.Color:=clRed;
     Pen.Width:=3;
     with a^ do MoveTo(mx,my);
     with b^ do LineTo(mx,my);
     Pen.Width:=1;
    end;
   end;

   Pen.Color:=clBlack;
   if mAction.ItemIndex<2 then begin
    for i:=0 to fMass.Count-1 do with Mass[i]^ do begin
     if fix then Brush.Color:=clSilver else Brush.Color:=clBlue;
     Ellipse(mx-4,my-4,mx+4,my+4);
    end;
   end else begin
    Brush.Color:=clBlack;
    for i:=0 to fMass.Count-1 do
    with Mass[i]^ do
      Ellipse(mx-4,my-4,mx+4,my+4);
   end;

   if fSourceMass<>nil then begin
    MoveTo(MouseX,MouseY);
    with fSourceMass^ do LineTo(mx,my);
   end;

   if fActiveMass<>nil then begin
    Brush.Color:=clGreen;
    with fActiveMass^ do Ellipse(mx-6,my-6,mx+6,my+6);
   end;

   if fSourceMass<>nil then begin
    Brush.Color:=clRed;
    with fSourceMass^ do Ellipse(mx-6,my-6,mx+6,my+6);
   end;

  end;
 end;

function TForm1.GetMass(Index:integer):PMass;
 begin
  Result:=fMass[Index];
 end;

function TForm1.GetLink(Index:integer):PLink;
 begin
  Result:=fLink[Index];
 end;

function TForm1.AddMass(x,y:integer; fixed:boolean):PMass;
 begin
  New(Result);
  with Result^ do begin
   mx:=x;
   my:=y;
   fx:=0;
   fy:=0;
   fix:=fixed;
  end;
  fMass.Add(Result);
 end;

Function TForm1.AddLink(ma,mb:PMass; lmuscle:integer):integer;
 var
  i:integer;
  l:^TLink;
 begin
  for i:=0 to fLink.Count-1 do
   with Link[i]^ do
    if ((a=ma)and(b=mb))or((a=mb)and(b=ma)) then begin
     //muscle:=lmuscle;
     result:=i;
     exit;
    end;
  new(l);
  l.a:=ma;
  l.b:=mb;
  l.muscle:=lmuscle;
  Result:=fLink.Add(l);
 end;

procedure TForm1.DelMass(m:PMass);
 var
  i:integer;
 begin
  for i:=fLink.Count-1 downto 0 do
   with Link[i]^ do begin
    if (a=m)or(b=m) then DelLink(Link[i])
   end;
  fActiveMass:=nil;
  Dispose(m);
  fMass.Remove(m);
  PaintSoda;
 end;

procedure TForm1.DelLink(l:PLink);
 begin
  fActiveLink:=nil;
  Dispose(l);
  fLink.Remove(l);
  PaintSoda;
 end;

function TForm1.MouseMass:PMass;
 var
  i:integer;
 begin
  for i:=0 to fMass.Count-1 do
   with Mass[i]^ do
    if (abs(mx-MouseX)<=4)and(abs(my-MouseY)<=4) then begin
     Result:=Mass[i];
     exit;
    end;
  Result:=nil;
 end;

function TForm1.MouseLink:PLink;
 var
  i:integer;
  x,y:integer;
  dx,dy:integer;
  f:single;
  t:integer;
 begin
  for i:=0 to fLink.Count-1 do
   with Link[i]^ do begin
    x:=a.mx; dx:=b.mx-x;
    y:=a.my; dy:=b.my-y;
    t:=5;
    if abs(dx)>abs(dy) then begin
     if ((MouseX>x)and(MouseX<x+dx))or((MouseX<x)and(MouseX>x+dx)) then
     begin
      f:=MouseY-(y+(dy*(MouseX-x))/dx);
      t:=abs(Trunc(f));
     end;
    end else begin
     if ((MouseY>y)and(MouseY<y+dy))or((MouseY<y)and(MouseY>y+dy)) then
     begin
      if dy=0 then
       t:=abs(MouseX-X)
      else begin
       f:=MouseX-(x+(dx*(MouseY-y))/dy);
       t:=abs(Trunc(f));
      end;
     end;
    end;
    if t<4 then begin
     Result:=Link[i];
     exit;
    end;
   end;
  Result:=nil;
 end;

function TForm1.CheckPoint:boolean;
 var
  m:PMass;
  l:PLink;
 begin
 // Active Mass
  m:=MouseMass;
  Result:=(m<>fActiveMass);
  if Result then fActiveMass:=m;
 // Active Link
  if mAction.ItemIndex<2 then begin
   if fActiveMass<>nil then l:=nil else l:=MouseLink;
   if l<>fActiveLink then begin
    Result:=True;
    fActiveLink:=l;
    PaintMove;
   end;
  end; 
 end;

function TForm1.LinkLen(i:integer):single;
 var
  dx,dy:single;
 begin
  with Link[i]^ do begin
   with a^ do begin dx:=mx; dy:=my end;
   with b^ do begin dx:=dx-mx; dy:=dy-my end;
   Result:=sqrt(dx*dx+dy*dy);
  end;
 end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 Button3.Click;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 i:integer;
begin
 fActiveMass:=nil;
 fSourceMass:=nil;
 fActiveLink:=nil;
 fSourceLink:=nil;
 MouseB:=False;
 for i:=fLink.Count-1 downto 0 do Dispose(Link[i]); fLink.Clear;
 for i:=fMass.Count-1 downto 0 do Dispose(Mass[i]); fMass.Clear;
 mAction.ItemIndex:=0; mActionChange(Self);
 PaintSoda;
end;

procedure TForm1.SpeedImageMouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
 TControl(Sender).Tag:=1;
end;

procedure TForm1.SpeedImageMouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
 TControl(Sender).Tag:=0;
end;

procedure TForm1.SpeedImageMouseMove(Sender: TObject; Shift: TShiftState;
          X, Y: Integer);
begin
 if SpeedImage.Tag=1 then begin
  Speed:=Y*MaxSpeed div SpeedImage.Height;
  PaintSpeed;
  Timer.Interval:=MaxSpeed-Speed+1;
 end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
 fStatus:=sNone;
 fSourceLink:=nil;
 case mAction.ItemIndex of
 // construct
  0 : if (ssRight in Shift) then begin // Right click
        if fSourceMass<>nil then begin // Cancel linking
         fSourceMass:=nil;
         PaintSoda;
        end;
      end else begin // Left click
       if fActiveMass=nil then begin // New Mass
        if fActiveLink=nil then begin
         fActiveMass:=AddMass(X,Y,mMass.ItemIndex=1);
         if fSourceMass<>nil then AddLink(fSourceMass,fActiveMass,0);
         fSourceMass:=nil;//fActiveMass;
         MouseB:=True;
        end else begin
         fSourceLink:=fActiveLink;
         StartX:=MouseX;
         StartY:=MouseY;
         MouseB:=True;
        end;
       end else begin // Link 2 Mass
        if fSourceMass<>nil then AddLink(fSourceMass,fActiveMass,0);
        fSourceMass:=nil;//fActiveMass;
        MouseB:=True;
       end;
       PaintSoda;
      end;
 // Delete
  1 : if fActiveMass<>nil then DelMass(fActiveMass) else
      if fActiveLink<>nil then DelLink(fActiveLink);
 // Simulate
  2 : begin
       if (fActiveMass<>nil) then with fActiveMass^ do begin
        MouseB:=True;
        WasFix:=Fix;
        Fix:=True;
       end;
      end;
 end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState;
          X, Y: Integer);
begin
 MouseX:=x;
 MouseY:=y;
 if MouseB then begin
  if fActiveMass=nil then begin
   with fActiveLink^ do begin
    with a^ do begin
     inc(mx,MouseX-StartX);
     inc(my,MouseY-StartY);
    end;
    with b^ do begin
     inc(mx,MouseX-StartX);
     inc(my,MouseY-StartY);
    end;
    StartX:=MouseX;
    StartY:=MouseY;
   end;
  end else
   with fActiveMass^ do begin
    mx:=MouseX;
    my:=MouseY;
   end;
  if mAction.ItemIndex=2 then
   Application.ProcessMessages
  else
   PaintSoda;
 end else begin
  if CheckPoint or (fSourceMass<>nil) then PaintSoda;
 end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if mAction.ItemIndex=0 then fSourceMass:=fActiveMass;
 if MouseB then begin
  if (mAction.ItemIndex=2)and(fActiveMass<>nil) then
    fActiveMass^.Fix:=WasFix else PaintMove;
  MouseB:=False;
 end;
end;

procedure TForm1.mActionChange(Sender: TObject);
var
 i:integer;
 dx,dy:single;
begin
 fActiveMass:=nil;
 fSourceMass:=nil;
 fActiveLink:=nil;
 fSourceLink:=nil;
 MouseB:=False;
 PaintSoda;
 if mAction.ItemIndex<>2 then
  Timer.Enabled:=False
 else begin
  for i:=0 to fLink.Count-1 do Link[i]^.Len:=LinkLen(i);
  Timer.Enabled:=True;
 end;
end;

procedure TForm1.TimerTimer(Sender: TObject);
const
  k=5;
var
  i:integer;
  ma,mb:PMass;
  dx,dy:single;
  l:single;
  dl:single;
  tx,ty:integer;
begin
 Inc(Cycle,Speed div 5+1);
 PaintMove;

 for i:=0 to fLink.Count-1 do begin
  with Link[i]^ do begin
   mb:=b;
   if not mb.fix then
    ma:=a
   else begin
    mb:=a;
    ma:=b;
   end;
   if not mb.fix then begin
    dx:=mb.mx-ma.mx;
    dy:=mb.my-ma.my;
    l:=LinkLen(i); // compute actual length

    dl:=len-l;
    if Muscle>0 then dl:=dl+Delta*sin(((Cycle+Muscle) and 255)*PI/128);

    if l=0 then l:=1;
    dx:=dx/l;
    dy:=dy/l;

    if (Gravity<>0)and(ma.fix) then begin
     mb.fx:=mb.fx-dx*Gravity;
     mb.fy:=mb.fy-dy*Gravity;
    end;

    if dl<>0 then begin
     dx:=dx*dl;
     dy:=dy*dl;
     mb.fx:=mb.fx+dx;
     mb.fy:=mb.fy+dy;
     if ma.fix then begin
      mb.fx:=mb.fx+dx;
      mb.fy:=mb.fy+dy;
     end else begin
      ma.fx:=ma.fx-dx;
      ma.fy:=ma.fy-dy;
     end;
    end;
   end;

  end;
 end;

 for i:=0 to fMass.Count-1 do begin
  with Mass[i]^ do begin
   if not fix then fy:=fy+Gravity;
   tx:=Trunc(fx/k); inc(mx,tx); fx:=fx-tx;
   ty:=Trunc(fy/k); inc(my,ty); fy:=fy-ty;
   if mx<0 then mx:=-mx div 2;
   if my<0 then my:=-my div 2;
   if mx>MaxX then mx:=MaxX-(mx-MaxX) div 2;
   if my>MaxY then my:=MaxY-(my-MaxY) div 2;
  end;
 end;

 if MouseB and (fActiveMass<>nil) then with fActiveMass^ do begin
  mx:=MouseX;
  my:=MouseY;
 end;

 PaintSoda;
end;

procedure TForm1.mGravityChange(Sender: TObject);
begin
 case mGravity.ItemIndex of
  0: Gravity:=+G;
  1: Gravity:=0;
  2: Gravity:=-G;
 end;
end;

procedure TForm1.PosImageMouseMove(Sender: TObject; Shift: TShiftState;
          X, Y: Integer);
begin
 if PosImage.Tag=1 then begin
  Cycle:=255-((255*Y) div PosImage.Height);
  if mAction.ItemIndex<>2 then PaintMove;
  Application.ProcessMessages;
 end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 MaxX:=Image1.Width;
 MaxY:=Image1.Height;
 Image1.Picture.Graphic:=nil;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 Button3.Click;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 src:TextFile;
 s:string;
 m,l:integer;
 a,b,c:integer;
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Data';
  if OpenDialog1.Execute then begin
  AssignFile(src,OpenDialog1.FileName);
  Reset(src);
  ReadLn(src,s);
  if s<>'Script v1' then
   ShowMessage('Not valid a Script')
  else begin
   Button3.Click;
   ReadLn(src,m,l);
   while m>0 do begin
    dec(m);
    ReadLn(src,a,b,c);
    AddMass(a,b,(c=1));
   end;
   while l>0 do begin
    dec(l);
    ReadLn(src,a,b,c);
    AddLink(Mass[a],Mass[b],c);
   end;
  end;
  PaintSoda;
  CloseFile(src);
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 txt:TextFile;
 i:integer;
begin
 if SaveDlg.Execute then begin
  AssignFile(txt,SaveDlg.FileName);
  Rewrite(txt);
  WriteLn(txt,'Script v1');
  WriteLn(txt,fMass.Count:5,fLink.Count:5,' Mass & Link count');
  for i:=0 to fMass.Count-1 do begin
   with Mass[i]^ do WriteLn(txt,mx:5,my:5,byte(fix):5,' Mass[',i,']');
  end;
  for i:=0 to fLink.Count-1 do begin
   with Link[i]^ do
   WriteLn(txt,fMass.IndexOf(a):5,fMass.IndexOf(b):5,muscle:5,' Link[',i,']');
  end;
  CloseFile(txt);
 end;
end;

procedure TForm1.MoveImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if (MoveImage.Tag=1)and(fSourceLink<>nil)and(Y>0)and(Y<MoveImage.Height) then
 begin
  fSourceLink.Muscle:=MoveImage.Height-Y;
  fSourceLink.Delta :=X-MoveImage.Width div 2;
  PaintMove;
  PaintSoda;
 end;
end;

end.
