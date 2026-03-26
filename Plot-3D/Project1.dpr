program Project1;
{
  (c) 2007-2008 by omata (http://www.delphipraxis.net)
}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  RegExprU in 'RegExprU.pas',
  PunkteU in 'PunkteU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.