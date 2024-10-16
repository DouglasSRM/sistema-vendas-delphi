unit cControleEstoque;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Data.DB, Datasnap.DBClient;

type
  TControleEstoque = class
  private
    ConexaoDB: TZConnection;
    F_produtoId: Integer;
    F_quantidade: Double;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property produtoId: Integer read F_produtoid  write F_produtoId;
    property quantidade: Double read F_quantidade write F_quantidade;
  end;


implementation

{ TControleEstoque }

{$region 'Constructor and Desctructor'}

constructor TControleEstoque.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin
  inherited;
end;

{$endregion}

function TControleEstoque.BaixarEstoque: Boolean;
var Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos ' +
                '   SET quantidade = quantidade - :qtdeBaixa ' +
                ' WHERE produtoId = :produtoId ');
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    Qry.ParamByName('qtdeBaixa').AsFloat   := quantidade;
    try
      Qry.ExecSQL;
    except
      result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  end;
end;

function TControleEstoque.RetornarEstoque: Boolean;
var Qry: TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos ' +
                '   SET quantidade = quantidade + :qtdeRetorno ' +
                ' WHERE produtoId = :produtoId ');
    Qry.ParamByName('produtoId').AsInteger := produtoId;
    Qry.ParamByName('qtdeRetorno').AsFloat   := quantidade;
    try
      Qry.ExecSQL;
    except
      result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  end;
end;

end.
