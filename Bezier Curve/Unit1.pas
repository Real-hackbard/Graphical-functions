unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, XPMan;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    E0X: TEdit;
    Label2: TLabel;
    E0Y: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    E1X: TEdit;
    Label5: TLabel;
    E1Y: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    E2X: TEdit;
    Label8: TLabel;
    E2Y: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    E3X: TEdit;
    Label11: TLabel;
    E3Y: TEdit;
    Label12: TLabel;
    BtnApplyCoord: TBitBtn;
    Panel3: TPanel;
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure BtnApplyCoordClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure E0XKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    // Array with the 4 points...
    Arr_pt: Array[0..3] Of TPoint;

    // Determining whether we are changing the position of a point...
    DraggingPt: Boolean;
    // Knowing which point is being moved...
    IndDraggingPt: Integer;

    // Allows you to determine if a point exists at coordinates x, y...
    function PontoEm(x, y: Integer; Ponto: TPoint): Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnApplyCoordClick(Sender: TObject);
begin
  Arr_pt[0] := Point(StrToInt(E0X.Text), StrToInt(E0Y.Text));
  Arr_pt[1] := Point(StrToInt(E1X.Text), StrToInt(E1Y.Text));
  Arr_pt[2] := Point(StrToInt(E2X.Text), StrToInt(E2Y.Text));
  Arr_pt[3] := Point(StrToInt(E3X.Text), StrToInt(E3Y.Text));

  PaintBox1.Refresh;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  DraggingPt := False;
  BtnApplyCoord.OnClick(Nil);   // Initialization of points ...
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
    // Draw a dot...
    procedure DesenharPonto(Ponto: TPoint; CorPen: TColor; CorBrush: TColor);
    begin
      PaintBox1.Canvas.Pen.Color   := CorPen;
      PaintBox1.Canvas.Brush.Color := CorBrush;
      PaintBox1.Canvas.Rectangle(Ponto.X-2, Ponto.Y-2, Ponto.X+2, Ponto.Y+2);
    end;

    // MoveTo ...
    procedure MoverPara(Ponto: TPoint);
    begin
      PaintBox1.Canvas.MoveTo(Ponto.x, Ponto.Y);
    end;

    // Draw a line between two points...
    procedure Linha(PontoInicial: TPoint; PontoFinal: TPoint; Cor: TColor);
    begin
      PaintBox1.Canvas.Pen.Color := Cor;
      MoverPara(PontoInicial);
      PaintBox1.Canvas.LineTo(PontoFinal.X, PontoFinal.Y);
    end;

begin
  With PaintBox1.Canvas Do
  begin
    Brush.Color := clWhite;
    Pen.Color   := clBlack;
    FillRect(PaintBox1.ClientRect);

    PolyBezier(Arr_pt);

    Linha(Arr_pt[0], Arr_pt[1], clRed);          // P1 and P2 ...
    Linha(Arr_pt[3], Arr_pt[2], clRed);          // P4 and P3 ...

    DesenharPonto(Arr_pt[0], clBlack, clYellow);
    DesenharPonto(Arr_pt[1], clBlack, clBlack);
    DesenharPonto(Arr_pt[2], clBlack, clBlack);
    DesenharPonto(Arr_pt[3], clBlack, clYellow);
  end;
end;

function  TForm1.PontoEm(x, y: Integer; Ponto: TPoint): Boolean;
begin
  RESULT := (Ponto.X >= x-2) And (Ponto.X <= x+2)
              And (Ponto.y >= y-2) And (Ponto.y <= y+2);
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DraggingPt := False;

  If PontoEm(x, y, Arr_pt[0])
  Then Begin
    DraggingPt := True;
    IndDraggingPt := 0;
    StatusBar1.Panels[3].Text := IntToStr(x) + 'x' + IntToStr(y);
  End;

  If PontoEm(x, y, Arr_pt[1])
  Then Begin
    DraggingPt := True;
    IndDraggingPt := 1;
    StatusBar1.Panels[5].Text := IntToStr(x) + 'x' + IntToStr(y);
  End;

  If PontoEm(x, y, Arr_pt[2])
  Then Begin
    DraggingPt := True;
    IndDraggingPt := 2;
    StatusBar1.Panels[7].Text := IntToStr(x) + 'x' + IntToStr(y);
  End;

  If PontoEm(x, y, Arr_pt[3])
  Then Begin
    DraggingPt := True;
    IndDraggingPt := 3;
    StatusBar1.Panels[9].Text := IntToStr(x) + 'x' + IntToStr(y);
  End;

  If DraggingPt
  Then PaintBox1.Cursor := crHandPoint;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  StatusBar1.Panels[1].Text := IntToStr(x) + 'x' + IntToStr(y);
  If DraggingPt Then
  Begin
    Arr_pt[IndDraggingPt] := Point(x, y);
    TEdit( FindComponent('E' + IntToStr(IndDraggingPt)+ 'X') ).Text := IntToStr(x);
    TEdit( FindComponent('E' + IntToStr(IndDraggingPt)+ 'Y') ).Text := IntToStr(y);
    PaintBox1Paint(Nil);
  End
  Else
    If PontoEm(x, y, Arr_pt[0]) Or PontoEm(x, y, Arr_pt[1])
      Or PontoEm(x, y, Arr_pt[2]) Or PontoEm(x, y, Arr_pt[3])
    Then PaintBox1.Cursor := crHandPoint
    Else PaintBox1.Cursor := crDefault;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If DraggingPt
  Then Begin
    // Position the bridge at no certain position...
    PaintBox1MouseMove(PaintBox1, Shift, x, y);
    DraggingPt := False;
    PaintBox1.Cursor := crDefault;
  End;
end;

procedure TForm1.E0XKeyPress(Sender: TObject; var Key: Char);
begin
  if NOT (Key in [#08, '0'..'9']) then 
    Key := #0; 
end;

end.
