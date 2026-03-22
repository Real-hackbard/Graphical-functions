unit KoordinatenU;

interface

uses Types, SysUtils, Graphics, ExtCtrls, PunkteU, FunktionenU, Grids;

type
  TKoordinaten = class
  private
    _Canvas:TCanvas;
    _CanvasWidth:integer;
    _CanvasHeight:integer;
    _Funktionen:TFunktionen;
    _MinX, _MaxX:Extended;
    _MinY, _MaxY:Extended;
    _SchrittX, _SchrittY:Extended;
    _MitteX, _MitteY:integer;
    _PosiSchrittX, _PosiSchrittY:integer;
    _Punkte:TPunkte;
    _PunkteVerbinden:boolean;
    _KurveZeichnen:boolean;
    _MarkPunkt:integer;
    _Grad:byte;
    procedure SetMaxX(const Value: Extended);
    procedure SetMaxY(const Value: Extended);
    procedure SetMinX(const Value: Extended);
    procedure SetMinY(const Value: Extended);
    procedure SetSchrittX(const Value: Extended);
    procedure SetSchrittY(const Value: Extended);
    procedure PosiSchrittXberechnen;
    procedure PosiSchrittYberechnen;
    procedure KreuzMalen(Point:TPoint; Color:TColor);
    function PunktToPoint(Punkt:TPunkt):TPoint;
    procedure SetMarkPunkt(const Value: integer);
  public
    constructor create(StringGrid:TStringGrid;
                       RadioGroup:TRadioGroup); reintroduce;
    destructor destroy; override;
    procedure Repaint;
    procedure Kurven_zeichnen;
    procedure Punkte_zeichnen;
    procedure Refresh;
    function PointToPunkt(Point:TPoint):TPunkt;
    procedure SetKreuz(Punkt:TPunkt);
    procedure Punkte_loeschen;
    procedure Punkt_loeschen(index:integer);
    function GetFunktion(var Funktion:TFunktion):boolean;
    function findPunkt(var Index:integer; Point:TPoint):boolean;
    function GradDesZusammenhangs:Extended;
    property MinX:Extended read _MinX write SetMinX;
    property MaxX:Extended read _MaxX write SetMaxX;
    property MinY:Extended read _MinY write SetMinY;
    property MaxY:Extended read _MaxY write SetMaxY;
    property SchrittX:Extended read _SchrittX write SetSchrittX;
    property SchrittY:Extended read _SchrittY write SetSchrittY;
    property PunkteVerbinden:boolean read _PunkteVerbinden write _PunkteVerbinden;
    property KurveZeichnen:boolean read _KurveZeichnen write _KurveZeichnen;
    property MarkPunkt:integer read _MarkPunkt write SetMarkPunkt;
    property Punkte:TPunkte read _Punkte;
    property Grad:byte read _Grad write _Grad;
    property Canvas:TCanvas read _Canvas write _Canvas;
    property CanvasWidth:integer read _CanvasWidth write _CanvasWidth;
    property CanvasHeight:integer read _CanvasHeight write _CanvasHeight;
  end;

implementation

uses Controls, Math;

{ Koordinaten }

constructor TKoordinaten.create(StringGrid:TStringGrid;
                                RadioGroup:TRadioGroup);
begin
  _Punkte:=TPunkte.create(StringGrid);
  _Canvas:=nil;
  _CanvasHeight:=-1;
  _CanvasWidth:=-1;
  _Funktionen:=TFunktionen.create(_Punkte, RadioGroup);
  _MinX:=-1;
  _MaxX:=10;
  _MinY:=-1;
  _MaxY:=1;
  _SchrittX:=1;
  _SchrittY:=1;
  _MitteX:=0;
  _MitteY:=0;
  _PosiSchrittX:=0;
  _PosiSchrittY:=0;
  _PunkteVerbinden:=false;
  _KurveZeichnen:=true;
  _MarkPunkt:=-1;
  _Grad:=0;
end;

destructor TKoordinaten.destroy;
begin
  _Punkte.free;
  _Funktionen.free;
  inherited;
end;

function TKoordinaten.PointToPunkt(Point:TPoint): TPunkt;
begin
  if _PosiSchrittX <> 0 then begin
    Result.X:=(Point.X - _MitteX) / (_PosiSchrittX / _SchrittX);
    Result.Y:=(_MitteY - Point.Y) / (_PosiSchrittY / _SchrittY);
  end
  else begin
    Result.X:=0.0;
    Result.Y:=0.0;
  end;
end;

procedure TKoordinaten.PosiSchrittXberechnen;
var x:Extended;
    xPosi:integer;
    Mitte:boolean;
begin
  x:=_MinX;
  xPosi:=0;
  _PosiSchrittX:=round(_CanvasWidth / ((_MaxX - _MinX) / _SchrittX));
  Mitte:=false;
  while (x <= _MaxX) do begin
    if (x >= -0.0009) and not Mitte then begin
      Mitte:=true;
      _MitteX:=xPosi;
    end;
    x:=x + _SchrittX;
    xPosi:=xPosi + _PosiSchrittX;
  end;
end;

procedure TKoordinaten.PosiSchrittYberechnen;
var y:Extended;
    yPosi:integer;
    Mitte:boolean;
begin
  y:=_MinY;
  yPosi:=_CanvasHeight-1;
  _PosiSchrittY:=round(_CanvasHeight / ((_MaxY - _MinY) / _SchrittY));

  Mitte:=false;
  while (y <= _MaxY) do begin
    if (y >= -0.0009) and not Mitte then begin
      Mitte:=true;
      _MitteY:=yPosi;
    end;
    y:=y + _SchrittY;
    yPosi:=yPosi - _PosiSchrittY;
  end;
end;

procedure TKoordinaten.Repaint;
begin
  Kurven_zeichnen;
  Punkte_zeichnen;
end;

procedure TKoordinaten.Kurven_zeichnen;
var xPosi, yPosi, Zeige, Zeigen:integer;
    x, y:Extended;
    Mitte:boolean;
    Bez:string;
begin
  if assigned(_Canvas) and (_CanvasWidth >= 1) and (_CanvasHeight >= 1) then begin
    PosiSchrittXberechnen;
    PosiSchrittYberechnen;

    _Canvas.Brush.Color:=clWhite;
    _Canvas.FillRect(_Canvas.ClipRect);

    x:=_MinX;
    xPosi:=0;
    Mitte:=false;

    if _Canvas.TextWidth(FormatFloat('0.#', _MinX)) > _Canvas.TextWidth(FormatFloat('0.0', _MaxX)) then
      Zeigen:=((_Canvas.TextWidth(FormatFloat('0.#', _MinX))+5) div _PosiSchrittX) +1
    else
      Zeigen:=((_Canvas.TextWidth(FormatFloat('0.#', _MaxX))+5) div _PosiSchrittX) +1;

    if odd(round(abs(_MinX) / _SchrittX)) then
      Zeige:=2
    else
      Zeige:=1;
    while (x <= _MaxX) do begin
      Bez:=FormatFloat('0.#', x);
      if (x >= -0.0009) and not Mitte then begin
        Zeige:=1;
        Mitte:=true;
        _Canvas.MoveTo(xPosi, 0);
        _Canvas.LineTo(xPosi, _CanvasHeight);
      end
      else begin
        if (x > _MinX) and (x < _MaxX) then begin
          if Zeige < Zeigen then
            inc(Zeige)
          else begin
            Zeige:=1;
            _Canvas.TextOut(xPosi - (_Canvas.TextWidth(Bez) div 2),
                                     _MitteY - _Canvas.TextHeight(Bez) + 20,
                                     Bez);
          end;
        end;
      end;
      _Canvas.MoveTo(xPosi, _MitteY-5);
      _Canvas.LineTo(xPosi, _MitteY+5);
      x:=x + _SchrittX;
      xPosi:=xPosi + _PosiSchrittX;
    end;

    y:=_MinY;
    yPosi:=_CanvasHeight-1;
    Mitte:=false;
    if _Canvas.TextHeight(FormatFloat('0.#', _MinY)) > _Canvas.TextHeight(FormatFloat('0.0', _MaxY)) then
      Zeigen:=((_Canvas.TextHeight(FormatFloat('0.#', _MinY))+5) div _PosiSchrittY) +1
    else
      Zeigen:=((_Canvas.TextHeight(FormatFloat('0.#', _MaxY))+5) div _PosiSchrittY) +1;
    if odd(round(abs(_MinY) / _SchrittY)) then
      Zeige:=2
    else
      Zeige:=1;
    while (y <= _MaxY) do begin
      Bez:=FormatFloat('0.0', y);
      if (y >= -0.0009) and not Mitte then begin
        Zeige:=1;
        Mitte:=true;
        _Canvas.MoveTo(0, yPosi);
        _Canvas.LineTo(_CanvasWidth, yPosi);
      end
      else begin
        if (y > _MinY) and (y < _MaxY) then
          if Zeige < Zeigen then
            inc(Zeige)
          else begin
            Zeige:=1;
            _Canvas.TextOut(_MitteX - _Canvas.TextWidth(Bez) - 10,
                            yPosi - (_Canvas.TextHeight(Bez) div 2),
                            Bez);
          end;
      end;
      _Canvas.MoveTo(_MitteX-5, yPosi);
      _Canvas.LineTo(_MitteX+5, yPosi);
      y:=y + _SchrittY;
      yPosi:=yPosi - _PosiSchrittY;
    end;
  end;
end;

procedure TKoordinaten.Punkte_zeichnen;
var Parameter:TParameter;
    Funktion:TFunktion;
    i:integer;
    Punkt:TPunkt;
    aktPoint, oldPoint:TPoint;
    aktKurvePoint, oldKurvePoint:TPoint;
    Farbe:TColor;
    x:Extended;
begin
  if assigned(_Canvas) and (_CanvasWidth >= 1) and (_CanvasHeight >= 1) then begin
    Funktion:=nil;
    setlength(Parameter, 0);
    if _KurveZeichnen then begin
      Funktion:=_Funktionen.GetFunktion;
      if assigned(Funktion) then
        Parameter:=Funktion.Parameter(_Grad);
    end;
    for i:=1 to _Punkte.Count do begin
      Punkt:=_Punkte.Punkt[i-1];
      aktPoint:=PunktToPoint(Punkt);
      if _PunkteVerbinden then begin
        if i > 1 then begin
          _Canvas.MoveTo(oldPoint.X, oldPoint.Y);
          _Canvas.LineTo(aktPoint.X, aktPoint.Y);
        end;
        oldPoint:=aktPoint;
      end;
      if _MarkPunkt = i then
        Farbe:=clRed
      else
        Farbe:=clBlack;
      KreuzMalen(aktPoint, Farbe);
    end;
    if assigned(Funktion) and (_Punkte.Count > 1) then begin
      x:=_MinX;
      i:=1;
      while x <= _MaxX do begin
        Punkt.X:=x;
        Punkt.Y:=Funktion.y(Parameter, x);
        aktKurvePoint:=PunktToPoint(Punkt);
        if i > 1 then begin
          _Canvas.Pen.Color:=clBlue;
          _Canvas.MoveTo(oldKurvePoint.X, oldKurvePoint.Y);
          _Canvas.LineTo(aktKurvePoint.X, aktKurvePoint.Y);
          _Canvas.Pen.Color:=clBlack;
        end;
        oldKurvePoint:=aktKurvePoint;
        x:=x + (_SchrittX / 5);
        inc(i);
      end;
    end;
  end;
end;

procedure TKoordinaten.SetMaxX(const Value: Extended);
begin
  _MaxX:=Value;
  Repaint;
end;

procedure TKoordinaten.SetMaxY(const Value: Extended);
begin
  _MaxY:=Value;
  Repaint;
end;

procedure TKoordinaten.SetMinX(const Value: Extended);
begin
  _MinX:=Value;
  Repaint;
end;

procedure TKoordinaten.SetMinY(const Value: Extended);
begin
  _MinY:=Value;
  Repaint;
end;

procedure TKoordinaten.SetKreuz(Punkt:TPunkt);
begin
  _Punkte.add(Punkt.X, Punkt.Y);
  Repaint;
end;

procedure TKoordinaten.SetSchrittX(const Value: Extended);
begin
  if Value > 0.0 then begin
    _SchrittX:=Value;
    Repaint;
  end;
end;

procedure TKoordinaten.SetSchrittY(const Value: Extended);
begin
  if Value > 0.0 then begin
    _SchrittY:=Value;
    Repaint;
  end;
end;

procedure TKoordinaten.KreuzMalen(Point:TPoint; Color:TColor);
begin
  if assigned(_Canvas) and (_CanvasWidth >= 1) and (_CanvasHeight >= 1) then begin
    with _Canvas do begin
      Canvas.Pen.Color:=Color;
      Canvas.MoveTo(Point.X-2, Point.Y-2);
      Canvas.LineTo(Point.X+3, Point.Y+3);

      Canvas.MoveTo(Point.X+2, Point.Y-2);
      Canvas.LineTo(Point.X-3, Point.Y+3);
      Canvas.Pen.Color:=clBlack;
    end;
  end;
end;

function TKoordinaten.PunktToPoint(Punkt: TPunkt): TPoint;
begin
  try
    Result.X:=round((Punkt.X * (_PosiSchrittX / _SchrittX)) + _MitteX);
  except
    Result.X:=0;
  end;
  try
    Result.Y:=round(_MitteY - (Punkt.Y * (_PosiSchrittY / _SchrittY)));
  except
    Result.Y:=0;
  end;
end;

procedure TKoordinaten.Punkte_loeschen;
begin
  _Punkte.Clear;
  _MarkPunkt:=-1;
  Repaint;
end;

procedure TKoordinaten.Punkt_loeschen(index: integer);
begin
  _Punkte.Del(index);
  if _Punkte.Count = 0 then
    _MarkPunkt:=-1;
  Repaint;
end;

procedure TKoordinaten.SetMarkPunkt(const Value: integer);
begin
  _MarkPunkt:=Value;
  Punkte_zeichnen;
end;

function TKoordinaten.GetFunktion(var Funktion:TFunktion):boolean;
begin
  Funktion:=_Funktionen.GetFunktion;
  Result:=assigned(Funktion);
end;

procedure TKoordinaten.Refresh;
begin
  Repaint;
  _Punkte.Refresh;
end;

function TKoordinaten.findPunkt(var Index: integer; Point:TPoint): boolean;
var abbruch:boolean;
    i:integer;
    P:TPoint;
begin
  abbruch:=false;
  i:=0;
  while (i < _Punkte.Count) and not abbruch do begin
    P:=PunktToPoint(_Punkte.Punkt[i]);
    abbruch:=     (Point.X >= P.X - 5)
              and (Point.X <= P.X + 5)
              and (Point.Y >= P.Y - 5)
              and (Point.Y <= P.Y + 5);
    if not abbruch then
      inc(i);
  end;
  if abbruch then
    index:=i;
  Result:=abbruch;
end;

function TKoordinaten.GradDesZusammenhangs: Extended;
var ZaehlerSumme, NennerSumme1, NennerSumme2:Extended;
    Mittelwert:TPunkt;
    i:integer;
begin
  if _Punkte.Count > 0 then begin
    ZaehlerSumme:=0.0;
    NennerSumme1:=0.0;
    NennerSumme2:=0.0;

    Mittelwert:=_Punkte.Mittelwert;
    for i:=1 to _Punkte.Count do begin
      ZaehlerSumme:=ZaehlerSumme + ((_Punkte.Punkt[i-1].X - Mittelwert.X) * (_Punkte.Punkt[i-1].Y - Mittelwert.Y));
      NennerSumme1:=NennerSumme1 + Power(_Punkte.Punkt[i-1].X - Mittelwert.X, 2);
      NennerSumme2:=NennerSumme2 + Power(_Punkte.Punkt[i-1].Y - Mittelwert.Y, 2);
    end;

    if NennerSumme1 * NennerSumme2 <> 0 then
      Result:=ZaehlerSumme / sqrt(NennerSumme1 * NennerSumme2)
    else
      Result:=0.0;
  end
  else Result:=0.0;
end;

end.
