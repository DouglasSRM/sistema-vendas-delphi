unit uRelCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset, uDTMConexao,
  ZAbstractDataset, ZDataset, RLReport, RLFilters, RLPDFFilter, RLXLSFilter,
  RLXLSXFilter;

type
  TfrmRelCategoria = class(TForm)
    QryCategorias: TZQuery;
    dtsCategorias: TDataSource;
    QryCategoriascategoriaid: TZIntegerField;
    QryCategoriasdescricao: TZUnicodeStringField;
    pdfFilter: TRLPDFFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel5: TRLLabel;
    RLLabel4: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel8: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel9: TRLLabel;
    RLSystemInfo3: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCategoria: TfrmRelCategoria;

implementation

{$R *.dfm}

procedure TfrmRelCategoria.FormCreate(Sender: TObject);
begin
  QryCategorias.Open;

end;

procedure TfrmRelCategoria.FormDestroy(Sender: TObject);
begin
  QryCategorias.Close;
end;

end.
