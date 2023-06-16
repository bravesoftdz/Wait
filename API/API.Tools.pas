{$IFNDEF VCL}
  {$IFNDEF FMX}
    //No built-in way of knowing the difference between applications targeted for FMX or VCL
    //This project is relying on a specific workaround:
    //   Add a project conditional define: $(FrameworkType) which will result in VCL or FMX
    //   This is typically added to the project config: "All Configurations"->"All Platforms"->Conditional Defines

    {$Message Fatal 'VCL or FMX not defined, aborting.  This application contains cross-framework references - add $(FrameworkType) as a conditional define in this project''s configuration.'}

  {$ENDIF}
{$ENDIF}

unit API.Tools;

interface

uses
  System.Threading
{$IFDEF VCL}
  ,Vcl.ExtCtrls
  ,Vcl.Controls
  {$ENDIF}
{$IFDEF FMX}
  ,FMX.Types
  ,FMX.StdCtrls
  {$ENDIF};

type

{$IFDEF VCL}
  TControl = class(Vcl.Controls.TControl) // to Access private Methods (eSPECIALLY text or caption properties)!!!
  end;
  {$ENDIF}
{$IFDEF FMX}
  TPresentedTextControl = class(FMX.StdCtrls.TPresentedTextControl)
  end;
  {$ENDIF}

  TWait = record
  strict private
    fTask: ITask;
    fTimer: TTimer;
    fElapsed_Sec_Timer: TTimer;

//    fComplete: Boolean;
    procedure OnWait(aSender: TObject);
    procedure OnProgress(aSender: TObject);
  public
  {$IFDEF VCL}
    procedure _For(aMillSec: Cardinal; aDisplayProgress: TControl = nil);
    {$ENDIF}
  {$IFDEF FMX}
    procedure _For(aMillSec: Cardinal; aDisplayProgress: TPresentedTextControl = nil);
    {$ENDIF}
  end;


implementation

uses
  System.SysUtils,
  System.Classes
{$IFDEF VCL}
  ,Vcl.Forms
    {$ENDIF}

{$IFDEF FMX}
  ,FMX.Forms
  {$ENDIF};

{ TWait }
var
  _Complete: Boolean = False;
  _ElapsedSec: Byte = 255;
  _Elapsed_MillSec: Double = 0;

procedure TWait.OnProgress(aSender: TObject);
begin
  if not _Complete then
   _ElapsedSec := _ElapsedSec -1 else
  fElapsed_Sec_Timer.Enabled := False;
end;

procedure TWait.OnWait(aSender: TObject);
begin

  fTimer.Enabled   := False;
  _Complete        := True;
end;

{$IFDEF VCL}
procedure TWait._For(aMillSec: Cardinal; aDisplayProgress: TControl = nil);
//var
//  IsComplete: Boolean absolute fComplete;
begin
  if aMillSec = 0 then Abort;

  _Complete := False;

  _ElapsedSec := 255;
  fElapsed_Sec_Timer := nil;

  if Assigned(aDisplayProgress) then begin
    if (aMillSec <> 1000) then begin

      fElapsed_Sec_Timer  := TTimer.Create(nil);
      try
        fElapsed_Sec_Timer.OnTimer := OnProgress;
        _Elapsed_MillSec := frac(aMillSec / 1000); // Returns the fractional part of a real number.

        if (aMillSec > 1000) then _ElapsedSec := (aMillSec div 1000) else
          _ElapsedSec := 0;

      finally

      end;

    end else begin
      _ElapsedSec := 1;
      _Elapsed_MillSec := 0;
    end;
  end;


  fTimer    := TTimer.Create(nil);
  try
    fTimer.Interval := aMillSec;
    fTimer.OnTimer  := OnWait;
    fTimer.Enabled  := True;
//    if Assigned(fElapsed_Sec_Timer) then fElapsed_Sec_Timer.Enabled := True;

    fTask           := TTask.Create(
      procedure begin
      // Do your Task Here..
        TThread.Synchronize(TThread.CurrentThread,
          procedure begin
            while not _Complete do begin
              if _Elapsed_MillSec > 0 then
                aDisplayProgress.Text := 'Elapsed Seconds: '+
                   (_ElapsedSec+_Elapsed_MillSec).ToString + ' Seconds ..' else
                aDisplayProgress.Text := 'Elapsed Seconds: '+_ElapsedSec.ToString + ' Seconds ..';

              Application.ProcessMessages;
            end;
            aDisplayProgress.Text := 'Task Wait Complete ..';
          end);

      end);
  finally
    fTask.ExecuteWork; // this will stop here.. until [fTask] finish work !!

    if Assigned(fElapsed_Sec_Timer) then FreeAndNil(fElapsed_Sec_Timer);

    FreeAndNil(fTimer);
  end;

end;
  {$ENDIF}

{$IFDEF FMX}
procedure TWait._For(aMillSec: Cardinal; aDisplayProgress: TPresentedTextControl);
begin
  if aMillSec = 0 then Abort;

  _Complete := False;

  _ElapsedSec := 255;
  fElapsed_Sec_Timer := nil;

  if Assigned(aDisplayProgress) then begin
    if (aMillSec <> 1000) then begin

      fElapsed_Sec_Timer  := TTimer.Create(nil);
      try
        fElapsed_Sec_Timer.OnTimer := OnProgress;
        _Elapsed_MillSec := frac(aMillSec / 1000); // Returns the fractional part of a real number.

        if (aMillSec > 1000) then _ElapsedSec := (aMillSec div 1000) else
          _ElapsedSec := 0;

      finally

      end;

    end else begin
      _ElapsedSec := 1;
      _Elapsed_MillSec := 0;
    end;
  end;


  fTimer    := TTimer.Create(nil);
  try
    fTimer.Interval := aMillSec;
    fTimer.OnTimer  := OnWait;
    fTimer.Enabled  := True;
//    if Assigned(fElapsed_Sec_Timer) then fElapsed_Sec_Timer.Enabled := True;

    fTask           := TTask.Create(
      procedure begin
      // Do your Task Here..
        TThread.Synchronize(TThread.CurrentThread,
          procedure begin
            while not _Complete do begin
              if _Elapsed_MillSec > 0 then
                aDisplayProgress.Text := 'Elapsed Seconds: '+
                   (_ElapsedSec+_Elapsed_MillSec).ToString + ' Seconds ..' else
                aDisplayProgress.Text := 'Elapsed Seconds: '+_ElapsedSec.ToString + ' Seconds ..';

              Application.ProcessMessages;
            end;
            aDisplayProgress.Text := 'Task Wait Complete ..';
          end);

      end);
  finally
    fTask.ExecuteWork; // this will stop here.. until [fTask] finish work !!

    if Assigned(fElapsed_Sec_Timer) then FreeAndNil(fElapsed_Sec_Timer);

    FreeAndNil(fTimer);
  end;

end;
  {$ENDIF}

end.
