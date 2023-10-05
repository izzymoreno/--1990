unit UTalkoff;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//Максимальное значение спрайтов Игоря движения влево и вправо соответственно
MaxImageTalkoff = 3;
MaxImgTalkoffMoveLeft = 8;
MaxImgTalkoffMoveRight = 8;
//Максимальное значение спрайтов Игоря ударов кулаком влево и вправо соответственно
MaxImgTalkoffFistLeft = 2;
MaxImgTalkoffFistRight = 2;

//MaxImgFreddyMoveSitLeft = 1;
//MaxImgFreddyMoveSitRight = 1;


type
    TTalkoffDirection = (TalkoffdirectionLeft, TalkoffdirectionCenter, TalkoffdirectionRight, TalkoffdirectionFirstLeft, TalkoffdirectionFirstRight);

type

   TTalkoffSpritesArr = array[0..MaxImageTalkoff] of BitMap;
   pTalkoffSpritesArr = ^TTalkoffSpritesArr;

type

  TTalkoff = class (TObject)
  public
  Name: string;

  ImgMassTalkoffMoveLeft: TList;
  ImgMassTalkoffMoveRight: TList;
  ImgMassTalkoffMoveFistLeft: TList;
  ImgMassTalkoffMoveFistRight: TList;

  owner:TWinControl;
  shagx,shagy, sprleftindex, sprrightindex, sprindexshag, KickLeftindex, KickRightindex,
  KickLeftindexshag, KickRightindexshag :integer;
  XTalkoff,YTalkoff,sprindex:integer;
  //Думаю, что нужно сделать специальный триггер: бьёт ли кулаком Игорь а в методе Show выводить эту анимацию.
  TalkoffUseFist: boolean;

//Маркер направления Игоря
  ThereMove: TTalkoffDirection;
//Таймер вывода анимации ходьбы Игоря
  TimerAnimationWalk: TTimer;
  TimerAnimationFist: TTimer;
  procedure Show;
//  procedure Gravity;
  procedure OnTimerAnimationFist(Sender: TObject);


  procedure TimerAnimationProcessing(Sender: TObject);
  Constructor CreateTalkoff(X,Y: integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight
                             {pTalkoffSpritesMoveSitLeft, pTalkoffSpritesMoveSitRight}: TList);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UWorld;

constructor TTalkoff.CreateTalkoff(X, Y:integer; ownerForm: TWinControl; var pTalkoffSpritesLeft, pTalkoffSpritesRight, pTalkoffSpritesKickLeft, pTalkoffSpritesKickRight
                             : TList);
var
i:integer;
begin
//Randomize
self.TimerAnimationWalk := TTimer.Create(nil);
self.TimerAnimationWalk.OnTimer := self.TimerAnimationProcessing;
self.TimerAnimationWalk.Interval := round(145);
self.TimerAnimationFist := TTimer.Create(nil);
self.TimerAnimationFist.Interval := round(150);
self.TimerAnimationFist.OnTimer := self.OnTimerAnimationFist;

//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);
//Направление движения Игоря
ThereMove := TalkoffdirectionRight;
XTalkoff:=X;
YTalkoff:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//Присваеваем список спрайтов созданных в главном Unit все спрайты Игоря

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;
ImgMassTalkoffMoveRight := pTalkoffSpritesRight;
ImgMassTalkoffMoveFistLeft := pTalkoffSpritesKickLeft;
ImgMassTalkoffMoveFistRight := pTalkoffSpritesKickRight;

//Заводим переменные для анимации Игоря
//TalkoffSit := false;
shagx:=0;
shagy:=0;
sprleftindex := 0;
sprrightindex := 0;
sprindexshag := 0;
KickLeftindex := 0  ;
KickRightindex := 0 ;
KickLeftindexshag := 1;
KickRightindexshag := -1;

//ThereMove:=OwldirectionCenter;
//Включаем таймер анимации Игоря
self.TimerAnimationWalk.Enabled:=true;
end;

procedure TTalkoff.OnTimerAnimationFist(Sender: TObject);
begin

//Если прибавлять индекс спрайта в Show(), то он будет дёргаться 170 раз в секунду.
//Поэтому создаём отдельный таймер, который будет прибавлять индекс спрайта 2 раза в секунду.



KickLeftindex := KickLeftindex + KickLeftindexshag;
            //Проверяем индекс массива на единицу
            if KickLeftindex >= MaxImgTalkoffFistLeft then
              begin
              KickLeftindex := 0;
              TalkoffUseFist := False;
              end;

        KickRightindex := KickRightindex + 1;
         //Проверяем индекс массива на единицу
         if KickRightindex >= MaxImgTalkoffFistRight then
           begin
           KickRightindex := 0;
           TalkoffUseFist := False;
           end;

end;

//Здесь реализован механизм смены спрайтов Игоря, когда он идёт влево или вправо в зависимомти от маркера ThereMove
procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);
begin
//Проигрываем спрайты удара кулаком влево
//Здесь мы изменяем номер спрайта удара кулаком влево

//Здесь мы изменяем номер спрайта удара кулаком вправо

//If (ThereMove = TalkoffdirectionFirstRight) then
//  begin
//   KickRightindex := KickRightindex + KickRightindexshag;
//   if KickRightindexshag >= MaxImgTalkoffMoveLeft then
//      KickRightindexshag := 0;
//   end;

//Игорь идёт вправо
//If (ThereMove = TalkoffdirectionRight) then
//   begin
//   sprrightindex := sprrightindex + sprindexshag;
//   if sprrightindex >= MaxImgTalkoffMoveRight then
//     sprrightindex := 0;
//   end;

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

//Отрисовываем Игоря, если он делает удар кулаком влево
if TalkoffUseFist = True then
      begin
         If (ThereMove = TalkoffdirectionLeft) then
            begin
            VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
            //Здесь делаем break, чтобы не выводить спрайт анимации шагов.
            exit;
            end;
         end;
     //TalkoffUseFist := False;

//Отрисовываем Игоря, если он делает удар кулаком вправо
if (TalkoffUseFist = True) then
   begin
      If (ThereMove = TalkoffdirectionRight) then
         begin
         VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
         //Здесь делаем break, чтобы не выводить спрайт анимации шагов.
         exit;
         end;
      //  TalkoffUseFist := False;
     end;


//   If (ThereMove = TalkoffdirectionFirstLeft) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
//     end;
//Отрисовываем Игоря, если он делает удар кулаком вправо

//   If (ThereMove = TalkoffdirectionFirstRight) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self. ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
//     end;

//Отображаем движения Игоря влево

   If (ThereMove = TalkoffdirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveLeft.Items[sprleftindex]);
     end;
//Отображаем движения Игоря вправо
   If (ThereMove = TalkoffdirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveRight.Items[sprrightindex]);
     end;
//Здесь Игорь должен приседать
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

//Это деструктор объекта Игоря
destructor TTalkoff.Destroy;
var
i:byte;
begin
//Здесь мы удаляем из памяти Игоря
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
TimerAnimationWalk.Free;
TimerAnimationFist.Free;
//Вызов деструктора родительского класса
inherited;
end;

end.
