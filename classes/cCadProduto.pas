unit cCadProduto;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TProduto = class
  private
    ConexaoDB: TZConnection;
    F_produtoId:Integer;
    F_nome: String;
    F_descricao: String;
    F_valor: Double;
    F_quantidade: Double;
    F_categoriaId: Integer;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
  published
    property codigo       :Integer   read F_produtoId    write F_produtoId;
    property nome         :String    read F_nome         write F_nome;
    property descricao    :String    read F_descricao    write F_descricao;
    property valor        :Double    read F_valor        write F_valor;
    property quantidade   :Double    read F_quantidade   write F_quantidade;
    property categoriaId  :Integer   read F_categoriaId  write F_categoriaId;
  end;

implementation

{ TProduto }

{$region 'Constructor and Destructor'}

constructor TProduto.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TProduto.Apagar: Boolean;
  var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'C�digo: '+IntToStr(F_produtoId) +#13+
                'Nome: '+F_nome,
                mtConfirmation, [mbYes, mbNo],0) = mrNo then begin
    Result := false;
    abort;
  end;

  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM produtos ' +
                ' WHERE produtoId = :produtoId ');
    Qry.ParamByName('produtoId').AsInteger := F_produtoId;
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

function TProduto.Atualizar: Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos ' +
                '   SET nome        = :nome ' +
                '      ,descricao   = :descricao ' +
                '      ,valor       = :valor ' +
                '      ,quantidade  = :quantidade ' +
                '      ,categoriaId = :categoriaId ' +
                ' WHERE produtoId = :produtoId ');
    Qry.ParamByName('produtoId').AsInteger   := Self.F_produtoId;
    Qry.ParamByName('nome').AsString         := Self.F_nome;
    Qry.ParamByName('descricao').AsString    := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat         := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat    := Self.F_quantidade;
    if Self.F_categoriaId = 0 then
      Qry.ParamByName('categoriaId').Clear
    else
      Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Inserir: Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO produtos (nome,'          +
                '                      descricao, '    +
                '                      valor, '        +
                '                      quantidade, '   +
                '                      categoriaId) ' +
                ' VALUES              (:nome, '        +
                '                      :descricao, '   +
                '                      :valor, '       +
                '                      :quantidade, '  +
                '                      :categoriaId) ');
    Qry.ParamByName('nome').AsString         := Self.F_nome;
    Qry.ParamByName('descricao').AsString    := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat         := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat    := Self.F_quantidade;
    if Self.F_categoriaId = 0 then
      Qry.ParamByName('categoriaId').Clear
    else
      Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;

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

function TProduto.Selecionar(id: Integer): Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT produtoId,' +
                '       nome, ' +
                '       descricao, ' +
                '       valor, ' +
                '       quantidade, ' +
                '       categoriaId ' +
                '  FROM produtos '+
                ' WHERE produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := id;

    try
      Qry.Open;

      Self.F_produtoId      := Qry.FieldByName('produtoId').AsInteger;
      Self.F_nome           := Qry.FieldByName('nome').AsString;
      Self.F_descricao      := Qry.FieldByName('descricao').AsString;
      Self.F_valor          := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade     := Qry.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId    := Qry.FieldByName('categoriaId').AsInteger;

    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

{$endregion}

end.
