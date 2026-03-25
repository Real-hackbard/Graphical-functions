unit LeastSquareFit;

{ A mathematical procedure for finding the best fitting curve to a given
  set of points by minimizing the sum of the squares of the offsets
  ("the residuals") of the points from the curve. The sum of the squares of the
  offsets is used instead of the offset absolute values because this allows
  the residuals to be treated as a continuous differentiable quantity.

  The linear least squares fitting technique is the simplest and most commonly
  applied form of linear regression and provides a solution to the problem of
  finding the best fitting straight line through a set of points. In fact,
  if the functional relationship between the two quantities being graphed is
  known to within additive or multiplicative constants, it is common practice
  to transform the data in such a way that the resulting line is a straight
  line.

  For nonlinear least squares fitting to a number of unknown parameters,
  linear least squares fitting may be applied iteratively to a linearized form
  of the function until convergence is achieved. However, it is often also
  possible to linearize a nonlinear function at the outset and still use
  linear methods for determining fit parameters without resorting to iterative
  procedures. This approach does commonly violate the implicit assumption
  that the distribution of errors is normal, but often still gives acceptable
  results using normal equations, a pseudoinverse, etc. 
 
  LeastSquareFit can be seen as an object which calculates the best 
  approximated solution for an overdetermined equation system.
  (more equations or points than variables). 
  The equation is unresolvable if there are less points than variables.
  If the number of points is equal to the number of variables LeastSquareFit
  calculates the exact solution. 
 
  constructor Create(count:integer);
  Creates the object. Count indicates the number of variables 

  procedure AddValue(const v:array of extended);
  Adds an oberservation (values of dependent and independent variables)
  
  function GetResult(var v:array of extended):boolean;
  Gives the coefficients. 
  The method returns false if the equation is unresolveable.

  This version was updated and compiled for Borland's Delphi 7.0.

  }

  {

    LeastSquareFit is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    LeastSquareFit is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with LeastSquareFit; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 }

interface
type
  TMatrix=array of array of extended;
  TLeastSquareFit = class
    h:TMatrix;
    n:integer;
    constructor Create(count:integer); 
    procedure AddValue(const v:array of extended);
    function GetResult(var v:array of extended):boolean;
  end;
  function hornerscheme(var h:TMatrix):boolean;

implementation

function hornerscheme(var h:TMatrix):boolean;
var k,i,j,n:integer;
    t:extended;
function tozero:boolean;
// remove 0 on the diagonal by adding of equations.
var j,k :integer;
begin
  result:=true;
  for j:=i+1 to n-1 do
  begin
    if h[j,i] <> 0 then
    begin
      for k:=0 to n do  h[i,k]:=h[i,k]+h[j,k]/h[j,i];
      exit;
    end;
  end;
  result:=false; {equation unresolvable }
end;
begin
  n:=high(h[0]);
  result:=true;
  for i:=0 to n-1 do
  begin
    if h[i,i]=0 then
    begin
      if tozero = false then
      begin
        result:=false;
        exit;
      end;
    end;
    // divide the equation so that the current element becomes 1
    if h[i,i]<>1 then
    begin
      t:=1/h[i,i];
      h[i,i]:=1;
      for j:=i+1 to n do h[i,j]:=h[i,j]*t;
    end;
    for j:=0 to n-1 do
    begin
      if ((i<>j) and (h[j,i]<>0)) then
      begin
        t:=h[j,i];
        for k:=i to n do h[j,k]:=h[j,k]-h[i,k]*t;
      end;
    end;
  end;
end;

constructor TLeastSquareFit.Create(count:integer);
var i,j:integer;
begin
  n:=count;
  SetLength(h,n,n+1);
  for i:=0 to n-1 do
    for j:=0 to n do H[i,j]:=0;
end;

procedure TLeastSquareFit.AddValue(const v:array of extended);
var i,j:integer;
begin
  for i:=0 to n-1 do
    for j:=i to n do H[i,j]:=H[i,j]+v[i]*v[j];
end;

function TLeastSquareFit.GetResult(var v:array of extended):boolean;
var i,j:integer;
begin
  for i:=1 to n-1 do
    for j:=0 to i do H[i,j]:=H[j,i];
  result:=Hornerscheme(h);
  for i:=0 to n-1 do v[i]:=H[i,n];
end;

end.

