unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, ExtDlgs, XPMan, ComCtrls, StdCtrls;

type
  BasisTyp=Record
   Typ:Integer; // 1=Picture 2= Form
   X,Y,Height,Width:Integer;
  end;
  BildTyp=Record
   Typ:Integer;
   X,Y,Height,Width:Integer;
   Image:TBitmap;
  end;
  FormTyp=Record
   Typ:Integer;
   X,Y,Height,Width:Integer;
   FormTyp:Integer; // 1 = Rectangle 2 = Ellipse
   LinienFarbe,FuellFarbe:TColor;
  end;

  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    PictureDialog: TOpenPictureDialog;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Objekte:TList;
    AnGewaehlt:Integer; // Which object is currently selected?
    MausDown:boolean;
    MausX,MausY:Integer;
    procedure LoescheObjekt(Objekt:Pointer);
    procedure NeuesBild(FileName:String);
    procedure NeueForm(WelcheForm:Integer);
    procedure PaintIt;
  end;

var
  Form1: TForm1;
    
implementation

{$R *.DFM}

procedure TForm1.PaintIt;
var
  loop:Integer;
  Basis:^BasisTyp;
  bild:^BildTyp;
  Form:^FormTyp;

begin
 with Image1.Canvas do
  begin
   // delete
   Brush.Color:=clWhite;
   FillRect(Image1.ClientRect);

   if CheckBox1.Checked = true then
   begin
    Pen.Color := clRed;
    Rectangle(0,0,Image1.Width,Image1.Height);
   end;

   for loop:=0 to Objekte.Count-1 do // Draw the last one first
    begin
     Basis:=Objekte[loop];
     case Basis^.Typ of
      1: begin
          Bild:=Objekte[loop];
          StretchDraw(Rect(Bild^.X,Bild^.Y,Bild^.X+Bild^.Width,Bild^.Y+Bild^.Height),Bild^.Image);
          //Draw(Bild^.X,Bild^.Y,Bild^.Image);
         end; // Bild;
      2: begin
          Form:=Objekte[loop];
          Brush.Color := Form^.FuellFarbe;
          Pen.Color:=Form^.LinienFarbe;
           case Form^.FormTyp of
            1: Rectangle(Form^.X,Form^.Y,Form^.X+Form^.Width,Form^.Y+Form^.Height);
            2: Ellipse(Form^.X,Form^.Y,Form^.X+Form^.Width,Form^.Y+Form^.Height);
           end; // rectangle or circle
         end; // Form
     end; // case
     if loop=AnGewaehlt then
      begin
          Brush.Style := bsClear;
          Pen.Color := clRed;
          Rectangle(Basis^.X,Basis^.Y,Basis^.X+Basis^.Width,Basis^.Y+Basis^.Height);
          Brush.Style:=bsSolid;
      end; // selected
    end; // every object
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Panel1.DoubleBuffered := true;
  Randomize;
  Objekte:=tList.Create;
  Image1.Align:=alClient;
  AngeWaehlt:=-1;
  MausDown:=false;
end;

procedure TForm1.NeuesBild(FileName:String);
var
  Bild:^BildTyp;
begin
 New(Bild);
 with Bild^ do
  begin
   Typ:=1;
   X:=0;
   y:=0;
   Image:=TBitmap.Create;
   Image.LoadFromFile(FileName);
   Width:=Image.Width;
   Height:=Image.Height;
   caption:=inttostr(height);
  end;
 Objekte.Add(Bild);
 AnGewaehlt:=Objekte.Count-1; // the latest
end;

procedure TForm1.NeueForm(WelcheForm:Integer);
var
  Form:^FormTyp;
begin
 New(Form);
 with Form^ do
  begin
   Typ:=2;
   X:=Random(Image1.ClientWidth div 2);
   y:=Random(Image1.ClientHeight div 2);
   Width:=Random(Image1.ClientWidth div 4)+10;
   Height:=Random(Image1.ClientHeight div 4)+10;
   FormTyp:=WelcheForm;
   LinienFarbe:=clBlack;
   FuellFarbe:=clBlue;
  end;
 Objekte.Add(Form);
 AnGewaehlt:=Objekte.Count-1; // the latest
end;

procedure TForm1.LoescheObjekt(Objekt:Pointer);
var
  Basis:^BasisTyp;
  bild:^BildTyp;
  Form:^FormTyp;
begin
 Basis:=Objekt;
 case Basis^.Typ of
  1: begin
      Bild:=Objekt;
      Bild^.Image.Free;
      Dispose(bild);
     end; // picture
  2: begin
      Form:=Objekt;
      Dispose(Form);
     end; // form
 end; // case
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 while Objekte.Count>0 do
  begin
   LoescheObjekt(Objekte[0]);
   Objekte.Delete(0);
  end;
 Objekte.Clear;
 Objekte.Free;
end;

procedure TForm1.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  loop:Integer;
  Basis:^BasisTyp;
begin
  MausDown:=true;
  MausX:=X;
  MausY:=Y;
   for loop:= Objekte.Count-1 downto 0 do // Check the front one first.
    begin
     Basis:=Objekte[loop];
     if X>Basis^.X then if X<Basis^.X+Basis^.Width then
      if Y>Basis^.Y then if Y<Basis^.Y+Basis^.Height then
       begin
        AnGewaehlt:=loop;
        PaintIt;
        exit; // out
       end; // found
    end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Basis:^BasisTyp;
begin
 if AnGewaehlt=-1 then Exit; // no object yet
 Basis:=Objekte[AnGewaehlt];
 if not (ssShift in Shift) then
  begin
   if key=vk_Left then Dec(Basis^.X,5);
   if key=vk_Right then Inc(Basis^.X,5);
   if key=vk_Up then Dec(Basis^.Y,5);
   if key=vk_Down then Inc(Basis^.Y,5);
  end else begin
   if key=vk_Left then Dec(Basis^.Width,5);
   if key=vk_Right then Inc(Basis^.Width,5);
   if key=vk_Up then Dec(Basis^.Height,5);
   if key=vk_Down then Inc(Basis^.Height,5);
  end;

 if key=vk_F1 then // backwards
  begin
   Objekte.Move(AnGewaehlt,0);
   AnGewaehlt:=0;
  end;
 if key=vk_F2 then // forward
  begin
   Objekte.Move(AnGewaehlt,Objekte.Count-1);
   Angewaehlt:=Objekte.Count-1;
  end;
 PaintIt;
end;

procedure TForm1.Image1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 MausDown:=false;
end;

procedure TForm1.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Basis:^BasisTyp;
begin
 if MausDown then
  begin
   if AnGewaehlt=-1 then Exit; // no object yet
   Basis:=Objekte[AnGewaehlt];
   StatusBar1.Panels[1].Text := inttostr(MausX) + 'x' + inttostr(MausY);
   Basis^.X:=Basis^.X+(X-MausX);
   Basis^.Y:=Basis^.Y+(Y-MausY);
   MausX:=X;
   MausY:=Y;
   PaintIt;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  NeueForm(1);
  PaintIt;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  NeueForm(2);
 PaintIt;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if PictureDialog.Execute then NeuesBild(PictureDialog.FileName);
 PaintIt;
end;

procedure TForm1.Button4Click(Sender: TObject);
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

