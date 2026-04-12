unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, OpenGL12,
  StdCtrls, Buttons, ExtCtrls, TGATexture, ComCtrls, ImgList, ToolWin,
  XPMan, Math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    tbPlay: TToolButton;
    tbPause: TToolButton;
    tbCursor: TToolButton;
    tbVert: TToolButton;
    ToolButton5: TToolButton;
    tbLink: TToolButton;
    tbDel: TToolButton;
    CheckBox1: TCheckBox;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tbPlayClick(Sender: TObject);
    procedure tbPauseClick(Sender: TObject);
    procedure tbVertClick(Sender: TObject);
    procedure tbLinkClick(Sender: TObject);
    procedure tbCursorClick(Sender: TObject);
    procedure tbDelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    rc : HGLRC;    // Rendering Context
    dc  : HDC;     // Device Context
    ElapsedTime, AppStart: DWord;  // Timing variables
    procedure glDraw;
    procedure Idle(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
  end;

  Vertex = array[0..2] of double;
  PVertlet = ^Vertlet;

  Link = class
          V1,V2: Integer;
          Normal: vertex;
          Len, CurLen: Single;
          Procedure Calc;
          Constructor Create(Va, Vb: Integer);
         end;

  Vertlet = class
             P,F,A: Vertex;
             ForceCount: integer;
             Ind: integer;
             Mass: single;
             Fixed: boolean;
             constructor Create(Index: integer);
             Procedure Tick(UpdateS: boolean);
            End;

var
  Form1: TForm1;
  T: double;
  Xx,Yy, Lx, Ly, ToolID, Sel1,Sel2: integer;
  MouseD: boolean;
  SelInd: integer;
  LastTime, Tim: int64;
  PreviousT: array[0..10] of double; //Time keeping - not used
  UpdateStep, Playing: boolean;
  BallTex: gluint;
  V: array of Vertlet;
  L: array of Link;

implementation

{$R *.DFM}

constructor Vertlet.Create(Index: integer);
begin
  Ind := Index;
end;

Function DotProduct(const A,B: vertex):double;
begin
  result := A[0]*B[0] + A[1]*B[1]+ A[2]*B[2];
end;

Function Subtract(const A,B: vertex): vertex;
begin
   result[0] := A[0]-B[0];
   result[1] := A[1]-B[1];
   result[2] := A[2]-B[2];
end;

Function PlaneIntersect(const PlanePos, PlaneNorm, RayStart, RayDirection: Vertex; var Lamda: double): Boolean;
Var
  Dot, L2:double ;
begin
    Dot := Dotproduct(RayDirection, PlaneNorm);
    //if Dot <= 0 then
    //begin
    //  Result := False;
    //  Exit;
    //end;

    L2 := (DotProduct(PlaneNorm, Subtract(PlanePos, RayStart)))/Dot;

    if L2 < 0 then
    begin
      Result := False;
      Exit;
    end;

    Lamda := L2;
    Result := True;
end;

Function Dist(V1,V2: vertex): double;
Var
  A,B,C: single;
begin
  A := V1[0]-V2[0];
  B := V1[1]-V2[1];
  // C := V1[2]-V2[2];
  REsult := sqrt(A*A+B*B);
end;


Function Normalise(V: vertex; Dist: single): vertex;
Var
  L: single;
begin
  L := Dist;  // Sqrt(abs(V[0]*V[0]) + abs(V[1]*V[1])+ abs(V[2]*V[2]));
  if L > 0 then
  begin
   Result[0] := V[0] / L;
   Result[1] := V[1] / L;
   // Result[2] := V[2] / L;
  end;
end;

PRocedure Normalize(var V: vertex);
Var
  L: single;
begin
  L := Sqrt(abs(V[0]*V[0]) + abs(V[1]*V[1])+ abs(V[2]*V[2]));
  if L > 0 then
  begin
   V[0] := V[0] / L;
   V[1] := V[1] / L;
   V[2] := V[2] / L;
  end;
end;

Constructor Link.Create(Va,Vb: Integer);
begin
 V1 := Va;
 V2 := Vb;
 Len := Dist(V[Va].P, V[Vb].P);
end;


Procedure Link.Calc;
Var
  Delta, Le: Double;
  Force: Vertex;
  TF: single;

Const
  K = 0.40;
  FORCELIMIT = 0.7;

begin
with Form1 do
begin
 if V1 = -1 then exit;
 Force[0] := (V[V2].P[0]-V[V1].P[0]);
 Force[1] := (V[V2].P[1]-V[V1].P[1]);

 CurLen := Dist(V[V1].P, V[V2].P);
 Delta := (CurLen-Len);

 Force := Normalise(Force, CurLen);

 Normal[1] :=  Force[0];
 Normal[0] := -Force[1];

 TF:=Delta*(-K)*0.19;

 if abs(TF) < 0.00005 then
 begin
   exit;
 end;
  {
  begin
     if (TF>0) THEN TF:=FORCELIMIT
      else TF:=-FORCELIMIT;
  end;
  }

 Force[0] := Force[0]*TF;
 Force[1] := Force[1]*TF;

 V[V1].A[0] := (V[V1].A[0] - Force[0]);
 V[V1].A[1] := (V[V1].A[1] - Force[1]);
 inc(V[V1].ForceCount);

 V[V2].A[0] := (V[V2].A[0] + Force[0]);
 V[V2].A[1] := (V[V2].A[1] + Force[1]);
 inc(V[V2].ForceCount);

  if Checkbox2.Checked and (abs(TF) > FORCELIMIT) then
  begin
   V1 := -1;
   TF := 0;
   exit;
  end;

end;
end;

Procedure Vertlet.Tick(UpdateS: boolean);
Var
  Dir, Nor, P1, P2, CurP: vertex;
  Mag, Lamb, DP: double;
  I,J: integer;
begin
if UpdateS then
begin
  if not Fixed Then
  begin
   if ForceCount > 0 then
   begin
     A[0] := A[0]/(ForceCount);
     A[1] := A[1]/(ForceCount);

     ForceCount := 0;
   end;

   A[1] := A[1] - 0.00078*sqrt(T);

   {  Collision Detection. Not Working Right.
   Dir[0] := F[0];
   Dir[1] := F[1];
   Dir[2] := 0;
   Mag := sqrt(Dir[1]*Dir[1]+Dir[2]*Dir[2]);
   if Mag > 0.0001 then
   begin
    CurP[0] := P[0]+Dir[0];
    CurP[1] := P[1]+Dir[1];
    CurP[2] := 0;

    Dir[1] := Dir[1]/Mag;
    Dir[2] := Dir[2]/Mag;

    for I := 0 to high(L) do
    if L[I].V1 > -1 then
    if (L[I].V1 <> ind) and (L[I].V2 <> ind) then
    begin
      P1 := V[L[I].V1].P;
      P2 := V[L[I].V2].P;

      if (Max(CurP[0], P[0]) >= Min(P1[0]-2, P2[0]-2)) and (Min(CurP[0], P[0]) <= Max(P1[0]+2, P2[0]+2)) then
      if (Max(CurP[1], P[1]) >= Min(P1[1]-2, P2[1]-2)) and (Min(CurP[1], P[1]) <= Max(P1[1]+2, P2[1]+2)) then
      begin
         Nor := L[I].Normal;

            if DotProduct(Nor, Dir) < 0 then
            begin
               Nor[0] := -Nor[0];
               Nor[1] := -Nor[1];
            end;


         //if abs(DotProduct(Nor, Dir)) > 0.1 then
         if PlaneIntersect(P1, Nor,P, Dir, Lamb) then
         if Lamb <= Mag then
         begin
            DP := DotProduct(Nor, Dir)*Lamb*0.5;
             F[0] := -Nor[0]*DP;
             F[1] := -Nor[1]*DP;

             V[L[I].V1].F[0] := V[L[I].V1].F[0]+Nor[0]*DP*0.2;
             V[L[I].V1].F[1] := V[L[I].V1].F[1]+Nor[1]*DP*0.2;
             V[L[I].V2].F[0] := V[L[I].V2].F[0]+Nor[0]*DP*0.2;
             V[L[I].V2].F[1] := V[L[I].V2].F[1]+Nor[1]*DP*0.2;

          end;
       end;
     end;
   end
   else
   begin
     F[0] := 0;
     F[1] := 0;
   end;
  }

   F[0] := F[0]*0.9999;
   F[1] := F[1]*0.9999;

   F[0] := F[0] + A[0]*T;
   F[1] := F[1] + A[1]*T;

   A[0] := 0;
   A[1] := 0;

   P[0] := P[0]+F[0];
   P[1] := P[1]+F[1];
  end
  else
  begin
   F[0] := 0;
   F[1] := 0;
   F[2] := 0;
  end;

  if P[0] < 0 then
  begin
   P[0] :=0;
   F[0] := -F[0]*0.7;
   F[1] := F[1]*0.99;
  end;

  if P[0] > Form1.Panel1.Width then
  begin
   P[0] := Form1.Panel1.Width;
   F[0] := -F[0]*0.7;
   F[1] := F[1]*0.99;
  end;

  if P[1] > form1.Panel1.Height then
  begin
   P[1] := Form1.Panel1.Height;
   F[1] := -F[1]*0.7;
   F[0] := F[0]*0.99;
  end;

  if P[1] < 0 then
  begin
   P[1] := 0;
   F[1] := -F[1]*0.7;
   F[0] := F[0]*0.99;
  end;
  end
  else
  begin
    //F[2] := F[2]*0.999;
  end;
end;

Procedure RenderScene;
Var
  I, J, C: integer;
  Si: single;
begin
  Si := form1.trackbar1.position;
   glDisable(GL_TEXTURE_2D);
   glDisable(GL_BLEND);

   glColor3f(0,0,0);
   glBegin(GL_LINES);
    for I := 0 to high(L) do
    if L[I].V1 > -1 then
    begin
      glVertex3dv(@V[L[I].V1].P);
      glVertex3dv(@V[L[I].V2].P);

      {
      glVertex3f((V[L[I].V1].P[0]+V[L[I].V2].P[0])*0.5,
                 (V[L[I].V1].P[1]+V[L[I].V2].P[1])*0.5,0);
      glColor3f(1,0,0);
      glVertex3f((V[L[I].V1].P[0]+V[L[I].V2].P[0])*0.5+L[I].Normal[0]*30,
                 (V[L[I].V1].P[1]+V[L[I].V2].P[1])*0.5+L[I].Normal[1]*30,0);
      glColor3f(0,0,0);
      }

    end;
    if (ToolId = 3) then
    begin
      glColor3f(0.7, 0.7, 0.7);
      glVertex3dv(@V[Sel1].P);
      glVertex2f(XX,YY);
    end;

   glEnd;
   glEnable(GL_TEXTURE_2D);
   glenable(GL_BLEND);
   glBindTexture(GL_TEXTURE_2D, Balltex);
   glColor3f(1,1,1);
   for I := 0 to high(V) do
   begin
   C := 0;
     for J := 0 to high(L) do
     if L[J].V1 > -1 then
     begin
       if L[J].V1 = I then inc(C);
       if L[J].V2 = I then inc(C);
       if C > 1 then break;
     end;
   if form1.checkbox1.checked then C := 1;
   if C < 2 then
   begin

    glPushMatrix;
    glTranslated(V[I].P[0], V[I].P[1], V[I].P[2]);

    if SelInd = I then
    glColor3f(1,0.6, 0)
    else
    glColor3f(1,1,1);
    glBegin(GL_TRIANGLE_STRIP);
       glTExCoord2f(0,0);glVertex2f(-Si, -Si);
       glTExCoord2f(1,0);glVertex2f( Si, -Si);
       glTExCoord2f(0,1);glVertex2f(-Si,  Si);
       glTExCoord2f(1,1);glVertex2f( Si,  Si);
    glEnd;
    glPopMatrix;
   end;
   end;
end;

Procedure DoPhysics;
Var
  I: integer;
begin
  UpdateStep := (UpdateStep = false);

 if UpdateStep then
 begin
  for I := 0 to High(V) do
   V[I].Tick(UpdateStep);
 end;

 if UpdateStep = false  then
 begin
  For I := 0 to high(L) do
   begin
     Application.ProcessMessages;
     L[I].Calc;
   end;
 end;
end;

procedure TForm1.glDraw();
Var
  I: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);    // Clear The Screen And The Depth Buffer
  glLoadIdentity();

  {LastTime := Tim;
  QueryPerformanceCounter(Tim);
  T := (Tim-LastTime)/2000;

  for I := high(PreviousT)-1 downto 0 do
  begin
    PreviousT[I+1] := PreviousT[I];
  end;
  PreviousT[0] := T;

  T := 0;
  for I := 0 to High(PreviousT) do
  begin
   T := T + PreviousT[I];
  end;
   T := T/(high(PreviousT)+1);
  if T > 5 then T := 5;

  caption := formatfloat('0.000',T);
  }

  //Still some problems with time independance..
  T := Trackbar1.Position/1000;

  if Playing then
  DoPhysics;

  if UpdateStep then
  begin
   if MouseD and (SelInd > -1) and (ToolId = -1) then
   begin
    V[SelInd].P[0] := V[SelInd].P[0]-(V[SelInd].P[0]-XX)*0.05*T;
    V[SelInd].P[1] := V[SelInd].P[1]-(V[SelInd].P[1]-YY)*0.05*T;
    V[SelInd].F[0] := 0;
    V[SelInd].F[1] := 0;
   end;
  end;
  RenderScene;

end;

Procedure CreateAGrid(Columns: integer);
Var
  I, J, K, Col: integer;
  Ang: single;
begin
  Col := Columns;
  Setlength(L, 0);
  Setlength(V, 25*(Col+1));
  For I := 0 to high(V) do
  begin
  V[I] := Vertlet.Create(I);
  V[I].Mass := 1;
  V[I].P[0] := 100+(I div 25)*30; //Form1.Panel1.Width/2+Sin(Ang)*120;
  V[I].P[1] := 100+(I mod 25)*10; //Form1.Panel1.Height/2+Cos(Ang)*120;
  V[I].P[2] := 0;
  V[I].F[0] := 0;
  V[I].F[1] := 0;
  V[I].F[2] := 0;
  end;

  For K := 0 to Col-1 do
  for I := 0+K*25 to 23+K*25 do
  begin
    J := high(L)+1;
    Setlength(L, high(L)+7);
    L[J]   := Link.Create(I, I+25);
    L[J+1] := Link.Create(I+1, I+25);
    L[J+2] := Link.Create(I,   (I+1)+25);
    L[J+3] := Link.Create(I+1, (I+1)+25);
    L[J+4] := Link.Create(I,    I+1);
    L[J+5] := Link.Create(I+25,(I+1)+25);
  end;
end;

{------------------------------------------------------------------}
{  Initialise OpenGL                                               }
{------------------------------------------------------------------}
procedure glInit();
Var
  I, J, K, Col: integer;
  Ang: single;
begin
  glClearColor(1.0, 1.0, 1.0, 0.0); 	   // Black Background
  glShadeModel(GL_SMOOTH);               // Enables Smooth Color Shading
  glClearDepth(1.0);                     // Depth Buffer Setup
  glDisable(GL_DEPTH_TEST);              // Enable Depth Buffer
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glDepthFunc(GL_LESS);		               // The Type Of Depth Test To Do
  glLineWidth(1);
  LoadTGA(ExtractFilePath(Application.ExeName) + 'Ball.tga',BallTex, False);
  CreateAGrid(2);
  glEnable(GL_TEXTURE_2D);
  glAlphaFunc(GL_GREATER, 0.01);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
end;


{------------------------------------------------------------------}
{  Create the form and initialist openGL                           }
{------------------------------------------------------------------}
procedure TForm1.FormCreate(Sender: TObject);
var pfd : TPIXELFORMATDESCRIPTOR;
    pf  : Integer;
begin
  InitOpenGL;
  ToolID := -1;
  // OpenGL initialisieren
  dc:=GetDC(Panel1.Handle);

  // PixelFormat
  pfd.nSize:=sizeof(pfd);
  pfd.nVersion:=1;
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
  pfd.iPixelType:=PFD_TYPE_RGBA;      // PFD_TYPE_RGBA or PFD_TYPEINDEX
  pfd.cColorBits:=32;

  pf :=ChoosePixelFormat(dc, @pfd);   // Returns format that most closely matches above pixel format
  SetPixelFormat(dc, pf, @pfd);

  rc :=wglCreateContext(dc);    // Rendering Context = window-glCreateContext
  wglMakeCurrent(dc,rc);        // Make the DC (Form1) the rendering Context

  // Initialist GL environment variables
  glInit;
  Panel1Resize(sender);    // sets up the perspective
  AppStart :=GetTickCount();

  // when the app has spare time, render the GL scene
  Application.OnIdle := Idle;
  Button1Click(self);
end;


{------------------------------------------------------------------}
{  Release rendering context when form gets detroyed               }
{------------------------------------------------------------------}
procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(rc);
  CloseOpenGL;
end;


{------------------------------------------------------------------}
{  Application onIdle event                                        }
{------------------------------------------------------------------}
procedure TForm1.Idle(Sender: TObject; var Done: Boolean);
begin
  Done := FALSE;

  LastTime :=ElapsedTime;
  ElapsedTime :=GetTickCount() - AppStart;      // Calculate Elapsed Time
  ElapsedTime :=(LastTime + ElapsedTime) DIV 2; // Average it out for smoother movement
  glDraw();                         // Draw the scene
  SwapBuffers(DC);                  // Display the scene
end;


{------------------------------------------------------------------}
{  If the panel resizes, reset the GL scene                        }
{------------------------------------------------------------------}
procedure TForm1.Panel1Resize(Sender: TObject);
begin
  glViewport(0, 0, Panel1.Width, Panel1.Height);    // Set the viewport for the OpenGL window
  glMatrixMode(GL_PROJECTION);        // Change Matrix Mode to Projection
  glLoadIdentity();                   // Reset View
  //gluPerspective(70.0, Panel1.Width/Panel1.Height, 0.01, 5000.0);  // Do the perspective calculations. Last value = max clipping depth
  glOrtho(0, Panel1.Width, 0, Panel1.Height, 0, 1000);
  glMatrixMode(GL_MODELVIEW);         // Return to the modelview matrix
end;


{------------------------------------------------------------------}
{  Monitors all keypress events for the app                        }
{------------------------------------------------------------------}
procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;


procedure TForm1.FormResize(Sender: TObject);
begin
//  Panel1.SetBounds(30, 30, clientwidth-60, clientheight-60);
end;

Function MouseDist(Vind: integer): single;
Var
  A,B: single;
begin
  A := XX - V[Vind].P[0];
  B := YY - V[Vind].P[1];

  result := Sqrt(A*A + B*B);
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var
  I, Cl: integer;
  Closest, Dis: single;
begin
 Lx := xx;
 Ly := Yy;
  Xx := x;
  Yy := panel1.Height-Y;

  if MouseD then exit;

  Cl := -1;
  Closest := 10;
  for I := 0 to high(V) do
  begin
    Dis := MouseDist(I);
    if Dis < Closest then
    begin
      Closest := Dis;
      Cl := I;
    end;
  end;

  SelInd := Cl;
end;

procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin
  MouseD := true;

  case ToolID of
  0: begin
      if SelInd = -1 then
      begin
        Setlength(V, high(V)+2);
        V[High(V)] := Vertlet.Create(High(V));
        with V[High(V)] do
        begin
          P[0] := Xx;
          P[1] := Yy;
          F[0] := 0;
          F[1] := 0;
          Mass := 1;
        end;
        
      end;
     end;
  1: if SelInd <> -1 then
     begin
       Sel1 := SelInd;
       Sel2 := -1;
       ToolID := 3;
     end;
  2: if SelInd <> -1 then
     begin
     end;
  3: if SelInd <> -1 then
     begin
       Sel2 := SelInd;
       if Sel1 = Sel2 then begin ToolID := 1; exit; end;
       SetLength(L, high(L)+2);
       L[High(L)] := Link.Create(Sel1, Sel2);
       //ToolId := 1;
       Sel1 := Sel2;
     end;
  end;
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Playing then
 begin
  if SelInd > -1 then
  begin
    V[SelInd].A[0] := V[SelInd].A[0]+(Xx-Lx)/20;
    V[SelInd].A[1] := V[SelInd].A[1]+(YY-Ly)/20;
    inc(V[SelInd].ForceCount);
  end;
 end;
  MouseD := False;
end;

procedure TForm1.tbPlayClick(Sender: TObject);
begin
  tbPause.Enabled := true;
  tbPlay.Enabled := false;
  tbCursor.Click;
  Playing := true;
  tbCursor.Click;
end;

procedure TForm1.tbPauseClick(Sender: TObject);
begin
  tbPause.Enabled := false;
  tbPlay.Enabled := true;
  Playing := false;
end;

procedure TForm1.tbVertClick(Sender: TObject);
begin
  tbVert.Down := true;
  tbLink.Down := false;
  tbCursor.Down := false;
  tbDel.down := false;
  ToolID := 0;
end;

procedure TForm1.tbLinkClick(Sender: TObject);
begin
  tbVert.Down := false;
  tbLink.Down := true;
  tbCursor.Down := false;
  tbDel.down := false;
  ToolId := 1;
end;

procedure TForm1.tbCursorClick(Sender: TObject);
begin
  tbVert.Down := false;
  tbLink.Down := false;
  tbCursor.Down := true;
  tbDel.down := false;
  ToolId := -1;
end;

procedure TForm1.tbDelClick(Sender: TObject);
begin
  tbVert.Down := false;
  tbLink.Down := false;
  tbCursor.Down := false;
  tbDel.down := true;
  ToolId := 2;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Playing then
  tbPause.Click;

  Setlength(L, 0);
  Setlength(V, 0);
  createAGrid(strtoInt(Edit1.Text));
end;

end.
