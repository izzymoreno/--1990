unit UWriteThread;

interface

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TWriteThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TWriteThread }

uses
  SysUtils, Windows, Classes, Graphics;

type
  TWriteThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure DoWork;
    procedure Execute; override;
  public
    Count: integer;
    //procedure OnCanvasPaint(Sender: TObject);
    constructor Create(Suspended: boolean);
  end;

implementation

uses UMainProg;

//procedure TWriteThread.OnCanvasPaint(Sender: TObject);
//begin
//inc(Count);
//end;

constructor TWriteThread.Create(Suspended: boolean);
begin
  Count := 0;
  inherited Create(Suspended);
end;

procedure TWriteThread.Execute;
begin
{Пока процесс не прервали, выполняем DoWork}
  while not Terminated do
    begin

   //первый вариант
    try
      CriticalSection.Enter;
      //CriThreadFight := 'Trolo-lo-lo!';
    finally
      CriticalSection.Leave;
    end;

    Synchronize(DoWork);
//    DoWork;
     sleep(1);
    end;

end;

procedure TWriteThread.DoWork;
//var Bitmap: TMyBitmap;
begin
//первый вариант

  try
    CriticalSection.Enter;
    if Form1.Image1.Canvas.LockCount = 0 then
      begin
      Form1.Image1.Canvas.Lock;
      //Form1.Image1.Canvas.TextOut(10, 30, '');
      inc(count);
      Form1.DrawFrame();
      Form1.Image1.Canvas.Unlock;
      end;
  finally
    CriticalSection.Leave;
  end;
end;

end.
