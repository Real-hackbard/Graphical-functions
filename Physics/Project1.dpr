//------------------------------------------------------------------------
//
// Author      : Michael Pote
// Email       : michaelpote@eject.co.za
// Website     : http://www.sulaco.co.za
//
// Date        :
// Version     : 1.0
// Description : Worms!
//
//------------------------------------------------------------------------
program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
