unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, Series, Jpeg,
  XPMan;

type TfctCalculTrace = function(x : double) : double;

type
 TForm1 = class(TForm)
    pnlBottom: TPanel;
    btnTrace: TButton;
    Chart1: TChart;
    btnTraceMore: TButton;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    procedure btnTraceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTraceMoreClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
    { Declarations public }
    // Main procedure. Trace the first segments
    // + deletes existing points.
    procedure Trace;
    // draw a segment
    procedure TraceSegment(Pa, Pb: double; fct : TfctCalculTrace; Couleur : TColor);
    // recalculate the axis scale
    procedure ResizeAxis (StartIndex : integer = -1; EndIndex: integer = -1);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  math;

var
  P1, P2, P3, P4 : Double; // Segment boundaries

  // Tips for beginners: if you need to draw a lot of segments,
  // it's much easier with arrays than with global variables.

  XResolution : double; // distance between two calculated points

{

Explanations:
¯¯¯¯¯¯¯¯¯¯¯¯¯

This program is a demo of
"how to plot a curve defined by a segment (multiple functions) with TChart"
The Trace function is the entry point.
The TfctCalculTrace function type is used to calculate the curve.
The TraceSegment function plots a curve segment defined by a particular function.
Note that no "overlap" check is performed.


Precision of mathematical order:
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
To ultimately obtain a trace that appears to be a single trace,
the last point of a segment MUST be used as the
starting point for the next segment.

That is:

Segment 1 goes from P1 to P2
Segment 2 goes from P2 to P3

with function Segment 1(P2) = function Segment 2(P2)

The derivatives can be calculated to obtain
a continuous connection (without angles).

}
Function GetChartJPEG(AChart:TCustomChart):TJPEGImage;
var
  tmpBitmap:TBitmap;
begin
  result:=TJPEGImage.Create;   { <-- create a TJPEGImage }
  tmpBitmap:=TBitmap.Create;   { <-- create a temporary TBitmap }
  try

    tmpBitmap.Width :=AChart.Width;   { <-- set the bitmap dimensions }
    tmpBitmap.Height:=AChart.Height;

    { draw the Chart on the temporary Bitmap... }
    AChart.Draw(tmpBitmap.Canvas,Rect(0,0,tmpBitmap.Width,tmpBitmap.Height));

    { set the desired JPEG options... }
    With result do
    begin
      GrayScale            :=False;
      ProgressiveEncoding  :=True;
      CompressionQuality   :=50;  // % 0 - 100
      PixelFormat          :=jf24bit;  // or jf8bit
      ProgressiveDisplay   :=True;
      Performance          :=jpBestQuality;  // or jpBestSpeed
      Scale                :=jsFullSize;  // or jsHalf, jsQuarter, jsEighth
      Smoothing            :=True;

      { Copy the temporary Bitmap onto the JPEG image... }
      Assign(tmpBitmap);
    end;
  finally
    tmpBitmap.Free;  { <-- free the temporary Bitmap }
  end;
end;


procedure InitVar;
begin
  P1 := 0;
  P2 := Pi/2;
  P3 := PI;
  P4 := 2*PI;
  XResolution := 0.01;
end;

function fctSegment1(x : double) : double;
begin
  result := 100 * sin(x);
end;

function fctSegment2(x : double) : double;
begin
  result := 100;
end;

function fctSegment3(x : double) : double;
begin
  result := 100 +  exp(x)*sin(20*x);
end;

function Max(VL : TChartValueList; StartIndex : integer = -1; EndIndex: integer = -1) : Double;
// return the maximum value over the range passed as a parameter.
// Default: full extended.
var
  i : integer;
begin
  result := MinDouble;
  if StartIndex = -1 then StartIndex := 0;
  if EndIndex = -1 then EndIndex := VL.Count-1;
  for i := StartIndex to EndIndex do begin
    if VL[i] > result then result := VL[i];
  end;
end;

function Min(VL : TChartValueList; StartIndex : integer = -1; EndIndex: integer = -1) : Double;
// return the minimum value over the range passed as a parameter.
// Default: full extended.
var
  i : integer;
begin
  result := MaxDouble;
  if StartIndex = -1 then StartIndex := 0;
  if EndIndex = -1 then EndIndex := VL.Count-1;
  for i := StartIndex to EndIndex do begin
    if VL[i] < result then result := VL[i];
  end;
end;

procedure TForm1.btnTraceClick(Sender: TObject);
begin
  Trace;
  ResizeAxis;
end;

procedure TForm1.btnTraceMoreClick(Sender: TObject);
begin
  TraceSegment(P3, P4, fctSegment3, clPurple);
  ResizeAxis;

  // allow you to start again
  btnTrace.Enabled := true;
  btnTrace.Caption := 'Re Trace';
  btnTraceMore.Enabled := false;
end;

procedure TForm1.Trace;
begin
  InitVar;
  btnTraceMore.Enabled := true;
  btnTrace.Enabled := false;

  //deletes any existing points.
  Chart1[0].Clear;

  TraceSegment(P1, P2, fctSegment1, clBlue);
  TraceSegment(P2, P3, fctSegment2, clRed);
end;

procedure TForm1.TraceSegment(Pa, Pb: double; fct: TfctCalculTrace ; Couleur : TColor);
// draws a segment from "Pa" to "Pb" using the mathematical function "fct".
var
  s : TLineSeries;
  i, new : Integer;
  nbPas : integer;
  deltaX, X : double;
begin
  // to make the code more readable (and gain a little speed).
  s := Chart1[0] as TLineSeries;

  nbPas := trunc((Pb-Pa) / XResolution);

  deltaX := (Pb-Pa) / nbPas;

  for i := 0 to nbPas-1 do begin
    x := Pa + i*deltaX;
    //s.AddXY(x, fct(x), '', Color);
    // Doc: It is possible to assign a distinct color to each point
    s.AddXY(x, fct(x));
  end;//for

  // changes the color over the area that has just been drawn.
  // Note: If the range was not empty,
  // This will also change pre-existing points
  s.ColorRange(s.XValues,Pa,Pb, Couleur);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  //# Create and configure a new series.
  Chart1.AddSeries(TLineSeries.Create(chart1));

  // to have a different color for each point (obvious, right? ;) )
  // Chart1[0].ColorEachPoint := true;

  // do not draw the edge of the points
  (Chart1[0] as TLineSeries).LinePen.Visible := false;
end;

procedure TForm1.ResizeAxis(StartIndex, EndIndex: integer);
// recalculate the min/max of the right axis
// to display all the points in the series + a margin
var
  amin, amax : double;
  Marge : double;
begin
  aMin := Min(Chart1[0].YValues, StartIndex, EndIndex);
  aMax := Max(Chart1[0].YValues, StartIndex, EndIndex);
  Marge := (aMax-aMin) / 10; // 10% on each side
  Chart1.LeftAxis.SetMinMax(aMin - marge, aMax + marge);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i : integer;
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
    if SaveDialog1.FilterIndex = 1 then
    begin
      with GetChartJPEG(Chart1) do
       try
        SaveToFile(SaveDialog1.FileName + '.jpg');    { <-- save the JPEG to disk }
       finally
        Free;  { <-- free the temporary JPEG object }
       end;
    end;

    if SaveDialog1.FilterIndex = 2 then
    begin
      try
        bmp := TBitmap.Create;
        bmp.Height := Chart1.Height;
        bmp.Width := Chart1.Width;
        Chart1.Draw(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height));
        bmp.PixelFormat := pf24bit;
        bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
      finally
        bmp.Free;
      end;
    end;

end;

end.
