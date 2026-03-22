unit WurfCls;

interface

uses
  Math;

type
  TDoubleArray = array of Double;

type
  TWurf = class(TObject)
  private
    FTable: TDoubleArray; // Score table for throwing lane
    Fs_max: Double;
    Fh_max: Double;
    Ft_h_max: Double;
    Fs_h_max: Double;
  public
    procedure CalcThrow(MaxSteps: Integer; v0: Integer; Angle, Height: Double;
      Gravity: Double); //  Calculate trajectory, fill in the table of values
    property Table: TDoubleArray read FTable; //  Score table for throwing lane
    property s_max: Double read Fs_max;
    property h_max: Double read Fh_max;
    property t_h_max: Double read Ft_h_max;
    property s_h_max: Double read Fs_h_max;
  end;

implementation



////////////////////////////////////////////////////////////////////////////////
//
//  TWurf.CalcThrow
//    Wurfbahn berechnen, Wertetabelle erstellen
//
procedure TWurf.CalcThrow(MaxSteps: Integer; v0: Integer; Angle, Height: Double;
  Gravity: Double);
var
  Loop         : Integer;
//  h_time       : Double;
begin
  Fs_max := (v0 * v0 * sin(2 * DegToRad(Angle))) / Gravity + Height;
  Fh_max := (sqr(v0) * sqr(sin(DegToRad(Angle)))) / (2 * Gravity) + Height;
  Ft_h_max := (v0 * sin(DegToRad(Angle))) / Gravity;
  Fs_h_max := v0 * Ft_h_max * cos(DegToRad(Angle));
  setlength(FTable, MaxSteps);
  for Loop := 0 to MaxSteps - 1 do
  begin
    FTable[Loop] := tan(DegToRad(Angle)) * Loop - ((Gravity) / (2 *
      sqr(v0) * sqr(cos(DegToRad(Angle)))) * sqr(Loop)) + Height;
  end;
end;

end.

