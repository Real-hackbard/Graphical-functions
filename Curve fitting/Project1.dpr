program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  KoordinatenU in 'KoordinatenU.pas',
  PunkteU in 'PunkteU.pas',
  FunktionenU in 'FunktionenU.pas',
  PunktEingabeU in 'PunktEingabeU.pas' {FPunktEingabe},
  QReportU in 'QReportU.pas' {QReport: TQuickRep};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
