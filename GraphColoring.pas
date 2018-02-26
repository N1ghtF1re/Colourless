﻿unit GraphColoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, VcL.Menus, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,SplashScreen, pngimage,
  Instructions;
const
  R = 25;

type
 TBConnection1 = array [1..11,1..12] of byte;
  TStatus = (stBlue, stRed, stBlack);
  //TArray = array [1..18] of Tstatus;
  TLevel = (lev1, lev2, lev3, lev4);
  TPeak = record
    x,y:integer;
    status:TStatus;
  end;
  TPeakList = array[1..18] of TPeak;
  TgraphForm = class(TForm)
    Image1: TImage;
    pnlSidebar: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    introIMG: TImage;
    MainMenu1: TMainMenu;
    mnSettings: TMenuItem;
    mnHelp: TMenuItem;
    mnNewGame: TMenuItem;
    mnLevels: TMenuItem;
    mnLevel1: TMenuItem;
    mnLeve2: TMenuItem;
    mnLevel3: TMenuItem;
    mnLevel4: TMenuItem;
    procedure RisuiSuka;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButtonRestartClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure mnHelpClick(Sender: TObject);
    procedure mnNewGameClick(Sender: TObject);
    procedure mnLevel1Click(Sender: TObject);
    procedure mnLeve2Click(Sender: TObject);
    procedure mnLevel3Click(Sender: TObject);
    procedure mnLevel4Click(Sender: TObject);
  private
  splash: TSplash;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  N1 = 12;
  Level1:array[1..2, 1..12] of integer = ((180,300,420,300,60,180,300,420,540,420,300,180),(110,40,110,200,400,320,320,320,400,500,500,500));
  N2 = 18;
  level2:array[1..2, 1..18] of Integer = ((250,420,510,650,860,860,860,860,80,80,80,80,305,305,665,665,570,365), (50,50,50,50,250,370,445,535,535,445,370,220,{13}295,465,465,295,220,220));
  N3 = 6;
  level3:array[1..2, 1..6] of integer = ((40,300,300,40,120,220),(40,40,200,200,120,120));
  level4:array[1..2, 1..6] of integer = ((125,280,440,440,280,125),(145,50,145,265,350,265));
  Level1XShift = 120;
  Level1YShift = 60;
  Answer11:array [1..12] of Tstatus =
  (stBlack,stRed,stRed,stRed,stBlack,stRed,stRed,stRed,stBlack,stBlack,stRed,stRed);
  Answer12:array [1..12] of Tstatus=
  (stRed,stRed,stBlack,stRed,stBlack,stBlack,stRed,stRed,stBlack,stRed,stRed,stRed);
  Answer21:array[1..18] of TStatus =
  (stRed,stRed,stRed,stRed,stRed,stRed,stRed,stRed,stRed,stRed,stRed,stRed,stBlack,stBlack,stBlack,stBlack,stBlack,stBlack);
  Answer31:array[1..6] of TStatus =
  (stRed,stRed,stRed,stRed,stBlack,stBlack);
  Answer32:array[1..6] of TStatus =
  (stBlack,stBlack,stRed,stRed,stRed,stRed);
  Answer33:array[1..6] of TStatus =
  (stRed,stRed,stBlack,stBlack,stRed,stRed);
  Answer41:array[1..6] of TStatus =
  (stRed,stBlack,stRed,stRed,stBlack,stRed);
  Answer42:array[1..6] of TStatus =
  (stRed,stRed,stBlack,stRed,stRed,stBlack);
  Answer43:array[1..6] of TStatus =
  (stBlack,stRed,stRed,stBlack,stRed,stRed);
  const   // 2 3 4 5 6 7 8 9 0 1 2
	BConnection1:TBConnection1 =
           ((0,1,0,1,1,0,0,0,0,0,0,0),
            (0,0,1,1,0,0,0,0,0,0,0,0),
            (0,0,0,1,0,0,0,0,1,0,0,0),
            (0,0,0,0,0,0,0,0,0,0,0,0),
            (0,0,0,0,0,1,0,0,0,0,0,1),
            (0,0,0,0,0,0,1,0,0,0,1,0),
            (0,0,0,0,0,0,0,1,0,1,0,0),
            (0,0,0,0,0,0,0,0,1,0,0,1),
            (0,0,0,0,0,0,0,0,0,1,0,0),
            (0,0,0,0,0,0,0,0,0,0,1,0),
            (0,0,0,0,0,0,0,0,0,0,0,1));
  BConntection2:array[1..17,1..18] of Byte =
// 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
  ((0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1),
  (0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1),
  (0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0),
  (0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0),
  (0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0),
  (0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0),
  (0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0),
  (0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0),
  (0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
  (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1));
  BConnection3:array[1..5, 1..6] of Byte =
  ((0,1,0,1,1,0),
  (0,0,1,0,0,1),
  (0,0,0,1,0,1),
  (0,0,0,0,1,0),
  (0,0,0,0,0,1));
  BConnection4:array[1..5, 1..6] of Byte =
  ((0,0,1,1,1,0),
  (0,0,0,1,1,1),
  (0,0,0,0,1,1),
  (0,0,0,0,0,1),
  (0,0,0,0,0,0));
var
  graphForm: TgraphForm;
  PeakList:TPeakList;
  x0,y0:integer;
  gameState: boolean;
  InitHeight, InitWidth:integer;
  lsh, tsh: integer;
  level: TLevel;
  N:integer;

implementation

{$R *.dfm}

procedure TgraphForm.ButtonRestartClick(Sender: TObject);
var i:integer;
begin
for i := 1 to N do
  begin
  PeakList[i].status :=stBlue;
  x0:= PeakList[i].x;
  y0:= PeakList[i].y;
  Image1.Canvas.Brush.Color := RGB(104,174,186);
  Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R)
  end;
button2.Visible:=False;
button1.Visible:=False;
end;

procedure TgraphForm.Button1Click(Sender: TObject);
var i:integer;
    gameState1, gameState2, gamestate3, FinishedBool:Boolean;
begin
gameState:=true;
gameState1 := true;
gameState2 := true;
gameState3:= True;
FinishedBool := true;
i:=1;
while (i<=N) and (gameState) do
  begin
    case level of
      lev1:
      begin
        gamestate3:= false;
        if gameState1 then
          if (Peaklist[i].Status <> Answer11[i]) then
            gameState1:=False;
        if gameState2 then
          if (Peaklist[i].Status <> Answer12[i]) then
            gameState2:=False;
      end;
      lev2:
      begin
        gamestate3:= false;
        gameState2 := False;
        if gameState1 then
          if (Peaklist[i].Status <> Answer21[i]) then
            gameState1:=False;

      end;
      lev3:
      begin
        if gameState1 then
          if (Peaklist[i].Status <> Answer31[i]) then
            gameState1:=False;
         if gameState2 then
         if (Peaklist[i].Status <> Answer32[i]) then
            gameState2:=False;
         if gameState3 then
          if (Peaklist[i].Status <> Answer33[i]) then
            gameState3:=False;

      end;
      lev4:
      begin

        if gameState1 then
          if (Peaklist[i].Status <> Answer41[i]) then
            gameState1:=False;
         if gameState2 then
         if (Peaklist[i].Status <> Answer42[i]) then
            gameState2:=False;
         if gameState3 then
          if (Peaklist[i].Status <> Answer43[i]) then
            gameState3:=False;

      end;
    end;

  if not (gameState1 or gameState2 or gameState3)  then
    gameState:=False;

  if Peaklist[i].Status = stBlue then
    FinishedBool:=False;
  inc(i);
  end;
if gameState then
  begin
  ShowMessage('Все правильно!');
  button2.Visible:=true;
  end
else
  begin
  while (i<=N) and (FinishedBool) do
    begin
    if Peaklist[i].Status = stBlue then
      FinishedBool:=False;
    inc(i);
    end;
  if FinishedBool then
    begin
    ShowMessage('Попробуйте ещё');
    button2.Visible:=true;
    end
  else
    ShowMessage('Сначала нужно всё докрасить!');
  end;
end;

procedure TgraphForm.RisuiSuka;
var i,j:integer;
begin
  Image1.Canvas.Brush.Color:= clWhite;
  image1.Canvas.Pen.Color := clWhite;
  Image1.Canvas.Rectangle(0,0, image1.Width, image1.Height);
  case level of
    lev1:
    begin
      n:=n1;
      for i := 1 to N do
      begin
        PeakList[i].x := level1[1,i] + Level1XShift;
        PeakList[i].y := level1[2,i] + Level1YShift;
      end;
    end;
    lev2:
    begin
      n:=n2;
      for i := 1 to N do
      begin
        PeakList[i].x := level2[1,i] + Level1XShift;
        PeakList[i].y := level2[2,i] + Level1YShift + 80;

      end;
    end;
    lev3:
    begin
      n:=n3;
      for i := 1 to N do
      begin
        PeakList[i].x := level3[1,i] + Level1XShift + 300;
        PeakList[i].y := level3[2,i] + Level1YShift + 180;

      end;
    end;
    lev4:
    begin
      n:=n3;
      for i := 1 to N do
      begin
        PeakList[i].x := level4[1,i] + Level1XShift + 200;
        PeakList[i].y := level4[2,i] + Level1YShift + 180;

      end;
    end;
  end;

  Image1.Canvas.Pen.Width := 10;
  Image1.Canvas.Pen.Color := RGB(199,183,188);
  //  НАДО РАСКОМЕНТИТЬ
  for i := 1 to N-1 do
  begin
    for j := 1 to N do
    begin
      //ShowMessage(IntToStr(i) + ' ' + IntToStr(j));
      case level of
        lev1:
        begin
          if BConnection1[i,j] = 1 then
          begin
            Image1.Canvas.MoveTo(PeakList[i].x, PeakList[i].y);
            Image1.Canvas.LineTo(PeakList[j].x, PeakList[j].y);
          end;
        end;
        lev2:
        begin
          if BConntection2[i,j] = 1 then
          begin
            Image1.Canvas.MoveTo(PeakList[i].x, PeakList[i].y);
            Image1.Canvas.LineTo(PeakList[j].x, PeakList[j].y);

          end;
        end;
        lev3:
        begin
          if BConnection3[i,j] = 1 then
          begin
            Image1.Canvas.MoveTo(PeakList[i].x, PeakList[i].y);
            Image1.Canvas.LineTo(PeakList[j].x, PeakList[j].y);

          end;
        end;
        lev4:
        begin
          if BConnection4[i,j] = 1 then
          begin
            Image1.Canvas.MoveTo(PeakList[i].x, PeakList[i].y);
            Image1.Canvas.LineTo(PeakList[j].x, PeakList[j].y);

          end;
        end;
      end;

    end;
  end;

  Image1.Canvas.Brush.Color := RGB(104,174,186);
  Image1.Canvas.Pen.Width := 0;

  for i := 1 to N do
  begin
    Image1.Canvas.Ellipse(PeakList[i].x-R,PeakList[i].y-R,PeakList[i].x+R,PeakList[i].y+R);
  end;
end;

procedure TgraphForm.FormCreate(Sender: TObject);
var
  i,j: Integer;
  png: TPngImage;
begin
  png:= TPngImage(introIMG.Picture);
  Splash := TSplash.Create(png);
  Splash.Show(true);

  InitHeight := Self.Height;
  InitWidth := Self.Width;
  level := lev1;

  risuiSuka;

  Sleep(2000);

  Splash.Close;

  //png.Free;
end;

procedure TgraphForm.FormDestroy(Sender: TObject);
begin
  Splash.Free;
end;

procedure TgraphForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 122 then
  begin
    BorderStyle := bsNone;
    WindowState := wsMaximized;
  end;
  if key = 27 then
  begin
    BorderStyle := bsSingle;
    WindowState := wsNormal;
  end;
end;

procedure TgraphForm.FormResize(Sender: TObject);
begin
  lsh := (Self.Width - InitWidth) div 2;
  tsh := (Self.Height - InitHeight) div 2;
  Invalidate;
end;

procedure TgraphForm.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
Button1.Visible:=true;
    if  Button=mbLeft then
      begin
      Image1.Canvas.Brush.Color := clRed;
      for i:=1 to N do
        begin
        if ((PeakList[i].x + lsh)-x)*((PeakList[i].x + lsh)-x) + ((PeakList[i].y + tsh)-y)*((PeakList[i].y + tsh)-y) <= R*R then
          begin
            x0:= PeakList[i].x;
            y0:= PeakList[i].y;

            PeakList[i].status :=stRed;
            Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);
          end;
        end;

      end
    else if Button=mbRight then
      begin
      Image1.Canvas.Brush.Color := clBlack;
      for i:=1 to N do
        begin
        if ((PeakList[i].x + lsh)-x)*((PeakList[i].x + lsh)-x) + ((PeakList[i].y + tsh)-y)*((PeakList[i].y + tsh)-y) <= R*R then
          begin
          x0:= PeakList[i].x;
          y0:= PeakList[i].y;
          PeakList[i].status :=stBlack;
          Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);
          end;
        end;

      end;


end;

procedure TgraphForm.mnHelpClick(Sender: TObject);
begin
  Application.CreateForm(TForm1, Form1);
  FORM1.SHOW
end;

procedure TgraphForm.mnLeve2Click(Sender: TObject);
begin
  level := lev2;
  risuiSuka;
end;

procedure TgraphForm.mnLevel1Click(Sender: TObject);
begin
  level := lev1;
  risuiSuka;
end;

procedure TgraphForm.mnLevel3Click(Sender: TObject);
begin
  level := lev3;
  risuiSuka;
end;

procedure TgraphForm.mnLevel4Click(Sender: TObject);
begin
  level := lev4;
  risuiSuka;
end;

procedure TgraphForm.mnNewGameClick(Sender: TObject);
var i:integer;
begin
for i := 1 to N do
  begin
  PeakList[i].status :=stBlue;
  x0:= PeakList[i].x;
  y0:= PeakList[i].y;
  Image1.Canvas.Brush.Color := RGB(104,174,186);
  Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R)
  end;
button2.Visible:=False;
button1.Visible:=False;
end;

end.
