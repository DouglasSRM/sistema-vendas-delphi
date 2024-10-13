inherited frmCadCategoria: TfrmCadCategoria
  Caption = 'Cadastro de Categorias'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 776
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
            FieldName = 'categoriaId'
            Width = 108
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 889
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object edtCategotiaId: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 56
        Width = 121
        Height = 23
        EditLabel.Width = 39
        EditLabel.Height = 15
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtDescricao: TLabeledEdit
        Tag = 2
        Left = 16
        Top = 112
        Width = 361
        Height = 23
        EditLabel.Width = 51
        EditLabel.Height = 15
        EditLabel.Caption = 'Descri'#231#227'o'
        MaxLength = 30
        TabOrder = 1
        Text = ''
        OnChange = edtDescricaoChange
      end
    end
  end
  inherited pnlRodape: TPanel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 479
    ExplicitWidth = 782
    inherited btnFechar: TBitBtn
      Left = 676
      ExplicitLeft = 674
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select categoriaId, descricao from categorias')
    object QryListagemcategoriaId: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryListagemdescricao: TZUnicodeStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
end
