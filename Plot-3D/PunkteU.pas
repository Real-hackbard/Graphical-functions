unit PunkteU;

interface

uses Classes, ComCtrls;

type
  TPunkteSort = (_Winkel, _Hoehe);
  TPunkt = class
    X, Y, W:real;
    Show:boolean;
  end;

  TWinkel = class
    Wert:real;
    Show:boolean;
  end;

  THoehe = class
    Wert:real;
    Show:boolean;
  end;

  TPunkte = class
  private
    _Punkte:TList;
    _maxX, _maxY:real;
    _PunkteSort:TPunkteSort;
    procedure ClearNode(Node:TTreeNode);
    function GetPunkt(index: integer): TPunkt;
  public
    constructor create;
    destructor destroy; override;
    procedure clear;
    procedure LoadFromFile(Dateiname:string; ProgressBar:TProgressBar = nil);
    function count:integer;
    procedure MakeSort(PunkteSort:TPunkteSort);
    procedure GetTree(TreeView:TTreeView; ProgressBar:TProgressBar = nil);
    procedure ClearTree(TreeView:TTreeView);
    property MaxX:real read _maxX;
    property MaxY:real read _maxY;
    property Punkt[index:integer]:TPunkt read GetPunkt;
    property Sort:TPunkteSort read _PunkteSort;
  end;

const
  cFlatUnCheck = 1;
  cFlatChecked = 2;
  cFlatRadioUnCheck = 3;
  cFlatRadioChecked = 4;

implementation

uses
  SysUtils, RegExprU;

function CompareWinkel(Item1, Item2:Pointer):integer;
begin
  if TPunkt(Item1).W > TPunkt(Item2).W then
    Result:=1
  else if TPunkt(Item1).W < TPunkt(Item2).W then
    Result:=-1
  else begin
    if TPunkt(Item1).Y > TPunkt(Item2).Y then
      Result:=1
    else if TPunkt(Item1).Y < TPunkt(Item2).Y then
      Result:=-1
    else
      Result:=0;
  end;
end;

function CompareHoehe(Item1, Item2:Pointer):integer;
begin
  if TPunkt(Item1).Y > TPunkt(Item2).Y then
    Result:=1
  else if TPunkt(Item1).Y < TPunkt(Item2).Y then
    Result:=-1
  else begin
    if TPunkt(Item1).W > TPunkt(Item2).W then
      Result:=1
    else if TPunkt(Item1).W < TPunkt(Item2).W then
      Result:=-1
    else
      Result:=0;
  end;
end;

{ TPunkte }

constructor TPunkte.create;
begin
  _maxX:=0;
  _maxY:=0;
  _PunkteSort:=_Winkel;
  _Punkte:=TList.create;
end;

destructor TPunkte.destroy;
begin
  clear;
  _Punkte.free;
  inherited;
end;

procedure TPunkte.Clear;
var
  i:integer;
begin
  for i:=1 to _Punkte.Count do
    TPunkt(_Punkte[i-1]).free;
  _Punkte.Clear;
end;

procedure TPunkte.ClearNode(Node: TTreeNode);
var
  NodeObject:TObject;
begin
  while assigned(Node) do begin
    NodeObject:=Node.Data;
    Node.Data:=nil;
    if NodeObject is TWinkel then
      NodeObject.free
    else if NodeObject is THoehe then
      NodeObject.free;

    ClearNode(Node.getFirstChild);
    Node:=Node.getNextSibling;
  end;
end;

procedure TPunkte.ClearTree(TreeView: TTreeView);
begin
  try
    TreeView.Items.BeginUpdate;
    ClearNode(TreeView.Items.GetFirstNode);
    TreeView.Items.Clear;
  finally
    TreeView.Items.EndUpdate;
  end;
end;

function TPunkte.count: integer;
begin
  Result:=_Punkte.Count;
end;

function TPunkte.GetPunkt(index: integer): TPunkt;
begin
  Result:=_Punkte[index];
end;

procedure TPunkte.GetTree(TreeView: TTreeView; ProgressBar:TProgressBar = nil);

  function addWinkel(var Node, PunktNode:TTreeNode;
                     pkey, old:real; Punkt:TPunkt; aktiv:boolean):boolean;
  var
    Winkel:TWinkel;
  begin
    Result:=false;
    if old <> pkey then begin
      if assigned(Node) then begin
        if aktiv then
          PunktNode.StateIndex:=cFlatChecked
        else
          PunktNode.StateIndex:=cFlatUnCheck;
      end;
      Winkel:=TWinkel.Create;
      Winkel.Show:=true;
      Winkel.Wert:=Punkt.W;
      Node:=TreeView.Items.AddObject(
        nil, FormatFloat('Angle: 0.0°', Punkt.W), Winkel
      );
      Node.StateIndex:=cFlatChecked;
      Result:=true;
    end;
    PunktNode:=TreeView.Items.AddChildObject(
      Node,
      'Height: ' + FormatFloat('0.0mm', Punkt.Y) + ' / ' +
      'Width: ' + FormatFloat('0.0mm', Punkt.X),
      Punkt
    );
  end;

  function addHoehe(var Node, PunktNode:TTreeNode;
                    pkey, old:real; Punkt:TPunkt; aktiv:boolean):boolean;
  var
    Hoehe:THoehe;
  begin
    Result:=false;
    if old <> pkey then begin
      if assigned(Node) then begin
        if aktiv then
          PunktNode.StateIndex:=cFlatChecked
        else
          PunktNode.StateIndex:=cFlatUnCheck;
      end;
      Hoehe:=THoehe.Create;
      Hoehe.Show:=true;
      Hoehe.Wert:=Punkt.Y;
      Node:=TreeView.Items.AddObject(
        nil, FormatFloat('Height: 0.0mm', Punkt.Y), Hoehe
      );
      Node.StateIndex:=cFlatChecked;
      Result:=true;
    end;
    PunktNode:=TreeView.Items.AddChildObject(
      Node,
      FormatFloat('Angle: 0.0°', Punkt.W)
        + ' / ' + FormatFloat('Width: 0.0mm', Punkt.X),
      Punkt
    );
  end;

var
  i:integer;
  Node, PunktNode:TTreeNode;
  old:real;
  Punkt:TPunkt;
  aktiv:boolean;
begin
  ClearTree(TreeView);
  try
    TreeView.Items.BeginUpdate;
    old:=-1;
    Node:=nil;
    PunktNode:=nil;
    aktiv:=false;
    if assigned(ProgressBar) then begin
      ProgressBar.Min:=1;
      ProgressBar.Max:=_Punkte.Count;
      ProgressBar.Position:=1;
      ProgressBar.Step:=1;
    end;
    for i:=1 to _Punkte.Count do begin
      Punkt:=_Punkte[i-1];
      case _PunkteSort of
        _Winkel: if addWinkel(Node, PunktNode, Punkt.W, old, Punkt, aktiv) then
                 begin
                   old:=Punkt.W;
                   aktiv:=false;
                 end;
        _Hoehe:  if addHoehe(Node, PunktNode, Punkt.Y, old, Punkt, aktiv) then
                 begin
                   old:=Punkt.Y;
                   aktiv:=false;
                 end;
      end;
      if assigned(PunktNode) then begin
        if Punkt.Show then begin
          PunktNode.StateIndex:=cFlatChecked;
          aktiv:=true;
        end
        else PunktNode.StateIndex:=cFlatUnCheck;
      end;
      if assigned(Node) then begin
        if aktiv then
          Node.StateIndex:=cFlatChecked
        else
          Node.StateIndex:=cFlatUnCheck;
      end;
      if assigned(ProgressBar) then
        ProgressBar.Position:=i;
    end;
  finally
    TreeView.Items.EndUpdate;
  end;
end;

procedure TPunkte.LoadFromFile(Dateiname: string;
                               ProgressBar:TProgressBar = nil);
var
  Datei:textfile;
  RegExpr:TRegExpr;
  zeile, sX, sY, sW:string;
  Punkt:TPunkt;
  X, Y, W:double;
begin
  if FileExists(Dateiname) then begin
    RegExpr:=TRegExpr.Create;
    try
      clear;
      assignfile(Datei, Dateiname);
      reset(Datei);
      _maxX:=0;
      _maxY:=0;
      if assigned(ProgressBar) then begin
        ProgressBar.Max:=FileSize(Datei);
        ProgressBar.Step:=1;
      end;
      RegExpr.Expression:='^[ ]*([-0-9.]*)[ ]*([-0-9.]*)[ ]*([-0-9.]*)[ ]*$';
      while not Eof(Datei) do begin
        readln(Datei, zeile);
        if RegExpr.Exec(zeile) then begin
          sW:=StringReplace(RegExpr.Match[1], '.', ',', [rfReplaceAll]);
          sX:=StringReplace(RegExpr.Match[2], '.', ',', [rfReplaceAll]);
          sY:=StringReplace(RegExpr.Match[3], '.', ',', [rfReplaceAll]);
          if     TryStrToFloat(sW, W)
             and TryStrToFloat(sX, X)
             and TryStrToFloat(sY, Y) then
          begin
            Punkt:=TPunkt.Create;
            Punkt.Show:=true;
            Punkt.W:=W;
            Punkt.X:=X;
            Punkt.Y:=Y;
            if Punkt.X > _maxX then
              _maxX:=Punkt.X;
            if Punkt.Y > _maxY then
              _maxY:=Punkt.Y;
            _Punkte.Add(Punkt);
          end;
        end;
        if assigned(ProgressBar) then
          ProgressBar.Position:=FilePos(Datei);
      end;
      MakeSort(_PunkteSort);
    finally
      closefile(Datei);
    end;
  end;
end;

procedure TPunkte.MakeSort(PunkteSort: TPunkteSort);
begin
  _PunkteSort:=PunkteSort;
  case PunkteSort of
    _Winkel: _Punkte.Sort(@CompareWinkel);
    _Hoehe:  _Punkte.Sort(@CompareHoehe);
  end;
end;

end.