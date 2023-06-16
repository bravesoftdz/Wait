unit Main;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TMainView = class(TForm)
    Btn_Test: TButton;
    procedure Btn_TestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  MainView: TMainView;

implementation

uses
  API.Tools;

{$R *.fmx}
var
  Wait: TWait;

procedure TMainView.Btn_TestClick(Sender: TObject);
begin
  Wait._For(3500, TPresentedTextControl(Btn_Test));
  ShowMessage('we wait for [ 3 Seconds and Half Sec ] before Show you this Message here !!')
end;

end.
