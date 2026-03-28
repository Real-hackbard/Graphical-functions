program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {PolyLineDemoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TPolyLineDemoForm, PolyLineDemoForm);
  Application.Run;
end.
