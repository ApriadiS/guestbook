unit GuestDataQuickReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuickRpt, QRCtrls, Vcl.ExtCtrls,
  ZAbstractConnection, ZConnection, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TF_GuestDataQuickReport = class(TForm)
    QuickRep: TQuickRep;
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    LabelLAPORANDATAPENGUNJUNG: TQRLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    QRLabelNama: TQRLabel;
    QRLabelTelepon: TQRLabel;
    QRLabelEmail: TQRLabel;
    QRLabelWaktu: TQRLabel;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    ZQuery: TZQuery;
    ZConnection: TZConnection;
  private
    { Private declarations }
    procedure ConnectionSetup;
    procedure QuerySetup(ATanggal: TDateTime);
    procedure DetailBandSetup;

  public
    { Public declarations }
    procedure GenerateReport(ATanggal: TDateTime);


  end;

var
  F_GuestDataQuickReport: TF_GuestDataQuickReport;

implementation

{$R *.dfm}

procedure TF_GuestDataQuickReport.ConnectionSetup;
begin
  ZConnection.HostName := 'localhost';
  ZConnection.Database := 'guestbook';
  ZConnection.User := 'root';
  ZConnection.Password := '';
  ZConnection.Protocol := 'mysql';
  ZConnection.Port := 3306;
  ZConnection.Connect;
  ZQuery.Connection := ZConnection;
  QuickRep.DataSet := ZQuery;
end;

procedure TF_GuestDataQuickReport.QuerySetup(ATanggal: TDateTime);
begin
  ZQuery.SQL.Text := 'SELECT nama_lengkap, email, telepon, waktu_kedatangan FROM tamu WHERE DATE(waktu_kedatangan) = :tanggal';
  ZQuery.ParamByName('tanggal').AsDate := ATanggal;
  ZQuery.Open;
end;

procedure TF_GuestDataQuickReport.GenerateReport(ATanggal: TDateTime);
begin
  ConnectionSetup;
  DetailBandSetup;
  QuerySetup(ATanggal);

  if ZQuery.IsEmpty then
  begin
    ShowMessage('Tidak ada data untuk tanggal yang dipilih.');
    Exit;
  end;

  QuickRep.Preview;
end;

procedure TF_GuestDataQuickReport.DetailBandSetup;
begin
  QRDBText1.DataSet := ZQuery;
  QRDBText2.DataSet := ZQuery;
  QRDBText3.DataSet := ZQuery;
  QRDBText4.DataSet := ZQuery;
  QRDBText1.DataField := 'nama_lengkap';
  QRDBText2.DataField := 'email';
  QRDBText3.DataField := 'telepon';
  QRDBText4.DataField := 'waktu_kedatangan';
  QRDBText4.Mask := 'dd/mm/yyyy hh:nn:ss';
end;

end.
