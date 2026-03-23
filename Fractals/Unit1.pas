unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ToolWin, ComCtrls, ImgList,
  Menus, ExtDlgs, ClipBrd, Math;

type
  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    Panel1: TPanel;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Copierlimage1: TMenuItem;
    Enregistrerlimage1: TMenuItem;
    SavePictureDialog1: TSavePictureDialog;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    CheckBox1: TCheckBox;
    ToolButton3: TToolButton;
    Label2: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Enregistrerlimage1Click(Sender: TObject);
    procedure Copierlimage1Click(Sender: TObject);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
  bmp : TBitmap;
  y : Integer;
  el : Array[0..500] of Real;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, j, ninit, nmax : Integer;
  t0, t, f : Int64;
  x, k : Real;
  P : pRGBArray;
begin
  Image1.Tag := 1;
  ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := 600;
    bmp.Height := 550;
    if CheckBox1.Checked then with bmp.Canvas do begin
      Pen.Color := clBlue;
      PenPos := Point(20, 521);
      LineTo(551, 521);
      PenPos := Point(49, 10);
      LineTo(49, 550);
      Font.Color := clNavy;
      TextOut(41, 20, '1');
      TextOut(38, 508, '-1');
      TextOut(52, 522, '0');
      TextOut(548, 522, '2');
    end;
    ninit := SpinEdit1.Value;
    nmax := SpinEdit2.Value;
    x := 0;
    for i := 0 to 500 do begin
      k := i/250;
      for j := 1 to ninit do x := k*sqr(x)-1;
      for j := 1 to nmax do begin
        x := k*sqr(x)-1;
        P := bmp.ScanLine[520-round((x+1)*250)];
        //P[i+50].rgbtRed := 255;
        P[i+50].rgbtGreen := 0;
        P[i+50].rgbtBlue := 0;
      end;
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t);
  Caption := 'Fractals - ' + FormatFloat('0.000 ms', (t-t0)/f*1000);
  if not Label2.Visible then Label2.Show;
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.Enregistrerlimage1Click(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
end;

procedure TForm1.Copierlimage1Click(Sender: TObject);
begin
  ClipBoard.Assign(Image1.Picture);
end;

procedure TForm1.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['-', '+', DecimalSeparator]) then begin
    Key := #0;
    Beep;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.HintPause := 50;
  Application.HintHidePause := 5000;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  i, j, ninit, nmax : Integer;
  t0, t, f : Int64;
  x, k, l, logn2 : Real;
  P : pRGBArray;
begin
  Image1.Tag := 2;
  ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := 600;
    bmp.Height := 550;
    if CheckBox1.Checked then with bmp.Canvas do begin
      Pen.Color := clBlue;
      PenPos := Point(20, 521);
      LineTo(551, 521);
      PenPos := Point(49, 10);
      LineTo(49, 550);
      Font.Color := clNavy;
      TextOut(41, 20, '1');
      TextOut(39, 508, '0');
      TextOut(52, 522, '2,5');
      TextOut(548, 522, '4');
    end;
    logn2 := Ln(2);
    ninit := SpinEdit1.Value;
    nmax := SpinEdit2.Value;
    x := 0.5;
    for i := 0 to 500 do begin
      l := 0;
      k := 2.5+i/334;
      for j := 1 to ninit do x := k*x*(1-x);
      for j := 1 to nmax do begin
        x := k*x*(1-x);
        P := bmp.ScanLine[520-round(x*500)];
        //P[i+50].rgbtRed := 255;
        P[i+50].rgbtGreen := 0;
        P[i+50].rgbtBlue := 0;
        l := l + Ln(Abs(k-2*k*x))/logn2;
      end;
      el[i] := l/nmax;
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t);
  Caption := 'Fractals - ' + FormatFloat('0.000 ms', (t-t0)/f*1000);
  if not Label2.Visible then Label2.Show;
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var
  i, j, ninit, nmax : Integer;
  t0, t, f : Int64;
  x, k : Real;
  P : pRGBArray;
begin
  Image1.Tag := 3;
  ActiveControl := nil;
  PopupMenu1.AutoPopup := false;
  QueryPerformanceFrequency(f);
  QueryPerformanceCounter(t0);
  bmp := TBitmap.Create;
  try
    bmp.PixelFormat := pf24bit;
    bmp.Width := 600;
    bmp.Height := 550;
    if CheckBox1.Checked then with bmp.Canvas do begin
      Pen.Color := clBlue;
      PenPos := Point(20, 521);
      LineTo(551, 521);
      PenPos := Point(49, 10);
      LineTo(49, 550);
      Font.Color := clNavy;
      TextOut(32, 20, '1,5');
      TextOut(39, 508, '0');
      TextOut(52, 522, '1,9');
      TextOut(548, 522, '3');
    end;
    ninit := SpinEdit1.Value;
    nmax := SpinEdit2.Value;
    x := 0.25;
    for i := 0 to 500 do begin
      k := 1.9+i/455;
      for j := 1 to ninit do x := x*(1+k)-k*sqr(x);
      for j := 1 to nmax do begin
        x := x*(1+k)-k*sqr(x);
        P := bmp.ScanLine[520-round(x*334)];
        //P[i+50].rgbtRed := 255;
        P[i+50].rgbtGreen := 0;
        P[i+50].rgbtBlue := 0;
      end;
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;
  QueryPerformanceCounter(t);
  Caption := 'Fractals - ' + FormatFloat('0.000 ms', (t-t0)/f*1000);
  if not Label2.Visible then Label2.Show;
  PopupMenu1.AutoPopup := true;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (X >= 50) and (X <= 550) then begin
    if Label2.Visible then Case Image1.Tag of
        1 : Label2.Caption := 'x = '+FloatToStr((X-50)/250);
        2 : Label2.Caption := 'x = '+FloatToStr(2.5+(X-50)/334);
        3 : Label2.Caption := 'x = '+FloatToStr(1.9+(X-50)/455);
    end;
  end;
end;

end.
