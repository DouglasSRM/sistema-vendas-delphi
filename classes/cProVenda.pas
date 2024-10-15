unit cProVenda;

interface

uses System.Classes, System.SysUtils, Vcl.Controls, Vcl.ExtCtrls, Vcl.Dialogs,
  ZAbstractConnection, ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TVenda = class
  private
    ConexaoDB: TZConnection;
    F_vendaId:Integer;
    F_clienteId: Integer;
    F_dataVenda: TDateTime;
    F_totalVenda: Double;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar:Boolean;
    function Selecionar(id:Integer):Boolean;
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

function TVenda.Atualizar: Boolean;
  var Qry: TZQuery;
begin
  try
    Result := true;
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
    except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TVenda.Inserir: Boolean;
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

function TVenda.Selecionar(id: Integer): Boolean;
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
