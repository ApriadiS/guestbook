program GuestBook;

uses
  Vcl.Forms,
  GuestData in 'GuestData.pas' {F_GuestData},
  GuestDataQuickReport in 'GuestDataQuickReport.pas' {F_GuestDataQuickReport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_GuestData, F_GuestData);
  Application.CreateForm(TF_GuestDataQuickReport, F_GuestDataQuickReport);
  Application.Run;
end.
