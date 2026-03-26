unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OpenGL, StdCtrls, ExtCtrls, ComCtrls, ImgList, PunkteU, XPMan, Menus;

type
  TForm1 = class(TForm)
    PaScene: TPanel;
    ScrollBarX: TScrollBar;
    ScrollBarY: TScrollBar;
    ScrollBarZ: TScrollBar;
    Timer: TTimer;
    SbSize: TScrollBar;
    SbHeight: TScrollBar;
    SbWidth: TScrollBar;
    OpenDialog: TOpenDialog;
    BtnOpen: TButton;
    StatusBar: TStatusBar;
    RbSort: TRadioGroup;
    ImageList: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    LaBildPunkte: TLabel;
    GroupBox2: TGroupBox;
    TreeView: TTreeView;
    SbScaleY: TScrollBar;
    SbScaleX: TScrollBar;
    Label5: TLabel;
    Label6: TLabel;
    PopupMenu1: TPopupMenu;
    S1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure SbChange(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure RbSortClick(Sender: TObject);
    procedure TreeViewClick(Sender: TObject);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word;
                              Shift: TShiftState);
    procedure S1Click(Sender: TObject);
  private
    { Private declarations }
    _DC : hdc;        // contains the handle to the drawing area
    _hrc: HGLRC;      // contains the handle to the OpenGL rendering context
                      // the drawing area
    _Punkte:TPunkte;  // Object for managing character points
    procedure DrawScene;
    procedure OnActivate(Sender:TObject);
    procedure SetDCPixelFormat(Handle: HDC);
    procedure ToggleTreeViewCheckBoxes(Node:TTreeNode;
                                       cUnChecked, cChecked, cRadioUnchecked,
                                       cRadioChecked:integer);
    procedure DrawWinkel;
    procedure DrawHoehe;
    procedure DrawPunktInfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  RegExprU;

{
  When the window is created, the points management and
  the OpenGL rendering context are created.
}
procedure TForm1.FormCreate(Sender: TObject);
begin
  _Punkte:=TPunkte.Create;
  _DC := GetDC(PaScene.Handle);
  SetDCPixelFormat(_DC);
  _hrc := wglCreateContext(_DC);
  Application.OnActivate := OnActivate;
end;

{
  When the application is closed, the points management,
  any existing points, and the OpenGL rendering context are reactivated.
}
procedure TForm1.FormDestroy(Sender: TObject);
begin
  wglDeleteContext(_hrc);
  ReleaseDC(Handle, _DC);
  _Punkte.ClearTree(TreeView);
  _Punkte.free;
end;

{
  This procedure prepares the drawing area for use
  by OpenGL.
}
procedure TForm1.SetDCPixelFormat(Handle: HDC);
var
  pfd: TPixelFormatDescriptor;
  nPixelFormat: integer;
begin
  FillChar(pfd, sizeOf(pfd), 0);
  with pfd do begin
    nSize     := sizeof(pfd);
    nVersion  := 1;
    dwFlags   :=    PFD_DRAW_TO_WINDOW
                 or PFD_SUPPORT_OPENGL
                 or PFD_DOUBLEBUFFER;
    iPixelType:= PFD_TYPE_RGBA;
    cColorBits:= 24;
    cDepthBits:= 32;
    iLayerType:= PFD_MAIN_PLANE;
  end;
  nPixelFormat := ChoosePixelFormat(Handle, @pfd);
  SetPixelFormat(Handle, nPixelFormat, @pfd);
end;

{
  This is the OpenGL rendering procedure. It is called whenever
  the scene needs to be redrawn.
  Here, resizing and rotation are applied to the drawing area.
  Depending on the sorting, a different procedure is called for drawing the
  points.
}
procedure TForm1.DrawScene;
begin
  glEnable(GL_DEPTH_TEST);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glMatrixMode(GL_MODELVIEW);

  glLoadIdentity;
  glTranslatef(
    SbWidth.Position / PaScene.Width,
    (0 - SbHeight.Position) / PaScene.Height,
    SbSize.Position
  );

  glRotatef(ScrollBarX.Position, 1, 0, 0);
  glRotatef(ScrollBarY.Position, 0, 1, 0);
  glRotatef(ScrollBarZ.Position, 0, 0, 1);

  case _Punkte.Sort of
    _Winkel: DrawWinkel;
    _Hoehe:  DrawHoehe;
  end;
  DrawPunktInfo;
  SwapBuffers(_DC); // Contents of the OpenGL drawing area from the shadow storage
                    // Copy to canvas without flickering
end;

{
  This procedure draws a continuous line for each angle, so the figure
  is drawn exactly as it was scanned.
  The points are scaled, and points marked in the coordinate tree are
  highlighted in red.
}
procedure TForm1.DrawWinkel;
var
  i:integer;
  Punkt:TPunkt;
  X, Y, Z, oldY, oldX, oldW:real;
  NodeObject:TObject;
  Winkel:TWinkel;
  Start:boolean;
begin
  Winkel:=nil;
  if assigned(TreeView.Selected) then begin
    NodeObject:=TreeView.Selected.Data;
    if NodeObject is TWinkel then
      Winkel:=TWinkel(NodeObject);
  end;
  oldY:=-1;
  oldX:=-1;
  oldW:=-1;
  i:=0;
  Start:=false;
  while i < _Punkte.Count do begin
    Punkt:=_Punkte.Punkt[i];
    if Punkt.Show then begin
      if assigned(Winkel) and (Winkel.Wert = Punkt.W) then
        glColor3ub(255, 0, 0)
      else
        glColor3ub(255, 255, 255);
      if oldW <> Punkt.W then begin
        if Start then
          glEnd;
        glBegin(GL_LINE_STRIP);
        Start:=true;
      end;
      X:=Punkt.X / SbScaleX.Position;
      Y:=(_Punkte.MaxY - Punkt.Y) / SbScaleY.Position;
      Z:=((pi/180) * Punkt.W);
      glVertex3f(cos(Z)*X, Y, sin(Z)*X);
      oldY:=Punkt.Y;
      oldX:=Punkt.X;
      oldW:=Punkt.W;
    end
    else begin
      if Start then begin
        X:=(oldX + 0.1) / SbScaleX.Position;
        Y:=(_Punkte.MaxY - oldY) / SbScaleY.Position;
        Z:=((pi/180) * oldW);
        glVertex3f(cos(Z)*X, Y, sin(Z)*X);
        glEnd;
        glBegin(GL_LINE_STRIP);
      end;
    end;
    inc(i);
  end;
  if Start then
    glEnd;
end;

{
  This procedure draws a continuous line for each elevation value; the
  figure is thus now drawn as an elevation map.
  The points are scaled, and points marked in the coordinate tree are highlighted in
  red.
}
procedure TForm1.DrawHoehe;
var
  i:integer;
  Punkt:TPunkt;
  X, Y, Z, oldY, oldX, oldW:real;
  NodeObject:TObject;
  Hoehe:THoehe;
  Start:boolean;
begin
  Hoehe:=nil;
  if assigned(TreeView.Selected) then begin
    NodeObject:=TreeView.Selected.Data;
    if NodeObject is THoehe then
      Hoehe:=THoehe(NodeObject);
  end;
  oldY:=-1;
  oldX:=-1;
  oldW:=-1;
  i:=0;
  Start:=false;
  while i < _Punkte.Count do begin
    Punkt:=_Punkte.Punkt[i];
    if Punkt.Show then begin
      if assigned(Hoehe) and (Hoehe.Wert = Punkt.Y) then
        glColor3ub(255, 0, 0)
      else
        glColor3ub(255, 255, 255);
      if oldY <> Punkt.Y then begin
        if Start then
          glEnd;
        glBegin(GL_LINE_STRIP);
        Start:=true;
      end;
      X:=Punkt.X / SbScaleX.Position;
      Y:=(_Punkte.MaxY - Punkt.Y) / SbScaleY.Position;
      Z:=((pi/180) * Punkt.W);
      glVertex3f(cos(Z)*X, Y, sin(Z)*X);
      oldY:=Punkt.Y;
      oldX:=Punkt.X;
      oldW:=Punkt.W;
    end
    else begin
      if Start then begin
        X:=(oldX+0.1) / SbScaleX.Position;
        Y:=(_Punkte.MaxY - oldY) / SbScaleY.Position;
        Z:=((pi/180) * oldW);
        glVertex3f(cos(Z)*X, Y, sin(Z)*X);
        glEnd;
        glBegin(GL_LINE_STRIP);
      end;
    end;
    inc(i);
  end;
  if Start then
    glEnd;
end;

{
  The point marked in the coordinate tree receives a red marker
  towards the center of the figure. This line is created by this procedure.
}
procedure TForm1.DrawPunktInfo;
var
  NodeObject:TObject;
  Punkt:TPunkt;
  X, Y, Z:real;
begin
  if _Punkte.Count > 0 then begin
    if assigned(TreeView.Selected) then
      NodeObject:=TreeView.Selected.Data
    else
      NodeObject:=nil;
    if NodeObject is TPunkt then begin
      Punkt:=TPunkt(NodeObject);
      glBegin(GL_LINE_STRIP);
        glColor3ub(255, 0, 0);
        X:=Punkt.X / SbScaleX.Position;
        Y:=(_Punkte.MaxY - Punkt.Y) / SbScaleY.Position;
        Z:=((pi/180) * Punkt.W);
        glVertex3f(cos(Z)*X, Y, sin(Z)*X);
        X:=0;
        Y:=(_Punkte.MaxY - Punkt.Y) / SbScaleY.Position;
        Z:=((pi/180) * Punkt.W);
        glVertex3f(cos(Z)*X, Y, sin(Z)*X);
      glEnd;
    end;
  end;
end;

{
  When the main window is resized, this procedure adjusts the
  drawing area to the changed size.
}
procedure TForm1.FormResize(Sender: TObject);
var
  gldAspect : GLdouble;
begin
  wglMakeCurrent(_DC, _hrc);
  gldAspect := PaScene.Width / PaScene.Height;
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  gluPerspective(
    30.0,      // Specifies the field of view (FOV) in degrees, along the
               // Y-axis, on.
    gldAspect, // Provides the aspect ratio that defines the field of view along the
               // X-axis is set. The aspect ratio is the ratio of
               // Height to width.
    1.0,       // Distance from the viewer to the nearest Z-intercept
               // (must be positive).
    50.0       // Distance from the viewer to the distant Z-intercept surface
               // (must be positive).
  );
  glViewport(0, 0, PaScene.Width, PaScene.Height);
  wglMakeCurrent(0, 0);
  Timer.Enabled:=true;
end;

{
  If the form needs to be redrawn, this procedure is called,
  the OpenGL rendering context is switched to the drawing area, and the actual
  rendering procedure is called.
}
procedure TForm1.FormPaint(Sender: TObject);
begin
  wglMakeCurrent(_DC, _hrc);
  DrawScene;
  wglMakeCurrent(0, 0);
end;

{
  When changing the OpenGL system parameters (position, size, scale),
  re-rendering/redrawing is required.
}
procedure TForm1.SbChange(Sender: TObject);
begin
  Self.Repaint;
end;

{
  When a marker is changed in the coordinate tree, it must be
  re-rendered/redrawn.
}
procedure TForm1.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  Self.Repaint;
end;

{
  When the application receives focus, the timer for the new
  rendering/drawing is activated.
}
procedure TForm1.OnActivate(Sender: TObject);
begin
  Timer.Enabled:=true;
end;

{
  The timer event is present so that the artboard is re-rendered/redrawn
  when the application receives focus or a dialog box
  is displayed.
  Otherwise, the artboard is empty until a redraw is forced.
}
procedure TForm1.TimerTimer(Sender: TObject);
begin
  Self.Repaint;
  Timer.Enabled:=false; // only redraw once
end;

{
  This procedure controls the reading of a file containing
  cylinder coordinates.
}
procedure TForm1.BtnOpenClick(Sender: TObject);
var
  ProgressBar:TProgressBar;
begin
  Timer.Enabled:=true;
  if OpenDialog.Execute then begin
    ProgressBar:=TProgressBar.Create(Self);
    try
      ProgressBar.Parent:=StatusBar;
      ProgressBar.Align:=alClient;
      _Punkte.ClearTree(TreeView);
      _Punkte.LoadFromFile(OpenDialog.FileName, ProgressBar);
      _Punkte.GetTree(TreeView, ProgressBar);
      SbScaleY.Min:=1;
      SbScaleY.Max:=round(_Punkte.MaxY);
      SbScaleY.Position:=round(_Punkte.MaxY) div 2;
      SbScaleX.Min:=1;
      SbScaleX.Max:=round(_Punkte.MaxX);
      SbScaleX.Position:=round(_Punkte.MaxX) div 2;
      LaBildPunkte.Caption:=inttostr(_Punkte.Count);
    finally
      ProgressBar.free;
    end;
  end;
  Timer.Enabled:=true;
end;

{
  If a different sorting option is selected, this procedure ensures that
  the points are sorted and displayed in the coordinate tree.
}
procedure TForm1.RbSortClick(Sender: TObject);
var
  ProgressBar:TProgressBar;
begin
  _Punkte.MakeSort(TPunkteSort(RbSort.ItemIndex));
  ProgressBar:=TProgressBar.Create(Self);
  try
    ProgressBar.Parent:=StatusBar;
    ProgressBar.Align:=alClient;
    _Punkte.GetTree(TreeView, ProgressBar);
  finally
    ProgressBar.free;
  end;
  Self.Repaint;
end;

{
  This procedure takes over the control of the checkboxes in the TreeView
  (via the mouse).
}
procedure TForm1.TreeViewClick(Sender: TObject);
var
  P:TPoint;
begin
  GetCursorPos(P);
  P := TreeView.ScreenToClient(P);
  if (htOnStateIcon in TreeView.GetHitTestInfoAt(P.X,P.Y)) then
    ToggleTreeViewCheckBoxes(
      TreeView.Selected,
      cFlatUnCheck,
      cFlatChecked,
      cFlatRadioUnCheck,
      cFlatRadioChecked
    );
  Self.Repaint;
end;

{
  This procedure takes over the control of the checkboxes in the TreeView
  (via the keyboard).
}
procedure TForm1.TreeViewKeyDown(Sender: TObject; var Key: Word;
                                 Shift: TShiftState);
begin
  if (Key = VK_SPACE) and assigned(TreeView.Selected) then
    ToggleTreeViewCheckBoxes(
      TreeView.Selected,
      cFlatUnCheck,
      cFlatChecked,
      cFlatRadioUnCheck,
      cFlatRadioChecked
    );
  Self.Repaint;
end;

{
  This procedure controls the checkboxes in the TreeView.
}
procedure TForm1.ToggleTreeViewCheckBoxes(Node:TTreeNode;
                                          cUnChecked, cChecked, cRadioUnchecked,
                                          cRadioChecked:integer);
var
  tmp:TTreeNode;
  NodeObject:TObject;
  status:boolean;
begin
  if assigned(Node) then begin
    if Node.StateIndex = cUnChecked then
      Node.StateIndex := cChecked
    else if Node.StateIndex = cChecked then
      Node.StateIndex := cUnChecked
    else if Node.StateIndex = cRadioUnChecked then begin
      tmp := Node.Parent;
      if not assigned(tmp) then
        tmp := TTreeView(Node.TreeView).Items.getFirstNode
      else
        tmp := tmp.getFirstChild;
      while assigned(tmp) do begin
        if (tmp.StateIndex in [cRadioUnChecked, cRadioChecked]) then
          tmp.StateIndex := cRadioUnChecked;
        tmp := tmp.getNextSibling;
      end;
      Node.StateIndex := cRadioChecked;
    end;
    if (Node.StateIndex = cChecked) or (Node.StateIndex = cUnChecked) then
    begin
      NodeObject:=Node.Data;
      if NodeObject is TWinkel then // Is the current element a
                                    // Angle parent nodes, all receive
                                    // Child nodes have the same status
                                    // (checked/not checked)
      begin
        status:=(Node.StateIndex = cChecked);
        TWinkel(NodeObject).Show:=status;
        tmp:=Node.getFirstChild;
        while assigned(tmp) do begin
          NodeObject:=tmp.Data;
          tmp.StateIndex:=Node.StateIndex;
          if NodeObject is TPunkt then
            TPunkt(NodeObject).Show:=status;
          tmp:=tmp.getNextSibling;
        end;
      end
      else if NodeObject is THoehe then // Is the current element a
                                        // High-altitude parent nodes, all receive
                                        // Child nodes have the same status
                                        // (checked/not checked)
      begin
        status:=(Node.StateIndex = cChecked);
        THoehe(NodeObject).Show:=status;
        tmp:=Node.getFirstChild;
        while assigned(tmp) do begin
          NodeObject:=tmp.Data;
          tmp.StateIndex:=Node.StateIndex;
          if NodeObject is TPunkt then
            TPunkt(NodeObject).Show:=status;
          tmp:=tmp.getNextSibling;
        end;
      end
      else if NodeObject is TPunkt then // If the current element is a point,
                                        // This only changes the status of this point.
                                        // changed
      begin
        TPunkt(NodeObject).Show:=(Node.StateIndex = cChecked);
      end;
    end;
  end;
end;

procedure TForm1.S1Click(Sender: TObject);
VAR
  bmp : TBitmap;
  DC  : HDC;
Begin
  try
    bmp := TBitmap.Create;
    bmp.width := PaScene.Width;
    bmp.Height := PaScene.Height;
    bmp.PixelFormat := pf24bit;
    DC := GetDc ( PaScene.Handle );
    Bitblt(bmp.canvas.handle, 0, 0, PaScene.Width,
                                    PaScene.Height,
                                    Dc,
                                    0,
                                    0,
                                    NOTSRCCOPY);
    Releasedc (PaScene.handle,dc);
    if SaveDialog1.Execute then
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
    bmp.Free;
  end;

End;

end.