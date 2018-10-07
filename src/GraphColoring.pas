{*******************************************************}
{                                                       }
{       Coloring Graph                                  }
{       The trademark is not registered                 }
{       no rights are protected                         }
{       (c) 2018,  BrakhMen Corp                        }
{       SITE: brakhmen.info                             }
{                                                       }
{*******************************************************}

unit GraphColoring;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, VcL.Menus, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,SplashScreen, pngimage,
  Instructions,Levels;
const
  R = 25;

type
  TCheck = function(i,j:byte):boolean;
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
    mnHelp: TMenuItem;
    mnLevels: TMenuItem;
    mnLevel1: TMenuItem;
    mnLeve2: TMenuItem;
    mnLevel3: TMenuItem;
    mnLevel4: TMenuItem;
    Button3: TButton;
    Button4: TButton;
    procedure drawGraph;
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
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
  splash: TSplash;
    { Private declarations }
  public
    isClose:Boolean;
    numOfHelp:byte;
  end;

var
  graphForm: TgraphForm;
  PeakList:TPeakList;
  x0,y0:integer;
  gameState: boolean;
  InitHeight, InitWidth:integer;
  lsh, tsh: integer;
  level: TLevel;
  N:integer;
  initImgWidth, initImgHeight: integer;
  isNoActive:boolean;


implementation

{$R *.dfm}

function Check1(i,j:Byte):boolean;
begin
  result := BConnection1[i,j] = 1;
end;

function Check2(i,j:Byte):boolean;
begin

  result := BConnection2[i,j] = 1;
end;

function Check3(i,j:Byte):boolean;
begin

  result := BConnection3[i,j] = 1;

end;

function Check4(i,j:Byte):boolean;
begin

  result := BConnection4[i,j] = 1;
end;

procedure buttonsToDefault();
begin
    button1.visible:=false
    button2.visible:=false
end;


function checkCorrected(Check:TCheck):Boolean;
var i, j, k:integer;
    numRed, numBlack:integer;
    completedTask, correct:Boolean;
begin
completedTask:=true;
correct:=true;

j:=1;
while (j<=N) and (completedTask) and (correct) do
  begin
  numRed:=0;
  numBlack:=0;
  i:=1;
  while (i<j) and (completedTask) and (correct) do
    begin
    if Check(i,j) then
      begin
      if PeakList[i].status = stBlack then Inc(numBlack);
      if PeakList[i].status = stRed then Inc(numRed);
      if PeakList[i].status = stBlue then completedTask:=false;

      if (numRed>2) or (numBlack>1) then
        correct:=false;
      end;
    Inc(i);
    end;

  k:=j;
  while (j<N) and (k<=N) and (completedTask) and (correct) do
    begin
    if Check(i,j) then
      begin
      if PeakList[k].status = stBlack then Inc(numBlack);
      if PeakList[k].status = stRed then Inc(numRed);
      if PeakList[k].status = stBlue then completedTask:=false;

      if (numRed>2) or (numBlack>1) then
        correct:=false;
      end;
    inc(k);
    end;

  Inc(j);
  end;

if correct and completedTask then
  result:=True
else
  result:=False;
end;

procedure TgraphForm.Button3Click(Sender: TObject);
begin
inc(level);
drawGraph;
end;

procedure TgraphForm.Button4Click(Sender: TObject);
begin
level := lev1;
drawGraph;
end;

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
buttonsToDefault;
button3.Visible:=false;
button4.Visible:=false;
end;

procedure TgraphForm.Button1Click(Sender: TObject);
var i:integer;
    FinishedBool:Boolean;
begin
gameState:=true;
FinishedBool := true;
  if level = lev4 then
  begin
    if not(checkCorrected(Check4)) then gameState:=False;
  end;
  if level = lev3 then
  begin
    if not(checkCorrected(Check3)) then gameState:=False;
  end;
  if level = lev2 then
  begin
    if not(checkCorrected(Check2)) then gameState:=False;
  end;
  if level = lev1 then
  begin
    if not(checkCorrected(Check1)) then gameState:=False;
  end;

if gameState then
  begin
  ShowMessage('Все правильно!');
  button2.Visible:=true;
  if level<>lev4 then
    button3.Visible:=true
  else
    button4.Visible:=true
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

procedure TgraphForm.drawGraph;
var i,j:integer;
Wcoef, HCoef:real;
begin
  Image1.Canvas.Brush.Color:= clWhite;
  image1.Canvas.Pen.Color := clWhite;
  Image1.Canvas.Rectangle(0,0, image1.Width, image1.Height);
  Wcoef := Screen.Width / 1920;
  HCoef := Screen.Height / 1080;
  // ShowMessage(FloatToStr( WCoef ));
  case level of
    lev3:
    begin
      n:=n1;
      for i := 1 to N do
      begin
        PeakList[i].x := trunc(level3[1,i]*wcoef) - 60 + (initImgWidth - Trunc(480*WCoef)) div 2;
        PeakList[i].y := trunc(level3[2,i]*hcoef) -40 + ( initImgHeight -Trunc(460*Hcoef)) div 2 ;
      end;
    end;
    lev4:
    begin
      n:=n2;
      //ShowMessage( IntToStr(  Screen.PixelsPerInch ));
      //ShowMessage( IntToStr( Image1.Width ) );
      for i := 1 to N do
      begin
        PeakList[i].x := trunc(level4[1,i]*wcoef*0.7) - 80 + (initImgWidth - Trunc(780*wcoef*0.7)) div 2;
        PeakList[i].y := trunc(level4[2,i]*hcoef*0.7) -40 + ( initImgHeight -Trunc(485*hcoef*0.7)) div 2 ;
      end;
    end;
    lev1:
    begin
      n:=n3;
      for i := 1 to N do
      begin
        PeakList[i].x := trunc(level1[1,i]*wcoef) - 40 + (initImgWidth - Trunc(260*wcoef)) div 2;
        PeakList[i].y := trunc(level1[2,i]*wcoef) -40 + ( initImgHeight - Trunc(160*hcoef)) div 2 ;
       end;
    end;
    lev2:
    begin
      n:=n3;
      for i := 1 to N do
      begin
        PeakList[i].x := trunc(level2[1,i]*wcoef) - 125 + (initImgWidth - Trunc(315*wcoef)) div 2;
        PeakList[i].y := trunc(level2[2,i]*hcoef) -50 + ( initImgHeight -Trunc(300*hcoef)) div 2 ;
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
          if BConnection2[i,j] = 1 then
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
buttonsToDefault;
button3.Visible:=false;
button4.Visible:=false;
end;

procedure TgraphForm.FormActivate(Sender: TObject);
var
  f: file of byte;
  b:byte;
  var y,n:byte;
begin
  if isNoActive then
  begin
    isNoActive := false;
    y:=1;
    n:=0;
    b:=1;
    AssignFile(f, 'openhelp.brakh');
    if fileExists('openhelp.brakh') then
    begin
      Reset(f);
      read(f, b);
      //showmessage( IntToStr(b));
      if b = 1 then
      begin
        Application.CreateForm(TForm1, Form1);
        Form1.showModal;
      end;
      //ShowMessage( BoolToStr(isClose)  );
    end
    else
    begin
      Rewrite(f);
      write(f, y);
      Application.CreateForm(TForm1, Form1);
      Form1.showModal;
    end;

    if (b <> 0) then
    begin
      rewrite(f);
      if isClose then
      begin
        write(f, n);
      end
      else
      begin
        write(f, y);
      end;
    end;
  end;
end;

procedure TgraphForm.FormCreate(Sender: TObject);
var
  i,j: Integer;
  png: TPngImage;
begin
  numofhelp := 0;
  isNoActive := true;
  InitImgWidth := Image1.Width;
  InitImgHeight := Image1.Height;
  png:= TPngImage(introIMG.Picture);
  Splash := TSplash.Create(png);
  Splash.Show(true);

  InitHeight := Self.Height;
  InitWidth := Self.Width;
  level := lev1;

  drawGraph;

  Sleep(2000);

  Splash.Close;//AssignFile(f, 'openhelp.brakh');
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
    //BorderStyle := bsNone;
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
  numOfHelp := 1;
  Application.CreateForm(TForm1, Form1);
  FORM1.SHOW
end;

procedure TgraphForm.mnLeve2Click(Sender: TObject);
begin
  level := lev2;
  drawGraph;
end;

procedure TgraphForm.mnLevel1Click(Sender: TObject);
begin
  level := lev1;
  drawGraph;
end;

procedure TgraphForm.mnLevel3Click(Sender: TObject);
begin
  level := lev3;
  drawGraph;
end;

procedure TgraphForm.mnLevel4Click(Sender: TObject);
begin
  level := lev4;
  drawGraph;
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
buttonsToDefault;
end;

end.
