inherited frmProVenda: TfrmProVenda
  Caption = 'Vendas'
  ClientHeight = 626
  ClientWidth = 946
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 962
  ExplicitHeight = 665
  TextHeight = 15
  inherited pgcPrincipal: TPageControl
    Width = 946
    Height = 572
    ActivePage = tabManutencao
    ExplicitWidth = 944
    ExplicitHeight = 564
    inherited tabListagem: TTabSheet
      ExplicitWidth = 938
      ExplicitHeight = 542
      inherited pnlListagemTopo: TPanel
        Width = 938
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 938
        inherited lblIndice: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited mskPesquisar: TMaskEdit
          StyleElements = [seFont, seClient, seBorder]
        end
      end
      inherited grdListagem: TDBGrid
        Width = 938
        Height = 461
        Columns = <
          item
            Expanded = False
            FieldName = 'vendaid'
            Width = 114
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'clienteid'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'datavenda'
            Width = 142
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'totalvenda'
            Width = 123
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 938
      ExplicitHeight = 542
      object lbCliente: TLabel
        Left = 139
        Top = 31
        Width = 37
        Height = 15
        Caption = 'Cliente'
      end
      object lbDataVenda: TLabel
        Left = 776
        Top = 31
        Width = 75
        Height = 15
        Caption = 'Data da Venda'
      end
      object edtVendaId: TLabeledEdit
        Tag = 1
        Left = 16
        Top = 49
        Width = 107
        Height = 23
        EditLabel.Width = 95
        EditLabel.Height = 15
        EditLabel.Caption = 'N'#250'mero da Venda'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object lkpCliente: TDBLookupComboBox
        Left = 139
        Top = 49
        Width = 626
        Height = 23
        KeyField = 'clienteid'
        ListField = 'nome'
        ListSource = dtmVenda.dtsCliente
        TabOrder = 1
      end
      object edtDataVenda: TDateEdit
        Left = 776
        Top = 49
        Width = 135
        Height = 23
        ClickKey = 114
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 2
      end
      object Panel1: TPanel
        Left = 0
        Top = 96
        Width = 938
        Height = 446
        Align = alBottom
        TabOrder = 3
        ExplicitTop = 88
        ExplicitWidth = 936
        object Panel2: TPanel
          Left = 1
          Top = 67
          Width = 936
          Height = 336
          Align = alClient
          TabOrder = 0
          ExplicitWidth = 934
          object grdItens: TDBGrid
            Left = 1
            Top = 1
            Width = 934
            Height = 334
            Align = alClient
            DataSource = dtmVenda.dtsItensVenda
            Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit]
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnKeyDown = grdItensKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'produtoid'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NomeProduto'
                Width = 433
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'quantidade'
                Width = 128
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorUnitario'
                Width = 133
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valorTotalProduto'
                Width = 152
                Visible = True
              end>
          end
        end
        object Panel3: TPanel
          Left = 1
          Top = 403
          Width = 936
          Height = 42
          Align = alBottom
          TabOrder = 1
          ExplicitWidth = 934
          DesignSize = (
            936
            42)
          object lbValorVenda: TLabel
            Left = 707
            Top = 13
            Width = 81
            Height = 15
            Anchors = [akTop, akRight]
            Caption = 'Valor da Venda'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitLeft = 709
          end
          object edtValorTotal: TCurrencyEdit
            Left = 798
            Top = 10
            Width = 125
            Height = 23
            Alignment = taLeftJustify
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            Anchors = [akTop, akRight]
            ParentColor = True
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            ExplicitLeft = 796
          end
        end
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 936
          Height = 66
          Align = alTop
          TabOrder = 2
          ExplicitWidth = 934
          object lbProduto: TLabel
            Left = 7
            Top = 10
            Width = 43
            Height = 15
            Caption = 'Produto'
          end
          object lvValorUnitario: TLabel
            Left = 375
            Top = 10
            Width = 71
            Height = 15
            Caption = 'Valor Unit'#225'rio'
          end
          object lbQuantidade: TLabel
            Left = 487
            Top = 10
            Width = 62
            Height = 15
            Caption = 'Quantidade'
          end
          object lbValorTotal: TLabel
            Left = 599
            Top = 10
            Width = 88
            Height = 15
            Caption = 'Total do Produto'
          end
          object lkpProduto: TDBLookupComboBox
            Left = 7
            Top = 28
            Width = 354
            Height = 23
            KeyField = 'produtoid'
            ListField = 'nome'
            ListSource = dtmVenda.dtsProdutos
            TabOrder = 0
          end
          object edtValorUnitario: TCurrencyEdit
            Left = 375
            Top = 28
            Width = 98
            Height = 23
            DisplayFormat = ',0.00;- ,0.00'
            TabOrder = 1
          end
          object edtQuantidade: TCurrencyEdit
            Left = 487
            Top = 28
            Width = 98
            Height = 23
            DisplayFormat = ',0.00;- ,0.00'
            TabOrder = 2
          end
          object edtTotalProduto: TCurrencyEdit
            Left = 599
            Top = 28
            Width = 98
            Height = 23
            TabStop = False
            DisplayFormat = ',0.00;- ,0.00'
            ParentColor = True
            ReadOnly = True
            TabOrder = 3
          end
          object BitBtn1: TBitBtn
            Left = 720
            Top = 28
            Width = 92
            Height = 23
            Caption = 'A&dicionar'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FF686868
              6868686868686767676767676767676767676767676666666666666666666666
              66666666FF00FFFF00FFFF00FF767676FCFCFCF7F7F7F7F7F7F7F7F7F7F7F7F7
              F7F7F7F7F7F6F6F6F6F6F6F6F6F6FCFCFC747474FF00FFFF00FFFF00FF818181
              F7F7F7E0E0E0E1E1E1E1E1E1E1E1E1E1E1E1E0E0E0E0E0E0DEDEDEDDDDDDF6F6
              F67F7F7FFF00FFFF00FFFF00FF8B8B8BF8F8F8E3E3E3E5E5E5E5E5E5E5E5E5E5
              E5E5E3E3E3E2E2E2E1E1E1E0E0E0F7F7F78A8A8AFF00FFFF00FFFF00FF959595
              F8F8F8E7E7E7E7E7E7E9E9E9E9E9E9E7E7E7E7E7E7E6E6E6E5E5E5E3E3E3F8F8
              F8929292FF00FFFF00FFFF00FF9A9A9AFAFAFAEAEAEAEBEBEBEBEBEBEBEBEBEB
              EBEBEAEAEAEAEAEAE9E9E9E6E6E6F8F8F8999999FF00FFFF00FFFF00FFA1A1A1
              FBFBFBEDEDEDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEDEDEDEBEBEBEAEAEAFAFA
              FAA0A0A0FF00FFFF00FFFF00FFA5A5A5FBFBFBEFEFEFF0F0F0F2F2F2F2F2F2F0
              F0F0F0F0F0EFEFEFEEEEEEEDEDEDFAFAFAA5A5A5FF00FFFF00FFFF00FFA9A9A9
              FBFBFBF2F2F2F3F3F3F3F3F3F3F3F3F3F3F3F3F3F3F2F2F2F0F0F0EEEEEEFBFB
              FBA7A7A7FF00FFFF00FFFF00FFABABABFCFCFCF4F4F4F6F6F6F6F6F6F6F6F6F6
              F6F6F4F4F4F3F3F3F2F2F2F0F0F0FBFBFBABABABFF00FFFF00FFFF00FFACACAC
              FCFCFCF6F6F6F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F6F6F6F3F3F3F2F2F2FBFB
              FBACACACFF00FFFF00FFFF00FFADADADFCFCFCF7F7F7F8F8F8F8F8F8FAFAFAF8
              F8F8F8F8F8F7F7F7F6F6F6F3F3F3FCFCFCADADADFF00FFFF00FFFF00FFAFAFAF
              FEFEFEF8F8F8FAFAFAFAFAFAFAFAFAFAFAFAF8F8F8F7F7F7AFAFAFBCBCBCD0D0
              D0ADADADFF00FFFF00FFFF00FFAFAFAFFEFEFEFAFAFAFAFAFAFBFBFBFBFBFBFB
              FBFBFAFAFAF8F8F8BCBCBCD9D9D9AFAFAFFF00FFFF00FFFF00FFFF00FFAFAFAF
              FFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEF8F8F8D0D0D0AFAFAFFF00
              FFFF00FFFF00FFFF00FFFF00FFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAFAF
              AFAFAFAFAFAFAFAFAFAFAFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 4
          end
          object BitBtn2: TBitBtn
            Left = 828
            Top = 28
            Width = 88
            Height = 23
            Caption = 'Re&mover'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              2D2BAA252595FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0101
              60000073FF00FFFF00FFFF00FF3836B61111B81C1CB82F2FA4FF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF06066D01018A00008B020074FF00FF3F3FBB1616C5
              0A0AC20A0AC02222C43737ADFF00FFFF00FFFF00FFFF00FF11117B0505910000
              9000009000008B0200743B3BB22C2CD30D0DD00D0DCE0C0CC92828CC3D3DB4FF
              00FFFF00FF1F1F8E0C0C9F00009200009000009000008800005DFF00FF4747C1
              3333DE1111DA0F0FD50D0DCF2A2AD13C3CB42F2FA41717B40303A30101990000
              91010189010160FF00FFFF00FFFF00FF5454CC3C3CE71313E11111DA0E0ED328
              28CF2222C60707B50505AA0303A0060693050566FF00FFFF00FFFF00FFFF00FF
              FF00FF5C5CD33F3FEA1414E31111DC0E0ED10C0CC70909BC0606B10D0DA40E0E
              77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5B5BD03D3DE61414E311
              11DA0D0DCF0A0AC21616B5181886FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF6E6ECE5B5BE92020E71313E10F0FD40C0CC91616B7181887FF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7878CE7474E75353EE4848ED35
              35E92020DD1111CE0A0ABF0F0FAB0E0E79FF00FFFF00FFFF00FFFF00FFFF00FF
              7F7FCB8787E56D6DF26363F05757EF5C5CDE5252D83B3BDA2D2DCE1F1FC01818
              A5111176FF00FFFF00FFFF00FF8484C79797E38484F47B7BF37070F27272E05B
              5BBB4D4DB15151CF4141D43838C92F2FBD2929A51B1B78FF00FF8686C2A0A0E0
              9999F69191F68888F48383DE6767BCFF00FFFF00FF4747A55050C54242CB3737
              C02E2EB52929A01D1D7A9393B7A5A5EAA1A1F79A9AF69292DD6E6EBDFF00FFFF
              00FFFF00FFFF00FF3F3F9C4A4ABC3B3BC03232B52D2DA92B2B8EFF00FF9594B6
              A7A7E99D9DDC7676BBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3C3C984141
              B53535B0343495FF00FFFF00FFFF00FF9796B68080C0FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FF3636933E3E9AFF00FFFF00FF}
            TabOrder = 5
            TabStop = False
          end
        end
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 572
    Width = 946
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 564
    ExplicitWidth = 944
    inherited btnFechar: TBitBtn
      Left = 838
      ExplicitLeft = 836
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT vendas.vendaid,'
      #9#9'  vendas.clienteid,'
      #9#9'  clientes.nome,'
      #9#9'  vendas.datavenda,'
      #9#9'  vendas.totalvenda'
      'FROM vendas'
      'INNER JOIN clientes ON clientes.clienteid = vendas.clienteid')
    Top = 0
    object QryListagemvendaid: TZIntegerField
      DisplayLabel = 'N'#250'mero Venda'
      FieldName = 'vendaid'
    end
    object QryListagemclienteid: TZIntegerField
      DisplayLabel = 'Cod. Cliente'
      FieldName = 'clienteid'
      Required = True
    end
    object QryListagemnome: TZUnicodeStringField
      DisplayLabel = 'Cliente'
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryListagemdatavenda: TZDateTimeField
      DisplayLabel = 'Data da Venda'
      FieldName = 'datavenda'
    end
    object QryListagemtotalvenda: TZFMTBCDField
      DisplayLabel = 'Total da Venda'
      FieldName = 'totalvenda'
      Precision = 18
      Size = 5
    end
  end
  inherited dtsListagem: TDataSource
    Top = 0
  end
end
