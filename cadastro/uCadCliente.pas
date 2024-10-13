unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, cCadCliente, uDTMConexao, uEnum;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    lbCEP: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    lbTelefone: TLabel;
    edtEmail: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    lbDataNascimento: TLabel;
    QryListagemclienteId: TZIntegerField;
    QryListagemendereco: TZUnicodeStringField;
    QryListagemcidade: TZUnicodeStringField;
    QryListagembairro: TZUnicodeStringField;
    QryListagemestado: TZUnicodeStringField;
    QryListagemcep: TZUnicodeStringField;
    QryListagemtelefone: TZUnicodeStringField;
    QryListagememail: TZUnicodeStringField;
    QryListagemdatanascimento: TZDateTimeField;
    QryListagemnome: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtEnderecoChange(Sender: TObject);
    procedure edtBairroChange(Sender: TObject);
    procedure edtCidadeChange(Sender: TObject);
  private
    oCliente : TCliente;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

{$region 'Override'}

function TfrmCadCliente.Apagar: Boolean;
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
    Result:=oCliente.Apagar;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtClienteId.Text<>EmptyStr then begin
    oCliente.codigo := StrToInt(edtClienteId.Text)
  end
  else begin
    oCliente.codigo := 0;
  end;

  oCliente.nome           := edtNome.Text;
  oCliente.cep            := edtCep.Text;
  oCliente.endereco       := edtEndereco.Text;
  oCliente.bairro         := edtBairro.Text;
  oCliente.cidade         := edtCidade.Text;
  oCliente.telefone       := edtTelefone.Text;
  oCliente.email          := edtEmail.Text;
  oCliente.dataNascimento := edtDataNascimento.Date;

  if (EstadoDoCadastro = ecInserir) then
    Result := oCliente.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCliente.Atualizar;
end;

{$endregion}

{$region 'Form Procedures'}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then begin
    edtClienteId.Text      := IntToStr(oCliente.codigo);
    edtNome.Text           := oCliente.nome;
    edtCEP.Text            := oCliente.cep;
    edtEndereco.Text       := oCliente.endereco;
    edtBairro.Text         := oCliente.bairro;
    edtCidade.Text         := oCliente.cidade;
    edtTelefone.Text       := oCliente.telefone;
    edtEmail.Text          := oCliente.email;
    edtDataNascimento.Date := oCliente.dataNascimento;

  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  edtNome.SetFocus;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

{$endregion}

{$region 'Capitalize'}

procedure TfrmCadCliente.edtNomeChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtNome);
end;

procedure TfrmCadCliente.edtBairroChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtBairro);
end;

procedure TfrmCadCliente.edtCidadeChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtCidade);
end;

procedure TfrmCadCliente.edtEnderecoChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtEndereco);
end;

{$endregion}

end.
