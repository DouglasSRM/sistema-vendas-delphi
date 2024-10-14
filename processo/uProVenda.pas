unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uDTMConexao, uDTMVenda, RxToolEdit, RxCurrEdit;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    QryListagemvendaid: TZIntegerField;
    QryListagemclienteid: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemdatavenda: TZDateTimeField;
    QryListagemtotalvenda: TZFMTBCDField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    lbCliente: TLabel;
    edtDataVenda: TDateEdit;
    lbDataVenda: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValor: TCurrencyEdit;
    lbValorVenda: TLabel;
    grdItens: TDBGrid;
    lkpProduto: TDBLookupComboBox;
    lbProduto: TLabel;
    edtValorUnitario: TCurrencyEdit;
    lvValorUnitario: TLabel;
    edtQuantidade: TCurrencyEdit;
    lbQuantidade: TLabel;
    edtTotalProduto: TCurrencyEdit;
    lbValorTotal: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    dtmVenda:TdtmVenda;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}


procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda:=TdtmVenda.Create(Self);
end;

procedure TfrmProVenda.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

end.
