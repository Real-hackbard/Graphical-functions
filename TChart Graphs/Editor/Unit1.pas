unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, Series, XPMan;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Chart1: TChart;
    Memo1: TMemo;
    Memo2: TMemo;
    Label3: TLabel;
    TitleEdt: TEdit;
    TypeGrp: TRadioGroup;
    Series2: TBarSeries;
    Series3: TPointSeries;
    countLbl: TLabel;
    Series1: TLineSeries;
    procedure TitleEdtChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TypeGrpClick(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    public
      procedure RedrawChart;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{********** StrToFloatDef **********}
function strtofloatdef(s:string; default:extended):extended;
{Convert input string to extended}
{Return "default" if input string is not a valid real number}
begin
  try
    result:=strtofloat(trim(s));
    except  {on any conversion error}
      result:=default; {use the default}
  end;
end;

{************ Redrawchart ********}
procedure TForm1.RedrawChart;
{Load new data into chart series, called when data or chart format changes}
var i,j,n:integer;
    s,xs,ys:string;
    x,y:extended;
begin
  for i:=0 to 2 do chart1.serieslist[i].clear;
  for i:=0 to memo2.lines.count-1 do
  begin
    s:=memo2.lines[i]+',';
    n:=pos(',',s);
    if n>0 then {extract x as a string}
    begin
      xs:=copy(s,1,n-1);
      delete(s,1,n);
    end;
    n:=pos(',',s);
    if n>0 then  {extract y as a string}
    begin
      ys:=copy(s,1,n-1);
    end;
    x:=strtofloatdef(xs,-1e9); {convert inputs to numeric}
    y:=strtofloatdef(ys,-1e9);
    if (x<>-1e9) and (y<>-1e9) {if values were valid then add to chart}
    then for j:=0 to 2 do  chart1.serieslist[j].addxy(x,y);
  end;
  CountLbl.caption:=inttostr(chart1.serieslist[0].count)+' points';
end;

{*********** TitleEdtChange **********}
procedure TForm1.TitleEdtChange(Sender: TObject);
begin
  with chart1.Title.text do {title text is a stringlist}
  begin
    clear;
    add(TitleEdt.text);
  end;
end;

{************* FormCreate ************}
procedure TForm1.FormCreate(Sender: TObject);
{Generate a random set of data  as the inital set to be plotted}
var
  x,y:extended;
begin
  randomize;
  with memo2 do
  begin
    clear;
    x:=random(100)/10.0; {random start values between 0 and 9.9}
    y:=random(100)/10.0;
    lines.add(floattostr(x)+', '+floattostr(y));
    while lines.count<10 do
    begin
      x:=x+random(10)/10+ 1.0; {increment x by random value between 0.1 and 2.1}
      y:=random(1000)/10.0;  {random y between 0 and 99.9}
      lines.add(floattostr(x)+', '+floattostr(y));
    end;
  end;
  TitleEdtChange(sender);
  with chart1 do  {set only the 1st chart to active}
  begin
    series1.active:=true;
    series2.active:=false;
    series3.active:=false;
  end;
  Redrawchart;    {draw initial chart}
end;

{************ TypeGrpClick **************}
procedure TForm1.TypeGrpClick(Sender: TObject);
{Change chart type}
var
  i:integer;
begin
  for i:=0 to 2 do chart1.serieslist[i].active:=false;
  Chart1.seriesList[typegrp.itemindex].active:=true;
  Redrawchart;
end;

{*********** Memo2Change **********}
procedure TForm1.Memo2Change(Sender: TObject);
{Data changed, try to redraw the chart}
begin
  redrawchart;
end;

end.
