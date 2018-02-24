unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, Buttons, SplashScreen;

type
  TFormApp = class(TForm)
    btnShow: TButton;
    btnClose: TButton;
    btnExit: TButton;
    MemoText: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
    splash: TSplash;
  public
    { Public declarations }
  end;

var
  FormApp: TFormApp;

implementation

{$R *.dfm}

procedure TFormApp.btnCloseClick(Sender: TObject);
begin
  Splash.Close;
end;

procedure TFormApp.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormApp.FormCreate(Sender: TObject);
var
  png: TPNGImage;
begin
  png := TPNGImage.Create;

  png.LoadFromFile('habrahabr.png');
  //png.LoadFromFile('circle.png');
  //png.LoadFromFile('errorsoft.png');

  //создаем TSplash
  Splash := TSplash.Create(png);
  //показываем Splash
  Splash.Show(false);

  // Sleep ( здесь происходит загрузка приложения )
  Sleep(2000);
  // прячем Splash
  Splash.Close;

  png.Free;
end;

procedure TFormApp.FormDestroy(Sender: TObject);
begin
  Splash.Free;
end;

procedure TFormApp.btnShowClick(Sender: TObject);
begin
  Splash.Show(false);
end;

end.
