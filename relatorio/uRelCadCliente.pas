unit uRelCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.StdCtrls, RLXLSFilter,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao;

type
  TfrmRelClientes = class(TForm)
    QryClientes: TZQuery;
    dtsClientes: TDataSource;
    QryClientesclienteid: TZIntegerField;
    QryClientesnome: TZUnicodeStringField;
    QryClientesemail: TZUnicodeStringField;
    QryClientestelefone: TZUnicodeStringField;
    Relatorio: TRLReport;
    Cabecario: TRLBand;
    RLDraw1: TRLDraw;
    RLLabel1: TRLLabel;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLBand2: TRLBand;
    RLPanel1: TRLPanel;
    pdfFilter: TRLPDFFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelClientes: TfrmRelClientes;

implementation

{$R *.dfm}

procedure TfrmRelClientes.FormCreate(Sender: TObject);
begin
  QryClientes.Open;
end;

procedure TfrmRelClientes.FormDestroy(Sender: TObject);
begin
  QryClientes.Close;
end;

end.
