unit test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TStatus = (stBlue, stRed, stBlack);
  TPeak = record
    x,y:integer;
    status:TStatus;
  end;
  TPeakList = array[1..12] of TPeak;
  TForm1 = class(TForm)
    Image1: TImage;
    pnlSidebar: TPanel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  x0 = 40;
  y0 = 40;
  R = 40;
var
  Form1: TForm1;
  PeakList:TPeakList;


implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Canvas.MoveTo(X0,Y0);
  Image1.Canvas.Pen.Width := 10;
  Image1.Canvas.LineTo(x0+100, y0+100);
  Image1.Canvas.LineTo(x0+200, y0);
  Image1.Canvas.Pen.Width := 1;
  Image1.Canvas.Brush.Color := clBlue;
  Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);
  Image1.Canvas.Ellipse(x0+200-R,Y0-R,X0+200+R,Y0+R);

end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i:integer;
begin
  if (((X0-x)*(X0-x) + (Y0-y)*(Y0-y) < R*R)) then
  begin
    //ShowMessage(IntToStr(x) + ' ' + IntToStr(y));
    if  Button=mbLeft then
      begin
      Image1.Canvas.Brush.Color := clRed;
      for i:=1 to 12 do
        begin
        if (PeakList[i].x-x)(PeakList[i].x-x) + (PeakList[i].y-y)(PeakList[i].y-y) <= R*R then
          begin
          PeakList[i].status :=stRed;
          end;
        end;
      end
    else if Button=mbRight then
      begin
        Image1.Canvas.Brush.Color := clBlack;
        for i:=1 to 12 do
          begin
          if (PeakList[i].x-x)(PeakList[i].x-x) + (PeakList[i].y-y)(PeakList[i].y-y) <= R*R then
            begin
            PeakList[i].status :=stBlack;
            end;
          end;
      end;
    Image1.Canvas.Ellipse(x0-R,Y0-R,X0+R,Y0+R);
  end;
end;

end.
