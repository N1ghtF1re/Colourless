object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 412
  ClientWidth = 711
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 526
    Height = 412
    Align = alClient
    OnMouseUp = Image1MouseUp
    ExplicitWidth = 553
    ExplicitHeight = 409
  end
  object pnlSidebar: TPanel
    Left = 526
    Top = 0
    Width = 185
    Height = 412
    Align = alRight
    Color = clInfoBk
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 24
      Top = 336
      Width = 145
      Height = 49
      Caption = #1055#1088#1086#1074#1077#1088#1100' '#1084#1077#1085#1103' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
      TabOrder = 0
    end
  end
end
