unit TGATexture;

interface

uses
  Windows,
  Messages,
  Sysutils,
  Graphics,
  JPEG,
  OpenGL12;

Var
  Tex: array of glUint;
  CurTex: integer = 0;

function LoadTGA(filename : string; var TexId: glUint; Mipmap:boolean) : boolean;			// Loads A TGA File Into Memory
Function LoadTex(Path: string; Mipmap: boolean): integer;
function LoadJPG(Filename: String; var Texture: GLuint): Boolean;
Procedure ChangeTex(I: integer);

implementation

procedure glGenTextures(n: GLsizei; var textures: GLuint); stdcall; external 'opengl32.dll';
procedure glBindTexture(target: GLenum; texture: GLuint); stdcall; external 'opengl32.dll';

type TextureImage = record	 						// Structure Name
	imageData : PChar;										// Image Data (Up To 32 Bits)
	bpp : GLuint;							    				// Image Color Depth In Bits Per Pixel.
	width : GLuint;								  			// Image Width
	height : GLuint;											// Image Height
	texID : GLuint;
  end;

function LoadTGA( filename : string; var TexId: glUint; MipMap: boolean) : boolean;			// Loads A TGA File Into Memory
const
  TGAheader : array [0..11] of GLubyte = (0,0,2,0,0,0,0,0,0,0,0,0);	// Uncompressed TGA Header
  TGAComheader : array [0..11] of GLubyte = (0,0,10,0,0,0,0,0,0,0,0,0);	// Compressed TGA Header

var
  TGAcompare : array [0..11] of GLubyte;						// Used To Compare TGA Header
  header : array [0..5] of GLubyte;									// First 6 Useful Bytes From The Header
  bytesPerPixel : GLuint;					// Holds Number Of Bytes Per Pixel Used In The TGA File
  imageSize : GLuint;					 		// Used To Store The Image Size When Setting Aside Ram
  i : GLuint;								   		// Temporary Variable
  gltype : GLuint;					 			// Set The Default GL Mode To RBGA (32 BPP)
  Compressed:boolean;

  Tm: Char;
  Texture:  TextureImage;
  tgafile : integer;
  MaxSize: integer;
  TD: pchar;
  ScaleF: single;
  OldW, OldH, X, Y: integer;

  PixelCount, CurrentPixel, CurrentByte: gluInt;
  ColorBuffer: Pchar;
  ChunkHeader: gluByte;
  Counter, Ret: integer;
begin
  tgafile := FileOpen(filename, fmOpenReadWrite);

  Ret := FileRead(tgafile, TGAcompare, sizeof(TGAcompare));

  if (
      (tgafile = -1) or								// Does File Even Exist?
      (Ret <> sizeof(TGAcompare))	// Are There 12 Bytes To Read?
     )
  then
  begin
    if (tgafile = -1) then									// Did The File Even Exist? *Added Jim Strong*
    begin
      result := false;									// Return False
      exit;
    end
    else
    begin
      fileclose(tgafile);									// If Anything Failed, Close The File
      result := false;									// Return False
      exit;
    end;
  end;

  if (CompareMem(@TGAheader, @TGAcompare, sizeof(TGAheader)) = false)	                // Does The Header Match What We Want?
  Then
  begin //File is not uncompressed...

   if (CompareMem(@TGAComheader, @TGAcompare, sizeof(TGAComheader)) = True)	                // Does The Header Match What We Want?
   Then
   Begin
      Compressed := True;
   end
   else
   Begin
     i := 0;
     if (tgafile = -1) then									// Did The File Even Exist? *Added Jim Strong*
     begin
       result := false;									// Return False
       exit;
     end
     else
     begin
       fileclose(tgafile);									// If Anything Failed, Close The File
       result := false;									// Return False
       exit;
     end;
    end;

  end
  else
  begin
   Compressed := False;
  end;

   if (FileRead(tgafile, header, sizeof(header)) <> sizeof(header)) then
   begin
     if (tgafile = -1) then									// Did The File Even Exist? *Added Jim Strong*
     begin
       result := false;									// Return False
       exit;
     end
     else
     begin
       fileclose(tgafile);									// If Anything Failed, Close The File
       result := false;									// Return False
       exit;
     end;
   end;

  texture.width  := header[1] * 256 + header[0];			// Determine The TGA Width	(highbyte*256+lowbyte)
  texture.height := header[3] * 256 + header[2];			// Determine The TGA Height	(highbyte*256+lowbyte)

  if (texture.width <= 0)	or								// Is The Width Less Than Or Equal To Zero
     (texture.height <= 0)	or								// Is The Height Less Than Or Equal To Zero
     ((header[4] <> 24) and (header[4] <> 32)) then					// Is The TGA 24 or 32 Bit?
  begin
    fileclose(tgafile);										// If Anything Failed, Close The File
    result := false;										// Return False
    exit;
  end;

  texture.bpp	:= header[4];							// Grab The TGA's Bits Per Pixel (24 or 32)
  bytesPerPixel	:= texture.bpp div 8;						// Divide By 8 To Get The Bytes Per Pixel
  imageSize	:= texture.width * texture.height * bytesPerPixel;	// Calculate The Memory Required For The TGA Data


  GetMem(texture.imageData, imageSize);		// Reserve Memory To Hold The TGA Data
  if Not Compressed then
  begin
   if (texture.imageData = nil) or	       // Does The Storage Memory Exist?
      (fileread(tgafile, texture.imageData^, integer(imageSize)) <> imageSize)	// Does The Image Size Match The Memory Reserved?
      then
      begin
        if (texture.imageData <> nil)						// Was Image Data Loaded
           then freemem(texture.imageData);						// If So, Release The Image Data

        fileclose(tgafile);										// Close The File
        result := false;										// Return False
        exit;
      end;

    i := 0;
    while i < imageSize do
    with texture do
    begin
     Tm := ImageData[I+2];
     imageData[i+2] := imageData[i];					// Set The 3rd Byte To The Value In 'temp' (1st Byte Value)
     imageData[i] := Tm;                          // Set The 1st Byte To The Value Of The 3rd Byte

     i := i + bytesPerPixel;
    end;

 end
 else  //COMPRESSED TGA'S
 begin
   PixelCount := texture.width * Texture.Height;
   CurrentPixel := 0;
   CurrentByte := 0;
   GetMem(ColorBuffer, BytesPerPixel);

   Repeat
      ChunkHeader := 0;
      if FileRead(tgaFile, ChunkHeader, sizeof(gluByte)) = 0 then
      begin
        //ERROR reading Chunk!
        fileclose(tgafile);										// Close The File
        result := false;										// Return False
        exit;
      end;


      if ChunkHeader < 128 then
      begin
         ChunkHeader := ChunkHeader + 1;
         For Counter := 0 to ChunkHeader-1 do
         begin
            if fileRead(tgafile, ColorBuffer^, BytesPerPixel) <> BytesPerPixel then
            begin
             fileclose(tgafile);										// Close The File
             result := false;										// Return False
             exit;
            end;

            Texture.imageData[CurrentByte] := (ColorBuffer[2]);
            Texture.imageData[CurrentByte+1] := (ColorBuffer[1]);
            Texture.imageData[CurrentByte+2] := (ColorBuffer[0]);
            if BytesPerPixel = 4 then
            Texture.imageData[CurrentByte+3] := (ColorBuffer[3]);

            CurrentByte := CurrentByte + bytesPerPixel;
            inc(CurrentPixel);
            if CurrentPixel > PixelCount then
            begin
             fileclose(tgafile);										// Close The File
             //ShowError(18, 'TGATexture.LoadTGA', False);
             result := false;										// Return False
             exit;
            end;
         end;
      end
      else //Chunkheader > 128
      begin
         ChunkHeader := ChunkHeader - 128;
         if fileRead(tgafile, ColorBuffer^, BytesPerPixel) <> BytesPerPixel then
         begin
          fileclose(tgafile);										// Close The File
          result := false;										// Return False
          exit;
         end;
         For Counter := 0 to ChunkHeader do
         begin
            Texture.imageData[CurrentByte] := ColorBuffer[2];
            Texture.imageData[CurrentByte+1] := ColorBuffer[1];
            Texture.imageData[CurrentByte+2] := ColorBuffer[0];
            if BytesPerPixel = 4 then
            Texture.imageData[CurrentByte+3] := ColorBuffer[3];

            CurrentByte := CurrentByte + bytesPerPixel;
            inc(CurrentPixel);
         end;

      end;
   Until CurrentPixel >= PixelCount;
 end;
 fileclose (tgafile);											// Close The File

 glGetIntegerv(GL_MAX_TEXTURE_SIZE, @MaxSize);

 // Messagebox(0, pchar('Biggest Texture size = '+ inttostr(MaxSize)), '', MB_OK);

  OldW := -1;



  if Texture.width > Texture.Height then
  begin
   if Texture.width > Maxsize then
   begin
    ScaleF := MaxSize / Texture.width;
     OldW := texture.width;
     OldH := Texture.Height;
     texture.width := Maxsize;
     Texture.Height := round(Texture.Height*ScaleF);
   end;
  end
  else
  begin
   if Texture.height > cardinal(Maxsize) then
   begin
     ScaleF := MaxSize / Texture.height;
     OldW := texture.width;
     OldH := Texture.Height;
     texture.height := Maxsize;
     Texture.width := round(Texture.width*ScaleF);
   end;
  end;

  if OldW > -1 then
  begin
     ScaleF := 1/ScaleF;
     GetMem(TD, Texture.Width*Texture.height*Bytesperpixel);
     For X := 0 to Texture.Width-1 do
     For Y := 0 to Texture.Height-1 do
     begin
        For I := 0 to bytesperpixel-1 do
        TD[(Y*Texture.Width+X)*bytesperpixel+I] := Texture.imagedata[
                        round(((Y*OldW)*ScaleF+(X*ScaleF))*bytesperpixel+I)
                        ];
     end;
     freemem(Texture.imagedata);
     Texture.imagedata := Td;
  end;
  // Build A Texture From The Data

  glGenTextures(1, texture.texID);					// Generate OpenGL texture IDs

  if texture.bpp = 24 then									// Was The TGA 24 Bits
            gltype := GL_RGB
            else
            gltype := GL_RGBA;										// If So Set The 'type' To GL_RGB

  glBindTexture(GL_TEXTURE_2D, texture.texID);			        // Bind Our Texture
  if MipMap then
  begin
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);	// Linear Filtered
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR_MIPMAP_NEAREST);	// Linear Filtered
  gluBuild2DMipMaps(GL_TEXTURE_2D, 3,texture.width, texture.height, glType, GL_UNSIGNED_BYTE, Texture.Imagedata);
  end
  else
  begin
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);	// Linear Filtered
  glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);	// Linear Filtered
  glTexImage2D(GL_TEXTURE_2D, 0, gltype, texture.width, texture.height, 0, gltype, GL_UNSIGNED_BYTE, texture.imageData);
  end;

  TexId := Texture.texID;
  result := true;											// Texture Building Went Ok, Return True
end;

function CreateTexture(Width, Height, Format : Word; pData : Pointer) : Integer;
var
  Texture : GLuint;
begin
  glGenTextures(1, Texture);
  glBindTexture(GL_TEXTURE_2D, Texture);
  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);  {Texture blends with object background}
//  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL);  {Texture does NOT blend with object background}

  { Select a filtering type. BiLinear filtering produces very good results with little performance impact
    GL_NEAREST               - Basic texture (grainy looking texture)
    GL_LINEAR                - BiLinear filtering
    GL_LINEAR_MIPMAP_NEAREST - Basic mipmapped texture
    GL_LINEAR_MIPMAP_LINEAR  - BiLinear Mipmapped texture
  }

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR); { only first two can be used }
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR); { all of the above can be used }

  if Format = GL_RGBA then
    gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, Width, Height, GL_RGBA, GL_UNSIGNED_BYTE, pData)
  else
    gluBuild2DMipmaps(GL_TEXTURE_2D, 3, Width, Height, GL_RGB, GL_UNSIGNED_BYTE, pData);
//  glTexImage2D(GL_TEXTURE_2D, 0, 3, Width, Height, 0, GL_RGB, GL_UNSIGNED_BYTE, pData);  // Use when not wanting mipmaps to be built by openGL

  result :=Texture;
end;


function LoadJPG(Filename: String; var Texture: GLuint): Boolean;
var
  Data : Array of LongWord;
  W, Width : Integer;
  H, Height : Integer;
  BMP : TBitmap;
  JPG : TJPEGImage;
  C : LongWord;
  Line : ^LongWord;

  MaxSize: integer;
  TD: Array of LongWord;
  ScaleF: single;
  OldW, OldH, X, Y: integer;

begin
  result :=FALSE;
  JPG:=TJPEGImage.Create;

    try
      JPG.LoadFromFile(Filename);
    except
      MessageBox(0, PChar('Couldn''t load JPG - "'+ Filename +'"'), PChar('BMP Unit'), MB_OK);
      Exit;
    end;

  // Create Bitmap
  BMP:=TBitmap.Create;
  BMP.pixelformat:=pf32bit;
  BMP.width:=JPG.width;
  BMP.height:=JPG.height;
  BMP.canvas.draw(0,0,JPG);        // Copy the JPEG onto the Bitmap


  //  BMP.SaveToFile('D:\test.bmp');
  Width :=BMP.Width;
  Height :=BMP.Height;
  SetLength(Data, Width*Height);

  For H:=0 to Height-1 do
  Begin
    Line :=BMP.scanline[Height-H-1];   // flip JPEG
    For W:=0 to Width-1 do
    Begin
      c:=Line^ and $FFFFFF; // Need to do a color swap
      Data[W+(H*Width)] :=(((c and $FF) shl 16)+(c shr 16)+(c and $FF00)) or $FF000000;  // 4 channel.
      inc(Line);
    End;
  End;

  BMP.free;
  JPG.free;

 glGetIntegerv(GL_MAX_TEXTURE_SIZE, @MaxSize);

  OldW := -1;

  if width > Height then
  begin
   if width > Maxsize then
   begin

     ScaleF := MaxSize / width;
     OldW := width;
     OldH := Height;
     width := Maxsize;
     Height := round(Height*ScaleF);
   end;
  end
  else
  begin
   if height > Maxsize then
   begin
     ScaleF := MaxSize / height;
     OldW := width;
     OldH := Height;
     height := Maxsize;
     width := round(width*ScaleF);
   end;
  end;

  if OldW > -1 then
  begin
     ScaleF := 1/ScaleF;
     SetLength(TD, Width*Height);
     For X := 0 to Width-1 do
     For Y := 0 to Height-1 do
     begin
        TD[(Y*Width+X)] := data[
                        round(((Y*OldW)*ScaleF+(X*ScaleF)))
                        ];
     end;
     SetLength(Data, Width*Height);
     For Y := 0 to high(Td) do
      Data[Y] := Td[Y];
     SetLength(TD, 0);

  end;
  Texture :=CreateTexture(Width, Height, GL_RGBA, addr(Data[0]));
  result :=TRUE;
end;

Function LoadTex(Path: string; Mipmap: boolean): integer;
begin
  SetLength(Tex, High(tex)+2);
  if LoadTGA(Path, Tex[High(Tex)], MipMap) then
   Result := High(Tex)
  else
   Result := -1;
end;

Procedure ChangeTex(I: integer);
begin
  if CurTex <> I then
  begin
    CurTex := I;
    glBindTexture(GL_TEXTURE_2D, Tex[I]);
  end;
end;



end.
