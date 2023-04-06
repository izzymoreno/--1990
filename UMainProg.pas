unit UMainProg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math, StdCtrls, UStar, UWorld, UFreddy, USky, uWriteThread, SyncObjs;

Const
//�������� ���������
//������������ ���������� ����
MaxStars = 100;
//������ ������
xmax = 642;
ymax = 485;
xmin = 0;
ymin = 0;
XScreenMax = 642;
YScreenMax = 485;


type
  TForm1 = class(TForm)
    Image1: TImage;
    TimerFPS: TTimer;
    Timer1: TTimer;
    //�������� ���������, ������� ������ ����������
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    //�������� ������ �����
    procedure TimerFPSTimer(Sender: TObject);
    procedure DrawFrame();
    //��������� ������� �� �������
    function OverlapRects(R1, R2: TRect): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //��������� ���������� �������
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  procedure InitGame();
  end;

var
  //
  Form1: TForm1;
  //������ ����
  ExePath: string;
  //������ �������� ����
  Stars: array[0..MaxStars - 1] of TMyStar;
  //������ ������
  Freddy: TFreddy;
  //������� ������������
  GameWorld: TGameWorld;
  GameSky: TGameSky;
  //������� ������
  WriteThread : TWriteThread;
  CriticalSection: TCriticalSection;
  Tick, FPS: integer;
  //������ ��������� ������
  FreddySpritesArrLeft: TList;
  FreddySpritesArrRight: TList;
  FreddySpritesArrSitLeft: TList;
  FreddySpritesArrSitRight: TList;


//������� ����������� Canvas
VirtBitmap: TBitmap;

//����
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
i:integer;
SX,SY:integer;
begin
Tick := gettickcount();
ExePath := ExtractFilePath(Application.ExeName);
//��������� Canvas ������ ������
self.TimerFPS.Enabled:=false;
self.TimerFPS.Interval:=20;
//��������� ������� ������������ ������ ������
Form1.Image1.Canvas.Brush.Color:=clBlack;
//������ ������� ��������������
Form1.Image1.Canvas.FillRect(Rect(xmin,ymin,XScreenMax,YScreenMax));
//������ ������
Form1.Image1.Width:=XScreenMax;
//������ ������
Form1.Image1.Height:=YScreenMax;
//������ ����������� Bitmap
VirtBitmap:=TBitmap.Create;
VirtBitmap.Width:=Image1.Width;
VirtBitmap.Height:=Image1.Height;
VirtBitmap.Canvas.Brush.Color:=clBlack;
VirtBitmap.Canvas.FillRect(Rect(xmin,ymin,XScreenMax,YScreenMax));
InitGame();
//������ �����
for i := 0 to MaxStars-1 do
   begin
   //������ ����� � ������������� ������������ ���������� �� X � ��������� �� Y
//�� X
   SX:=round(Random*xmax);
//
   SY:=round(Random*ymax-250);
//�� Y
   Stars[i]:= TMyStar.CreateStar(SX,SY, 'left', Form1);
   end;
//������ ������� ������������
GameWorld := TGameWorld.CreateGameWorld(Form1);
GameSky :=  TGameSky.CreateGameSky(Form1);
//������ ������
Freddy := TFreddy.CreateFreddy(305, 310, Form1, FreddySpritesArrLeft, FreddySpritesArrRight,
                             FreddySpritesArrSitLeft, FreddySpritesArrSitRight);
//�������� ������ ���������
self.TimerFPS.Enabled:=true;
//������� ����� �����
WriteThread := TWriteThread.Create(False);
CriticalSection := TCriticalSection.Create;
WriteThread.Priority := tpNormal;//Highest;//tpHighest;
WriteThread.Priority := tpHigher;//tpHighest;
WriteThread.Priority := tpTimeCritical;
//InitializeCriticalSection(CS);
end;

procedure TForm1.InitGame;
var
i:integer;
tmpBitmap: TBitmap;
begin
//��������� � ������� ������ ���������� �����
FreddySpritesArrLeft := TList.Create;
For i:=0 to MaxImgFreddyMoveLeft - 1 Do
   begin
   tmpBitmap :=TBitMap.Create;
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Freddy\FreddyMoveLeft\Freddy'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   FreddySpritesArrLeft.Add(tmpBitmap);
   end;
//��������� � ������� ������ ���������� ������
FreddySpritesArrRight := TList.Create;
For i:=0 to MaxImgFreddyMoveRight - 1 Do
   begin
   tmpBitmap :=TBitMap.Create;
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Freddy\FreddyMoveRight\Freddy'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   FreddySpritesArrRight.Add(tmpBitmap);
   end;
//��������� � ������� ������ �������� �����
FreddySpritesArrSitLeft := TList.Create;
For i:=0 to MaxImgFreddyMoveSitLeft - 1 Do
   begin
   tmpBitmap :=TBitMap.Create;
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Freddy\FreddySitLeft\Freddy'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   FreddySpritesArrSitLeft.Add(tmpBitmap);
   end;
//��������� � ������� ������ �������� ������
FreddySpritesArrSitRight := TList.Create;
For i:=0 to MaxImgFreddyMoveSitRight - 1 Do
   begin
   tmpBitmap :=TBitMap.Create;
   tmpBitmap.LoadFromFile(ExePath+'Graphics\Freddy\FreddySitRight\Freddy'+IntToStr(i)+'.bmp');
   tmpBitmap.Transparent:=True;
   tmpBitmap.TransparentMode:=tmFixed;
   tmpBitmap.TransparentColor:=clBlack;
   FreddySpritesArrSitRight.Add(tmpBitmap);
   end;
end;

function TForm1.OverlapRects(R1, R2: TRect): Boolean;
var
  Temp: TRect;
begin
  Result := False;
  if not UnionRect(Temp, R1, R2) then
    Exit;
  if (Temp.Right - Temp.Left <= R1.Right - R1.Left + R2.Right - R2.Left) and
    (Temp.Bottom - Temp.Top <= R1.Bottom - R1.Top + R2.Bottom - R2.Top) then
    Result := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
i:integer;
begin
//��������� ������ ���������
self.TimerFPS.Enabled:=false;
//������� �� ������ ������ ����
for i := 0 to MaxStars-1 do
   begin
   Stars[i].free;
   end;
//������� �� ������ ������� ������������
GameWorld.Free;
GameSky.Free;
//������� �� ������ ������
Freddy.Free;
//������� �� ������ ����������� Canvas
VirtBitmap.Free;
WriteThread.Terminate;
CriticalSection.free;
end;

//
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Form1.Caption := IntToStr(Key);
   case key of
   vk_left:
         begin
//����������� ������� ������������ �� ��� �����
         If Freddy.FreddySit = false then
           begin
           GameWorld.WorldX := GameWorld.WorldX - 3;
           GameSky.SkyX := GameSky.SkyX - 1;
           end;
//�������� ������
         Freddy.sprindexshag := 1;
//������������� ���
         Freddy.shagx := -1;
//������ ��������������� �����
         Freddy.ThereMove := FreddydirectionLeft;
         end;
   vk_right:
         begin
//����������� ������� ������������ �� ��� ������
         If Freddy.FreddySit = false then
           begin
           GameWorld.WorldX := GameWorld.WorldX + 3;
           GameSky.SkyX := GameSky.SkyX + 1;
           end;
//�������� ������
         Freddy.sprindexshag := 1;
//������������� ���
         Freddy.shagx := 1;
//������ ��������������� ������
         Freddy.ThereMove := FreddydirectionRight;
         end;
   vk_down:
           begin
           Freddy.FreddySit := true;
           Freddy.sprindexshag := 0;
           end;
   vk_up:
        begin
        Freddy.FreddySit := false;
        Freddy.sprindexshag := 0;
        end;
     end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
//������ ���������������
Freddy.sprindexshag := 0;
end;

procedure TForm1.TimerFPSTimer(Sender: TObject);
begin
DrawFrame();
end;

procedure TForm1.DrawFrame();
var
i:integer;
begin
if (Tick + 1000) < gettickcount() then
  begin
  Tick := gettickcount();
  if WriteThread.Count > 0 then
    begin
    FPS := round(WriteThread.Count);
    WriteThread.Count := 0;
    end;
  end;

//�������������� Canvas
VirtBitmap.Canvas.FillRect(Rect(0,0,VirtBitmap.Width,VirtBitmap.Height));
//������� ������� ������������
GameWorld.Show;
//������� ����
GameSky.Show;
//������� ������
Freddy.Show;
//������ ������ ������������ �� ����������� ������
//�����
for i := 0 to MaxStars - 1 do
   begin
   If Stars[i] <> nil then
      begin
      Stars[i].Show();
      end;
   end;

VirtBitmap.Canvas.TextOut(10, 100, 'FPS=' + inttostr(FPS));
//�������� ����������� ������
Form1.Image1.Canvas.Draw(10, 10, VirtBitmap);
application.ProcessMessages;
end;

end.
