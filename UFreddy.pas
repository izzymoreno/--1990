unit UTalkoff;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//Максимальное значение спрайтов Игоря движения влево и вправо соответственно
MaxImageTalkoff = 3;
MaxImgTalkoffMoveLeft = 3;
MaxImgTalkoffMoveRight = 3;
//MaxImgFreddyMoveSitLeft = 1;
//MaxImgFreddyMoveSitRight = 1;


type
    TTalkoffDirection = (TalkoffdirectionLeft, TalkoffdirectionCenter, TalkoffdirectionRight);

type

   TTalkoffSpritesArr = array[0..MaxImageTalkoff] of BitMap;
   pTalkoffSpritesArr = ^TTalkoffSpritesArr;

type

  TTalkoff = class (TObject)
  public
  Name: string;

  ImgMassTalkoffMoveLeft: TList;
  ImgMassTalkoffMoveRight: TList;
//  ImgMassTalkoffMoveSitLeft: TList;
//  ImgMassTalkoffMoveSitRight: TList;

  owner:TWinControl;
  shagx,shagy, sprleftindex, sprrightindex, sprindexshag:integer;
  XTalkoff,YTalkoff,sprindex:integer;
//  FreddySit: boolean;

//Маркер направления Игоря
  ThereMove: TTalkoffDirection;
  TimerAnimation: TTimer;
  procedure Show;
//  procedure Gravity;
  procedure TimerAnimationProcessing(Sender: TObject);
  Constructor CreateTalkoff(X,Y: integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight
                             {pTalkoffSpritesMoveSitLeft, pTalkoffSpritesMoveSitRight}: TList);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UWorld;

constructor TTalkoff.CreateTalkoff(X, Y:integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight
                             {pTalkoffSpritesMoveSitLeft, pTalkoffSpritesMoveSitRight}: TList);
var
i:integer;
begin
//Randomize
self.TimerAnimation:=TTimer.Create(nil);
self.TimerAnimation.OnTimer:=self.TimerAnimationProcessing;
self.TimerAnimation.Interval:=round(145);
//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);
//Максимальная координата по X для мухи, чтобы она развернулась
ThereMove := TalkoffdirectionRight;
XTalkoff:=X;
YTalkoff:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//Загружаем все спрайты Игоря

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;
ImgMassTalkoffMoveRight := pTalkoffSpritesRight;
//ImgMassTalkoffMoveSitLeft := pTalkoffSpritesMoveSitLeft;
//ImgMassTalkoffMoveSitRight := pTalkoffSpritesMoveSitRight;

//Заводим переменные для анимации Игоря
//TalkoffSit := false;
shagx:=0;
shagy:=0;
sprleftindex := 0;
sprrightindex := 0;
sprindexshag := 0;
//ThereMove:=OwldirectionCenter;
//Включаем таймер анимации Игоря
self.TimerAnimation.Enabled:=true;
end;

procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);
begin
//Игорь идёт влево
//Здесь мы изменяем номер спрайта
//Игорь идёт влево
If (ThereMove = TalkoffdirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgTalkoffMoveLeft then
      sprleftindex := 0;
   end;
//Игорь идёт вправо
If (ThereMove = TalkoffdirectionRight) then
   begin
   sprrightindex := sprrightindex + sprindexshag;
   if sprrightindex >= MaxImgTalkoffMoveRight then
     sprrightindex := 0;
   end;
end;

procedure TTalkoff.Show;
begin

//Gravity;

//Отрисовываем Игоря
   If (ThereMove = TalkoffdirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveLeft.Items[sprleftindex]);
     end;

   If (ThereMove = TalkoffdirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveRight.Items[sprrightindex]);
     end;

   {if (Freddy.FreddySit = false) then
     if (ThereMove = FreddydirectionLeft) then
       begin
       VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveLeft.Items[sprleftindex]);
       exit;
       end
         else
           if (ThereMove = FreddydirectionRight) then
           begin
           VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveRight.Items[0]);
           exit;
           end;

   if Freddy.FreddySit = true then
     begin
      if (ThereMove = FreddydirectionLeft) then
        begin
        VirtBitmap.Canvas.Draw(self.XFreddy-8, self.YFreddy+10, self.ImgMassFreddyMoveSitLeft.Items[0]);
        exit;
        end
          else
          if (ThereMove = FreddydirectionRight) then
            begin
            VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy+10, self.ImgMassFreddyMoveSitRight.Items[sprrightindex]);
            exit;
            end;
     end;}
end;

{procedure TFreddy.Gravity;
var
i, Xscreen: integer;
sprindex: byte;
FirstBrick: integer;
LastBrick : integer;
begin
//Берём в цикле перечсляем все спрайты земли и сравниваем прямоугольник спрайта земли с прямоугольником Фредди.
//Проверяем, если под ногами Фредди грунт
for i := FirstBrick to LastBrick do
  begin
   //Читаем из массива игрового пространства номер спрайта
  sprindex := GameWorld.GameWorldArr[i];
  //Необходимо пересчитать Xscreen в координаты виртуального экрана.

  Form1.OverlapRects(R1, R2: TRect): Boolean;

  //VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);
  // Прибавляем 10. 10 - размер спрайтов по 10 пикселей, учтём это
  xScreen:= xScreen + TextureWidth;
  end;

if YFreddy<= 310 then
  begin
  self.YFreddy := YFreddy + 1;
  end;
end;}

//Это деструктор Игоря
destructor TTalkoff.Destroy;
var
i:byte;
begin
//Здесь мы удаляем из памяти Фредди
{For i:=0 to  MaxImgFreddyMoveLeft-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveRight-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitLeft-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitRight-1 Do
   begin
   //Если объект существует в памяти, то мы его удаляем
   if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;
   end;}
//Удаляем таймер анимации
TimerAnimation.free;
//Вызов деструктора родительского класса
inherited;
end;

end.

