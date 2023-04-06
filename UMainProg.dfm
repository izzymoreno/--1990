object Form1: TForm1
  Left = 99
  Top = 73
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = #1043#1072#1089#1080#1090#1077#1083#1100' '#1101#1082#1088#1072#1085#1072' (Created by FoxSoft Inc.)'
  ClientHeight = 485
  ClientWidth = 642
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 642
    Height = 485
    Align = alClient
    ExplicitWidth = 640
    ExplicitHeight = 480
  end
  object TimerFPS: TTimer
    OnTimer = TimerFPSTimer
  end
  object Timer1: TTimer
    Left = 24
  end
end
