unit Unit1;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, XPMan;

type
  TForm1 = class(TForm)
    btnDelete: TButton;
    btnRandom: TButton;
    lblCount: TLabel;
    tbCount: TTrackBar;
    memTree: TMemo;
    panNum: TPanel;
    btnPath: TButton;
    btnSearch: TButton;
    edtNum: TEdit;
    btnRemove: TButton;
    btnTraverse: TButton;
    btnInsert: TButton;
    imgTree: TImage;
    btnLoad: TButton;
    procedure Init(Sender: TObject);
    procedure InsertNode(Sender: TObject);
    procedure ShowTree(Sender: TObject);
    procedure SearchNode(Sender: TObject);
    procedure TracePath(Sender: TObject);
    procedure RemoveNode(Sender: TObject);
    procedure DeleteTree(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  end;

  zeiger = ^knoten;
  knoten = record
             info : integer;
             li,re : zeiger;
           end;

var Form1 : TForm1;
     root : zeiger; // Root of the binary tree

implementation

{$R *.dfm}

// creates a tree or subtree with root x
function construct (x: integer): zeiger;
var
  k : zeiger;
begin
  new (k);
  k^.li := nil; k^.info := x; k^.re := nil;
  construct := k
end;

// inserts x as a leaf at the point where the search was unsuccessfully terminated.
function insert (p:zeiger; x:integer): boolean;
var
  q : zeiger;
begin
  q := p;
  while (p^.info <>x) and (q <> nil) do
    begin
      p := q;                          // Remember predecessors
      if x < p^.info then q := p^.li   // q points to left son
                     else q := p^.re   // q points to right son
    end;
  if x < p^.info then p^.li := construct (x)
                 else if x > p^.info then p^.re := construct (x);
  insert := (x <> p^.info)
end;

// returns a pointer to the found node or NIL
function search (p:zeiger; x: integer): zeiger;
begin
  while (p <> nil) and (x <> p^.info) do
    if x < p^.info then p := p^.li else p := p^.re;
  search := p
end;

// traverses the entire search tree recursively
procedure traverse (p: zeiger; var s: string);
begin
  if p <> nil then begin
                     traverse (p^.li, s);
                     s := s + IntToStr (p^.info) + ' ';
                     traverse (p^.re, s)
                   end
end;

// traverses the entire search tree recursively
procedure paint (x,y,b:integer; tree:zeiger);
begin
  if tree <> nil then with Form1.imgTree.Canvas do
    begin
      if tree^.li <> nil then begin
                                MoveTo (x, y);
                                LineTo (x - b div 2, y+16);
                                paint (x - b div 2, y+30, b div 2, tree^.li);
                              end;
      TextOut (x-6, y-13, IntToStr(tree^.info));
      if tree^.re <> nil then begin
                                MoveTo (x, y);
                                LineTo (x + b div 2, y+16);
                                paint (x + b div 2, y+30, b div 2, tree^.re);
                              end
  end
end;

procedure PaintTree;
begin
  with Form1.imgTree do begin
    Canvas.Pen.Color := clTeal;
    Canvas.Rectangle (0, 0, Width, Height);
    paint (Width div 2 - 6, 20, Width div 2 - 6, root);
  end
end;

// deletes the entire tree recursively
procedure delete (p: zeiger);
begin
  if p <> nil then begin
                     delete (p^.li);
                     delete (p^.re);
                     dispose (p)
                   end
end;

// provides the complete path from the root to the node
function trace (p:zeiger; x: integer): string;
var s : string;
begin
  s := '';
  while (p <> nil) and (x <> p^.info) do
    begin
      s := s + IntToStr (p^.info) + '-';
      if x < p^.info then p := p^.li else p := p^.re
    end;
  if p <> nil then trace := s + IntToStr (p^.info)
              else trace := ''
end;

// removes the node that z points to from the tree with root r
procedure remove (var r:zeiger; z:zeiger);
var h,p,q : zeiger;
begin
  q := r;   // The search begins at the root
  p := nil; // If the node to be deleted is the root, there is no predecessor.
  while z^.info <> q^.info do begin
                                p := q;     // Remember predecessors
                                if z^.info < q^.info then q := q^.li
                                                     else q := q^.re
                              end;
  if z^.re = nil
    then q := q^.li                 // CASE 1: There is no son on the right.
    else if z^.re^.li = nil         // CASE 2a: there is no grandchild on the left
           then begin
                  q := q^.re;       // Replace node with son
                  q^.li := z^.li    // Attach the rest to the left
                end
           else begin               // CASE 2b: there is a grandchild on the left
                  h := q^.re;       // Search for replacement nodes in the right subtree
                  while h^.li^.li <> nil do h := h^.li;   // looking for replacement nodes
                  q := h^.li;       // this node replaces e.g
                  h^.li := q^.re;   // reassign the subtree of the leftmost node
                  q^.li := z^.li;   // Append the left subtree of z to q
                  q^.re := z^.re    // re. Append subtree of z to q
                end;
  if p = nil then r := q
             else if z^.info < p^.info then p^.li := q
                                       else p^.re := q;
  dispose (z)
end;

procedure TForm1.Init(Sender: TObject);
var
  i,n,x : integer;
begin
  randomize;
  n := tbCount.Position;
  lblCount.Caption := IntToStr(n) + ' Numbers';
  DeleteTree(Sender);
  root := construct (10+random(90));
  for i:=2 to n do
    repeat x := 10 + random(90) until insert (root,x);
  ShowTree (sender);
  btnLoad.Enabled := true
end;

procedure TForm1.InsertNode(Sender: TObject);
var
  x : integer;
  p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then begin
                    if root = nil then root := construct (x)
                                  else insert (root,x);
                    ShowTree (sender)
                  end
             else memTree.Lines[1] := edtNum.Text + ' is already in the tree.';
  btnLoad.Enabled := true
end;

procedure TForm1.RemoveNode(Sender: TObject);
var x : integer;
    p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then memTree.Lines[1] := edtNum.Text + ' is not in the tree.'
             else begin
                    remove (root, p);
                    ShowTree (sender);
                    memTree.Lines[1] := ' '
                  end;
end;

procedure TForm1.DeleteTree(Sender: TObject);
begin
  delete (root);
  root := nil;
  ShowTree (sender);
  btnLoad.Enabled := false
end;

procedure TForm1.SearchNode(Sender: TObject);
var x : integer;
    p : zeiger;
begin
  x := StrToInt(edtNum.Text);
  p := search (root,x);
  if p = nil then memTree.Lines[1] := edtNum.Text + ' is not in the tree.'
             else memTree.Lines[1] := edtNum.Text + ' was found.'
end;

procedure TForm1.TracePath(Sender: TObject);
var x : integer;
    s : string;
begin
  x := StrToInt(edtNum.Text);
  s := trace (root,x);
  if s = '' then memTree.Lines[1] := edtNum.Text + ' is not in the tree.'
            else memTree.Lines[1] := s
end;

procedure TForm1.ShowTree(Sender: TObject);
var s : string;
begin
  s := '';
  traverse (root, s);
  memTree.Lines[0] := s;
  PaintTree;
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var i,l,x : integer;
        s : string;
begin
  s := memTree.Lines[0];
  l := length(s);
  if s[l] <> ' ' then s := s + ' ';
  i := pos (' ', s);
  x := StrToInt(Copy (s, 1, i-1));
  root := construct (x);
  System.Delete (s, 1, i);
  while s <> '' do begin
                     i := pos (' ', s);
                     x := StrToInt(Copy (s, 1, i-1));
                     insert (root,x);
                     System.Delete (s, 1, i);
                   end;
  PaintTree;
end;

end.
