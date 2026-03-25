unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, StdCtrls, Mask,
  Buttons,LeastSquareFit, XPMan;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Series2: TPointSeries;
    Series1: TFastLineSeries;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    MaskEdit1: TMaskEdit;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;
  Matrix:TMatrix;         // Array for sample data
  coef:array of extended; // Array for resulting coefficients
  k:integer;              // Number of variables
  n:integer=10;           // Number of data points

implementation

{$R *.dfm}
function LSF(const Matrix:TMatrix; var coef:array of extended ):Boolean;
var i,j:integer; v: array of extended;
    Reg:TLeastSquareFit;
begin
  SetLength(v, high(Matrix)+2);
  Reg:=TLeastSquareFit.Create(high(Matrix)+1);
  for j:=0 to high(Matrix[0]) do   // add all samples
  begin
    v[0]:=1;        // column of 1's in the column '0' spot
    for i:=1 to high(matrix)+1 do v[i]:=Matrix[i-1,j];
    Reg.AddValue(v);
  end;
  result:=Reg.GetResult(coef);
  Reg.Free;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var i:integer;
begin
  Chart1.Series[0].Clear;
  Chart1.Series[1].Clear;
  Randomize;
  n:=StrtoInt(trim(MaskEdit1.Text));
  k:=1;
  SetLength(Matrix,k+1,n+1);
  SetLength(coef,k+1);
  for i:=0 to n do
  begin
    Matrix[1,i]:=2+i+Random(10);
    if ComboBox1.Text='Y=c+X*b1+X^2*b2+X^3*b3' then
      Matrix[1,i]:=2+i+i*i*2+Random(50);
    if ComboBox1.Text='Y=c+Ln(X*b1)' then
      Matrix[1,i]:=2+ln((i+1)*2)+Random;
    if ComboBox1.Text='Y=Exp(c+X*b1)' then
      Matrix[1,i]:=2+Exp(i)*2+Random(4);
    if ComboBox1.Text='Y=c+X*b1' then
      Matrix[1,i]:=i*2+5;
    Matrix[0,i]:=i+1;
    Chart1.Series[0].Add(Matrix[1,i]);
  end;
  ComboBox1Select(nil);
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
var i:integer;
    AMatrix:TMatrix;         // Array for data points
begin
  SetLength(AMatrix,2,n+1);
  SetLength(coef,2);
  Chart1.Series[1].Clear;
  if ComboBox1.Text='Y=c+X*b1' then
  begin
    LSF(Matrix,coef);
    for i:=0 to n do
      Chart1.Series[1].Add(coef[0]+Matrix[0,i]*coef[1]);
    Label1.Caption:='c ='+floattoStr(coef[0]);
    Label2.Caption:='b1='+floattoStr(coef[1]);
  end;
  if ComboBox1.Text='Y=c+X*b1+X*X*b2' then
  begin
    SetLength(AMatrix,3,n+1);
    SetLength(coef,3);
    for i:=0 to n do
    begin
      AMatrix[0,i]:=Matrix[0,i];
      AMatrix[1,i]:=Matrix[0,i]*Matrix[0,i];
      AMatrix[2,i]:=Matrix[1,i];
    end;
    LSF(AMatrix,coef);
    for i:=0 to n do
      Chart1.Series[1].Add(coef[0]+AMatrix[0,i]*coef[1]+
                                   AMatrix[0,i]*AMatrix[0,i]*coef[2]);
    Label1.Caption:='c ='+floattoStr(coef[0]);
    Label2.Caption:='b1='+floattoStr(coef[1]);
    Label3.Caption:='b2='+floattoStr(coef[2]);
  end;
  if ComboBox1.Text='Y=c+X*b1+X^2*b2+X^3*b3' then
  begin
    SetLength(AMatrix,4,n+1);
    SetLength(coef,4);
    for i:=0 to n do
    begin
      AMatrix[0,i]:=Matrix[0,i];
      AMatrix[1,i]:=Matrix[0,i]*Matrix[0,i];
      AMatrix[2,i]:=Matrix[0,i]*Matrix[0,i]*Matrix[0,i];
      AMatrix[3,i]:=Matrix[1,i];
    end;
    LSF(AMatrix,coef);
    for i:=0 to n do
      Chart1.Series[1].Add(coef[0]+AMatrix[0,i]*coef[1]+
                                   AMatrix[0,i]*AMatrix[0,i]*coef[2]+
      AMatrix[0,i]*AMatrix[0,i]*AMatrix[0,i]*coef[3]);
    Label1.Caption:='c ='+floattoStr(coef[0]);
    Label2.Caption:='b1='+floattoStr(coef[1]);
    Label3.Caption:='b2='+floattoStr(coef[2]);
    Label4.Caption:='b3='+floattoStr(coef[3]);
  end;
  if ComboBox1.Text='Y=c+Ln(X*b1)' then
  begin
    for i:=0 to n do
    begin
      AMatrix[0,i]:=Matrix[0,i];
      AMatrix[1,i]:=Exp(Matrix[1,i]);
     end;
    LSF(AMatrix,coef);
    for i:=0 to n do
      Chart1.Series[1].Add(Ln(Abs(-Exp(coef[0])+AMatrix[0,i]*coef[1])));
    Label1.Caption:='c ='+floattoStr(coef[0]);
    Label2.Caption:='b1='+floattoStr(coef[1]);
  end;
  if ComboBox1.Text='Y=Exp(c+X*b1)' then
  begin
    for i:=0 to n do
    begin
      AMatrix[0,i]:=Matrix[0,i];
      AMatrix[1,i]:=Ln(Matrix[1,i]);
    end;
    LSF(AMatrix,coef);
    for i:=0 to n do
      Chart1.Series[1].Add(Exp(coef[0]+AMatrix[0,i]*coef[1]));
    Label1.Caption:='c ='+floattoStr(coef[0]);
    Label2.Caption:='b1='+floattoStr(coef[1]);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SpeedButton1Click(nil);
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ComboBox1Select(nil);
end;

end.
