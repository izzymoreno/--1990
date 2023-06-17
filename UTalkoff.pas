unit UTalkoff;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//������������ �������� �������� ����� �������� ����� � ������ ��������������
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

//������ ����������� �����
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
//������������ ���������� �� X ��� ����, ����� ��� ������������
ThereMove := TalkoffdirectionRight;
XTalkoff:=X;
YTalkoff:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//��������� ��� ������� �����

ImgMassTalkoffMoveLeft := pTalkoffSpritesLeft;
ImgMassTalkoffMoveRight := pTalkoffSpritesRight;
//ImgMassTalkoffMoveSitLeft := pTalkoffSpritesMoveSitLeft;
//ImgMassTalkoffMoveSitRight := pTalkoffSpritesMoveSitRight;

//������� ���������� ��� �������� �����
//TalkoffSit := false;
shagx:=0;
shagy:=0;
sprleftindex := 0;
sprrightindex := 0;
sprindexshag := 0;
//ThereMove:=OwldirectionCenter;
//�������� ������ �������� �����
self.TimerAnimation.Enabled:=true;
end;

procedure TTalkoff.TimerAnimationProcessing(Sender: TObject);
begin
//����� ��� �����
//����� �� �������� ����� �������
//����� ��� �����
If (ThereMove = TalkoffdirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgTalkoffMoveLeft then
      sprleftindex := 0;
   end;
//����� ��� ������
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

//������������ �����
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
//���� � ����� ���������� ��� ������� ����� � ���������� ������������� ������� ����� � ��������������� ������.
//���������, ���� ��� ������ ������ �����
for i := FirstBrick to LastBrick do
  begin
   //������ �� ������� �������� ������������ ����� �������
  sprindex := GameWorld.GameWorldArr[i];
  //���������� ����������� Xscreen � ���������� ������������ ������.

  Form1.OverlapRects(R1, R2: TRect): Boolean;

  //VirtBitmap.Canvas.Draw(xScreen, GameWorld.WorldY, GameWorld.ImgGameWorld[sprindex]);
  // ���������� 10. 10 - ������ �������� �� 10 ��������, ���� ���
  xScreen:= xScreen + TextureWidth;
  end;

if YFreddy<= 310 then
  begin
  self.YFreddy := YFreddy + 1;
  end;
end;}

//��� ���������� �����
destructor TTalkoff.Destroy;
var
i:byte;
begin
//����� �� ������� �� ������ ������
{For i:=0 to  MaxImgFreddyMoveLeft-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveLeft[i]<>nil then ImgMassFreddyMoveLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveRight-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveRight[i]<>nil then ImgMassFreddyMoveRight[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitLeft-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveSitLeft[i]<>nil then ImgMassFreddyMoveSitLeft[i].free;
   end;
For i:=0 to  MaxImgFreddyMoveSitRight-1 Do
   begin
   //���� ������ ���������� � ������, �� �� ��� �������
   if ImgMassFreddyMoveSitRight[i]<>nil then ImgMassFreddyMoveSitRight[i].free;
   end;}
//������� ������ ��������
TimerAnimation.free;
//����� ����������� ������������� ������
inherited;
end;

end.
