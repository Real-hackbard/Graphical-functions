unit FunktionenU;

interface

uses SysUtils, PunkteU, ExtCtrls, math;

const
  ExcelGenauigkeit = '0.000000000000000';

type
  TExcelSprache = (esDeutsch, esEnglisch);
  TParameter = array of Extended;
  TGaussMatrix = array of TParameter;

  TFunktion = class
  private
    _FormelText:string;
    _Punkte:TPunkte;
    function ExcelDeutsch2Englisch(Formel:string):string;
  public
    constructor create(FormelText:string; Punkte:TPunkte);
    function Parameter(Grad:byte = 0):TParameter; virtual;
    function y(Parameter:TParameter; x:Extended):Extended; virtual; abstract;
    function ZaehlerFormel(Punkt:TPunkt):Extended; virtual; abstract;
    function NennerFormel(Punkt:TPunkt):Extended; virtual; abstract;
    function Formel(Parameter:TParameter):string; virtual;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; virtual; abstract;
    property FormelText:string read _FormelText;
  end;

  TFunktionsTyp1 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp2 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp3 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp4 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp5 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp6 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionsTyp7 = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionBeliebigenGrades = class(TFunktion)
  private
  public
    constructor create(Punkte:TPunkte);
    function Parameter(Grad:byte):TParameter; override;
    function y(Parameter:TParameter; x:Extended):Extended; override;
    function ZaehlerFormel(Punkt:TPunkt):Extended; override;
    function NennerFormel(Punkt:TPunkt):Extended; override;
    function Formel(Parameter:TParameter):string; override;
    function ExcelFormel(Parameter:TParameter;
                         Zelle:string;
                         ExcelSprache:TExcelSprache):string; override;
  end;

  TFunktionen = class
  private
    _RadioGroup: TRadioGroup;
  public
    constructor create(Punkte:TPunkte; RadioGroup:TRadioGroup);
    destructor destroy; override;
    function GetFunktion:TFunktion;
  end;

implementation

{ TFunktion }

function TFunktion.Parameter(Grad:byte): TParameter;
var i:integer;
    Zaehler, Nenner:Extended;
begin
  if _Punkte.Count > 0 then begin
    setlength(Result, 1);
    Zaehler:=0.0;
    Nenner:=0.0;
    for i:=1 to _Punkte.Count do begin
      Zaehler:=Zaehler + ZaehlerFormel(_Punkte.Punkt[i-1]);
      Nenner:=Nenner + NennerFormel(_Punkte.Punkt[i-1]);
    end;
    try
      Result[0]:=Zaehler / Nenner;
    except
      Result[0]:=0.0;
    end;
  end
  else setlength(Result, 0);
end;

constructor TFunktion.create(FormelText:string; Punkte:TPunkte);
begin
  _FormelText:=FormelText;
  _Punkte:=Punkte;
end;

function TFunktion.Formel(Parameter: TParameter): string;
begin
  if length(Parameter) = 1 then
    Result:=Stringreplace(
      _FormelText, 'a', FormatFloat('0.000', Parameter[0]), [rfReplaceAll]
    )
  else
    Result:='';
end;

function TFunktion.ExcelDeutsch2Englisch(Formel: string): string;
begin
  Result:=StringReplace(Formel, 'PRODUKT', 'PRODUCT', [rfReplaceAll]);
  Result:=StringReplace(Result, 'POTENZ', 'POWER', [rfReplaceAll]);
  Result:=StringReplace(Result, 'WURZEL', 'SQRT', [rfReplaceAll]);
  Result:=StringReplace(Result, ',', '.', [rfReplaceAll]);
  Result:=StringReplace(Result, ';', ',', [rfReplaceAll]);
end;

{ TFunktionen }

constructor TFunktionen.create(Punkte:TPunkte; RadioGroup: TRadioGroup);
var Funktion:TFunktion;
begin
  _RadioGroup:=RadioGroup;
  RadioGroup.Items.Clear;
  Funktion:=TFunktionsTyp1.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp2.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp3.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp4.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp5.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp6.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionsTyp7.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
  Funktion:=TFunktionBeliebigenGrades.create(Punkte);
  RadioGroup.Items.AddObject(Funktion.FormelText, Funktion);
end;

destructor TFunktionen.destroy;
var i:integer;
    FunktionObject:TObject;
begin
  for i:=1 to _RadioGroup.Items.Count do begin
    FunktionObject:=_RadioGroup.Items.Objects[i-1];
    if FunktionObject is TFunktionsTyp1 then
      TFunktionsTyp1(FunktionObject).free
    else if FunktionObject is TFunktionsTyp2 then
      TFunktionsTyp2(FunktionObject).free
    else if FunktionObject is TFunktionsTyp3 then
      TFunktionsTyp3(FunktionObject).free
    else if FunktionObject is TFunktionsTyp4 then
      TFunktionsTyp4(FunktionObject).free
    else if FunktionObject is TFunktionsTyp5 then
      TFunktionsTyp5(FunktionObject).free
    else if FunktionObject is TFunktionsTyp6 then
      TFunktionsTyp6(FunktionObject).free
    else if FunktionObject is TFunktionsTyp7 then
      TFunktionsTyp7(FunktionObject).free
    else if FunktionObject is TFunktionBeliebigenGrades then
      TFunktionBeliebigenGrades(FunktionObject).free;
  end;
  inherited;
end;

function TFunktionen.GetFunktion: TFunktion;
begin
  if _RadioGroup.ItemIndex >= 0 then
    Result:=TFunktion(_RadioGroup.Items.Objects[_RadioGroup.ItemIndex])
  else
    Result:=nil;
end;

{ FFunktionsTyp1 }

constructor TFunktionsTyp1.create(Punkte:TPunkte);
begin
  inherited create('y = a * x', Punkte);
end;

function TFunktionsTyp1.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Punkt.X * Punkt.Y;
end;

function TFunktionsTyp1.NennerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Power(Punkt.X, 2);
end;

function TFunktionsTyp1.y(Parameter:TParameter; x:Extended): Extended;
begin
  if length(Parameter) = 1 then
    Result:=Parameter[0] * x
  else
    Result:=0.0;
end;

function TFunktionsTyp1.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=PRODUKT(%s; %s)',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp2 }

constructor TFunktionsTyp2.create(Punkte:TPunkte);
begin
  inherited create('y = a * x²', Punkte);
end;

function TFunktionsTyp2.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then
    Result:=Parameter[0] * Power(x, 2)
  else
    Result:=0.0;
end;

function TFunktionsTyp2.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Power(Punkt.X, 2) * Punkt.Y;
end;

function TFunktionsTyp2.NennerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Power(Punkt.X, 4);
end;

function TFunktionsTyp2.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=PRODUKT(%s; POTENZ(%s; 2))',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp3 }

constructor TFunktionsTyp3.create;
begin
  inherited create('y = a / x', Punkte);
end;

function TFunktionsTyp3.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then begin
    try
      Result:=Parameter[0] / x;
    except
      Result:=0.0;
    end;
  end
  else Result:=0.0;
end;

function TFunktionsTyp3.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Punkt.Y / Punkt.X;
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp3.NennerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=1 / Power(Punkt.X, 2);
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp3.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=%s / %s',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp4 }

constructor TFunktionsTyp4.create;
begin
  inherited create('y = a * SQRT(x)', Punkte);
end;

function TFunktionsTyp4.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then begin
    try
      Result:=Parameter[0] * sqrt(x);
    except
      Result:=0.0;
    end;
  end
  else Result:=0.0;
end;

function TFunktionsTyp4.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=sqrt(Punkt.X) * Punkt.Y;
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp4.NennerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Punkt.X;
end;

function TFunktionsTyp4.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=PRODUKT(%s; WURZEL(%s))',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp5 }

constructor TFunktionsTyp5.create;
begin
  inherited create('y = a * LN(x)', Punkte);
end;

function TFunktionsTyp5.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then begin
    try
      Result:=Parameter[0] * Ln(x);
    except
      Result:=0.0;
    end;
  end
  else Result:=0.0;
end;

function TFunktionsTyp5.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Ln(Punkt.X) * Punkt.Y;
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp5.NennerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Power(Ln(Punkt.X), 2);
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp5.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=PRODUKT(%s; LN(%s))',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp6 }

constructor TFunktionsTyp6.create;
begin
  inherited create('y = e^(a*x)', Punkte);
end;

function TFunktionsTyp6.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then begin
    try
      Result:=exp(Parameter[0]*x);
    except
      Result:=0.0;
    end;
  end
  else Result:=0.0;
end;

function TFunktionsTyp6.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Punkt.X * Ln(Punkt.Y);
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp6.NennerFormel(Punkt: TPunkt): Extended;
begin
  Result:=Power(Punkt.X, 2);
end;

function TFunktionsTyp6.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=EXP(%s * %s)',
      [FormatFloat(ExcelGenauigkeit, Parameter[0]), Zelle]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionsTyp7 }

constructor TFunktionsTyp7.create(Punkte: TPunkte);
begin
  inherited create('y = x^a', Punkte);
end;

function TFunktionsTyp7.y(Parameter:TParameter; x: Extended): Extended;
begin
  if length(Parameter) = 1 then begin
    try
      Result:=Power(x, Parameter[0]);
{      if x > 0 then
        Result:=exp(abs(Parameter[0])*ln(abs(x)))
      else
        Result:=0.0;}
    except
      Result:=0.0;
    end;
  end
  else Result:=0.0;
end;

function TFunktionsTyp7.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Ln(Punkt.Y) * Ln(Punkt.X);
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp7.NennerFormel(Punkt: TPunkt): Extended;
begin
  try
    Result:=Power(Ln(abs(Punkt.X)), 2);
  except
    Result:=0.0;
  end;
end;

function TFunktionsTyp7.ExcelFormel(Parameter: TParameter;
                                    Zelle:string;
                                    ExcelSprache:TExcelSprache): string;
begin
  Result:='';
  if length(Parameter) = 1 then
    Result:=Format(
      '=POTENZ(%s; %s)',
      [Zelle, FormatFloat(ExcelGenauigkeit, Parameter[0])]
    );
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

{ TFunktionBeliebigenGrades }

constructor TFunktionBeliebigenGrades.create(Punkte: TPunkte);
begin
  inherited create('beliebiger Grad', Punkte);
end;

function TFunktionBeliebigenGrades.ZaehlerFormel(Punkt: TPunkt): Extended;
begin
  Result:=0.0;
end;

function TFunktionBeliebigenGrades.NennerFormel(Punkt: TPunkt): Extended;
begin
  Result:=0.0;
end;

function TFunktionBeliebigenGrades.Parameter(Grad:byte): TParameter;
  function LinearSystemLoesen(A: TGaussMatrix; m, n: Integer): TParameter;
  var i, j, k: Integer;
      Pivot: TParameter;
      PivotRow: Integer;
      Multiplicator, Sum: Extended;
      abbruch:boolean;
  begin
    SetLength(A, m, n);
    abbruch:=false;
    for i := 0 to m - 1 do begin
      // Vorwärtselimination
      for j := i to m  - 2 do begin
        if (A[j, j] = 0) then begin
          // Pivotisierung
          SetLength(Pivot, n + 1);
          Pivot := A[j];
          PivotRow := 0;
          for k := j + 1 to m - 1 do begin
            if (Abs(A[k, j]) > Abs(Pivot[j])) then begin
              Pivot := A[k];
              PivotRow := k;
            end;
            if (PivotRow > 0) then begin
              A[PivotRow] := A[j];
              A[j] := Pivot;
            end
            else abbruch:=true;
          end;
        end;
        if not abbruch then begin
          try
            Multiplicator := A[j + 1, i] / A[i, i];
            for k := i to n - 1 do
              A[j + 1, k] := A[j + 1, k] - (Multiplicator * A[i, k]);
          except
            abbruch:=true;
          end;
        end;
      end;
    end;
    if not abbruch then begin
      // Rückwärtssubstitution
      SetLength(Result, m);
      for i := m - 1 downto 0 do begin
        Sum := 0;
        for k := i to m - 1 do
          Sum := Sum + Result[k] * A[i, k] / A[i, i];
        Result[i] := A[i, n - 1] / A[i, i] - Sum;
      end;
    end;
  end;
  // ***************************************************************************

  function SummeX(XExponent:integer):Extended;
  var i:integer;
  begin
    Result:=0.0;
    for i:=1 to _Punkte.Count do
      Result:=Result + power(_Punkte.Punkt[i-1].X, XExponent);
  end;

  function SummeYX(XExponent:integer):Extended;
  var i:integer;
  begin
    Result:=0.0;
    for i:=1 to _Punkte.Count do
      Result:=
        Result + (_Punkte.Punkt[i-1].Y * power(_Punkte.Punkt[i-1].X, XExponent));
  end;

var i, j: Integer;
    A: TGaussMatrix;
begin
  if _Punkte.Count > 1 then begin
    SetLength(A, Grad+1, Grad+2);
    for i:=1 to Grad+1 do begin
      for j:=1 to Grad+1 do
        A[i-1][j-1]:=SummeX((i-1)+(j-1));
      A[i-1][Grad+1]:=SummeYX(i-1);
    end;
    Result := LinearSystemLoesen(A, Grad+1, Grad+2);
  end
  else setlength(Result, 0);
end;

function TFunktionBeliebigenGrades.y(Parameter:TParameter;
                                     x: Extended): Extended;
var i:integer;
begin
  Result:=0.0;
  for i:=1 to length(Parameter) do
    Result:=Result + (Parameter[i-1] * power(x, i-1));
end;

function TFunktionBeliebigenGrades.Formel(Parameter: TParameter): string;
var i:integer;
begin
  Result:='';
  if length(Parameter) > 0 then begin
    for i:=1 to length(Parameter) do begin
      if Parameter[i-1] >= 0 then
        Result:=Format(
          '+ %sx^%d ', [FormatFloat('0.000', Parameter[i-1]), i-1]
        ) + Result
      else
        Result:=Format(
          '- %sx^%d ', [FormatFloat('0.000', abs(Parameter[i-1])), i-1]
        ) + Result;
    end;
    Result:='y = ' + copy(Result, 3, length(Result));
  end;
end;

function TFunktionBeliebigenGrades.ExcelFormel(Parameter: TParameter;
                                               Zelle:string;
                                               ExcelSprache:TExcelSprache): string;
var i:integer;
    Wert:Extended;
    Z, P:string;
begin
  Result:='';
  if length(Parameter) > 0 then begin
    for i:=1 to length(Parameter) do begin
      if Parameter[i-1] >= 0 then begin
        Wert:=Parameter[i-1];
        Z:='+';
      end
      else begin
        Wert:=abs(Parameter[i-1]);
        Z:='-';
      end;
      if i = 1 then
        P:='1'
      else
        P:=Format('POTENZ(%s; %d)', [Zelle, i-1]);
      Result:=Format(
        '%s PRODUKT(%s; %s) ',
        [Z, FormatFloat(ExcelGenauigkeit, Wert), P]
      ) + Result;
    end;
    Result:='=' + copy(Result, 3, length(Result));
  end;
  if ExcelSprache = esEnglisch then
    Result:=ExcelDeutsch2Englisch(Result);
end;

end.
