inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produtos'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited lblIndice: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited mskPesquisar: TMaskEdit
          StyleElements = [seFont, seClient, seBorder]
        end
      end
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoid'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 252
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Width = 86
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao_categoria'
            Width = 275
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object lbDescricao: TLabel
        Left = 16
        Top = 190
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object lbValor: TLabel
        Left = 16
        Top = 318
        Width = 26
        Height = 15
        Caption = 'Valor'
      end
      object lbQuantidade: TLabel
        Left = 170
        Top = 318
        Width = 62
        Height = 15
        Caption = 'Quantidade'
      end
      object lbCategoria: TLabel
        Left = 448
        Top = 126
        Width = 51
        Height = 15
        Caption = 'Categoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 72
        Width = 107
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 16
        Top = 144
        Width = 417
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
        Text = ''
        OnChange = edtNomeChange
      end
      object edtDescricao: TMemo
        Left = 16
        Top = 208
        Width = 735
        Height = 89
        MaxLength = 255
        TabOrder = 3
      end
      object edtValor: TCurrencyEdit
        Left = 16
        Top = 336
        Width = 121
        Height = 23
        TabOrder = 4
      end
      object edtQuantidade: TCurrencyEdit
        Left = 170
        Top = 336
        Width = 121
        Height = 23
        DisplayFormat = ',0.00;- ,0.00'
        TabOrder = 5
      end
      object lkpCategoria: TDBLookupComboBox
        Left = 448
        Top = 144
        Width = 303
        Height = 23
        KeyField = 'categoriaid'
        ListField = 'descricao'
        ListSource = dtsCategoria
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select p.produtoId,'
      '       p.nome,'
      '       p.descricao,'
      #9'   p.valor,'
      #9'   p.quantidade,'
      #9'   p.categoriaid,'
      #9'   c.descricao as descricao_categoria'
      '  from produtos as p'
      '  left join categorias as c on c.categoriaid = p.categoriaid')
    Top = 65534
    object QryListagemprodutoid: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoid'
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 255
    end
    object QryListagemvalor: TZFMTBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Precision = 18
      Size = 5
    end
    object QryListagemquantidade: TZFMTBCDField
      DisplayLabel = 'Estoque'
      FieldName = 'quantidade'
      Precision = 18
      Size = 5
    end
    object QryListagemcategoriaid: TZIntegerField
      DisplayLabel = 'Cod. Categoria'
      FieldName = 'categoriaid'
    end
    object QryListagemdescricao_categoria: TZUnicodeStringField
      DisplayLabel = 'Categoria'
      FieldName = 'descricao_categoria'
      Required = True
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Top = 65534
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT categoriaid, descricao from categorias')
    Params = <>
    DataSource = dtsListagem
    Left = 636
    Top = 50
    object QryCategoriacategoriaid: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaid'
    end
    object QryCategoriadescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Required = True
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 716
    Top = 50
  end
end
