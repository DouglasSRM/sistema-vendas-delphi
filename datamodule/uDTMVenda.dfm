object dtmVenda: TdtmVenda
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 344
  Width = 589
  PixelsPerInch = 120
  object QryCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'select clienteid, nome from clientes')
    Params = <>
    Left = 88
    Top = 88
    object QryClienteclienteid: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteid'
    end
    object QryClientenome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
  end
  object QryProdutos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT produtoid, nome, valor, quantidade FROM produtos')
    Params = <>
    Left = 248
    Top = 88
    object QryProdutosprodutoid: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoid'
    end
    object QryProdutosnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryProdutosvalor: TZFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryProdutosquantidade: TZFMTBCDField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
  end
  object cdsItensVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 88
    object cdsItensVendaprodutoid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoid'
    end
    object cdsItensVendaNomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NomeProduto'
      Size = 60
    end
    object cdsItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'valorUnitario'
    end
    object cdsItensVendatotalProduto: TFloatField
      DisplayLabel = 'Total'
      FieldName = 'totalProduto'
    end
  end
  object dtsCliente: TDataSource
    DataSet = QryCliente
    Left = 88
    Top = 168
  end
  object dtsProdutos: TDataSource
    DataSet = QryProdutos
    Left = 248
    Top = 168
  end
  object dtsItensVenda: TDataSource
    DataSet = cdsItensVenda
    Left = 416
    Top = 168
  end
end
