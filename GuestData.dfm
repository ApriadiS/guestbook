object F_GuestData: TF_GuestData
  Left = 0
  Top = 0
  Caption = 'Guest Book'
  ClientHeight = 433
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object GroupBoxGuest: TGroupBox
    Left = 8
    Top = 8
    Width = 608
    Height = 341
    Caption = 'Guest'
    TabOrder = 0
    object LabelNama: TLabel
      Left = 15
      Top = 31
      Width = 32
      Height = 15
      Caption = 'Nama'
    end
    object LabelEmail: TLabel
      Left = 15
      Top = 60
      Width = 29
      Height = 15
      Caption = 'Email'
    end
    object LabelTelepon: TLabel
      Left = 15
      Top = 89
      Width = 42
      Height = 15
      Caption = 'Telepon'
    end
    object LabelCatatan: TLabel
      Left = 15
      Top = 118
      Width = 41
      Height = 15
      Caption = 'Catatan'
    end
    object ListViewData: TListView
      Left = 272
      Top = 28
      Width = 313
      Height = 294
      Columns = <
        item
          AutoSize = True
          Caption = 'Nama'
        end
        item
          AutoSize = True
          Caption = 'Email'
        end
        item
          AutoSize = True
          Caption = 'Telepon'
        end>
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
    object EditNama: TEdit
      Left = 71
      Top = 28
      Width = 185
      Height = 23
      TabOrder = 1
    end
    object EditEmail: TEdit
      Left = 71
      Top = 57
      Width = 185
      Height = 23
      TabOrder = 2
    end
    object EditTelepon: TEdit
      Left = 71
      Top = 86
      Width = 185
      Height = 23
      TabOrder = 3
    end
    object RichEdit: TRichEdit
      Left = 71
      Top = 115
      Width = 185
      Height = 89
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object ButtonBuat: TButton
      Left = 15
      Top = 220
      Width = 75
      Height = 25
      Caption = 'Buat'
      TabOrder = 5
    end
    object ButtonHapus: TButton
      Left = 15
      Top = 251
      Width = 75
      Height = 25
      Caption = 'Hapus'
      TabOrder = 6
    end
    object ButtonUbah: TButton
      Left = 96
      Top = 220
      Width = 75
      Height = 25
      Caption = 'Ubah'
      TabOrder = 7
    end
    object ButtonBatal: TButton
      Left = 96
      Top = 251
      Width = 75
      Height = 25
      Caption = 'Batal'
      TabOrder = 8
    end
    object ButtonKeluar: TButton
      Left = 96
      Top = 282
      Width = 75
      Height = 25
      Caption = 'Keluar'
      TabOrder = 9
    end
    object ButtonSimpan: TButton
      Left = 15
      Top = 282
      Width = 75
      Height = 25
      Caption = 'Simpan'
      TabOrder = 10
    end
  end
  object GroupBoxPreview: TGroupBox
    Left = 8
    Top = 355
    Width = 608
    Height = 70
    Caption = 'Preview'
    TabOrder = 1
    object LabelTanggalData: TLabel
      Left = 15
      Top = 32
      Width = 69
      Height = 15
      Caption = 'Tanggal Data'
    end
    object DateTimePicker: TDateTimePicker
      Left = 90
      Top = 26
      Width = 186
      Height = 23
      Date = 45838.000000000000000000
      Time = 0.986119849534588900
      TabOrder = 0
    end
    object ButtonPreview: TButton
      Left = 294
      Top = 25
      Width = 75
      Height = 25
      Caption = 'Preview'
      TabOrder = 1
    end
  end
  object ZConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    DisableSavepoints = False
    HostName = ''
    Port = 0
    Database = ''
    User = ''
    Password = ''
    Protocol = ''
    Left = 528
    Top = 280
  end
  object ZQuery: TZQuery
    Params = <>
    Left = 528
    Top = 200
  end
end
