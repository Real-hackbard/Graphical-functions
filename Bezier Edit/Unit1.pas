unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, ComCtrls, XPman, Spin;

type
  TForm1 = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Image1: TImage;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    ColorDialog1: TColorDialog;
    CheckBox3: TCheckBox;
    SpinEdit1: TSpinEdit;
    Button4: TButton;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Shape3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  m:array[0..3] of TPoint;

const
  MaxPoint=4;

type
  PixArray = Array [0..2] of Byte;

implementation

{$R *.dfm}
procedure Antialiasing(Bitmap: TBitmap; Rect: TRect; Percent: Integer);
var
  pix, prevscan, nextscan, hpix: ^PixArray;
  l, p: Integer;
  R, G, B: Integer;
  R1, R2, G1, G2, B1, B2: Byte;
begin
  Bitmap.PixelFormat := pf24bit;
  with Bitmap.Canvas do
  begin
    Brush.Style := bsclear;
    for l := Rect.Top to Rect.Bottom - 1 do
    begin
      pix:= Bitmap.ScanLine[l];
      if l <> Rect.Top then prevscan := Bitmap.ScanLine[l-1]
      else prevscan := nil;
      if l <> Rect.Bottom - 1 then nextscan := Bitmap.ScanLine[l+1]
      else nextscan := nil;

      for p := Rect.Left to Rect.Right - 1 do
      begin
        R1 := pix^[2];
        G1 := pix^[1];
        B1 := pix^[0];

        if p <> Rect.Left then
        begin
          //Pixel left
          hpix := pix;
          dec(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if p <> Rect.Right - 1 then
        begin
          //Pixel right
          hpix := pix;
          inc(hpix);
          R2 := hpix^[2];
          G2 := hpix^[1];
          B2 := hpix^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            hpix^[2] := R;
            hpix^[1] := G;
            hpix^[0] := B;
          end;
        end;

        if prevscan <> nil then
        begin
          //Pixel up
          R2 := prevscan^[2];
          G2 := prevscan^[1];
          B2 := prevscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            prevscan^[2] := R;
            prevscan^[1] := G;
            prevscan^[0] := B;
          end;
          Inc(prevscan);
        end;

        if nextscan <> nil then
        begin
          //Pixel down
          R2 := nextscan^[2];
          G2 := nextscan^[1];
          B2 := nextscan^[0];

          if (R1 <> R2) or (G1 <> G2) or (B1 <> B2) then
          begin
            R := R1 + (R2 - R1) * 50 div (Percent + 50);
            G := G1 + (G2 - G1) * 50 div (Percent + 50);
            B := B1 + (B2 - B1) * 50 div (Percent + 50);
            nextscan^[2] := R;
            nextscan^[1] := G;
            nextscan^[0] := B;
          end;
          Inc(nextscan);
        end;
        Inc(pix);
      end;
    end;
  end;
end;

procedure DrawSpline;
begin
  with Form1 do begin
       m[0].X:=Shape1.Left+(Shape1.Width - (Panel1.Width+10));
       m[0].Y:=Shape1.Top+(Shape1.Height div 2);

       m[3].X:=Shape2.Left+(Shape2.Width - (Panel1.Width+10));
       m[3].Y:=Shape2.Top+(Shape2.Height div 2);

       m[1].X:=Shape3.Left+(Shape3.Width - (Panel1.Width+10));
       m[1].Y:=Shape3.Top+(Shape3.Height div 2);

       m[2].X:=Shape4.Left+(Shape4.Width - (Panel1.Width+10));
       m[2].Y:=Shape4.Top+(Shape4.Height div 2);

       Image1.Canvas.Brush.Color:=ColorDialog1.Color;
       Image1.Canvas.FillRect(Image1.ClientRect);
       Image1.Canvas.Pen.Width:= ScrollBar1.Position;
       Image1.Canvas.Pen.Color:=clBlack;
       Image1.Canvas.PolyBezier(m);
       //
       if CheckBox2.Checked = true then
       begin
         Image1.Canvas.Pen.Width:=0;
         Image1.Canvas.Pen.Color:=clRed;
         Image1.Canvas.MoveTo(m[0].X,m[0].Y);
         Image1.Canvas.LineTo(m[1].X,m[1].Y);
         Image1.Canvas.LineTo(m[2].X,m[2].Y);
         Image1.Canvas.LineTo(m[3].X,m[3].Y);
       end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, jx, jy:Integer;
  count : integer;
begin
  //count := 0

  for count := 0 to SpinEdit2.Value do
  begin
    Randomize;

    for i:=1 to MaxPoint-1 do
    begin
       jx:=RandomRange(0,Image1.Width);
       jy:=RandomRange(0,Image1.Height);
       m[i].X:=jx;
       m[i].Y:=jy;
    end;

    case ComboBox1.ItemIndex of
    0 : Form1.Canvas.PolyBezier(Slice(m, MaxPoint));
    1 : Form1.Canvas.PolyLine(Slice(m, MaxPoint));
    2 : Form1.Canvas.Polygon(Slice(m, MaxPoint));
    end;

    jx:=m[0].X;
    jy:=m[0].Y;
    Form1.Canvas.Rectangle(jx-2,jy-2,jx+2,jy+2);

    jx:=m[MaxPoint-1].X;
    jy:=m[MaxPoint-1].Y;
    Form1.Canvas.Rectangle(jx-2,jy-2,jx+2,jy+2);

    if CheckBox3.Checked = true then
    begin
      Antialiasing(Image1.Picture.Bitmap,
      Rect(0, 0, Image1.Picture.Bitmap.Width,
                 Image1.Picture.Bitmap.Height),
                 SpinEdit1.Value);
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  DrawSpline;
  Shape3.Tag:=0;
  Shape4.Tag:=0;
end;

procedure TForm1.Shape3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetCaptureControl(Image1);
  Shape3.Tag:=1;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if Shape3.Tag=1 then begin
         Shape3.Left:=X-(Shape3.Width - (Panel1.Width+10));
         Shape3.Top:=Y-(Shape3.Height div 2);
         DrawSpline;
      end else if Shape4.Tag=1 then begin
         Shape4.Left:=X-(Shape4.Width - (Panel1.Width+10));
         Shape4.Top:=Y-(Shape4.Height div 2);
         DrawSpline;
      end else if Shape1.Tag=1 then begin
         Shape1.Left:=X-(Shape1.Width - (Panel1.Width+10));
         Shape1.Top:=Y-(Shape1.Height div 2);
         DrawSpline;
      end else if Shape2.Tag=1 then begin
         Shape2.Left:=X-(Shape2.Width - (Panel1.Width+10));
         Shape2.Top:=Y-(Shape2.Height div 2);
         DrawSpline;
      end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Shape1.Tag:=0;
  Shape2.Tag:=0;
  Shape3.Tag:=0;
  Shape4.Tag:=0;

  CheckBox3.OnClick(sender);
end;

procedure TForm1.Shape4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetCaptureControl(Image1);
  Shape4.Tag:=1;
end;

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetCaptureControl(Image1);
  Shape1.Tag:=1;
end;

procedure TForm1.Shape2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetCaptureControl(Image1);
  Shape2.Tag:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered:=true;
  ColorDialog1.Color := clWhite;
  StatusBar1.Panels[1].Text := ' ' + IntToStr(Image1.Height) + 'x' +
                                     IntToStr(Image1.Width);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  i : integer;
begin
  if CheckBox1.Checked = false then
  begin
    for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TShape then (Components[i] as TShape).Visible:=false;
    end;
  end else begin
    for i := 0 to ComponentCount - 1 do begin
    if Components[i] is TShape then (Components[i] as TShape).Visible:=true;
    end;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  with Form1 do
  begin
       m[0].X:=Shape1.Left+(Shape1.Width - (Panel1.Width+10));
       m[0].Y:=Shape1.Top+(Shape1.Height div 2);

       m[3].X:=Shape2.Left+(Shape2.Width - (Panel1.Width+10));
       m[3].Y:=Shape2.Top+(Shape2.Height div 2);

       m[1].X:=Shape3.Left+(Shape3.Width - (Panel1.Width+10));
       m[1].Y:=Shape3.Top+(Shape3.Height div 2);

       m[2].X:=Shape4.Left+(Shape4.Width - (Panel1.Width+10));
       m[2].Y:=Shape4.Top+(Shape4.Height div 2);

       Image1.Canvas.Brush.Color:=ColorDialog1.Color;
       Image1.Canvas.FillRect(Image1.ClientRect);
       Image1.Canvas.Pen.Width:=ScrollBar1.Position;
       Image1.Canvas.Pen.Color:=clBlack;
       Image1.Canvas.PolyBezier(m);

       if CheckBox2.Checked = true then
       begin
         Image1.Canvas.Pen.Width:=0;
         Image1.Canvas.Pen.Color:=clRed;
         Image1.Canvas.MoveTo(m[0].X,m[0].Y);
         Image1.Canvas.LineTo(m[1].X,m[1].Y);
         Image1.Canvas.LineTo(m[2].X,m[2].Y);
         Image1.Canvas.LineTo(m[3].X,m[3].Y);
       end;
  end;

  DrawSpline;
  Application.ProcessMessages;
  StatusBar1.Panels[1].Text := ' ' + IntToStr(Image1.Height) + 'x' +
                                     IntToStr(Image1.Width);
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  DrawSpline;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image1.Picture.Bitmap);
      bmp.PixelFormat := pf24bit;
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if ColorDialog1.Execute then
  begin
    Image1.Picture.Graphic := nil;
    with Form1 do
    begin
         m[0].X:=Shape1.Left+(Shape1.Width - (Panel1.Width+10));
         m[0].Y:=Shape1.Top+(Shape1.Height div 2);

         m[3].X:=Shape2.Left+(Shape2.Width - (Panel1.Width+10));
         m[3].Y:=Shape2.Top+(Shape2.Height div 2);

         m[1].X:=Shape3.Left+(Shape3.Width - (Panel1.Width+10));
         m[1].Y:=Shape3.Top+(Shape3.Height div 2);

         m[2].X:=Shape4.Left+(Shape4.Width - (Panel1.Width+10));
         m[2].Y:=Shape4.Top+(Shape4.Height div 2);

         Image1.Canvas.Brush.Color:=ColorDialog1.Color;
         Image1.Canvas.FillRect(Image1.ClientRect);
         Image1.Canvas.Pen.Width:=ScrollBar1.Position;
         Image1.Canvas.Pen.Color:=clBlack;
         Image1.Canvas.PolyBezier(m);

         if CheckBox2.Checked = true then
         begin
           Image1.Canvas.Pen.Width:=0;
           Image1.Canvas.Pen.Color:=clRed;
           Image1.Canvas.MoveTo(m[0].X,m[0].Y);
           Image1.Canvas.LineTo(m[1].X,m[1].Y);
           Image1.Canvas.LineTo(m[2].X,m[2].Y);
           Image1.Canvas.LineTo(m[3].X,m[3].Y);
         end;
    end;
    Application.ProcessMessages;
    DrawSpline;
    StatusBar1.Panels[1].Text := ' ' + IntToStr(Image1.Height) + 'x' +
                                       IntToStr(Image1.Width);
  end;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  DrawSpline;

  if CheckBox3.Checked = true then
  begin
    SpinEdit1.Enabled := true;
    Antialiasing(Image1.Picture.Bitmap,
    Rect(0, 0, Image1.Picture.Bitmap.Width,
               Image1.Picture.Bitmap.Height),
               SpinEdit1.Value);
  end else begin
    SpinEdit1.Enabled := false;
  end;

  Application.ProcessMessages;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  DrawSpline;
end;

end.
