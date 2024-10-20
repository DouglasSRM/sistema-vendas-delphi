unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter, uFrmAtualizaDB;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    CADASTRO1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    Relatrio1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    menuFechar: TMenuItem;
    Venda1: TMenuItem;
    Cliente2: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    Vendapordata1: TMenuItem;
    Categoria2: TMenuItem;
    FichadeClientes1: TMenuItem;
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure Venda1Click(Sender: TObject);
    procedure Categoria2Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure FichadeClientes1Click(Sender: TObject);
  private
    TeclaEnter: TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente, uCadProduto, uProVenda, uRelCategoria, uRelCadCliente,
  uRelCadClienteFicha;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.Categoria2Click(Sender: TObject);
begin
  frmRelCategoria := TfrmRelCategoria.Create(Self);
  frmRelCategoria.Relatorio.PreviewModal;
  frmRelCategoria.Release;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  frmRelCadCliente := TfrmRelCadCliente.Create(self);
  frmRelCadCliente.Relatorio.PreviewModal;
  frmRelCadCliente.Release;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(self);
  frmCadProduto.ShowModal;
  frmCadProduto.Release;
end;

procedure TfrmPrincipal.Venda1Click(Sender: TObject);
begin
  frmProVenda := TfrmProVenda.Create(self);
  frmProVenda.ShowModal;
  frmProVenda.Release;
end;

procedure TfrmPrincipal.FichadeClientes1Click(Sender: TObject);
begin
  frmRelCadClienteFicha := TfrmRelCadClienteFicha.Create(self);
  frmRelCadClienteFicha.Relatorio.PreviewModal;
  frmRelCadClienteFicha.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  frmAtualizaDB := TfrmAtualizaDB.Create(self);
  frmAtualizaDB.Show;
  frmAtualizaDB.Refresh;

  dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do
  begin
    try
      Connected := False;

      SQLHourGlass := True;
      LibraryLocation := 'C:\libpq.dll';
      HostName := 'localhost';
      Database := 'vendas';
      User := 'postgres';
      Password := 'admin';
      Port := 5433;
      Protocol := 'postgresql';

      Connected := True;
    except
      on E: Exception do
        ShowMessage('Erro ao conectar: ' + E.Message);
    end;
  end;
  AtualizacaoBancoDados(frmAtualizaDB);

  frmAtualizaDB.Free;

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk;
end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
begin
  aForm.chkConexao.Checked := true;
  aForm.Refresh;

  DtmPrincipal.QryScriptCategorias.ExecSQL;
  aForm.chkCategorias.Checked := true;
  aForm.Refresh;
  Sleep(200);

  DtmPrincipal.QryScriptClientes.ExecSQL;
  aForm.chkClientes.Checked := true;
  aForm.Refresh;
  Sleep(200);

  DtmPrincipal.QryScriptProdutos.ExecSQL;
  aForm.chkProdutos.Checked := true;
  aForm.Refresh;
  Sleep(200);

  DtmPrincipal.QryScriptVendas.ExecSQL;
  aForm.chkVendas.Checked := true;
  aForm.Refresh;
  Sleep(200);

  DtmPrincipal.QryScriptItensVendas.ExecSQL;
  aForm.chkItensVendas.Checked := true;
  aForm.Refresh;
  Sleep(200);
end;

end.
