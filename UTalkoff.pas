unit UTalkoff;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//Ìàêñèìàëüíîå çíà÷åíèå ñïðàéòîâ Èãîðÿ äâèæåíèÿ âëåâî è âïðàâî ñîîòâåòñòâåííî
MaxImageTalkoff = 3;
MaxImgTalkoffMoveLeft = 8;
MaxImgTalkoffMoveRight = 8;
//Ìàêñèìàëüíîå çíà÷åíèå ñïðàéòîâ Èãîðÿ óäàðîâ êóëàêîì âëåâî è âïðàâî ñîîòâåòñòâåííî
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
  //Äóìàþ, ÷òî íóæíî ñäåëàòü ñïåöèàëüíûé òðèããåð: áü¸ò ëè êóëàêîì Èãîðü à â ìåòîäå Show âûâîäèòü ýòó àíèìàöèþ.
  TalkoffUseFist: boolean;

//Ìàðêåð íàïðàâëåíèÿ Èãîðÿ
  ThereMove: TTalkoffDirection;
//Òàéìåð âûâîäà àíèìàöèè õîäüáû Èãîðÿ
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
//Íàïðàâëåíèå äâèæåíèÿ Èãîðÿ
ThereMove := TalkoffdirectionRight;
XTalkoff:=X;
YTalkoff:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//Ïðèñâàåâàåì ñïèñîê ñïðàéòîâ ñîçäàííûõ â ãëàâíîì Unit âñå ñïðàéòû Èãîðÿ

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;
ImgMassTalkoffMoveRight := pTalkoffSpritesRight;
ImgMassTalkoffMoveFistLeft := pTalkoffSpritesKickLeft;
ImgMassTalkoffMoveFistRight := pTalkoffSpritesKickRight;

//Çàâîäèì ïåðåìåííûå äëÿ àíèìàöèè Èãîðÿ
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
//Âêëþ÷àåì òàéìåð àíèìàöèè Èãîðÿ
self.TimerAnimationWalk.Enabled:=true;
end;

procedure TTalkoff.OnTimerAnimationFist(Sender: TObject);
begin

//Åñëè ïðèáàâëÿòü èíäåêñ ñïðàéòà â Show(), òî îí áóäåò ä¸ðãàòüñÿ 170 ðàç â ñåêóíäó.
//Ïîýòîìó ñîçäà¸ì îòäåëüíûé òàéìåð, êîòîðûé áóäåò ïðèáàâëÿòü èíäåêñ ñïðàéòà 2 ðàçà â ñåêóíäó.



KickLeftindex := KickLeftindex + KickLeftindexshag;
            //Ïðîâåðÿåì èíäåêñ ìàññèâà íà åäèíèöó
            if KickLeftindex >= MaxImgTalkoffFistLeft then
              begin
              KickLeftindex := 0;
              TalkoffUseFist := False;
              end;

        KickRightindex := KickRightindex + 1;
         //Ïðîâåðÿåì èíäåêñ ìàññèâà íà åäèíèöó
         if KickRightindex >= MaxImgTalkoffFistRight then
           begin
           KickRightindex := 0;
           TalkoffUseFist := False;
           end;

end;

//Çäåñü ðåàëèçîâàí ìåõàíèçì ñìåíû ñïðàéòîâ Èãîðÿ, êîãäà îí èä¸ò âëåâî èëè âïðàâî â çàâèñèìîìòè îò ìàðêåðà ThereMove
procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);
begin
//Ïðîèãðûâàåì ñïðàéòû óäàðà êóëàêîì âëåâî
//Çäåñü ìû èçìåíÿåì íîìåð ñïðàéòà óäàðà êóëàêîì âëåâî

//Çäåñü ìû èçìåíÿåì íîìåð ñïðàéòà óäàðà êóëàêîì âïðàâî

//If (ThereMove = TalkoffdirectionFirstRight) then
//  begin
//   KickRightindex := KickRightindex + KickRightindexshag;
//   if KickRightindexshag >= MaxImgTalkoffMoveLeft then
//      KickRightindexshag := 0;
//   end;

//Èãîðü èä¸ò âïðàâî
//If (ThereMove = TalkoffdirectionRight) then
//   begin
//   sprrightindex := sprrightindex + sprindexshag;
//   if sprrightindex >= MaxImgTalkoffMoveRight then
//     sprrightindex := 0;
//   end;

//Èãîðü èä¸ò âëåâî
If (ThereMove = TalkoffdirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgTalkoffMoveLeft then
      sprleftindex := 0;
   end;
//Èãîðü èä¸ò âïðàâî
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

//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âëåâî
if TalkoffUseFist = True then
      begin
         If (ThereMove = TalkoffdirectionLeft) then
            begin
            VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
            //Çäåñü äåëàåì break, ÷òîáû íå âûâîäèòü ñïðàéò àíèìàöèè øàãîâ.
            exit;
            end;
         end;
     //TalkoffUseFist := False;

//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âïðàâî
if (TalkoffUseFist = True) then
   begin
      If (ThereMove = TalkoffdirectionRight) then
         begin
         VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
         //Çäåñü äåëàåì break, ÷òîáû íå âûâîäèòü ñïðàéò àíèìàöèè øàãîâ.
         exit;
         end;
      //  TalkoffUseFist := False;
     end;


//   If (ThereMove = TalkoffdirectionFirstLeft) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveFistLeft.Items[KickLeftindex]);
//     end;
//Îòðèñîâûâàåì Èãîðÿ, åñëè îí äåëàåò óäàð êóëàêîì âïðàâî

//   If (ThereMove = TalkoffdirectionFirstRight) then
//     begin
//     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self. ImgMassTalkoffMoveFistRight.Items[KickRightindex]);
//     end;

//Îòîáðàæàåì äâèæåíèÿ Èãîðÿ âëåâî

   If (ThereMove = TalkoffdirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveLeft.Items[sprleftindex]);
     end;
//Îòîáðàæàåì äâèæåíèÿ Èãîðÿ âïðàâî
   If (ThereMove = TalkoffdirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XTalkoff, self.YTalkoff, self.ImgMassTalkoffMoveRight.Items[sprrightindex]);
     end;
//Çäåñü Èãîðü äîëæåí ïðèñåäàòü
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
//Áåð¸ì â öèêëå ïåðå÷ñëÿåì âñå ñïðàéòû çåìëè è ñðàâíèâàåì ïðÿìîóãîëüíèê ñïðàéòà çåìëè ñ ïðÿìîóãîëüíèêîì Ôðåääè.
//Ïðîâåðÿåì, åñëè ïîä íîãàìè Ôðåääè ãðóíò
for i := FirstBrick to LastBrick do
  begin
   //×èòàåì èç ìàññèâà èãðîâîãî ïðîñòðàíñòâà íîìåð ñïðàéòà
  sprindex := GameWorld.GameWorldArr[i];
  //Íåîáõîäèìî ïåðåñ÷èòàòü Xscreen â êîîðäèíàòû âèðòóàëüíîãî ýêðàíà.

  Form1.OverlapRects(R1, R2: TRect): Boolean;

  //VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);
  // Ïðèáàâëÿåì 10. 10 - ðàçìåð ñïðàéòîâ ïî 10 ïèêñåëåé, ó÷ò¸ì ýòî
  xScreen:= xScreen + TextureWidth;
  end;

if YFreddy<= 310 then
  begin
  self.YFreddy := YFreddy + 1;
  end;
end;}

//Ýòî äåñòðóêòîð îáúåêòà Èãîðÿ
destructor TTalkoff.Destroy;
var
i:byte;
begin
//Çäåñü ìû óäàëÿåì èç ïàìÿòè Èãîðÿ
{For i:=0 to  MaxImgFreddyMoveLeft-1 Do
   begin
   //Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì
   if ImgMassFreddyMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveRight-1 Do
   begin
   //Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì
   if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitLeft-1 Do
   begin
   //Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì
   if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitRight-1 Do
   begin
   //Åñëè îáúåêò ñóùåñòâóåò â ïàìÿòè, òî ìû åãî óäàëÿåì
   if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;
   end;}
//Óäàëÿåì òàéìåð àíèìàöèè
TimerAnimationWalk.Free;
TimerAnimationFist.Free;
//Âûçîâ äåñòðóêòîðà ðîäèòåëüñêîãî êëàññà
inherited;
end;

end.
