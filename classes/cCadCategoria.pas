unit cCadCategoria;

interface

uses System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
ZAbstractConnection, ZConnection; //lista de Units

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
    function Gravar:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
    //Variáveis públicas que podem ser trabalhadas fora da classe
  published
    property codigo:Integer read getCodigo write setCodigo;
    property descricao:String read getDescricao write setDescricao;
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

function TCategoria.Gravar: Boolean;
begin
  ShowMessage('Gravado');
  Result := true;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
begin
  Result := true;
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
