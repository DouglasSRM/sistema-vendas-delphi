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



{$region 'Crud'}
function TCategoria.Apagar: Boolean;
begin
  ShowMessage('Apagado');
  Result := true;
end;

function TCategoria.Atualizar: Boolean;
begin
  ShowMessage('Atualizado');
  Result := true;
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
       FreeAndNil(Qry)
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

{$region 'Getters'}
function TCategoria.getCodigo: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;
{$endregion}

{$region 'Setters'}
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
