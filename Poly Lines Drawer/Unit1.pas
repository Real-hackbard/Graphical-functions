unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LineLib, ExtCtrls, StdCtrls, XPMan;

type
  TPolyLineDemoForm = class(TForm)
    Panel1: TPanel;
    InfoMemo: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ClearButton: TButton;
    SaveButton: TButton;
    LoadLinesButton: TButton;
    AllowMoveEndPointsCheckBox: TCheckBox;
    AllowMoveLineCheckBox: TCheckBox;
    ButtonCreateNewLine: TButton;
    LineColorBox: TColorBox;
    LineColorLabel: TLabel;
    LineWidthComboBox: TComboBox;
    LineWidthLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ButtonCreateNewLineClick(Sender: TObject);
    procedure AllowMoveLineCheckBoxClick(Sender: TObject);
    procedure AllowMoveEndPointsCheckBoxClick(Sender: TObject);
    procedure LoadLinesButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    PolyLines: TPolyLines;
    procedure SetSize;
  public
    { Public declarations }
  end;

var
  PolyLineDemoForm: TPolyLineDemoForm;

implementation

{$R *.dfm}
procedure TPolyLineDemoForm.FormCreate(Sender: TObject);
begin
  PolyLines := TPolyLines.Create(Self);
  PolyLines.VirtualWorkRect := Rect(0, 0, 10000, 10000);
  SetSize;
end;

procedure TPolyLineDemoForm.FormDestroy(Sender: TObject);
begin
  PolyLines.Free;
end;

procedure TPolyLineDemoForm.FormPaint(Sender: TObject);
begin
  PolyLines.UpdateLines;
end;

procedure TPolyLineDemoForm.FormMouseDown(Sender: TObject;
          Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PolyLines.MouseDown(Button, X, Y);
end;

procedure TPolyLineDemoForm.SetSize;
begin
  PolyLines.ParentWorkRect := Rect(0, 0, Width - Panel1.Width, Height);
end;

procedure TPolyLineDemoForm.FormShow(Sender: TObject);
begin
  SetSize;
end;

procedure TPolyLineDemoForm.FormResize(Sender: TObject);
begin
  SetSize;
end;

procedure TPolyLineDemoForm.FormMouseMove(Sender: TObject; Shift: TShiftState;
          X, Y: Integer);
begin
  PolyLines.MouseMove(Shift, X, Y);
end;

procedure TPolyLineDemoForm.ButtonCreateNewLineClick(Sender: TObject);
begin
  PolyLines.AddLine(Point(((Width - Panel1.Width) div 4), (Height div 4)),
                            Point((Width - Panel1.Width) -
                            ((Width - Panel1.Width) div 4),
                            Height - (Height div 4)),
                            ctParent, LineWidthComboBox.ItemIndex + 1,
                            LineColorBox.Selected);
  PolyLines.SelectedLine := PolyLines.Lines[PolyLines.Count - 1];
  PolyLines.UpdateLines;
end;

procedure TPolyLineDemoForm.AllowMoveLineCheckBoxClick(Sender: TObject);
begin
  PolyLines.AllowMoveLine := AllowMoveLineCheckBox.Checked;
end;

procedure TPolyLineDemoForm.AllowMoveEndPointsCheckBoxClick(Sender: TObject);
begin
  PolyLines.AllowMoveEndPoints := AllowMoveEndPointsCheckBox.Checked;
end;

procedure TPolyLineDemoForm.LoadLinesButtonClick(Sender: TObject);
begin
  OpenDialog1.FileName := '';
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Data';
  if (OpenDialog1.Execute) then
    PolyLines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TPolyLineDemoForm.SaveButtonClick(Sender: TObject);
begin
  SaveDialog1.FileName := '';
  if (SaveDialog1.Execute) then
    PolyLines.SaveToFile(SaveDialog1.FileName);
end;

procedure TPolyLineDemoForm.ClearButtonClick(Sender: TObject);
begin
  PolyLines.Clear;
end;

procedure TPolyLineDemoForm.FormKeyDown(Sender: TObject;
var
  Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (Assigned(PolyLines.SelectedLine)) then
    PolyLines.Delete(PolyLines.SelectedLine);
end;

end.
