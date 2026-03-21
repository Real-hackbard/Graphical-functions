unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, XPman;

type
  TForm1 = class(TForm)
    Image1: TImage;
    TB2: TTrackBar;
    TB3: TTrackBar;
    TB4: TTrackBar;
    TB5: TTrackBar;
    TB6: TTrackBar;
    TB7: TTrackBar;
    TB8: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TBStretch: TTrackBar;
    Label8: TLabel;
    TB9: TTrackBar;
    Label9: TLabel;
    TB10: TTrackBar;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel1: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    procedure PaintCurve(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation
uses
  Math;

{$R *.DFM}

procedure TForm1.PaintCurve(Sender: TObject);
const
  cWidth  = 401;
  cHeight = 201;
var
  bmp : TBitmap;
  YStretch, DeltaX, Sum : Extended;
  x, y, n : Integer;
  v : array[1..10] of Extended;
begin
  v[ 1]:=1.0;
  v[ 2]:=(100-TB2 .Position)/100;
  v[ 3]:=(100-TB3 .Position)/100;
  v[ 4]:=(100-TB4 .Position)/100;
  v[ 5]:=(100-TB5 .Position)/100;
  v[ 6]:=(100-TB6 .Position)/100;
  v[ 7]:=(100-TB7 .Position)/100;
  v[ 8]:=(100-TB8 .Position)/100;
  v[ 9]:=(100-TB9 .Position)/100;
  v[10]:=(100-TB10.Position)/100;
  YStretch:=TBStretch.Position;

  bmp:=TBitmap.Create;
  try
    bmp.Width :=Image1.Width ;
    bmp.Height:=Image1.Height;
    DeltaX:=(2*Pi/(cWidth-1));
    for x:=0 to cWidth do begin
      Sum:=0;
      for n:=1 to 10 do begin
          Sum:=Sum+Sin(x*n*DeltaX)*v[n];
      end;
      y:=100-Round(Sum*YStretch);
      bmp.Canvas.Pixels[x,y] := clRed;
    end;
    Image1.Picture.Assign(bmp);
  finally
    bmp.Free;
  end;

  Label13.Caption := IntToStr(TBStretch.Position) + ' %';
  Label14.Caption := IntToStr(TB2.Position) + ' %';
  Label15.Caption := IntToStr(TB3.Position) + ' %';
  Label16.Caption := IntToStr(TB4.Position) + ' %';
  Label17.Caption := IntToStr(TB5.Position) + ' %';
  Label18.Caption := IntToStr(TB6.Position) + ' %';
  Label19.Caption := IntToStr(TB7.Position) + ' %';
  Label20.Caption := IntToStr(TB8.Position) + ' %';
  Label21.Caption := IntToStr(TB9.Position) + ' %';
  Label22.Caption := IntToStr(TB10.Position) + ' %';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DoubleBuffered := true;
  PaintCurve(Nil);
end;

end.
