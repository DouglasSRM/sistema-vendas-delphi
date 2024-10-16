unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, cCadProduto, uDTMConexao, uEnum;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    QryListagemprodutoid: TZIntegerField;
    QryListagemnome: TZUnicodeStringField;
    QryListagemdescricao: TZUnicodeStringField;
    QryListagemvalor: TZFMTBCDField;
    QryListagemquantidade: TZFMTBCDField;
    QryListagemcategoriaid: TZIntegerField;
    QryListagemdescricao_categoria: TZUnicodeStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    lbDescricao: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    lbValor: TLabel;
    lbQuantidade: TLabel;
    lkpCategoria: TDBLookupComboBox;
    QryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    QryCategoriacategoriaid: TZIntegerField;
    QryCategoriadescricao: TZUnicodeStringField;
    lbCategoria: TLabel;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    oProduto : TProduto;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

{$region 'Override'}

function TfrmCadProduto.Apagar: Boolean;
begin
  Result := False;
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
    Result:=oProduto.Apagar;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  Result := False;
  if edtProdutoId.Text<>EmptyStr then
    oProduto.codigo := StrToInt(edtProdutoId.Text)
  else
    oProduto.codigo := 0;

  oProduto.nome        := edtNome.Text;
  oProduto.descricao   := edtDescricao.Text;
  oProduto.valor       := edtValor.Value;
  oProduto.quantidade  := edtQuantidade.Value;
  if VarIsNull(lkpCategoria.KeyValue) then
    oProduto.categoriaId := 0
  else
    oProduto.categoriaId := lkpCategoria.KeyValue;

  if (EstadoDoCadastro = ecInserir) then
    Result := oProduto.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oProduto.Atualizar;
end;

{$endregion}

{$region 'Form Procedures'}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if QryListagem.FieldByName('produtoId').AsInteger = 0 then begin
    MessageDlg('Nenhum produto cadastrado', mtInformation, [mbOK], 0);
    abort;
  end;

  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then begin
    edtProdutoId.Text      := IntToStr(oProduto.codigo);
    edtNome.Text           := oProduto.nome;
    edtDescricao.Text      := oProduto.descricao;
    lkpCategoria.KeyValue  := oProduto.categoriaId;
    edtValor.Value         := oProduto.valor;
    edtQuantidade.Value    := oProduto.quantidade;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryCategoria.Close;
  if Assigned(oProduto) then
    FreeAndNil(oProduto);
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  QryCategoria.Open;
end;

{$endregion}

{$region 'Capitalize'}

procedure TfrmCadProduto.edtNomeChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtNome);
end;

{$endregion}

end.
