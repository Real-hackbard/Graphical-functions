unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Math, ComCtrls, XPMan;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Label3: TLabel;
    Memo3: TMemo;
    Label2: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    Label5: TLabel;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Memo1Change(Sender: TObject);
    procedure Memo3Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Declarations privates }
    XAxisCoord, YAxisCoord, savX, savY: Integer;
  public
    { Declarations public }
  end;

var
  Form1: TForm1;

implementation

uses
  MathParser;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  //XAxisCoord := Image1.Height div 2;
  //YAxisCoord := Image1.Width div 2;
  //MemExprsChange(nil);
  //MemGrafChange(nil);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  savX := X;
  savY := Y;

  if CheckBox2.Checked = true then
  begin
    image1.Canvas.Font.Color := clGray;
    image1.Canvas.TextOut((Image1.Width div 2) + 5, 5,'(Y-' +
                           IntToStr(Image1.Height) + ')');
    image1.Canvas.TextOut(5, (Image1.Height div 2) - 17,'(X-' +
                           IntToStr(Image1.Width) + ')');
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  YAxisCoord := YAxisCoord + (X - savX);
  XAxisCoord := XAxisCoord + (Y - savY);
  Memo3Change(nil);
end;

procedure TForm1.Memo1Change(Sender: TObject);
var
 i:integer;
 CurrentLine, CurrentExpression, Variable: String;
 MathParser: TMathParser;
begin
 Memo2.Clear;
 MathParser := TMathParser.create;

 for i:=0 to Memo1.Lines.Count-1 do
 begin
   CurrentLine := Memo1.Lines[i];

   // If there is an = sign, it is an assignment of a value to a variable:
   if pos('=', CurrentLine) <> 0
   then begin
     // we cut in half around the =
     Variable := trim(copy(CurrentLine, 1, pos('=', CurrentLine)-1));
     CurrentExpression := copy(CurrentLine, pos('=', CurrentLine)+1,length(CurrentLine));

     // Not all names are valid, WARNING!!!!
     if not ValidVariableName(Variable)
     then begin
       Memo2.Lines.add('Invalid variable name');
       Continue;  // Return to the "for" ...
     end;
    end
   else begin
     // Otherwise, it's a simple expression to calculate.
     Variable := '';
     CurrentExpression := CurrentLine;
   end;

   MathParser.Expression := CurrentExpression;
   MathParser.Parse;       // We evaluate the expression

   if MathParser.GetLastError = 0
   then begin
     // if it's an assignment
     if Variable <> ''
     then begin
       // The result is displayed and stored:
       Memo2.Lines.Add(Variable + '=' + FloatToStr(MathParser.ParserResult));
       MathParser.Variables.SetValue(Variable, MathParser.ParserResult);
     end
     else
     // Otherwise, we just display the result.
       Memo2.Lines.Add(FloatToStr(MathParser.ParserResult));
   end
   else
     Memo2.Lines.add(MathParser.GetLastErrorString);
 end;

 MathParser.Free;
end;

procedure TForm1.Memo3Change(Sender: TObject);
var
  pX, pY, j: integer;
  x, fx: Extended;
  MathParser: TMathParser;
begin
  Label5.Caption := IntToStr(TrackBar1.Position) + ' %';

  // Frame image:
  if CheckBox1.Checked = true then
  begin
    image1.Canvas.Rectangle(image1.ClientRect);
  end;

  // Draw the axes:
  image1.canvas.Pen.Color:=clgray;
  image1.Canvas.MoveTo(0, XAxisCoord);

  // Cross Coordinates
  if CheckBox2.Checked = true then
  begin
    image1.Canvas.LineTo(Image1.Width, XAxisCoord);
    image1.Canvas.MoveTo(YAxisCoord, 0);
    image1.Canvas.LineTo(YAxisCoord, Image1.Height);

    image1.Canvas.Font.Color := clGray;
    image1.Canvas.TextOut((Image1.Width div 2) + 5, 5,'(Y-' +
                           IntToStr(Image1.Height) + ')');
    image1.Canvas.TextOut(5, (Image1.Height div 2) - 17,'(X-' +
                           IntToStr(Image1.Width) + ')');
  end;

  MathParser := TMathParser.create;

  for j := 0 to Memo3.Lines.Count-1 do
  begin
    MathParser.Expression := Memo3.lines[j];
    if MathParser.GetLastError <> 0 then continue;

    for pX := 0 to Image1.Width do
    begin
      // Define the value of x:
      x := (pX - YAxisCoord) / TrackBar1.Position;
      MathParser.Variables.SetValue('x', x);
      // Calculate f(x):
      MathParser.Parse;

      if MathParser.GetLastError = 0
      then begin
       fx := MathParser.ParserResult;
       pY := Round( -(-XAxisCoord + fx * TrackBar1.Position) );
       image1.Canvas.Pixels[pX, pY] := clBlue;
      end
      else
        if MathParser.GetLastError < cCalcError  // Error in the expression
        then
        begin
          image1.Canvas.Font.Color := clRed;
          image1.Canvas.TextOut(2, 2 + j * 16, MathParser.GetLastErrorString);
          Break;
        end;
    end;
  end;
  MathParser.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  bmp : TBitmap;
begin
  if SaveDialog1.Execute then
  begin
    try
      bmp := TBitmap.Create;
      bmp.Assign(Image1.Picture.Bitmap);
      bmp.PixelFormat := pf24bit;
      bmp.SaveToFile(SaveDialog1.FileName + '.bmp');
    finally
      bmp.Free;
    end;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  x,y : integer;
begin
  Image1.Picture.Graphic := nil;
  XAxisCoord := Image1.Height div 2;
  YAxisCoord := Image1.Width div 2;
  Memo1Change(nil);
  Memo3Change(nil);

  if CheckBox2.Checked = true then
  begin
    image1.Canvas.Font.Color := clGray;
    image1.Canvas.TextOut((Image1.Width div 2) + 5, 5,'(Y-' +
                           IntToStr(Image1.Height) + ')');
    image1.Canvas.TextOut(5, (Image1.Height div 2) - 17,'(X-' +
                           IntToStr(Image1.Width) + ')');
  end;

  Application.ProcessMessages;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  Memo3Change(Sender);
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Image1.Picture.Graphic := nil;
  Memo3Change(Sender);
  Form1.OnResize(sender);
end;

end.
