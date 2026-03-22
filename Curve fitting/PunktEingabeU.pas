unit PunktEingabeU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PunkteU;

type
  TFPunktEingabe = class(TForm)
    EdX: TEdit;
    EdY: TEdit;
    BtnOK: TButton;
    BtnAbbruch: TButton;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    constructor create(AOwner:TComponent; Punkt:TPunkt); reintroduce;
    function GetPunkt:TPunkt;
  end;

var
  FPunktEingabe: TFPunktEingabe;

implementation

{$R *.dfm}

{ TFPunktEingabe }

constructor TFPunktEingabe.create(AOwner: TComponent; Punkt:TPunkt);
begin
  inherited create(AOwner);
  EdX.Text:=FormatFloat('0.000', Punkt.X);
  EdY.Text:=FormatFloat('0.000', Punkt.Y);
end;

function TFPunktEingabe.GetPunkt: TPunkt;
var Value:double;
begin
  if TryStrToFloat(EdX.Text, Value) then
    Result.X:=Value
  else
    Result.X:=0;
  if TryStrToFloat(EdY.Text, Value) then
    Result.Y:=Value
  else
    Result.Y:=0;
end;

end.
