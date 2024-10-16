unit cProVenda;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Data.DB, Datasnap.DBClient;

type
  TVenda = class
  private
    ConexaoDB: TZConnection;
    F_vendaId:Integer;
    F_clienteId: Integer;
    F_dataVenda: TDateTime;
    F_totalVenda: Double;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): boolean;
    function ApagaItens(cds: TClientDataSet): Boolean;
    function InNot(cds: TClientDataSet): String;
    function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
    function AtualizarItem(cds: TClientDataSet): Boolean;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir(cds:TClientDataSet):Boolean;
    function Atualizar(cds:TClientDataSet):Boolean;
    function Apagar:Boolean;
    function Selecionar(id: Integer; var cds: TClientDataSet):Boolean;
  published
    property vendaId: Integer     read F_vendaId    write F_vendaId;
    property clienteId: Integer   read F_clienteId  write F_clienteId;
    property dataVenda: TDateTime read F_dataVenda  write F_dataVenda;
    property totalVenda: Double   read F_totalVenda write F_totalVenda;
  end;

implementation

{ TVenda }

{$region 'Constructor and Destructor'}

constructor TVenda.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TVenda.Destroy;
begin
  inherited;
end;

{$endregion}

{$region 'CRUD'}

function TVenda.Apagar: Boolean;
var Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'Venda Nro: '+IntToStr(vendaId),
                mtConfirmation, [mbYes, mbNo],0) = mrNo then begin
    Result := false;
    abort;
  end;

  try
    Result := true;
    ConexaoDB.StartTransaction;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM vendasItens ' +
                ' WHERE vendaId = :vendaId ');
    Qry.ParamByName('vendaId').AsInteger := vendaId;
    try
      Qry.ExecSQL;

      Qry.SQL.Clear;
      Qry.SQL.Add('DELETE FROM vendas ' +
                  ' WHERE vendaId = :vendaId ');
      Qry.ParamByName('vendaId').AsInteger := vendaId;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.Atualizar(cds:TClientDataSet): Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
    ConexaoDB.StartTransaction;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE vendas ' +
                '   SET clienteId  = :clienteId ' +
                '      ,dataVenda  = :dataVenda ' +
                '      ,totalVenda = :totalVenda ' +
                ' WHERE vendaId    = :vendaId ');
    Qry.ParamByName('vendaId').AsInteger    := Self.F_vendaId;
    Qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      Qry.ExecSQL;

      ApagaItens(cds);

      cds.First;
      while not cds.Eof do begin
        if EsteItemExiste(Self.F_vendaId, cds.FieldByName('produtoId').AsInteger) then
          AtualizarItem(cds)
        else
          InserirItens(cds, Self.F_vendaId);

        cds.Next;
      end;

      ConexaoDB.Commit;
    except
      Result := false;
      ConexaoDB.Rollback;
    end;
  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.AtualizarItem(cds:TClientDataSet): Boolean;
var Qry:TZQuery;
begin
  try
    result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE vendasItens '+
                '   SET valorUnitario = :valorUnitario '+
                '      ,quantidade = :quantidade '+
                '      ,totalProduto = :totalProduto '+
                ' WHERE vendaId = :vendaId AND produtoId = :produtoId ');
    Qry.ParamByName('vendaId').AsInteger     := Self.F_vendaId;
    Qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('valorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('totalProduto').AsFloat  := cds.FieldByName('totalProduto').AsFloat;
    try
      Qry.ExecSQL
    except
      result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  end;
end;

function TVenda.EsteItemExiste(vendaId: Integer; produtoId: Integer) :Boolean;
var Qry:TZQuery;
begin
  try
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT Count(vendaId) AS Qtde '+
                '  FROM vendasItens ' +
                ' WHERE vendaId = :vendaId AND produtoId = :produtoId');
    Qry.ParamByName('vendaId').AsInteger   := vendaId;
    Qry.ParamByName('produtoId').asInteger := produtoId;
    try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
        result := true
      else
        result := false;
    except
      result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.ApagaItens(cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM vendasItens ' +
                ' WHERE vendaId = :vendaId ' +
                '   AND produtoId NOT IN ('+InNot(cds)+') ');
    Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
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

function TVenda.InNot(cds:TClientDataSet):String;
var sInNot:String;
begin
  sInNot := EmptyStr;
  cds.First;
  while not cds.Eof do begin
    if sInNot=EmptyStr then
      sInNot := cds.FieldByName('produtoId').AsString
    else
      sInNot := sInNot + ', ' + cds.FieldByName('produtoId').AsString;

    cds.Next;
  end;
  result:=sInNot;
end;

function TVenda.Inserir(cds:TClientDataSet): Boolean;
var Qry: TZQuery;
    IdVendaGerado: Integer;
begin
  try
    Result := true;
    ConexaoDB.StartTransaction;
    Qry := TZQuery.Create(nil);
    qry.Connection := ConexaoDB;

    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO vendas ( clienteId, dataVenda, totalVenda) '+
                '            VALUES (:clienteId,:dataVenda,:totalVenda) '+
                '         RETURNING vendaId');
    Qry.ParamByName('clienteId').AsInteger  := Self.F_clienteId;
    Qry.ParamByName('dataVenda').AsDateTime := Self.F_dataVenda;
    Qry.ParamByName('totalVenda').AsFloat   := Self.F_totalVenda;

    try
      Qry.Open;
      IdVendaGerado := Qry.FieldByName('vendaId').AsInteger;

      cds.First;
      while not cds.Eof do begin
        InserirItens(cds, IdVendaGerado);
        cds.Next;
      end;
      ConexaoDB.Commit;
    except
      ConexaoDB.Rollback;
      Result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TVenda.InserirItens(cds: TClientDataSet; IdVenda: Integer) : boolean;
var Qry:TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO vendasitens ( vendaId, produtoId, valorUnitario, quantidade, totalProduto) '+
                '                 VALUES (:vendaId,:produtoId,:valorUnitario,:quantidade,:totalProduto) ');
    Qry.ParamByName('vendaId').AsInteger     := IdVenda;
    Qry.ParamByName('produtoId').AsInteger   := cds.FieldByName('produtoId').AsInteger;
    Qry.ParamByName('valorUnitario').AsFloat := cds.FieldByName('valorUnitario').AsFloat;
    Qry.ParamByName('quantidade').AsFloat    := cds.FieldByName('quantidade').AsFloat;
    Qry.ParamByName('totalProduto').AsFloat  := cds.FieldByName('totalProduto').AsFloat;
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

function TVenda.Selecionar(id: Integer; var cds: TClientDataSet): Boolean;
var Qry: TZQuery;
begin
  try
    Result := true;
    Qry:= TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT vendaId' +
                '      ,clienteId ' +
                '      ,dataVenda ' +
                '      ,totalVenda ' +
                '  FROM vendas '+
                ' WHERE vendaId = :vendaId');
    Qry.ParamByName('vendaId').AsInteger := id;

    try
      Qry.Open;

      Self.F_vendaId        := Qry.FieldByName('vendaId').AsInteger;
      Self.F_clienteId      := Qry.FieldByName('clienteId').AsInteger;
      Self.F_dataVenda      := Qry.FieldByName('dataVenda').AsDateTime;
      Self.F_totalVenda     := Qry.FieldByName('totalVenda').AsFloat;

      cds.First;
      while not cds.Eof do begin
        cds.Delete;
      end;

      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('SELECT vendasItens.produtoId, '+
                  '       produtos.nome, ' +
                  '       vendasItens.valorUnitario, ' +
                  '       vendasItens.quantidade, ' +
                  '       vendasItens.totalProduto '+
                  '  FROM vendasItens '+
                  '       INNER JOIN produtos on produtos.produtoId = vendasItens.produtoId '+
                  ' WHERE vendasItens.vendaId = :vendaId ');
      Qry.ParamByName('vendaId').AsInteger := Self.F_vendaId;
      Qry.Open;

      Qry.First;
      while not Qry.Eof do begin
        cds.Append;
        cds.FieldByName('produtoId').AsInteger   := Qry.FieldByName('produtoId').AsInteger;
        cds.FieldByName('nomeProduto').AsString  := Qry.FieldByName('nome').AsString;
        cds.FieldByName('valorUnitario').AsFloat := Qry.FieldByName('valorUnitario').AsFloat;
        cds.FieldByName('quantidade').AsFloat    := Qry.FieldByName('quantidade').AsFloat;
        cds.FieldByName('totalProduto').AsFloat  := Qry.FieldByName('totalProduto').AsFloat;
        cds.Post;
        Qry.Next;
      end;
      cds.First;
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
