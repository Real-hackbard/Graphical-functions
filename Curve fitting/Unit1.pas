unit Unit1;

interface

uses
  Windows, Messages, Excel2000, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, KoordinatenU, Grids, Menus, FunktionenU,
  Spin, Math, printers;

type
  TForm1 = class(TForm)
    PopupMenu: TPopupMenu;
    Menu_PunktLoeschen: TMenuItem;
    Panel1: TPanel;
    LaPosition: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnLoeschen: TButton;
    CbPunkteVerbinden: TCheckBox;
    RgFunktionen: TRadioGroup;
    CbKurveZeichnen: TCheckBox;
    EdMinX: TEdit;
    EdMaxX: TEdit;
    EdSchrittX: TEdit;
    EdMinY: TEdit;
    EdMaxY: TEdit;
    EdSchrittY: TEdit;
    Label7: TLabel;
    EdGrad: TSpinEdit;
    MeParameter: TMemo;
    Splitter1: TSplitter;
    BtnDrucken: TButton;
    LaZusammenhang: TLabel;
    Panel3: TPanel;
    Panel2: TPanel;
    Image: TImage;
    StringGrid: TStringGrid;
    Panel4: TPanel;
    EdFormel: TEdit;
    EdExcelFormel: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnLoeschenClick(Sender: TObject);
    procedure CbPunkteVerbindenClick(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure StringGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Menu_PunktLoeschenClick(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure RgFunktionenClick(Sender: TObject);
    procedure CbKurveZeichnenClick(Sender: TObject);
    procedure EdMaxKeyPress(Sender: TObject; var Key: Char);
    procedure EdSchrittKeyPress(Sender: TObject; var Key: Char);
    procedure EdMinXChange(Sender: TObject);
    procedure EdMaxXChange(Sender: TObject);
    procedure EdSchrittXChange(Sender: TObject);
    procedure EdMinYChange(Sender: TObject);
    procedure EdMaxYChange(Sender: TObject);
    procedure EdSchrittYChange(Sender: TObject);
    procedure EdMinKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridDblClick(Sender: TObject);
    procedure EdXExit(Sender: TObject);
    procedure EdYExit(Sender: TObject);
    procedure PaintBoxDblClick(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EdGradChange(Sender: TObject);
    procedure BtnDruckenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    FKoordinaten:TKoordinaten;
    FMouseX, FMouseY:integer;
    FPunktAendern:integer;
    procedure ParameterAausgeben;
    procedure MyRepaint;
    procedure MyRefresh;
    procedure ZusammenhangAusgeben;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses PunkteU, PunktEingabeU, QReportU;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FKoordinaten:=TKoordinaten.create(StringGrid, RgFunktionen);
  FMouseX:=-1;
  FMouseY:=-1;
  FPunktAendern:=-1;
  LaPosition.Caption:='';
  EdMinX.Text:='-10';
  EdMaxX.Text:='10';
  EdSchrittX.Text:='1';
  EdMinY.Text:='-10';
  EdMaxY.Text:='10';
  EdSchrittY.Text:='1';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FKoordinaten.free;
end;

procedure TForm1.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
                                   X, Y: Integer);
var Punkt:TPunkt;
    index:integer;
begin
  FMouseX:=X;
  FMouseY:=Y;
  Punkt:=FKoordinaten.PointToPunkt(Point(X, Y));
  if FKoordinaten.findPunkt(index, Point(X, Y)) then begin
    FKoordinaten.MarkPunkt:=index+1;
    FKoordinaten.Punkte_zeichnen;
  end;
  LaPosition.caption:='X: '+FormatFloat('0.000', Punkt.X)+ ' / '+
                      'Y: '+FormatFloat('0.000', Punkt.Y);
end;

procedure TForm1.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Punkt:TPunkt;
    index:integer;
begin
  if Button = mbLeft then begin
    index:=-1;
    if     FKoordinaten.findPunkt(index, Point(X, Y))
       and (index+1 = FKoordinaten.MarkPunkt) then begin
      FPunktAendern:=index;
    end
    else begin
      Punkt:=FKoordinaten.PointToPunkt(Point(X, Y));
      FKoordinaten.SetKreuz(Punkt);
      ParameterAausgeben;
    end;
  end;
end;

procedure TForm1.BtnLoeschenClick(Sender: TObject);
begin
  FKoordinaten.Punkte_loeschen;
  ParameterAausgeben;
end;

procedure TForm1.CbPunkteVerbindenClick(Sender: TObject);
begin
  FKoordinaten.PunkteVerbinden:=
    CbPunkteVerbinden.Checked;
  MyRepaint;
end;

procedure TForm1.PopupMenuPopup(Sender: TObject);
var Col, Row:integer;
begin
  Menu_PunktLoeschen.Enabled:=false;
  if (FMouseX >= 0) and (FMouseY >= 0) then begin
    StringGrid.MouseToCell(FMouseX, FMouseY, Col, Row);
    if (Col > 0) and (Row >= 0) then
      Menu_PunktLoeschen.Enabled:=(StringGrid.Cells[Col, 0] <> '');
  end;
end;

procedure TForm1.StringGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  FMouseX:=X;
  FMouseY:=Y;
end;

procedure TForm1.Menu_PunktLoeschenClick(Sender: TObject);
var Col, Row:integer;
begin
  Menu_PunktLoeschen.Enabled:=false;
  if (FMouseX >= 0) and (FMouseY >= 0) then begin
    StringGrid.MouseToCell(FMouseX, FMouseY, Col, Row);
    if (Col > 0) and (Row >= 0) then
      FKoordinaten.Punkt_loeschen(Col);
  end;
end;

procedure TForm1.StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (ACol > 0) and (ARow >= 0) then
    FKoordinaten.MarkPunkt:=ACol;
end;

procedure TForm1.RgFunktionenClick(Sender: TObject);
var FunktionObject:TObject;
begin
  if RgFunktionen.ItemIndex >= 0 then begin
    FunktionObject:=
      TFunktion(RgFunktionen.Items.Objects[RgFunktionen.ItemIndex]);
    EdGrad.Enabled:=(FunktionObject is TFunktionBeliebigenGrades);
  end;
  ParameterAausgeben;
  MyRepaint;
end;

procedure TForm1.CbKurveZeichnenClick(Sender: TObject);
begin
  FKoordinaten.KurveZeichnen:=
    CbKurveZeichnen.Checked;
  MyRepaint;
end;

procedure TForm1.EdMinKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#8, '0'..'9', '-', ',']) then
    key:=#0;
end;

procedure TForm1.EdMaxKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#8, '0'..'9', ',']) then
    key:=#0;
end;

procedure TForm1.EdSchrittKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#8, '0'..'9', ',']) then
    key:=#0;
end;

procedure TForm1.EdMinXChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then
    if (Value >= -500) and (Value <= 500) then
      FKoordinaten.MinX:=Value;
end;

procedure TForm1.EdMaxXChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then
    if Value <= 50000 then
      FKoordinaten.MaxX:=Value;
end;

procedure TForm1.EdXExit(Sender: TObject);
begin
  EdSchrittXChange(EdSchrittX);
end;

procedure TForm1.EdSchrittXChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then begin
    if (Value >= -1000) and (Value <= 1000) then begin
      FKoordinaten.SchrittX:=Value;
      if FKoordinaten.MinX < 0 then
        EdMinX.Text:=FormatFloat(
          '0.#', round(abs(FKoordinaten.MinX) / Value) * Value * -1
        )
      else
        EdMinX.Text:=FormatFloat(
          '0.#', round(FKoordinaten.MinX / Value) * Value
        );
      EdMaxX.Text:=FormatFloat('0.#', round(FKoordinaten.MaxX / Value) * Value);
    end;
  end;
end;

procedure TForm1.EdMinYChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then
    if (Value >= -500) and (Value <= 500) then
      FKoordinaten.MinY:=Value;
end;

procedure TForm1.EdMaxYChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then
    if Value <= 50000 then
      FKoordinaten.MaxY:=Value;
end;

procedure TForm1.EdYExit(Sender: TObject);
begin
  EdSchrittYChange(EdSchrittY);
end;

procedure TForm1.EdSchrittYChange(Sender: TObject);
var Value:double;
begin
  if TryStrToFloat(TEdit(Sender).Text, Value) then begin
    if (Value >= -10000) and (Value <= 10000) then begin
      FKoordinaten.SchrittY:=Value;
      if FKoordinaten.MinY < 0 then
        EdMinY.Text:=FormatFloat(
          '0.#', round(abs(FKoordinaten.MinY) / Value) * Value * -1
        )
      else
        EdMinY.Text:=FormatFloat(
          '0.#', round(abs(FKoordinaten.MinY) / Value) * Value
        );
      EdMaxY.Text:=FormatFloat(
        '0.#', round(abs(FKoordinaten.MaxY) / Value) * Value
      );
    end;
  end;
end;

procedure TForm1.StringGridDblClick(Sender: TObject);
var FPunktEingabe:TFPunktEingabe;
    Col, Row:integer;
begin
  if FKoordinaten.Punkte.Count > 0 then begin
    if (FMouseX >= 0) and (FMouseY >= 0) then begin
      StringGrid.MouseToCell(FMouseX, FMouseY, Col, Row);
      if (Col > 0) and (Row >= 0) then begin
        FPunktEingabe:=TFPunktEingabe.Create(
          Self, FKoordinaten.Punkte.Punkt[Col-1]
        );
        try
          if FPunktEingabe.ShowModal = mrOK then begin
            FKoordinaten.Punkte.Punkt[Col-1]:=
              FPunktEingabe.GetPunkt;
            MyRefresh;
            ParameterAausgeben;
          end;
        finally
          FPunktEingabe.Release;
        end;
      end;
    end;
  end;
end;

procedure TForm1.ParameterAausgeben;
var Funktion:TFunktion;
    i:integer;
    Parameter:TParameter;
    s:string;
begin
  if FKoordinaten.GetFunktion(Funktion) then begin
    MeParameter.Clear;
    setlength(Parameter, 0);
    Parameter:=Funktion.Parameter(FKoordinaten.Grad);
    for i:=1 to length(Parameter) do begin
      if i > 26 then
        s:=inttostr(i)
      else
        s:=chr(i+64);
      MeParameter.Lines.Append(s+': '+FloatToStr(Parameter[i-1]));
    end;
    ZusammenhangAusgeben;
    EdFormel.Text:=Funktion.Formel(Parameter);
    EdExcelFormel.Text:=Funktion.ExcelFormel(Parameter, 'A1', esDeutsch);
  end;
end;

procedure TForm1.PaintBoxDblClick(Sender: TObject);
var index:integer;
    FPunktEingabe:TFPunktEingabe;
begin
  if FKoordinaten.findPunkt(index, Point(FMouseX, FMouseY)) then begin
    if index+1 = FKoordinaten.MarkPunkt then begin
      FPunktEingabe:=TFPunktEingabe.Create(
        Self, FKoordinaten.Punkte.Punkt[index]
      );
      try
        if FPunktEingabe.ShowModal = mrOK then begin
          FKoordinaten.Punkte.Punkt[index]:=
            FPunktEingabe.GetPunkt;
          MyRefresh;
          ParameterAausgeben;
        end;
      finally
        FPunktEingabe.Release;
      end;
    end;
  end;
end;

procedure TForm1.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Punkt:TPunkt;
begin
  if FPunktAendern >= 0 then begin
    Punkt:=FKoordinaten.PointToPunkt(Point(X, Y));
    FKoordinaten.Punkte.Punkt[FPunktAendern]:=Punkt;
    MyRefresh;
    ParameterAausgeben;
    FPunktAendern:=-1;
  end;
end;

procedure TForm1.EdGradChange(Sender: TObject);
begin
  FKoordinaten.Grad:=EdGrad.Value;
  ParameterAausgeben;
  MyRepaint;
end;

procedure TForm1.BtnDruckenClick(Sender: TObject);
var QReport:TQReport;
begin
  QReport:=TQReport.create(Self);
  try
    FKoordinaten.Canvas:=QReport.Image.Canvas;
    FKoordinaten.CanvasWidth:=QReport.Image.Width;
    FKoordinaten.CanvasHeight:=QReport.Image.Height;
    try
      FKoordinaten.Repaint;
      QReport.Preview;
    finally
      FKoordinaten.Canvas:=Image.Canvas;
      FKoordinaten.CanvasWidth:=Image.Width;
      FKoordinaten.CanvasHeight:=Image.Height;
    end;
  finally
    QReport.free;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Image.Picture:=nil;
  FKoordinaten.Canvas:=Image.Canvas;
  FKoordinaten.CanvasWidth:=Image.Width;
  FKoordinaten.CanvasHeight:=Image.Height;
  MyRepaint;
end;

procedure TForm1.MyRepaint;
begin
  ZusammenhangAusgeben;
  FKoordinaten.Repaint;
end;

procedure TForm1.MyRefresh;
begin
  ZusammenhangAusgeben;
  FKoordinaten.Refresh;
end;

procedure TForm1.ZusammenhangAusgeben;
var FunktionObject:TFunktion;
begin
  LaZusammenhang.Caption:='Zusammenhang: ---';
  if RgFunktionen.ItemIndex >= 0 then begin
    FunktionObject:=
      TFunktion(RgFunktionen.Items.Objects[RgFunktionen.ItemIndex]);
    if     (FunktionObject is TFunktionBeliebigenGrades)
       and (EdGrad.Value = 1) then
    begin
       LaZusammenhang.Caption:=
         'Zusammenhang: ' +
         FormatFloat('0.00', FKoordinaten.GradDesZusammenhangs);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var Excel:TExcelApplication;
    i, lcid:integer;
    Workbook:_Workbook;
    Sheet:Variant;
    Funktion:TFunktion;
    Parameter:TParameter;
begin
  Excel:=TExcelApplication.Create(Self);
  try
    lcid:=GetUserDefaultLCID;
    Excel.Connect;
    Excel.Visible[lcid] := true;
    Excel.UserControl:=true;

    Workbook:=Excel.Workbooks.Add(EmptyParam, LCID);

    Sheet:=Workbook.ActiveSheet;
    Sheet.Cells(1, 1):='X';
    Sheet.Cells(1, 2):='Y';
    if FKoordinaten.GetFunktion(Funktion) then begin
      setlength(Parameter, 0);
      Parameter:=Funktion.Parameter(EdGrad.Value);
      for i:=1 to FKoordinaten.Punkte.Count do begin
        Sheet.Range['A' + inttostr(i+1)]:=StringReplace(FormatFloat(
          '0.000', FKoordinaten.Punkte.Punkt[i-1].X), ',', '.', [rfReplaceAll]
        );
        Sheet.Range['B' + inttostr(i+1)].Formula:=
          Funktion.ExcelFormel(Parameter, 'A' + inttostr(i+1), esEnglisch);
      end;
    end;
    Excel.Disconnect;
  finally
    Excel.free;
  end;
end;

end.

