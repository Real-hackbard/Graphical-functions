unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GridCls, WurfCls, Spin, XPMan;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblMax_s: TLabel;
    lblMax_h: TLabel;
    lblTime: TLabel;
    Label5: TLabel;
    lbls_h_max: TLabel;
    btnDraw: TButton;
    ListBox1: TListBox;
    btnClear: TButton;
    edtv0: TSpinEdit;
    edtHeight: TSpinEdit;
    edtGrav: TEdit;
    edtAngel: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnDrawClick(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edtGravKeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
    OffScreenBitmap: TBitmap;
    Grid: TGrid;
    Wurf: TWurf;
  public
    { Public-Deklarationen }
  end;

const
  APPNAME      = 'Litter Calculation';
  VER          = '1.0';

var
  Form1        : TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := APPNAME;
  ScrollBar1.Position := 50;
  ScrollBar2.Position := 50;
  Grid := TGrid.Create;
  Grid.StepY := 10;
  Grid.StepX := 10;
  Grid.StepNumbers := 50;
  OffScreenBitmap := TBitmap.Create;
  OffScreenBitmap.Width := PaintBox1.Width;
  OffScreenBitmap.Height := paintbox1.Height;
  edtGrav.Text := '9' + DecimalSeparator + '81';
  Wurf := TWurf.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Grid);
  FreeAndnIl(Wurf);
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Loop         : Integer;
  ptArray      : array of TPoint;
begin
  // Draw a grid onto the paintbox
  Grid.DrawGrid(Paintbox1.Width, Paintbox1.Height);
  // Draw on Grid Bitmap
  setlength(ptArray, length(Wurf.Table));
  for Loop := 0 to length(Wurf.Table) - 1 do
  begin
    if Grid.ScaleVert > 0 then
      ptArray[Loop].X := Loop * Grid.ScaleVert
    else
      ptArray[Loop].X := Loop div abs(Grid.ScaleVert);
    if Grid.ScaleHorz > 0 then
      ptArray[Loop].Y := -round((Wurf.Table[Loop]) *
                          Grid.ScaleHorz) + Paintbox1.Height div 2
    else
      ptArray[Loop].Y := -round((Wurf.Table[Loop]) /
                          abs(Grid.ScaleHorz)) + Paintbox1.Height div 2
  end;
  with Grid.Bitmap.Canvas do
  begin
    Pen.Width := 2;
    Pen.Color := clBlue;
    Polyline(ptArray);
    Pen.Width := 1;
    Pen.Color := clBlack;
  end;
  // Copy grid bitmap with drawn throw onto paintbox
  BitBlt(Paintbox1.Canvas.Handle, 0, 0, PaintBox1.Width, PaintBox1.Height,
    Grid.Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TForm1.btnDrawClick(Sender: TObject);
var
  Loop         : Integer;
resourcestring
  rsMax_s      = 'Throwing Range:: %.2f m';
  rsMax_h      = 'Throw height: %.2f m';
  rsTime       = 'Rise time: %.2f s';
  rss_h_max = 'Highest Point: %.2f m';
begin
  Listbox1.Items.Clear;
  // Calculating the throw
  Wurf.CalcThrow(trunc(Wurf.s_max)+Paintbox1.Width, edtv0.Value, edtAngel.Value, edtHeight.Value,
    StrToFloat(edtGrav.Text));
  lblMax_s.Caption := Format(rsMax_s, [Wurf.s_max]);
  lblMax_h.Caption := Format(rsMax_h, [Wurf.h_max]);
  lblTime.Caption := Format(rsTime, [Wurf.t_h_max]);
  lbls_h_max.Caption := Format(rss_h_max, [Wurf.s_h_max]);
  // Output table of values
  for Loop := 0 to length(Wurf.Table) - 1 do
  begin
    Listbox1.Items.Add(IntToStr(Loop) + ': ' + FloatToStrF(Wurf.Table[Loop],
      ffNumber, 7, 2))
  end;
  // Force redrawing of the paintbox
  Paintbox1.Repaint;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  if Assigned(Grid) then
  begin
    Grid.ScaleVert := ScrollBar1.Position - 50;
    // Grid.DrawGrid;
  end;
  PaintBox1.Repaint;
end;

procedure TForm1.ScrollBar2Change(Sender: TObject);
begin
  if Assigned(Grid) then
  begin
    Grid.ScaleHorz := ScrollBar2.Position - 50;
    Grid.DrawGrid(Paintbox1.Width, Paintbox1.Height);
  end;
  PaintBox1.Repaint;
end;

procedure TForm1.btnClearClick(Sender: TObject);
resourcestring
  rsMax_s      = 'Throwing Range:';
  rsMax_h      = 'Throw height:';
  rsTime       = 'Rise time:';
begin
  ListBox1.Items.Clear;
  lblMax_s.Caption := rsMax_s;
  lblMax_h.Caption := rsMax_h;
  lblTime.Caption := rsTime;
  Grid.ClearGrid(Paintbox1.Canvas, Paintbox1.Width, Paintbox1.Height);
end;

procedure TForm1.edtGravKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#48..#57, #8, DecimalSeparator]) then
    Key := #0;
end;

end.

