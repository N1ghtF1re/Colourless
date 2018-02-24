program Project1;

uses
  Vcl.Forms,
  test in 'test.pas' {graphForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Раскраска графа';
  Application.CreateForm(TgraphForm, graphForm);
  Application.Run;
end.
