unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    btnClear: TButton;
    GroupBox1: TGroupBox;
    seWidth: TSpinEdit;
    btnColorDialog: TButton;
    ColorDialog: TColorDialog;
    Label1: TLabel;
    Label2: TLabel;
    pnlNumPoints: TPanel;
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnColorDialogClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

type
  APoint = record
    Cnvs: TCanvas;
    X, Y: Word;
    D: Byte;
    Col: TColor;
  end;

var
  Form1: TForm1;
  TTabPoints: array of APoint;
  LongTab: Word;
  CurrentColor: TColor;

implementation

{$R *.DFM}

procedure InitialiseTTabPoints;
begin
  with TForm1 do
  begin
    SetLength(TTabPoints, 0);
    LongTab := 0;
  end;
end;

procedure StockeTTabPoints(Cnvs: TCanvas; X, Y: Word; D: Byte; Col: TColor);
begin
  with TForm1 do
  begin
    Inc(LongTab);
    SetLength(TTabPoints, LongTab);
    TTabPoints[LongTab -1].Cnvs := Cnvs;
    TTabPoints[LongTab -1].X := X;
    TTabPoints[LongTab -1].Y := Y;
    TTabPoints[LongTab -1].D := D;
    TTabPoints[LongTab -1].Col := Col;
  end;
end;

procedure DessinePoint(Cnvs: TCanvas; X, Y: Word; D: Byte; Col: TColor;
  const Add: Bool = False);
var
  R: Byte;
begin
  if D < 1 then Exit;
  if D > 1 then
  begin
    R := D div 2;
    Cnvs.Pen.Color := Col;
    Cnvs.Brush.Color := Col;
    Cnvs.Ellipse(X - R, Y - R, X - R + D, Y - R + D);
  end
  else
    Cnvs.Pixels[X, Y] := Col;
  if Add then
    StockeTTabPoints(Cnvs, X, Y, D, Col);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  E: Byte;
begin
  E := seWidth.Value;
  DessinePoint(Canvas, X, Y, E, CurrentColor, True);
  pnlNumPoints.Caption := IntToStr(LongTab);  //
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CurrentColor := clNavy;
  InitialiseTTabPoints;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to LongTab -1 do
    with TTabPoints[i] do
      DessinePoint(Cnvs, X, Y, D, Col, False);
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
  InitialiseTTabPoints;
  pnlNumPoints.Caption := IntToStr(LongTab);  //
  Refresh;
end;

procedure TForm1.btnColorDialogClick(Sender: TObject);
begin
  if ColorDialog.Execute then
  begin
    CurrentColor := ColorDialog.Color;
    ColorDialog.Color := CurrentColor;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  E: Byte;
  X, Y : integer;
begin
  x := Form1.Width;
  y := Form1.Height;

  E := seWidth.Value;
  DessinePoint(Canvas, Random(X), Random(Y), E, CurrentColor, True);
  pnlNumPoints.Caption := IntToStr(LongTab);  //
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Timer1.Enabled := CheckBox1.Checked;
end;

end.
