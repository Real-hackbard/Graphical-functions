unit GridCls;

interface

uses
  windows, Graphics, SysUtils;

type
  TGrid = class(TObject)
  private
    FOffScreenBmp: TBitmap; // Bitmap in memory for drawing operations
    FStepY: Integer; // step size y
    FStepX: Integer; // step size x
    FScaleHorz: Integer; // Horizontal scale
    FScaleVert: Integer; // Scale vertical
    FStepNumbers: Integer; // Incremental numbering
    procedure SetStepY(Value: Integer); // Setter step size y
    procedure SetStepX(Value: Integer); // Setter step size x
    procedure SetScaleHorz(Value: Integer); // Setter scale horizontal
    procedure SetScaleVert(Value: Integer); // Setter scale vertical
    procedure SetStepNumbers(Value: Integer); // Setter step size numbering
    procedure DrawVertLines(Width, Height: Integer); // horizontal lines
    procedure DrawHorzLines(Width, Height: Integer); // vertical lines
  public
    constructor Create;
    destructor Destroy; override;
    procedure DrawGrid(Width, Height: Integer); // draws the grid
    procedure ClearGrid(Canvas: TCanvas; Width, Height: Integer); // Delete grid
    property StepY: Integer read FStepY write SetStepY; // step size Y
    property StepX: Integer read FStepX write SetStepX; // step size X
    property StepNumbers: Integer read FStepNumbers write SetStepNumbers; //
    property ScaleHorz: Integer read FScaleHorz write SetScaleHorz; // MS horz.
    property ScaleVert: Integer read FScaleVert write SetScaleVert; // MS vert
    property Bitmap: TBitmap read FOffScreenBmp; // returns memory bitmap
  end;

const
  STEP_Y       = 10;
  STEP_X       = 10;
  STEP_NUM     = 5;
  SCALE_HORZ   = 1;
  SCALE_VERT   = 1;

implementation

////////////////////////////////////////////////////////////////////////////////
//
//  TGrid.Create
//    Initialisieren der privaten Felder
//    Anlegen des Bitmaps im Speicher
//
constructor TGrid.Create;
begin
  inherited Create;
  FStepY := STEP_Y;
  FStepX := STEP_X;
  FStepNumbers := STEP_NUM;
  FScaleHorz := SCALE_HORZ;
  FScaleVert := SCALE_VERT;
  FOffScreenBmp := TBitmap.Create;
end;

destructor TGrid.Destroy;
begin
  FOffScreenBmp.Free;
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  Setter für StepY, StepX, StepNumbers, ScaleHorz, ScaleVert
//
//
//
procedure TGrid.SetStepY(Value: Integer);
begin
  FStepY := Value;
end;

procedure TGrid.SetStepX(Value: Integer);
begin
  FStepX := Value;
end;

procedure TGrid.SetStepNumbers(Value: Integer);
begin
  FStepNumbers := Value;
end;

procedure TGrid.SetScaleHorz(Value: Integer);
begin
  // Division durch 0 verhindern
  if Value = 0 then
    Value := 1;
  FScaleHorz := Value;
end;

procedure TGrid.SetScaleVert(Value: Integer);
begin
  // Division durch 0 verhindern
  if Value = 0 then
    Value := 1;
  FScaleVert := Value;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  TGrid.DrawHorzLines
//    Zeichnen der horizontalen Linien des Grids
//
procedure TGrid.DrawHorzLines(Width, Height: Integer);
var
  cnt          : Integer;
  Loop         : Integer;
  rect         : TRect;
  Number       : Integer;
  yPos         : Integer;
begin
  with FOffScreenBmp.Canvas do
  begin
    // x-Achse
    Pen.Width := 2;
    MoveTo(0, Height div 2);
    LineTo(Width, Height div 2);
    Pen.Width := 1;
    cnt := Height div FStepY;
    yPos := (Height div 2);
    // horizontalen Linien
    Pen.Color := clGray;
    // erst von der x-Achse nach oben
    for Loop := 0 to (cnt div 2) * abs(FScaleHorz) do
    begin
      // Abständ ein Abhängigkeit FScaleHorz und FStepY
      if FScaleHorz > 0 then
      begin
        MoveTo(0, yPos - (Loop * FStepY * FScaleHorz));
        LineTo(Width, yPos - (Loop * FStepY * FScaleHorz));
      end
      else
      begin
        MoveTo(0, yPos - (Loop * FStepY div abs(FScaleHorz)));
        LineTo(Width, yPos - (Loop * FStepY div abs(FScaleHorz)));
      end;
      // Beschriften
      if ((Loop * FStepY) mod FStepNumbers) = 0 then
      begin
        rect.Left := 10;
        rect.Right := 35;
        rect.Top := yPos - (Loop * FStepY * abs(FScaleHorz)) + 7;
        rect.Bottom := yPos - (Loop * FStepY * abs(FScaleHorz)) - 7;
        Brush.Style := bsClear;
        Font.Style := [fsBold];
        Number := Loop * FStepY;
        DrawText(Handle, PChar(IntToStr(Number)), length(IntToStr(Number)), rect,
          DT_SINGLELINE or DT_CENTER or DT_VCENTER);
        Font.Color := clBlack;
        Font.Style := [];
      end;
    end;
    // horizontale Linien von x-Achse nach unten
    for Loop := 1 to (cnt div 2) * abs(FScaleHorz) do
    begin
      // Abständ ein Abhängigkeit FScaleHorz und FStepY
      if FScaleHorz > 0 then
      begin
        MoveTo(0, yPos + (Loop * FStepY * FScaleHorz));
        LineTo(Width, yPos + (Loop * FStepY * FScaleHorz));
      end
      else
      begin
        MoveTo(0, yPos + (Loop * FStepY div abs(FScaleHorz)));
        LineTo(Width, yPos + (Loop * FStepY div abs(FScaleHorz)));
      end;
      // Beschriften
      if ((Loop * FStepY) mod FStepNumbers) = 0 then
      begin
        rect.Left := 10;
        rect.Right := 35;
        rect.Top := yPos + (Loop * FStepY * abs(FScaleHorz)) - 5;
        rect.Bottom := yPos + (Loop * FStepY * abs(FScaleHorz)) + 9;
        Brush.Style := bsClear;
        Font.Style := [fsBold];
        Font.Color := clRed;
        Number := -Loop * FStepY;
        DrawText(Handle, PChar(IntToStr(Number)), length(IntToStr(Number)), rect,
          DT_SINGLELINE or DT_CENTER or DT_VCENTER);
        Font.Color := clBlack;
        Font.Style := [];
      end;
    end;
    Pen.Color := clBlack;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  TGrid.DrawVertLines
//    Zeichnen der vertikalen Linien des Grids
//
procedure TGrid.DrawVertLines(Width, Height: Integer);
var
  cnt          : Integer;
  Loop         : Integer;
  rect         : TRect;
begin
  cnt := Width div FStepX;
  with FOffScreenBmp.Canvas do
  begin
    // y-Achse
    Pen.Color := clBlack;
    Pen.Width := 2;
    MoveTo(2, 0);
    LineTo(2, Height);
    Pen.Width := 1;
    Pen.Color := clGray;
    // vertikale Linien von links nach rechts
    for Loop := 0 to cnt * abs(FScaleVert) do
    begin
      // Abständ ein Abhängigkeit FScaleVert und FStepX
      if FScaleVert > 0 then
      begin
        MoveTo(Loop * FStepX * FScaleVert, 0);
        LineTo(Loop * FStepX * FScaleVert, Height);
      end
      else
      begin
        MoveTo(Loop * FStepX div abs(FScaleVert), 0);
        LineTo(Loop * FStepX div abs(FScaleVert), Height);
      end;
      // Beschriften
      if ((Loop * FStepX) mod FStepNumbers) = 0 then
      begin
        rect.Top := Height div 2 + 3;
        rect.Bottom := Height div 2 + 28;
        rect.Left := Loop * FStepX * FScaleVert - 13;
        rect.Right := Loop * FStepX * FScaleVert + 13;
        Brush.Style := bsClear;
        Font.Style := [fsBold];
        DrawText(Handle, PChar(IntToStr(Loop * FStepX)), length(IntToStr(Loop *
          FStepX)), rect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
        Font.Style := [];
      end;
    end;
    Pen.Color := clBlack;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
//
//  TGrid.DrawGrid
//    Grid zeichnen und auf Ausgabe-Canvas kopieren
//
procedure TGrid.DrawGrid(Width, Height: Integer);
var
  rect         : TRect;
begin
  //  Bitmapgröße setzten und komplett löschen
  FOffScreenBmp.Width := Width;
  FOffScreenBmp.Height := Height;
  FOffScreenBmp.Canvas.Brush.Style := bsSolid;
  FOffScreenBmp.Canvas.Brush.Color := clWhite;
  rect.Left := 0;
  rect.Top := 0;
  rect.Right := Width;
  rect.Bottom := Height;
  FOffScreenBmp.Canvas.FillRect(rect);
  // Grid zeichnen
  DrawHorzLines(Width, Height);
  DrawVertLines(Width, Height);
end;

////////////////////////////////////////////////////////////////////////////////
//
//  TGrid.ClearGrid
//
//   Grid löschen
//
procedure TGrid.ClearGrid(Canvas: TCanvas; Width, Height: Integer);
var
  rect         : TRect;
begin
  with FOffScreenBmp do
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clWhite;
    rect.Left := 0;
    rect.Top := 0;
    rect.Right := Width;
    rect.Bottom := Height;
    Canvas.FillRect(rect);
  end;
  DrawHorzLines(Width, Height);
  DrawVertLines(Width, Height);
  BitBlt(Canvas.Handle, 0, 0, Width, Height, FOffScreenBmp.Canvas.Handle, 0, 0,
    SRCCOPY);
end;

end.

