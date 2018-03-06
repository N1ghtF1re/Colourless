program Project1;

uses
  Vcl.Forms,
 GraphColoring in 'GraphColoring.pas' {graphForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Coloring graph demo';
  Application.CreateForm(TgraphForm, graphForm);
  Application.Run;
end.
