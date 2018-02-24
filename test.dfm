object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 554
  ClientWidth = 974
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
    Width = 789
    Height = 554
    Align = alClient
    Constraints.MinHeight = 412
    Constraints.MinWidth = 526
    OnMouseUp = Image1MouseUp
    ExplicitLeft = -6
    ExplicitTop = -8
    ExplicitHeight = 701
  end
  object pnlSidebar: TPanel
    Left = 789
    Top = 0
    Width = 185
    Height = 554
    Align = alRight
    Color = clInfoBk
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 701
    object Button1: TButton
      Left = 24
      Top = 336
      Width = 145
      Height = 49
      Caption = #1055#1088#1086#1074#1077#1088#1100' '#1084#1077#1085#1103' '#1087#1086#1083#1085#1086#1089#1090#1100#1102
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 40
      Top = 289
      Width = 113
      Height = 33
      Caption = #1053#1072#1095#1072#1090#1100' '#1089#1085#1072#1095#1072#1083#1072
      TabOrder = 1
      Visible = False
      OnClick = ButtonRestartClick
    end
  end
end
