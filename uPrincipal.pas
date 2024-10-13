unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter;

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
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
  private
    TeclaEnter: TMREnter;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(self);
  frmCadCliente.ShowModal;
  frmCadCliente.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
dtmPrincipal := TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do begin
    SQLHourGlass := False;
    Protocol := 'ado';
    Port := 1433;
    User := 'sa';
    Password := 'mudar@123';
    Database := 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initial Catalog=vendas;Data Source=DOUGLASNT\SERVERCURSO';
    Connected := True;
  end;

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk;

end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;

end.
