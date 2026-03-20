unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ComCtrls;

Const
  Size = 256;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Img: TImage;
    ImgBack: TImage;
    Timer1: TTimer;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Label4: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Label9: TLabel;
    Edit6: TEdit;
    UpDown6: TUpDown;
    Label10: TLabel;
    Label11: TLabel;
    Edit7: TEdit;
    UpDown7: TUpDown;
    CheckBox1: TCheckBox;
    UpDown8: TUpDown;
    Edit8: TEdit;
    CheckBox2: TCheckBox;
    Button2: TButton;
    ComboBox1: TComboBox;
    Button3: TButton;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown3Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown4Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown5Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown6Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox1Click(Sender: TObject);
    procedure UpDown7Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown8Click(Sender: TObject; Button: TUDBtnType);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Cell = record
          Life, Level: integer;
          Alive: boolean;
          NewAlive: boolean;
         end;
  Preset = record
    Name: string[20];
    AliveMin, AliveMax, DeadMin, DeadMax: integer;
    Crowding: boolean;
    CrowdMin, LevelMult: integer;
    Reset: boolean;
    Smp, LevelUp: integer;
  end;

var
  Form1: TForm1;
  C: array[0..Size-1, 0..Size-1] of Cell;
  P: array of Preset;

  MouseDwn: boolean;
  MouseBut: integer;
  AliveMin, AliveMax, DeadMin, DeadMax: integer;
  Crowding: boolean;
  CrowdMin, LevelMult: integer;
  Reset: boolean;
    CellsAlive: integer;
  Smp, LevelUp, AvrLevel: integer;


implementation

{$R *.dfm}

Procedure LoadPresets;
Var F: File of Preset;
begin
  setlength(P, 0);
  form1.Combobox1.Clear;

  assignFile(F, ExtractFilePath(Application.ExeName) + 'Preset.dat');
  System.Reset(F);
  while not eof(F) do
  begin
     SetLength(P, High(P)+2);
     Read(F, P[high(P)]);
     Form1.ComboBox1.Items.Add(P[High(P)].Name);
  end;
  closefile(F);

end;

Procedure LoadPreset(I: integer);
begin

with P[I] do
begin
 Form1.Updown1.Position := Smp;
 Form1.updown2.Position :=AliveMin ;
 Form1.Updown3.Position :=AliveMax ;
 Form1.UpDown6.Position := LevelUp;
 Form1.Updown4.Position := DeadMin;
 Form1.updown5.Position :=DeadMax ;
 Form1.Checkbox1.Checked :=Reset ;
 Form1.Updown7.Position := LevelMult;
 Form1.checkbox2.Checked :=Crowding ;
 Form1.updown8.Position := CrowdMin;
end;

with Form1 do
begin
 Smp := Updown1.Position;
 AliveMin := updown2.Position;
 AliveMax := Updown3.Position;
 LevelUp := UpDown6.Position;
 DeadMin := Updown4.Position;
 DeadMax := updown5.Position;
 Reset := Checkbox1.Checked;
 LevelMult := Updown7.Position;
 Crowding := checkbox2.Checked;
 CrowdMin := updown8.Position;

end;

end;

Procedure UpdateVariables;
begin
with Form1 do
begin
 Smp := Updown1.Position;
 AliveMin := updown2.Position;
 AliveMax := Updown3.Position;
 LevelUp := UpDown6.Position;
 DeadMin := Updown4.Position;
 DeadMax := updown5.Position;
 Reset := Checkbox1.Checked;
 LevelMult := Updown7.Position;
 Crowding := checkbox2.Checked;
 CrowdMin := updown8.Position;

end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Timer1.Enabled then
 begin
  Button1.Caption := 'Start Simulation';
  Timer1.Enabled := false;
 end
 else
 begin
  UpdateVariables;
  Button1.Caption := 'Stop Simulation';
  Timer1.Enabled := True;
 end;

end;

Procedure DrawCA;
Var X,Y, Col: integer;
    Rr,G,B: integer;
    Ba: PByteArray;
begin
   for Y := 0 to size-1 do
   begin
     Ba := form1.ImgBack.Picture.Bitmap.ScanLine[Y];
     for X := 0 to size-1 do
     begin
        Col := C[X,Y].Life;
        if Col < 0 then Col := 0;
        //Rr := round(Col*((C[X,Y].Level)/5));
        G := round(Col*((C[X,Y].Level+1)/5));
        B := Col;
        Rr := round(Col*((C[X,Y].Level)/10));

        {Case C[X,Y].Level of
        1: B := Col;
        2: begin
            G := Col;
           end;
        3: begin
            R := Col;
           end;
        4: begin
            B := Col;
            G := Col;
           end;
        5: begin
            G := Col;
            R := Col;
           end;
        6: begin
            B := Col;
            R := Col;
           end;
        end;
        }

        Ba[X*3] := B;
        Ba[X*3+1] := G;
        Ba[X*3+2] := Rr;


     end;
   end;

   //form1.Img.Canvas.Draw(0,0,Form1.ImgBack.Picture.Bitmap);
   bitblt(Form1.Img.Canvas.Handle, 0, 0, Size, Size, form1.ImgBack.Picture.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
   form1.Img.Invalidate ;

end;

Procedure Tick;
Var X,Y, Cnt, MinX, MinY, MaxX, MaxY, XX, YY: integer;
begin

  CellsAlive := 0;

  for X := 0 to Size-1 do
  for Y := 0 to Size-1 do
  begin

     MinX := X-Smp;
     MinY := Y-Smp;
     MaxX := X+Smp;
     MaxY := Y+Smp;
     if MinX < 0 then MinX := 0;
     if MinY < 0 then MinY := 0;
     if MaxX > Size-1 then MaxX := Size-1;
     if MaxY > Size-1 then MaxY := Size-1;

     Cnt := 0;
     AvrLevel := 0;
     for XX := MinX to MaxX do
     for YY := MinY to MaxY do
      if (XX <> X) or (YY <> Y) then
      begin
        if C[XX,YY].Alive then begin
         Inc(Cnt);
         AvrLevel := AvrLevel + C[XX,YY].Level;
        end;
      end;

      if Cnt > 0 then
      AvrLevel := round(AvrLevel / Cnt);

      if C[X,Y].Alive then
      begin
         C[X,Y].Life := 255;
         C[X,Y].NewAlive := ((Cnt >= (C[X,Y].Level*LevelMult)+AliveMin) and (Cnt <= (C[X,Y].Level*LevelMult)+AliveMax));


         if Cnt > LevelUp+(C[X,Y].Level*LevelMult) then
         inc(C[X,Y].Level);
      end
      else
      begin
         if C[X,Y].Life > -255 then Dec(C[X,Y].Life, 5);
         C[X,Y].NewAlive := ((Cnt >= DeadMin+(C[X,Y].Level*LevelMult)) and (Cnt <= DeadMax+C[X,Y].Level));
         if C[X,Y].NewAlive then C[X,Y].Level := AvrLevel;
         if Reset then C[X,Y].Level := 0
         else if C[X,Y].Life <= -255 then C[X,Y].Level := 0;
      end;

      if Crowding then
      if Cnt >= CrowdMin then C[X,Y].NewAlive := false;
  end;

  for X := 0 to Size-1 do
  for Y := 0 to Size-1 do
  begin
   C[X,Y].Alive := C[X,Y].NewAlive;
   if C[X,Y].Alive then
    inc(CellsAlive);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Img.Picture.Bitmap := TBitmap.Create;
  Img.Picture.Bitmap.Width := Size;
  Img.Picture.Bitmap.Height := Size;
  Img.Picture.Bitmap.PixelFormat := pf24bit;

  ImgBack.Picture.Bitmap := TBitmap.Create;
  ImgBack.Picture.Bitmap.Width := Size;
  ImgBack.Picture.Bitmap.Height := Size;
  ImgBack.Picture.Bitmap.PixelFormat := pf24bit;
   UpdateVariables;

   LoadPresets;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Drawca;
  Tick;
end;

procedure TForm1.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   Mousedwn := true;
   if Button = mbLeft then
   MouseBut := 0
   else
   MouseBut := 1;

   ImgMouseMove(Sender, Shift, X, Y);
end;

procedure TForm1.ImgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Mousedwn := false;
end;

procedure TForm1.ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Var XX,YY: integer;
begin
 if Mousedwn then
 begin
  for XX := X-5 to X+5 do
  for YY := Y-5 to Y+5 do
  if (XX >= 0) and (XX < Size-1) then
  if (YY >= 0) and (YY < Size-1) then
  begin

  if MouseBut = 0 then
  begin
   C[XX,YY].Alive := true;
   C[XX,YY].Life := 255;
   C[XX,YY].Level := 1;
  end
  else
  begin
   C[XX,YY].Alive := false;
   C[XX,YY].Life := 0;
  end;

  end;
   if not Timer1.Enabled then
    Drawca;

 end;
end;

procedure TForm1.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
 if updown3.Position < updown2.Position then updown3.Position := updown2.Position;
 UpdateVariables;

end;

procedure TForm1.UpDown3Click(Sender: TObject; Button: TUDBtnType);
begin
 if updown2.Position > updown3.Position then updown2.Position := updown3.Position;
 UpdateVariables;

end;

procedure TForm1.UpDown4Click(Sender: TObject; Button: TUDBtnType);
begin
 if updown5.Position < updown4.Position then updown5.Position := updown4.Position;
 UpdateVariables;

end;

procedure TForm1.UpDown5Click(Sender: TObject; Button: TUDBtnType);
begin
 if updown4.Position > updown5.Position then updown4.Position := updown5.Position;
 UpdateVariables;

end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
 UpdateVariables;

end;

procedure TForm1.UpDown6Click(Sender: TObject; Button: TUDBtnType);
begin
 UpdateVariables;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 UpdateVariables;

end;

procedure TForm1.UpDown7Click(Sender: TObject; Button: TUDBtnType);
begin
 UpdateVariables;

end;

procedure TForm1.UpDown8Click(Sender: TObject; Button: TUDBtnType);
begin
 UpdateVariables;

end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
 UpdateVariables;

end;

procedure TForm1.Button2Click(Sender: TObject);
Var X,Y: integer;
begin
  for X := 0 to Size-1 do
  For Y := 0 to Size-1 do
  begin
   C[X,Y].Alive := false;
   C[X,Y].Level := 0;
  end;
end;

Procedure SavePresets;
Var F: File of Preset;
    I: integer;
begin
  AssignFile(F, ExtractFilePath(Application.ExeName) + 'Preset.dat');
  Rewrite(F);
    for I := 0 to high(P) do
    begin
      write(F, P[I]);
    end;
  CloseFile(F);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 setlength(P, high(P)+2);
 with P[high(P)] do
 begin
  Smp := Form1.Updown1.Position;
  AliveMin := Form1.updown2.Position;
  AliveMax := Form1.Updown3.Position;
  LevelUp := Form1.UpDown6.Position;
  DeadMin := Form1.Updown4.Position;
  DeadMax := Form1.updown5.Position;
  Reset := Form1.Checkbox1.Checked;
  LevelMult := Form1.Updown7.Position;
  Crowding := Form1.checkbox2.Checked;
  CrowdMin := Form1.updown8.Position;
  Name := Form1.Combobox1.Text;
 end;

 SavePresets;
 LoadPresets;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Form1.StatusBar1.Panels[0].Text := 'Living Cells: '+inttostr(CellsAlive);

end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if Combobox1.ItemIndex > -1 then
  LoadPreset(Combobox1.ItemIndex);

end;

end.
