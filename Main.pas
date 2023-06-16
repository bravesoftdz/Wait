unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
//
  API.Tools;

type
  TViewMain = class(TForm)
    Btn_Test: TButton;
    procedure Btn_TestClick(Sender: TObject);
  private
    { Private declarations }
    Wait: TWait;
  public
    { Public declarations }
  end;

//var
//  ViewMain: TViewMain;

implementation


{$R *.dfm}

procedure TViewMain.Btn_TestClick(Sender: TObject);
begin
  Wait._For(3500, TControl(Btn_Test));
  ShowMessage('we wait for 3 Seconds before Show you this Message here !!')
end;

end.
