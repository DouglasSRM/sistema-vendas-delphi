unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  uDTMConexao, uDTMVenda, RxToolEdit, RxCurrEdit, cProVenda, uEnum;

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
    edtValorTotal: TCurrencyEdit;
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
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    dtmVenda:TdtmVenda;
    oVenda: TVenda;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}

{$region 'Override'}

function TfrmProVenda.Apagar: Boolean;
begin
  result := false;
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then
    Result:=oVenda.Apagar;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  Result := False;
  if edtVendaId.Text<>EmptyStr then
    oVenda.vendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.vendaId := 0;

  oVenda.clienteId   := lkpCliente.KeyValue;
  oVenda.dataVenda   := edtDataVenda.Date;
  oVenda.TotalVenda  := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    Result := oVenda.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oVenda.Atualizar;
end;

{$endregion}


procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger) then begin
    edtVendaId.Text       := IntToStr(oVenda.vendaId);
    lkpCliente.KeyValue   := oVenda.clienteId;
    edtDataVenda.Date   := oVenda.dataVenda;
    edtValorTotal.Value := oVenda.totalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);

  if Assigned(oVenda) then
    FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda:=TdtmVenda.Create(Self);

  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual:= 'clienteId';
end;

procedure TfrmProVenda.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

end.
