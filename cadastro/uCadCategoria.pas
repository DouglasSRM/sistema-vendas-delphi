unit uCadCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  cCadCategoria, uDTMConexao, uEnum;

type
  TfrmCadCategoria = class(TfrmTelaHeranca)
    edtCategotiaId: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    QryListagemcategoriaid: TZIntegerField;
    QryListagemdescricao: TZUnicodeStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtDescricaoChange(Sender: TObject);
  private
    oCategoria:TCategoria;
    function Apagar:Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategoria: TfrmCadCategoria;

implementation

{$R *.dfm}

{$region 'Override'}

function TfrmCadCategoria.Apagar: Boolean;
begin
  Result := False;
  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then
    Result:=oCategoria.Apagar;
end;

function TfrmCadCategoria.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  Result := False;
  if edtCategotiaId.Text<>EmptyStr then
    oCategoria.codigo := StrToInt(edtCategotiaId.Text)
  else
    oCategoria.codigo := 0;

  oCategoria.descricao := edtDescricao.Text;

  if (EstadoDoCadastro = ecInserir) then
    Result:=oCategoria.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCategoria.Atualizar;
end;

{$endregion}

{$region 'Form Procedures'}

procedure TfrmCadCategoria.btnAlterarClick(Sender: TObject);
begin
  if QryListagem.FieldByName('categoriaId').AsInteger = 0 then begin
    MessageDlg('Nenhuma categoria cadastrada', mtInformation, [mbOK], 0);
    abort;
  end;

  if oCategoria.Selecionar(QryListagem.FieldByName('categoriaId').AsInteger) then begin
    edtCategotiaId.Text := IntToStr(oCategoria.codigo);
    edtDescricao.Text := oCategoria.descricao;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadCategoria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCategoria) then
    FreeAndNil(oCategoria);
end;

procedure TfrmCadCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria := TCategoria.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'descricao';
end;

{$endregion}

{$region 'Capitalize'}

procedure TfrmCadCategoria.edtDescricaoChange(Sender: TObject);
begin
  CapitalizeLbEdit(edtDescricao);
end;

{$endregion}

end.
