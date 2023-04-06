unit UWorld;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UFreddy;

  Const

  //Максимальное длина игрового мира
  TextureWidth = 16; //10
// Длина игрового пространства
  GameWorldMaxX = 110;
//Массив игрового пространства
  GameWorldConst: array[0..GameWorldMaxX - 1] of byte = (0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         0, 1, 2, 3, 4, 5, 6, 0, 0, 0,
                                                         1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                         1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                         1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                         1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                         1, 0, 0, 0, 0, 0, 0, 0, 0, 0 );
type

  TGameWorld = class (TObject)
  public
  //TimerAnimation: TTimer;
  //Массив спрайтов игрового пространства
  WorldX, WorldY: integer;
  ImgGameWorld: array[0..6] of TBitMap;
  //Задаём спрайты игрового пространства
  GameWorldArr: array[0..GameWorldMaxX - 1] of byte;
  //procedure TimerAnimationProccessing(Sender: TObject);
  procedure Show;
  Constructor CreateGameWorld(ownerForm: TWinControl);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UStar;

constructor TGameWorld.CreateGameWorld(ownerForm: TWinControl);
var
i:integer;
begin
//Присваиваем значение переменным игрового пространства по X и Y
WorldX := 0;//40
WorldY := 350;

For i:=0 to length(GameWorldArr) - 1  Do
  begin
  GameWorldArr[i] := GameWorldConst[i];
  end;


//Загружаем спрайты в массив игрового пространства
For i := 0 to length(ImgGameWorld) - 1  Do
   begin
   ImgGameWorld[i]:=TBitMap.Create;
   ImgGameWorld[i].LoadFromFile(ExePath + 'Graphics\Ground'+IntToStr(i)+'.bmp');
   ImgGameWorld[i].Transparent:=True;
   ImgGameWorld[i].TransparentMode:=tmFixed;
   ImgGameWorld[i].TransparentColor:=clBlack;
   //ImgMassStar[i].Canvas.Brush.Color:=clPurple;
   end;
//Включаем таймер звёзд
//self.TimerAnimation := TTimer.Create(nil);
//self.TimerAnimation.OnTimer:=self.TimerAnimationProccessing;
//self.TimerAnimation.Interval:=round((Random*200)+500);
//TimerAnimation.Enabled:=true;
end;

procedure TGameWorld.Show;
var
i, Xscreen: integer;
sprindex: byte;
FirstBrick: integer;
LastBrick : integer;
begin
xScreen := 0;

//Мы должны пиксели координаты XWorld пересчитать в первый кирпич, с которого мы должны начать выводить игровое пространство.
FirstBrick := round(WorldX div TextureWidth);
LastBrick := FirstBrick + round(VirtBitmap.Width div TextureWidth * TextureWidth/TextureWidth);
if FirstBrick <= 0 then
  begin
  FirstBrick := 0;
  if WorldX < 0 then WorldX:= 0;
  end;
if LastBrick >= Length(GameWorldArr) then
  begin
  LastBrick := Length(GameWorldArr);
  if WorldX > (((LastBrick + 1) * TextureWidth) - VirtBitmap.Width) then WorldX := ((LastBrick + 1) * TextureWidth) - VirtBitmap.Width;
  end;
xScreen := -round(WorldX - WorldX div TextureWidth * TextureWidth);
for i := FirstBrick to LastBrick do
  begin
   //Читаем из массива игрового пространства номер спрайта
  sprindex := self.GameWorldArr[i];
  //Необходимо пересчитать Xscreen в координаты виртуального экрана.
  VirtBitmap.Canvas.Draw(xScreen, self.WorldY, self.ImgGameWorld[sprindex]);
  // Прибавляем 10. 10 - размер спрайтов по 10 пикселей, учтём это
  xScreen:= xScreen + TextureWidth;
  end;

VirtBitmap.Canvas.Font.Size := 8;
VirtBitmap.Canvas.Font.Color := clWhite;
VirtBitmap.Canvas.TextOut( 10, 10, 'WorldX=' + inttostr(WorldX));
VirtBitmap.Canvas.TextOut( 10, 30, 'FirstBrick=' + inttostr(FirstBrick));
VirtBitmap.Canvas.TextOut( 10, 50, 'LastBrick=' + inttostr(LastBrick));

end;

//Это деструктор спрайтов игрового пространства
destructor TGameWorld.Destroy;
var
i:byte;
begin
//Здесь мы удаляем из памяти звёзды
For i:=0 to length(ImgGameWorld) - 1  Do
   begin
   ImgGameWorld[i].Free;
   //ImgMassStar[i].Canvas.Brush.Color:=clPurple;
   end;
//Удаляем таймер
//TimerAnimation.free;
//Вызов деструктора родительского класса
inherited;
end;

end.
