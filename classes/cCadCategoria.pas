unit cCadCategoria;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TCategoria = class //Declaração do tipo da Classe
  private
    ConexaoDB: TZConnection;
    F_categoriaId : Integer; //Int
    F_descricao : String; //Varchar
    function getCodigo: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);
  public
    constructor Create(aConexao: TZConnection); //Construtor da Classe
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
    //Variáveis públicas que podem ser trabalhadas fora da classe
  published
    property codigo: Integer read getCodigo write setCodigo;
    property descricao: String read getDescricao write setDescricao;
    //Variaveis públicas utilizadas para propriedades da classe
    //para fornecer informações em runtime

  end;

implementation

{ TCategoria }

{$region 'Constructor and Destructor'}

constructor TCategoria.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCategoria.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TCategoria.Apagar: Boolean;
  var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Código: '+IntToStr(getCodigo) +#13+
                'Descrição: '+getDescricao,
                mtConfirmation, [mbYes, mbNo],0) = mrNo then begin
    Result := false;
    abort;
  end;


  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM categorias ' +
                ' WHERE categoriaId = :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := getCodigo;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE categorias ' +
                '   SET descricao = :descricao ' +
                ' WHERE categoriaId = :categoriaId ');
    Qry.ParamByName('categoriaId').AsInteger := getCodigo;
    Qry.ParamByName('descricao').AsString:= getDescricao;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TCategoria.Inserir: Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO categorias (descricao) values (:descricao)');
    Qry.ParamByName('descricao').AsString:= getDescricao;
    try
      Qry.ExecSQL;
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    Qry := TzQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT categoriaID, ' +
               '       descricao ' +
               'FROM categorias ' +
               'WHERE categoriaId = :categoriaId');
    Qry.ParamByName('categoriaId').AsInteger := id;
    try
      Qry.Open;

      setCodigo(Qry.FieldByName('categoriaId').AsInteger);
      setDescricao(Qry.FieldByName('descricao').AsString);
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;

{$endregion}

{$region 'Getters&Setters'}
function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;

procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;
{$endregion}

end.
