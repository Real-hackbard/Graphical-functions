unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, ExtDlgs, XPMan, Math;

type
pRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = ARRAY[0..599] OF TRGBTriple;

  TForm1 = class(TForm)
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    MaskEdit2: TMaskEdit;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    MaskEdit3: TMaskEdit;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    CheckBox2: TCheckBox;
    MaskEdit4: TMaskEdit;
    Label4: TLabel;
    MaskEdit5: TMaskEdit;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    MaskEdit6: TMaskEdit;
    MaskEdit7: TMaskEdit;
    MaskEdit8: TMaskEdit;
    MaskEdit9: TMaskEdit;
    MaskEdit10: TMaskEdit;
    MaskEdit11: TMaskEdit;
    Button3: TButton;
    Shape1: TShape;
    Shape2: TShape;
    CheckBox3: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Declaration privates }
  public
    { Declarations public }
  end;
var
  Form1: TForm1;
  bmp : tbitmap;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  bmp:=tbitmap.Create;
  bmp.Width:=600;
  bmp.Height:=600;
  bmp.PixelFormat:=pf24bit;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bmp.Free;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
    maskedit4.Enabled:=checkbox2.Checked;
    maskedit5.Enabled:=checkbox2.Checked;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
    BitBlt(form1.Canvas.Handle,0,0,599,599,bmp.Canvas.Handle,0,0,SrcCopy);
end;
procedure TForm1.Button1Click(Sender: TObject);
var
theta : single;
i,i2,iner,outer,numteeth : integer;
P1,P2 : Tpoint;
SinT,CosT : extended;
bo : boolean;

procedure spetial; {Sub-procedure for the extra in the gears}
var
  def,sections,a,b,c,d,e,j : integer;
  P3,P4 : Tpoint;
  theta2 : single;
  SinT2,CosT2 : extended;
begin
    outer:=strtoint(maskedit6.text);
    iner:=strtoint(maskedit7.text);
    a:=strtoint(maskedit8.text);
    b:=strtoint(maskedit9.text);
    def:=strtoint(maskedit10.text);
    sections:=strtoint(maskedit11.text);

    c:=round(def/sections/b*a);
    d:=round(def/sections-c);
    e:=0;
    bo:=true;
    for j:=0 to def-1 do
    begin
        Theta := j*PI /def*2;
        theta2:= (j-1)*PI/def*2;
        sincos(Theta,SinT,CosT);
        sincos(Theta2,SinT2,CosT2);
        P1:=point(round(outer*Sint)+299,round(outer*CosT)+299);
        P2:=point(round(iner*Sint)+299,round(iner*CosT)+299);
        P3:=point(round(outer*Sint2)+299,round(outer*CosT2)+299);
        P4:=point(round(iner*Sint2)+299,round(iner*CosT2)+299);

        if bo then
        begin
            if e=0 then
            begin
                bmp.Canvas.MoveTo(p2.X,p2.Y);
                bmp.Canvas.LineTo(p1.X,p1.Y);
            end else
            begin
                bmp.Canvas.MoveTo(P3.X,p3.y);
                bmp.Canvas.LineTo(p1.X,p1.Y);
                bmp.Canvas.MoveTo(p4.X,p4.Y);
                bmp.Canvas.LineTo(p2.X,p2.Y);
            end;
            inc(e);
            if e>=c then
            begin
                bmp.Canvas.MoveTo(p2.X,p2.Y);
                bmp.Canvas.LineTo(P1.X,p1.Y);
                bo:=not(bo);
                e:=0;
            end;
        end else
        begin
            inc(e);
            if e>=d then begin bo:=not(bo);e:=0;end;
        end;
    end;
end;

begin
  iner:=strtoint(maskedit2.text);
  outer:=strtoint(maskedit3.text);
  numteeth:=strtoint(maskedit1.Text);
  {
   if checkbox1.Checked=false
   To draw flat teeth.
   PS: This application was originally written to draw flat toothed wheels
   to then use them (printed, glued, then cut out of cardboard)
   in combination with optometry sensors to create electronic speedometers.
  }
  if checkbox1.Checked=false then begin
  for i:= 0 to numteeth*2 do begin
    Theta := (i)*PI / (numteeth);
    sincos(theta,SinT,CosT);
    p1:=point(round(outer*Sint)+299,round(outer*cost)+299);
    p2:=point(round(iner*Sint)+299,round(iner*cost)+299);
    if i=0 then
    begin
      bmp.Canvas.MoveTo(p2.X,p2.y);
      bmp.Canvas.LineTo(p1.X,p1.Y);
      bo:=false
      end
    else begin
        if bo=false then begin
                bmp.Canvas.LineTo(p1.X,p1.y);
                bmp.Canvas.LineTo(p2.X,p2.Y);
        end else begin
                bmp.Canvas.LineTo(p2.X,p2.Y);
                bmp.canvas.LineTo(p1.X,p1.Y);
        end;
        bo:=not(bo);
    end;
    end;
  end else {draw sharp teeth}
  begin
  i2:=0;
    for i:= 0 to numteeth*4 do begin
    Theta := (i)*PI / (numteeth*2);
    sincos(theta,SinT,CosT);
    p1:=point(round(outer*Sint)+299,round(outer*cost)+299);
    p2:=point(round(iner*Sint)+299,round(iner*cost)+299);
    if i2=0 then if i = 0 then bmp.Canvas.MoveTo(p1.X,p1.Y);
    case i2 of
        0 : bmp.Canvas.LineTo(p1.X,p1.Y);
        1 : bmp.Canvas.LineTo(p2.X,p2.Y);
        2 : bmp.Canvas.LineTo(p2.X,p2.Y);
        3 : bmp.Canvas.LineTo(p1.X,p1.Y);
    end;
    inc(i2);
    if i2=4 then i2:=0;
    end;
  end;
  if checkbox2.Checked then {draw a circle in the center of the wheel}
  begin
    for i:=0 to strtoint(maskedit5.Text) do
    begin
        theta:=i*pi/strtoint(maskedit5.Text)*2;
        sincos(theta,SinT,CosT);
        P1:=point(round(strtoint(maskedit4.Text)*SinT)+299,
                  round(strtoint(maskedit4.Text)*CosT)+299);
        if i=0 then bmp.Canvas.MoveTo(P1.X,P1.Y) else
        begin
            bmp.Canvas.LineTo(p1.X,p1.Y);
        end;
    end;
  end;
  if checkbox3.Checked then spetial;
  form1.Paint;
  // save bitmap
  //bmp.SaveToFile('bmp.bmp');
end;

procedure TForm1.Button2Click(Sender: TObject);
{erase what is on the canvas}
var
  row : pRGBTripleArray;
  i,j : integer;
begin
  for i := 0 to 599 do begin
        row:=bmp.ScanLine[i];
        for j := 0 to 599 do begin
            row[j].rgbtBlue:=255;
            row[j].rgbtGreen:=255;
            row[j].rgbtRed:=255;
        end;
  end;
  form1.Paint;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  maskedit6.Enabled:=checkbox3.Checked;
  maskedit7.Enabled:=checkbox3.Checked;
  maskedit8.Enabled:=checkbox3.Checked;
  maskedit9.Enabled:=checkbox3.Checked;
  maskedit10.Enabled:=checkbox3.Checked;
  maskedit11.Enabled:=checkbox3.Checked;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if savepicturedialog1.Execute then
    bmp.SaveToFile(savepicturedialog1.FileName);
end;

end.
