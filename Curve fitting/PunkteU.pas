unit PunkteU;

interface

uses Types, Grids, SysUtils, StdCtrls;

type
  TPunkt = record
    X:Extended;
    Y:Extended;
  end;

  TPunkte = class
  private
    _Punkte:array of TPunkt;
    _StringGrid:TStringGrid;
    procedure Grid_aktualisieren;
    procedure sortieren;
    function GetPunkt(index: integer): TPunkt;
    procedure SetPunkt(index: integer; const Value: TPunkt);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
                                 Rect: TRect; State: TGridDrawState);
  public
    constructor create(StringGrid:TStringGrid); reintroduce;
    destructor destroy; override;
    procedure add(X, Y:Extended);
    function Count:integer;
    procedure Clear;
    procedure Del(index:integer);
    procedure Refresh;
    function Mittelwert:TPunkt;
    property Punkt[index:integer]:TPunkt read GetPunkt write SetPunkt;
  end;

implementation

uses Graphics;

{ TPunkte }

constructor TPunkte.create(StringGrid: TStringGrid);
begin
  _StringGrid:=StringGrid;
  _StringGrid.DefaultColWidth:=30;
  _StringGrid.FixedCols:=1;
  _StringGrid.RowCount:=2;
  _StringGrid.Cells[0, 0]:='X:';
  _StringGrid.Cells[0, 1]:='Y:';
  _StringGrid.ColWidths[0]:=20;
  _StringGrid.ScrollBars:=ssHorizontal;
  _StringGrid.Options:=[goFixedVertLine, goFixedHorzLine,
                        goVertLine, goHorzLine];
  _StringGrid.OnDrawCell:=StringGridDrawCell;
  _StringGrid.DefaultDrawing:=false;
  setlength(_Punkte, 0);
  Grid_aktualisieren;
end;

destructor TPunkte.destroy;
begin
  setlength(_Punkte, 0);
  inherited;
end;

procedure TPunkte.add(X, Y: Extended);
var i:integer;
    abbruch:boolean;
begin
  abbruch:=false;
  i:=0;
  while (i < length(_Punkte)) and not abbruch do begin
    abbruch:=(FormatFloat('0.00', _Punkte[i].X) = FormatFloat('0.00', X));
    if not abbruch then
      inc(i);
  end;
  if abbruch then begin
    _Punkte[i].X:=X;
    _Punkte[i].Y:=Y;
  end
  else begin
    setlength(_Punkte, length(_Punkte)+1);
    _Punkte[length(_Punkte)-1].X:=X;
    _Punkte[length(_Punkte)-1].Y:=Y;
  end;
  sortieren;
  Grid_aktualisieren;
end;

procedure TPunkte.Grid_aktualisieren;
var i, BreiteX, BreiteY:integer;
    XString, YString:string;
begin
  if length(_Punkte) = 0 then begin
    _StringGrid.ColCount:=2;
    _StringGrid.Cells[1, 0]:='';
    _StringGrid.Cells[1, 1]:='';
  end
  else
    _StringGrid.ColCount:=length(_Punkte)+1;
  for i:=1 to length(_Punkte) do begin
    XString:=FormatFloat('0.00', _Punkte[i-1].X);
    YString:=FormatFloat('0.00', _Punkte[i-1].Y);

    BreiteX:=_StringGrid.Canvas.TextWidth(XString)+5;
    BreiteY:=_StringGrid.Canvas.TextWidth(YString)+5;

    _StringGrid.Cells[i, 0]:=XString;
    _StringGrid.Cells[i, 1]:=YString;
    if BreiteX > BreiteY then
      _StringGrid.ColWidths[i]:=BreiteX
    else
      _StringGrid.ColWidths[i]:=BreiteY;
  end;
end;

procedure TPunkte.sortieren;
var i, j:integer;
    tempX, tempY:Extended;
    tausch:boolean;
begin
  if length(_Punkte) > 1 then begin
    i:=length(_Punkte)-1;
    repeat
      tausch:=false;
      for j:=0 to i-1 do begin
        if _Punkte[j].X > _Punkte[j+1].X then begin
          tausch:=true;
          tempX:=_Punkte[j].X;
          tempY:=_Punkte[j].Y;
          _Punkte[j].X:=_Punkte[j+1].X;
          _Punkte[j].Y:=_Punkte[j+1].Y;
          _Punkte[j+1].X:=tempX;
          _Punkte[j+1].Y:=tempY;
        end;
      end;
      dec(i);
    until (i = 0) or not tausch;
  end;
end;

function TPunkte.Count: integer;
begin
  Result:=length(_Punkte);
end;

function TPunkte.GetPunkt(index: integer): TPunkt;
begin
  Result:=_Punkte[index];
end;

procedure TPunkte.Clear;
begin
  setlength(_Punkte, 0);
  Grid_aktualisieren;
end;

procedure TPunkte.Del(index: integer);
var i:integer;
begin
  for i:=index-1 to length(_Punkte)-2 do
    _Punkte[i]:=_Punkte[i+1];
  setlength(_Punkte, length(_Punkte)-1);
  Grid_aktualisieren;
end;

procedure TPunkte.SetPunkt(index: integer; const Value: TPunkt);
begin
  _Punkte[index]:=Value;
end;

procedure TPunkte.Refresh;
begin
  Grid_aktualisieren;
end;

procedure TPunkte.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var Breite, Hoehe:integer;
begin
  with TStringGrid(Sender) do begin
    Breite:=Canvas.TextWidth(Cells[ACol, ARow]);
    Hoehe:=Canvas.TextHeight(Cells[ACol, ARow]);
    if ACol = 0 then begin
      Canvas.Brush.Color:=clSilver;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + (Rect.Right - Rect.Left - Breite) div 2,
                     Rect.Top + (Rect.Bottom - Rect.Top - Hoehe) div 2,
                     Cells[ACol, ARow]);
    end
    else begin
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left + 2,
                     Rect.Top + (Rect.Bottom - Rect.Top - Hoehe) div 2,
                     Cells[ACol, ARow]);
    end;
  end;
end;

function TPunkte.Mittelwert: TPunkt;
var i:integer;
    XSumme, YSumme:Extended;
begin
  XSumme:=0.0;
  YSumme:=0.0;
  for i:=1 to length(_Punkte) do begin
    XSumme:=XSumme+_Punkte[i-1].X;
    YSumme:=YSumme+_Punkte[i-1].Y;
  end;
  Result.X:=XSumme / length(_Punkte);
  Result.Y:=YSumme / length(_Punkte);
end;

end.

