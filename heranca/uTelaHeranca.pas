unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RxToolEdit, uDTMConexao, uEnum,
  RxCurrEdit;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    tabManutencao: TTabSheet;
    pnlListagemTopo: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
              btnGravar, btnApagar:TBitBtn; btnNavigator: TDBNavigator;
              pgcPrincipal: TPageControl; Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): String;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
    function ExisteCampoObrigatorio: Boolean;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
  public
    EstadoDoCadastro: TEstadoDoCadastro;
    IndiceAtual : String;
    function Apagar:Boolean; virtual;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro):Boolean; virtual;
    function Capitalize(const Str: string):String;
    function CapitalizeLbEdit(EditControl: TLabeledEdit): Boolean;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}
{$region 'OBSERVAÇÕES'}
//TAG: 1 - Chave Primária - PK
//TAG: 2 - Campos Obrigatórios - Not Null
{$endregion}

{$region 'Funções e Procedures'}
procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmPrincipal.ConexaoDB;
  dtsListagem.DataSet := QryListagem;
  grdListagem.DataSource := dtsListagem;
  btnNavigator.DataSource := dtsListagem;
  grdListagem.Options := [dgTitles,dgIndicator,
                          dgColLines,dgRowLines,dgTabs,dgRowSelect,
                          dgAlwaysShowSelection,dgCancelOnExit,
                          dgTitleClick,dgTitleHotTrack]
end;


procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (QryListagem.SQL.Text <> EmptyStr) then begin
    QryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    QryListagem.Open;
  end;
  ControlarIndiceTab(pgcPrincipal, 0);
  DesabilitarEditPK;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar, btnNavigator, pgcPrincipal, true);

end;


procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);

begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
    pgcPrincipal.TabIndex := Indice;
end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:String):String;
var i: Integer;
begin
  for i := 0 to (QryListagem.Fields.Count - 1) do begin
    if lowercase(QryListagem.Fields[i].FieldName) = lowercase(Campo) then begin
      Result := QryListagem.Fields[i].DisplayLabel;
      Break;
    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:String; aLabel: TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

procedure TfrmTelaHeranca.grdListagemDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TfrmTelaHeranca.grdListagemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  QryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
  var Search:String;
begin
  Search := Capitalize(TMaskEdit(Sender).Text);
  QryListagem.Locate(IndiceAtual, Search, [loPartialKey]);
end;

function TfrmTelaHeranca.ExisteCampoObrigatorio:Boolean;
var i:Integer;
begin
  Result := false;
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 2) and
         (TLabeledEdit(Components[i]).Text=EmptyStr) then begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption +
                    ' é um campo obrigatório',mtInformation, [mbOK],0);
        TLabeledEdit(Components[i]).SetFocus;
        Result:=true;
        break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.DesabilitarEditPK;
var i:Integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then begin
      if (TLabeledEdit(Components[i]).Tag = 1) then begin
        TLabeledEdit(Components[i]).Enabled:=false;
        break;
      end;
    end;
  end;
end;

procedure TfrmTelaHeranca.LimparEdits;
var i:Integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TLabeledEdit) then
      TLabeledEdit(Components[i]).Text := EmptyStr
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text := EmptyStr
    else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text := EmptyStr
    else if (Components[i] is TDateEdit) then
      TDateEdit(Components[i]).Text := EmptyStr
    else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text := ''
    else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue :=  null
    else if (Components[i] is TCurrencyEdit) then
      TCurrencyEdit(Components[i]).Value := 0;
  end;
end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close;
end;

{$endregion}

{$region 'Métodos Virtuais'}
function TfrmTelaHeranca.Apagar: Boolean;
begin
  ShowMessage('Deletado');

  Result := True;

end;

function TfrmTelaHeranca.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if (EstadoDoCadastro = ecInserir) then
    ShowMessage('Inserido')
  else if (EstadoDoCadastro = ecAlterar) then
    ShowMessage('Alterado');

  Result := True;

end;

{$endregion}

{$region 'Controle de Botões'}

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
          btnGravar, btnApagar:TBitBtn; btnNavigator: TDBNavigator;
          pgcPrincipal: TPageControl; Flag:Boolean);
begin
  btnNovo.Enabled                  := Flag;
  btnApagar.Enabled                := Flag;
  btnAlterar.Enabled               := Flag;
  btnNavigator.Enabled             := Flag;
  pgcPrincipal.Pages[0].TabVisible := Flag;
  btnCancelar.Enabled              := not(Flag);
  btnGravar.Enabled                := not(Flag);
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                                        btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecInserir;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                                        btnNavigator, pgcPrincipal, false);
  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  Try
    if (Apagar) then begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                                            btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      LimparEdits;
      QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Exclusão', mtError, [mbOK],0);
    end;
  Finally
    EstadoDoCadastro := ecNenhum;
  End;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                                          btnNavigator, pgcPrincipal, true);
  ControlarIndiceTab(pgcPrincipal, 0);
  EstadoDoCadastro := ecNenhum;
  LimparEdits;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  if ExisteCampoObrigatorio then
  abort;

  try
    if Gravar(EstadoDoCadastro) then begin //Método Virtual
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnApagar,
                                            btnNavigator, pgcPrincipal, true);
      ControlarIndiceTab(pgcPrincipal, 0);
      EstadoDoCadastro := ecNenhum;
      LimparEdits;
      QryListagem.Refresh;
    end
    else begin
      MessageDlg('Erro na Gravação', mtError, [mbOK],0);
    end;
  finally

  end;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;
{$endregion}

{$region 'Funções QoL'}
function TfrmTelaHeranca.Capitalize(const Str: string):String;
var
  i: Integer;
  InWord: Boolean;
begin
  Result := LowerCase(Str);
  InWord := False;
  Result := Result.TrimLeft;

  i := 1;
  while i <= Length(Result) do begin
    if not InWord and (Result[i] <> ' ') then begin
      Result[i] := UpCase(Result[i]);
      InWord := true;
    end
    else if (Result[i] = ' ') and ((i < Length(Result)) and (Result[i+1] = ' ')) then begin
      Delete(Result, i, 1);
      Continue;
    end
    else if Result [i] = ' ' then InWord := False;

    Inc(i);
  end;
end;

function TfrmTelaHeranca.CapitalizeLbEdit(EditControl: TLabeledEdit): Boolean;
var
  updated: String;
  oldOnChange: TNotifyEvent;
  cursorPos: Integer;
begin
  Result := False;
  updated := Capitalize(EditControl.Text);

  if (EditControl.Text = updated) then Exit;

  cursorPos := EditControl.SelStart;
  oldOnChange := EditControl.OnChange;
  EditControl.OnChange := nil;

  try
    EditControl.Text := updated;
    EditControl.SelStart := cursorPos;
    Result := True;
  finally
    EditControl.OnChange := oldOnChange;
  end;

end;

procedure TfrmTelaHeranca.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
if (Shift = [ssCtrl]) and (Key = 46) then
    Key := 0;
end;

{$endregion}

end.
