program Wait_Prj;

uses
  Vcl.Forms,
  Main in 'Main.pas' {ViewMain},
  API.Tools in 'API\API.Tools.pas';

{$R *.res}

var
  ViewMain: TViewMain;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
