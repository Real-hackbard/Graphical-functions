program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ugraph in 'ugraph.pas' {FGraph};

{$R *.RES}
{$R inversion.RES}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFGraph, FGraph);
  Application.Run;
end.
