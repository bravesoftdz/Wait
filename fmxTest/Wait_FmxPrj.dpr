program Wait_FmxPrj;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainView},
  API.Tools in '..\API\API.Tools.pas';

{$R *.res}

var
  MainView: TMainView;

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
