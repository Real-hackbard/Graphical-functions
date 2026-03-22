program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  WurfCls in 'WurfCls.pas',
  GridCls in 'GridCls.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
