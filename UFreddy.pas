unit UFreddy;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

Const

//������������ �������� �������� ������ �������� ����� � ������ ��������������
MaxImageFreddy = 3;
MaxImgFreddyMoveLeft = 3;
MaxImgFreddyMoveRight = 3;
MaxImgFreddyMoveSitLeft = 1;
MaxImgFreddyMoveSitRight = 1;


type
    TFreddyDirection = (FreddydirectionLeft, FreddydirectionCenter, FreddydirectionRight);

type

   TFreddySpritesArr = array[0..MaxImageFreddy] of BitMap;
   pFreddySpritesArr = ^TFreddySpritesArr;

type

  TFreddy = class (TObject)
  public
  Name: string;

  ImgMassFreddyMoveLeft: TList;
  ImgMassFreddyMoveRight: TList;
  ImgMassFreddyMoveSitLeft: TList;
  ImgMassFreddyMoveSitRight: TList;

  owner:TWinControl;
  shagx,shagy, sprleftindex, sprrightindex, sprindexshag:integer;
  XFreddy,YFreddy,sprindex:integer;
  FreddySit: boolean;
  ThereMove: TFreddyDirection;
  TimerAnimation: TTimer;
  procedure Show;
//  procedure Gravity;
  procedure TimerAnimationProcessing(Sender: TObject);
  Constructor CreateFreddy(X,Y: integer; ownerForm: TWinControl; var pFreddySpritesLeft, pFreddySpritesRight,
                             pFreddySpritesMoveSitLeft, pFreddySpritesMoveSitRight: TList);
  Destructor Destroy(); override;
  end;

implementation

Uses UMainProg, UWorld;

constructor TFreddy.CreateFreddy(X, Y:integer; ownerForm: TWinControl; var pFreddySpritesLeft, pFreddySpritesRight,
                             pFreddySpritesMoveSitLeft, pFreddySpritesMoveSitRight: TList);
var
i:integer;
begin
//Randomize
self.TimerAnimation:=TTimer.Create(nil);
self.TimerAnimation.OnTimer:=self.TimerAnimationProcessing;
self.TimerAnimation.Interval:=round(145);
//self.TimTimerAnimation.Interval:=round((Random*120)+(Random*60)+1);
//������������ ���������� �� X ��� ����, ����� ��� ������������
ThereMove := FreddydirectionRight;
XFreddy:=X;
YFreddy:=Y;
//self.grad:=0;
self.owner:=ownerForm;
//��������� ��� ������� ������

ImgMassFreddyMoveLeft := pFreddySpritesLeft;
ImgMassFreddyMoveRight := pFreddySpritesRight;
ImgMassFreddyMoveSitLeft := pFreddySpritesMoveSitLeft;
ImgMassFreddyMoveSitRight := pFreddySpritesMoveSitRight;

//������� ���������� ��� �������� ������
FreddySit := false;
shagx:=0;
shagy:=0;
sprleftindex := 0;
sprrightindex := 0;
sprindexshag := 0;
//ThereMove:=OwldirectionCenter;
//�������� ������ �������� ������
self.TimerAnimation.Enabled:=true;
end;

procedure TFreddy.TimerAnimationProcessing(Sender: TObject);
begin
//������ ��� �����
//����� �� �������� ����� �������
//������ ��� �����
If (ThereMove = FreddydirectionLeft) then
  begin
   sprleftindex := sprleftindex + sprindexshag;
   if sprleftindex >= MaxImgFreddyMoveLeft then
      sprleftindex := 0;
   end;
//������ ��� ������
If (ThereMove = FreddydirectionRight) then
   begin
   sprrightindex := sprrightindex + sprindexshag;
   if sprrightindex >= MaxImgFreddyMoveRight then
     sprrightindex := 0;
   end;
end;

procedure TFreddy.Show;
begin

//Gravity;

//������������ ������
   If (ThereMove = FreddydirectionLeft) then
     begin
     VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveLeft.Items[sprleftindex]);
     end;

   If (ThereMove = FreddydirectionRight) then
     begin
     VirtBitmap.Canvas.Draw(self.XFreddy, self.YFreddy, self.ImgMassFreddyMoveRight.Items[sprrightindex]);
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

//��� ���������� ������
destructor TFreddy.Destroy;
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
