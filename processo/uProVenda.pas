unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
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
    btnAdicionarItem: TBitBtn;
    btnRemoverItem: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure btnRemoverItemClick(Sender: TObject);
    procedure grdItensDblClick(Sender: TObject);
  private
    dtmVenda:TdtmVenda;
    oVenda: TVenda;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure TotalizarProduto;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
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
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
    Result:=oVenda.Apagar;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if lkpCliente.KeyValue = Null then begin
      MessageDlg('Cliente é um campo obrigatório', mtInformation, [mbOK], 0);
      lkpCliente.SetFocus;
      abort;
  end;
  Result := False;
  if edtVendaId.Text<>EmptyStr then
    oVenda.vendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.vendaId := 0;

  oVenda.clienteId   := lkpCliente.KeyValue;
  oVenda.dataVenda   := edtDataVenda.Date;
  oVenda.TotalVenda  := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    Result := oVenda.Inserir(dtmVenda.cdsItensVenda)
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oVenda.Atualizar(dtmVenda.cdsItensVenda);
end;

{$endregion}

{$region 'Form Procedures'}

procedure TfrmProVenda.btnAdicionarItemClick(Sender: TObject);
begin
  inherited;
    if lkpProduto.KeyValue = Null then begin
      MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOK], 0);
      lkpProduto.SetFocus;
      abort;
    end;

    if edtValorUnitario.Value <= 0 then begin
      MessageDlg('Valor Unitário não pode ser zero', mtInformation, [mbOK], 0);
      edtValorUnitario.SetFocus;
      abort;
    end;

    if edtQuantidade.Value <= 0 then begin
      MessageDlg('Quantidade não pode ser zero', mtInformation, [mbOK], 0);
      edtQuantidade.SetFocus;
      abort;
    end;

    if dtmVenda.cdsItensVenda.Locate('produtoId',lkpProduto.KeyValue, []) then begin
      MessageDlg('Este Produto já foi selecionado', mtInformation, [mbOK], 0);
      lkpProduto.SetFocus;
      abort;
    end;

    TotalizarProduto;

    dtmVenda.cdsItensVenda.Append;
    dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString:=lkpProduto.KeyValue;
    dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := dtmVenda.QryProdutos.FieldByName('nome').AsString;
    dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
    dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
    dtmVenda.cdsItensVenda.FieldByName('totalProduto').AsFloat := edtTotalProduto.Value;
    dtmVenda.cdsItensVenda.Post;
    edtValorTotal.Value := TotalizarVenda;

    LimparComponenteItem;
    lkpProduto.SetFocus;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  lkpProduto.KeyValue    := null;
  edtQuantidade.Value    := 0;
  edtValorUnitario.Value := 0;
  edtTotalProduto.Value  := 0;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
    dtmVenda.cdsItensVenda.Delete;
end;

procedure TfrmProVenda.TotalizarProduto();
begin
  edtTotalProduto.Value := (edtValorUnitario.Value * edtQuantidade.Value);
end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if QryListagem.FieldByName('vendaid').AsInteger = 0 then begin
    MessageDlg('Nenhuma venda cadastrada', mtInformation, [mbOK], 0);
    abort;
  end;

  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then begin
    edtVendaId.Text     := IntToStr(oVenda.vendaId);
    lkpCliente.KeyValue := oVenda.clienteId;
    edtDataVenda.Date   := oVenda.dataVenda;
    edtValorTotal.Value := oVenda.totalVenda;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.btnRemoverItemClick(Sender: TObject);
begin
  inherited;
  if lkpProduto.KeyValue = null then begin
    MessageDlg('Selecione o Produto a ser excluído', mtInformation, [mbOK], 0);
    grdItens.SetFocus;
    abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', lkpProduto.KeyValue, []) then begin
    dtmVenda.cdsItensVenda.Delete;
    edtValorTotal.Value := TotalizarVenda;
    LimparComponenteItem;
  end;
end;

procedure TfrmProVenda.edtQuantidadeChange(Sender: TObject);
begin
  inherited;
  TotalizarProduto;
end;

procedure TfrmProVenda.edtValorUnitarioChange(Sender: TObject);
begin
  inherited;
  TotalizarProduto;
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

procedure TfrmProVenda.grdItensDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.grdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.lkpProdutoExit(Sender: TObject);
begin
  inherited;
  if TDBLookupComboBox(Sender).KeyValue<>null then begin
    edtValorUnitario.Value := dtmVenda.QryProdutos.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    TotalizarProduto;
  end;
end;

procedure TfrmProvenda.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue    := dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtQuantidade.Value    := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value := dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtTotalProduto.Value  := dtmVenda.cdsItensVenda.FieldByName('totalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  result := 0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do begin
    result := result + dtmVenda.cdsItensVenda.FieldByName('totalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;
end;

{$endregion}

end.
