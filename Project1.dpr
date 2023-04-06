program Project1;

uses
  Forms,
  UMainProg in 'C:\Freddy Hardest[Thread]\UMainProg.pas' {Form1},
  UStar in 'C:\Freddy Hardest[Thread]\UStar.pas',
  UWorld in 'C:\Freddy Hardest[Thread]\UWorld.pas',
  UTalkoff in 'C:\Freddy Hardest[Thread]\UTalkoff.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
