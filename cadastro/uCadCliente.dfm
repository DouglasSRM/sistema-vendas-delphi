inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Clientes'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    inherited tabListagem: TTabSheet
      inherited pnlListagemTopo: TPanel
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 934
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
            FieldName = 'clienteid'
            Width = 51
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 201
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Width = 179
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Width = 174
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'bairro'
            Width = 170
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'telefone'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'email'
            Width = 239
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'datanascimento'
            Width = 124
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      object lbCEP: TLabel
        Left = 826
        Top = 54
        Width = 21
        Height = 15
        Caption = 'CEP'
      end
      object lbTelefone: TLabel
        Left = 472
        Top = 151
        Width = 44
        Height = 15
        Caption = 'Telefone'
      end
      object lbDataNascimento: TLabel
        Left = 16
        Top = 202
        Width = 107
        Height = 15
        Caption = 'Data de Nascimento'
      end
      object edtClienteId: TLabeledEdit
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
        Left = 136
        Top = 72
        Width = 673
        Height = 23
        EditLabel.Width = 33
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
        Text = ''
        OnChange = edtNomeChange
      end
      object edtCEP: TMaskEdit
        Left = 826
        Top = 72
        Width = 81
        Height = 23
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 16
        Top = 120
        Width = 441
        Height = 23
        EditLabel.Width = 49
        EditLabel.Height = 15
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 3
        Text = ''
        OnChange = edtEnderecoChange
      end
      object edtBairro: TLabeledEdit
        Left = 472
        Top = 120
        Width = 435
        Height = 23
        EditLabel.Width = 31
        EditLabel.Height = 15
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 4
        Text = ''
        OnChange = edtBairroChange
      end
      object edtCidade: TLabeledEdit
        Left = 16
        Top = 168
        Width = 441
        Height = 23
        EditLabel.Width = 37
        EditLabel.Height = 15
        EditLabel.Caption = 'Cidade'
        MaxLength = 50
        TabOrder = 5
        Text = ''
        OnChange = edtCidadeChange
      end
      object edtTelefone: TMaskEdit
        Left = 472
        Top = 168
        Width = 159
        Height = 23
        EditMask = '(99) 99999-9999;1;_'
        MaxLength = 15
        TabOrder = 6
        Text = '(  )      -    '
      end
      object edtEmail: TLabeledEdit
        Left = 646
        Top = 168
        Width = 261
        Height = 23
        EditLabel.Width = 29
        EditLabel.Height = 15
        EditLabel.Caption = 'Email'
        MaxLength = 100
        TabOrder = 7
        Text = ''
      end
      object edtDataNascimento: TDateEdit
        Left = 16
        Top = 220
        Width = 121
        Height = 23
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 8
      end
    end
  end
  inherited pnlRodape: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited btnFechar: TBitBtn
      Left = 830
      ExplicitLeft = 672
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT'
      '    clienteId,'
      '    nome,'
      '    endereco,'
      '    cidade,'
      '    bairro,'
      '    estado,'
      '    cep,'
      '    telefone,'
      '    email,'
      '    dataNascimento'
      'FROM'
      '    clientes;')
    Left = 644
    Top = 65526
    object QryListagemclienteid: TZIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteid'
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryListagemendereco: TZUnicodeStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 60
    end
    object QryListagemcidade: TZUnicodeStringField
      DisplayLabel = 'Cidade'
      FieldName = 'cidade'
      Size = 50
    end
    object QryListagembairro: TZUnicodeStringField
      DisplayLabel = 'Bairro'
      FieldName = 'bairro'
      Size = 40
    end
    object QryListagemestado: TZUnicodeStringField
      DisplayLabel = 'Estado'
      FieldName = 'estado'
      Size = 2
    end
    object QryListagemcep: TZUnicodeStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagemtelefone: TZUnicodeStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Size = 15
    end
    object QryListagememail: TZUnicodeStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
      Size = 100
    end
    object QryListagemdatanascimento: TZDateTimeField
      DisplayLabel = 'Data de Nascimento'
      FieldName = 'datanascimento'
    end
  end
  inherited dtsListagem: TDataSource
    Top = 65526
  end
end
