unit GuestData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Menus,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, GuestDataQuickReport;

type
  TF_GuestData = class(TForm)
    GroupBoxGuest: TGroupBox;
    ListViewData: TListView;
    GroupBoxPreview: TGroupBox;
    LabelNama: TLabel;
    EditNama: TEdit;
    EditEmail: TEdit;
    LabelEmail: TLabel;
    EditTelepon: TEdit;
    LabelTelepon: TLabel;
    LabelCatatan: TLabel;
    RichEdit: TRichEdit;
    ButtonBuat: TButton;
    ButtonHapus: TButton;
    ButtonUbah: TButton;
    ButtonBatal: TButton;
    ButtonKeluar: TButton;
    DateTimePicker: TDateTimePicker;
    LabelTanggalData: TLabel;
    ButtonPreview: TButton;
    ZConnection: TZConnection;
    ZQuery: TZQuery;
    ButtonSimpan: TButton;
    
    procedure FormCreate(Sender: TObject);

    
    procedure ButtonBuatClick(Sender: TObject);
    procedure ButtonHapusClick(Sender: TObject);
    procedure ButtonUbahClick(Sender: TObject);
    procedure ButtonBatalClick(Sender: TObject);
    procedure ButtonKeluarClick(Sender: TObject);
    procedure ButtonPreviewClick(Sender: TObject);
    procedure ButtonSimpanClick(Sender: TObject);

    
    procedure ListViewDataItemClick(Sender: TObject; Item: TListItem; Selected: Boolean);

    
    procedure ConfigureMySQLConnection;
  private
    { Private declarations }
    FMode: string; 
    procedure SetStateAwal;
    procedure SetStateEdit;
    procedure SetStateInputBaru;
    procedure RefreshListView;
  public
    { Public declarations }
  end;

var
  F_GuestData: TF_GuestData;

implementation

{$R *.dfm}

procedure TF_GuestData.FormCreate(Sender: TObject);
begin
  
  ConfigureMySQLConnection;
  DateTimePicker.Date := Now; 
  RichEdit.Lines.Clear; 
  
  ZQuery.SQL.Text := 'SELECT * FROM tamu WHERE DATE(waktu_kedatangan) = CURDATE()';
  ZQuery.Open;
  ListViewData.Clear;
  while not ZQuery.Eof do
  begin
    with ListViewData.Items.Add do
    begin
      Caption := ZQuery.FieldByName('nama_lengkap').AsString; 
      SubItems.Add(ZQuery.FieldByName('email').AsString); 
      SubItems.Add(ZQuery.FieldByName('telepon').AsString); 
      
      Data := Pointer(ZQuery.FieldByName('id').AsInteger); 
    end;
    ZQuery.Next;
  end;
  ZQuery.Close;

  
  ListViewData.OnSelectItem := ListViewDataItemClick;
  ButtonBuat.OnClick := ButtonBuatClick;
  ButtonHapus.OnClick := ButtonHapusClick;
  ButtonUbah.OnClick := ButtonUbahClick;
  ButtonBatal.OnClick := ButtonBatalClick;
  ButtonKeluar.OnClick := ButtonKeluarClick;
  ButtonPreview.OnClick := ButtonPreviewClick;
  ButtonSimpan.OnClick := ButtonSimpanClick;

  SetStateAwal;
end;

procedure TF_GuestData.ConfigureMySQLConnection;
begin
  ZConnection.HostName := 'localhost'; 
  ZConnection.Database := 'guestbook'; 
  ZConnection.User := 'root'; 
  ZConnection.Password := ''; 
  ZConnection.Protocol := 'mysql'; 
  ZConnection.Port := 3306; 
  ZConnection.Connect;
  ZQuery.Connection := ZConnection;
  if not ZConnection.Connected then
    ShowMessage('Failed to connect to the database.');
end;

procedure TF_GuestData.SetStateAwal;
begin
  ButtonBuat.Enabled := True;
  ButtonSimpan.Enabled := False;
  ButtonUbah.Enabled := False;
  ButtonHapus.Enabled := False;
  ButtonBatal.Enabled := True;
  ButtonKeluar.Enabled := True;
  ButtonPreview.Enabled := True;
  EditNama.Enabled := False;
  EditEmail.Enabled := False;
  EditTelepon.Enabled := False;
  RichEdit.Enabled := False;
end;

procedure TF_GuestData.SetStateEdit;
begin
  ButtonBuat.Enabled := False;
  ButtonSimpan.Enabled := False;
  ButtonUbah.Enabled := True;
  ButtonHapus.Enabled := True;
  ButtonBatal.Enabled := True;
  ButtonKeluar.Enabled := True;
  ButtonPreview.Enabled := True;
  EditNama.Enabled := True;
  EditEmail.Enabled := True;
  EditTelepon.Enabled := True;
  RichEdit.Enabled := True;
end;

procedure TF_GuestData.SetStateInputBaru;
begin
  ButtonBuat.Enabled := False;
  ButtonSimpan.Enabled := True;
  ButtonUbah.Enabled := False;
  ButtonHapus.Enabled := False;
  ButtonBatal.Enabled := True;
  ButtonKeluar.Enabled := True;
  ButtonPreview.Enabled := False;
  EditNama.Enabled := True;
  EditEmail.Enabled := True;
  EditTelepon.Enabled := True;
  RichEdit.Enabled := True;
  EditNama.Clear;
  EditEmail.Clear;
  EditTelepon.Clear;
  RichEdit.Lines.Clear;
  ListViewData.Selected := nil;
  EditNama.SetFocus;
end;

procedure TF_GuestData.RefreshListView;
begin
  ListViewData.Clear;
  ZQuery.SQL.Text := 'SELECT * FROM tamu WHERE DATE(waktu_kedatangan) = CURDATE()';
  ZQuery.Open;
  while not ZQuery.Eof do
  begin
    with ListViewData.Items.Add do
    begin
      Caption := ZQuery.FieldByName('nama_lengkap').AsString;
      SubItems.Add(ZQuery.FieldByName('email').AsString);
      SubItems.Add(ZQuery.FieldByName('telepon').AsString);
      Data := Pointer(ZQuery.FieldByName('id').AsInteger);
    end;
    ZQuery.Next;
  end;
  ZQuery.Close;
end;

procedure TF_GuestData.ButtonBuatClick(Sender: TObject);
begin
  FMode := 'create';
  SetStateInputBaru;
end;

procedure TF_GuestData.ButtonSimpanClick(Sender: TObject);
begin
  if (EditNama.Text = '') or (EditEmail.Text = '') or (EditTelepon.Text = '') then
  begin
    ShowMessage('Silakan lengkapi semua data yang wajib diisi.');
    Exit;
  end;
  if not ZConnection.Connected then
  begin
    ShowMessage('Koneksi ke database belum berhasil.');
    Exit;
  end;
  try
    if FMode = 'create' then
    begin
      ZQuery.SQL.Text := 'INSERT INTO tamu (nama_lengkap, email, telepon, catatan, waktu_kedatangan) VALUES (:nama_lengkap, :email, :telepon, :catatan, :waktu_kedatangan)';
      ZQuery.ParamByName('nama_lengkap').AsString := EditNama.Text;
      ZQuery.ParamByName('email').AsString := EditEmail.Text;
      ZQuery.ParamByName('telepon').AsString := EditTelepon.Text;
      ZQuery.ParamByName('catatan').AsString := RichEdit.Lines.Text;      
      ZQuery.ParamByName('waktu_kedatangan').AsDateTime := Now;
      ZQuery.ExecSQL;
      ShowMessage('Data tamu berhasil ditambahkan.');
    end
    else if (FMode = 'edit') and (ListViewData.Selected <> nil) then
    begin
      ZQuery.SQL.Text := 'UPDATE tamu SET nama_lengkap = :nama_lengkap, email = :email, telepon = :telepon, catatan = :catatan WHERE id = :id';
      ZQuery.ParamByName('nama_lengkap').AsString := EditNama.Text;
      ZQuery.ParamByName('email').AsString := EditEmail.Text;
      ZQuery.ParamByName('telepon').AsString := EditTelepon.Text;
      ZQuery.ParamByName('catatan').AsString := RichEdit.Lines.Text;
      ZQuery.ParamByName('id').AsInteger := Integer(ListViewData.Selected.Data);
      ZQuery.ExecSQL;
      ShowMessage('Data tamu berhasil diubah.');
    end;
    RefreshListView;
    SetStateAwal;
    FMode := '';
  except
    on E: Exception do
      ShowMessage('Gagal menyimpan data tamu: ' + E.Message);
  end;
end;

procedure TF_GuestData.ButtonHapusClick(Sender: TObject);
begin
  
  if ListViewData.Selected = nil then
  begin
    ShowMessage('Silakan pilih data tamu yang ingin dihapus.');
    Exit;
  end;

  if not ZConnection.Connected then
  begin
    ShowMessage('Koneksi ke database belum berhasil.');
    Exit;
  end;

  if MessageDlg('Apakah Anda yakin ingin menghapus data ini?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      ZQuery.SQL.Text := 'DELETE FROM tamu WHERE id = :id';
      ZQuery.ParamByName('id').AsInteger := Integer(ListViewData.Selected.Data);
      ZQuery.ExecSQL;
      ShowMessage('Data tamu berhasil dihapus.');
      RefreshListView;
      SetStateAwal;
    except
      on E: Exception do
        ShowMessage('Gagal menghapus data tamu: ' + E.Message);
    end;
  end;
end;

procedure TF_GuestData.ButtonUbahClick(Sender: TObject);
begin
  
  if ListViewData.Selected = nil then
  begin
    ShowMessage('Silakan pilih data tamu yang ingin diubah.');
    Exit;
  end;
  FMode := 'edit';  
  EditNama.Enabled := True;
  EditEmail.Enabled := True;
  EditTelepon.Enabled := True;
  RichEdit.Enabled := True;
  ButtonSimpan.Enabled := True;
  ButtonBatal.Enabled := True;
  ButtonKeluar.Enabled := True;
  ButtonPreview.Enabled := False;
  ButtonBuat.Enabled := False;
  ButtonUbah.Enabled := False;
  ButtonHapus.Enabled := False;
end;

procedure TF_GuestData.ButtonPreviewClick(Sender: TObject);
var
  LGuestReport: TF_GuestDataQuickReport;
begin
  LGuestReport := TF_GuestDataQuickReport.Create(Self);
  try
    LGuestReport.GenerateReport(DateTimePicker.Date);
  finally
    LGuestReport.Free;
  end;
end;

procedure TF_GuestData.ListViewDataItemClick(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  
  if Selected then
  begin
    EditNama.Text := Item.Caption; 
    EditEmail.Text := Item.SubItems[0]; 
    EditTelepon.Text := Item.SubItems[1]; 
    ButtonUbah.Enabled := True;
    ButtonHapus.Enabled := True;
  end
  else
  begin
    ButtonUbah.Enabled := False;
    ButtonHapus.Enabled := False;
  end;
end;

procedure TF_GuestData.ButtonBatalClick(Sender: TObject);
begin  
  EditNama.Clear;
  EditEmail.Clear;
  EditTelepon.Clear;
  RichEdit.Lines.Clear;
  DateTimePicker.Date := Now; 
  ListViewData.Selected := nil; 
  SetStateAwal;
end;

procedure TF_GuestData.ButtonKeluarClick(Sender: TObject);
begin  
  Application.Terminate;
end;

end.