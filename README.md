# Graphical-functions

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![Delphi Multi](https://github.com/user-attachments/assets/bf35e8e0-143d-46e1-8365-aba53bded77e)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![Graphical functions](https://github.com/user-attachments/assets/900d2d3b-8d7d-4f18-ba79-4ce31a48725f)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![022026](https://github.com/user-attachments/assets/90c88085-69f5-4332-b090-2de107ca7f86)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

In mathematics, a function from a set X to a set Y assigns to each element of X exactly one element of Y. The set X is called the [domain](https://en.wikipedia.org/wiki/Domain_of_a_function) of the function and the set Y is called the [codomain](https://en.wikipedia.org/wiki/Codomain) of the function.

Functions were originally the idealization of how a varying quantity depends on another quantity. For example, the position of a planet is a function of time. [Historically](https://en.wikipedia.org/wiki/History_of_the_function_concept), the concept was elaborated with the infinitesimal [calculus](https://en.wikipedia.org/wiki/Calculus) at the end of the 17th century, and, until the 19th century, the functions that were considered were [differentiable](https://en.wikipedia.org/wiki/Differentiable_function) (that is, they had a high degree of regularity). The concept of a function was formalized at the end of the 19th century in terms of set theory, and this greatly increased the possible applications of the concept.

</br>

![Graphical functions](https://github.com/user-attachments/assets/be7640d0-9e1a-4e30-8373-b61b0dd91f1b)

</br>

The domain and codomain are not always explicitly given when a function is defined. In particular, it is common that one might only know, without some (possibly difficult) computation, that the domain of a specific function is contained in a larger set. For example, if ```f : R > R``` is a [real function](https://en.wikipedia.org/wiki/Function_of_a_real_variable), the determination of the domain of the function ```x > 1 / f(x)``` requires knowing the zeros of f. This is one of the reasons for which, in [mathematical analysis](https://en.wikipedia.org/wiki/Mathematical_analysis), "a function from X to Y " may refer to a function having a proper subset of X as a domain. For example, a "function from the reals to the reals" may refer to a [real-valued](https://en.wikipedia.org/wiki/Real-valued_function) function of a real variable whose domain is a proper subset of the [real numbers](https://en.wikipedia.org/wiki/Real_number), typically a subset that contains a non-empty [open interval](https://en.wikipedia.org/wiki/Interval_(mathematics)#open_interval). Such a function is then called a [partial function](https://en.wikipedia.org/wiki/Partial_function).

# Simple Example:
The red curve is the [graph of a function](https://en.wikipedia.org/wiki/Graph_of_a_function), because any [vertical line](https://en.wikipedia.org/wiki/Vertical_line_test) has exactly one crossing point with the curve.

</br>

![Example_Function](https://github.com/user-attachments/assets/caa493c6-2970-4118-89f6-cbf908a2a1b6)

</br>

# Drawing function
```pascal
procedure TForm1.darstellung(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  farbig:=m_farbe.Checked;
  grafb:=paintbox1.width;
  grafh:=paintbox1.Height;

  // Initialization of the coordinate system
  wbx:=1.0*(_x2-_x1);
  wby:=1.0*(_y2-_y1);

  fx:=grafb/wbx;
  fy:=grafh/wby;

  _x:=round(-_x1*grafb/(_x2-_x1));
  _y:=round(grafh+_y1*grafh/(_y2-_y1));

  Bitmap := TBitmap.Create;
  Bitmap.Width := paintbox1.Width;
  Bitmap.Height := paintbox1.Height;
  bitmap.canvas.font.name:='Verdana';
  bitmap.canvas.font.size:=9;

  setbkmode(bitmap.canvas.handle,transparent);
  try
    koordinatensystem(bitmap.canvas);
    zeichnen(bitmap.canvas);
    paintbox1.canvas.draw(0,0,bitmap);
  finally
    Bitmap.Free;
  end;
end;
```

# Animate function:
```pascal
procedure TForm1.Timer1Timer(Sender: TObject);
var
  x,diff:double;
begin
  if rb_punkta.checked then begin
    diff:=ein_double(ed_delta);
    x:=ein_double(ed_A);
    if steigen then x:=x+diff
               else x:=x-diff;
    if (x>ein_double(ed_bis)) then steigen:=false;
    if (x<ein_double(ed_von)) then steigen:=true;
    ed_A.text:=_strkomma(x,1,2);
    paintbox1paint(sender);
    exit;
  end;

  if rb_punktb.checked then begin
    diff:=ein_double(ed_delta);
    x:=ein_double(ed_B);
    if steigen then x:=x+diff
               else x:=x-diff;
    if (x>ein_double(ed_bis)) then steigen:=false;
    if (x<ein_double(ed_von)) then steigen:=true;
    ed_B.text:=_strkomma(x,1,2)
  end else begin
    diff:=ein_double(ed_delta);
    if steigen then p:=p+diff
               else p:=p-diff;
    if (p>ein_double(ed_bis)) then steigen:=false;
    if (p<ein_double(ed_von)) then steigen:=true;
    ed_parameter.text:=_strkomma(p,1,2)
  end;
  paintbox1paint(sender);
end;
```

# Save function
```pascal
procedure gifsave(bitmap:tbitmap;const f:string);
var
  GIF	: TGIFImage;
begin
  GIF := TGIFImage.Create;
  try
    GIF.Assign(Bitmap);
    GIF.SaveToFile(f);
  finally
    GIF.Free;
  end;
end;
begin
  sd1.filterindex:=3;
  sd1.filename:='';
  if sd1.execute then begin
    try
      darstellung(sender);
    finally
      Bitmap := TBitmap.Create;
      Bitmap.Width := paintbox1.Width;
      Bitmap.Height := paintbox1.Height;

      birect.left:=0;
      birect.right:=paintbox1.width;
      birect.top:=0;
      birect.bottom:=paintbox1.height;
      myrect:=birect;

      bitmap.canvas.copyrect(biRect,paintbox1.Canvas, MyRect);
      if sd1.filterindex=2 then Bitmap.PixelFormat := pf4bit;

      if sd1.filterindex<3 then begin
        f:=tfilestream.create(sd1.filename,fmcreate);
        bitmap.savetostream(f);
        f.free;
      end;
      if sd1.filterindex=3 then gifsave(bitmap,sd1.filename);
      if sd1.filterindex=4 then metadatei;
      Bitmap.Free;
    end;
  end;
end;
```

# Update List:
* [Curve inversion](https://github.com/Real-hackbard/Graphical-functions/tree/main/Curve%20inversion)
* [Graphical functions](https://github.com/Real-hackbard/Graphical-functions/tree/main/Graphical%20functions)
* [Implicit Curves](https://github.com/Real-hackbard/Graphical-functions/tree/main/Implicit%20Curves)
* [Trigonometric regression](https://github.com/Real-hackbard/Graphical-functions/tree/main/Trigonometric%20regression)

