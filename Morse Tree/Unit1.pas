unit Unit1;

interface

uses Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, XPman;

type
  TForm1 = class(TForm)
    panNum: TPanel;
    btnPath: TButton;
    btnSearch: TButton;
    edtNum: TEdit;
    edtPlain: TEdit;
    edtChiffre: TEdit;
    btnEncode: TButton;
    btnDecode: TButton;
    imgTree: TImage;
    edtPath: TEdit;
    Label1: TLabel;
    edtMorse: TEdit;
    Label2: TLabel;
    procedure Init(Sender: TObject);
    procedure ShowTree(Sender: TObject);
    procedure SearchNode(Sender: TObject);
    procedure TracePath(Sender: TObject);
    procedure EncodeText(Sender: TObject);
    procedure DecodeText(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

  zeiger = ^knoten;
  knoten = record
             info : char;
             li,re : zeiger;
           end;
   morse = string[4];

var Form1 : TForm1;
     root : zeiger;     // Root of the binary tree
      x,y : integer;    // Coordinates within the tree structure

implementation
{$R *.dfm}

// creates a tree or subtree with root x
function construct (x: char): zeiger;
var k : zeiger;
begin
  new (k);
  k^.li := nil; k^.info := x; k^.re := nil;
  construct := k
end;

// defines an order of the letters
function po (c: char): byte;
const
  alphabet = 'hsvifuüelräapwj bdxnckytzgqmöoß';

var i : integer;
begin
  i := 1;
  while c <> alphabet[i] do inc(i);
  po := i
end;

// inserts x as a leaf at the point where the search was unsuccessfully terminated.
function insert (p:zeiger; x:char): boolean;
var q : zeiger;
begin
  q := p;
  while (p^.info <> x) and (q <> nil) do
    begin
      p := q;
      if po(x) < po(p^.info) then q := p^.li  // q points to left son
                             else q := p^.re  // q points to right son
    end;
  if po(x) < po(p^.info) then p^.li := construct (x)
                         else if po(x) > po(p^.info) then p^.re := construct (x);
  insert := (x <> p^.info)
end;

// returns a pointer to the found node or NIL
function search (p:zeiger; x: char): morse;
var m : morse;
begin
  m := '';
  while (p <> nil) and (x <> p^.info) do
    if po(x) < po(p^.info) then begin p := p^.li; m := m + '·' end
                           else begin p := p^.re; m := m + '-' end;
  if x = p^.info then search := m else search := ''
end;

function pot (x,n: integer): integer;
var i,p : integer;
begin p := 1; for i:=1 to n do p:=p*x; pot := p end;

// traverses the entire search tree recursively
procedure traverse (p: zeiger);                     // recursive scanning
const b = 14;                                       // Output width per node
begin
  inc (y);                                          // node level
  if p <> nil then with Form1.imgTree.Canvas do
    begin
      traverse (p^.li);                             // visit left node
      inc (x);                                      // Node number
      TextOut (b*x, 30*y-30, p^.info);
      if y < 5 then begin
                      Font.Color := clRed;
                      TextOut(b*x+3-b*pot(2,4-y) div 2, 30*y-20, '·');
                      TextOut(b*x+6+b*pot(2,4-y) div 2, 30*y-27, '_');
                      Font.Color := clBlack;

                      MoveTo (b*x+6, 30*y-17);
                      LineTo (b*x+6-b*pot(2,4-y), 30*y-3);
                      MoveTo (b*x+6, 30*y-17);
                      LineTo (b*x+6+b*pot(2,4-y), 30*y-3)
                    end;
      traverse (p^.re)         // visit right node
    end;
  dec (y)
end;

// deletes the entire tree recursively
procedure del (p: zeiger);
begin
  if p <> nil then begin
                     del (p^.li);
                     del (p^.re);
                     dispose (p)
                   end
end;

// provides the complete path from the root to the node
function trace (p:zeiger; x: char): string;
var s : string;
begin
  s := '';
  while (p <> nil) and (x <> p^.info) do
    begin
      s := s + p^.info;
      if po(x) < po(p^.info) then p := p^.li else p := p^.re
    end;
  if p <> nil then trace := s + p^.info
              else trace := ''
end;

// provides the complete path from the root to the node
function decode (p:zeiger; x: morse): char;
var i : integer;
begin
  for i:=1 to length(x) do
    if x[i] = '·' then p := p^.li else p := p^.re;
  decode := p^.info;
end;

procedure TForm1.Init(Sender: TObject);
const
  zeichen = 'etianmsurwdkgohvfüläpjbxcyzqöß';

var i : integer;
begin
  root := construct (' ');
  for i:=1 to length(zeichen) do insert (root, zeichen[i]);
  ShowTree (sender);
end;

procedure TForm1.SearchNode(Sender: TObject);
var x : char;
    m : morse;
begin
  x := edtNum.Text[1];
  m := search (root,x);
  if m = '' then edtMorse.Text := edtNum.Text + ' is not in the tree.'
            else edtMorse.Text := ' ' + m
end;

procedure TForm1.TracePath(Sender: TObject);
var x : char;
    s : string;
begin
  x := edtNum.Text[1];
  s := trace (root,x);
  if s = '' then edtPath.Text := edtNum.Text + ' is not in the tree.'
            else edtPath.Text := s
end;

procedure TForm1.ShowTree(Sender: TObject);
begin
  traverse (root);
end;

procedure TForm1.EncodeText(Sender: TObject);
var s,chiffre : string;
    i : integer;
begin
  s := edtPlain.Text;
  chiffre := '';
  for i:=1 to length(s) do
    chiffre := chiffre + search(root, s[i]) + ' ';
  edtChiffre.Text := chiffre
end;

procedure TForm1.DecodeText(Sender: TObject);
var s,plain : string;
          p : integer;
begin
  s := edtChiffre.Text;
  plain := '';
  repeat
    p := pos (' ', s);
    plain := plain + decode (root, copy (s,1,p-1));
    delete (s,1,p)
  until s = '';
  edtPlain.Text := plain
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  del (root);
end;

end.
