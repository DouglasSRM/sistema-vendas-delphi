unit uRelCadClienteFicha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.StdCtrls, RLXLSFilter,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, Vcl.Imaging.pngimage;

type
  TfrmRelCadClienteFicha = class(TForm)
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
    pdfFilter: TRLPDFFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    QryClientesendereco: TZUnicodeStringField;
    QryClientescidade: TZUnicodeStringField;
    QryClientesbairro: TZUnicodeStringField;
    QryClientesestado: TZUnicodeStringField;
    QryClientescep: TZUnicodeStringField;
    QryClientesdatanascimento: TZDateTimeField;
    RLLabel2: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel3: TRLLabel;
    RLDBText6: TRLDBText;
    RLLabel6: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText8: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLDraw3: TRLDraw;
    RLAngleLabel1: TRLAngleLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadClienteFicha: TfrmRelCadClienteFicha;

implementation

{$R *.dfm}

procedure TfrmRelCadClienteFicha.FormCreate(Sender: TObject);
begin
  QryClientes.Open;
end;

procedure TfrmRelCadClienteFicha.FormDestroy(Sender: TObject);
begin
  QryClientes.Close;
end;

end.
