object Form1: TForm1
  Left = 99
  Top = 73
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = #1050#1091#1084#1080#1088'-1990  (Created by FoxSoft Inc.)'
  ClientHeight = 900
  ClientWidth = 1100
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
    Width = 1100
    Height = 900
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
