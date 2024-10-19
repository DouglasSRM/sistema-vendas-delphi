object frmRelCadClienteFicha: TfrmRelCadClienteFicha
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'frmRelCadClienteFicha'
  ClientHeight = 1061
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Relatorio: TRLReport
    Left = 8
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsClientes
    DefaultFilter = pdfFilter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = []
    object Cabecario: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 50
      BandType = btHeader
      object RLDraw1: TRLDraw
        Left = 0
        Top = 32
        Width = 718
        Height = 18
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLLabel1: TRLLabel
        Left = 3
        Top = 3
        Width = 179
        Height = 24
        Caption = 'Ficha de Clientes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 207
      Width = 718
      Height = 45
      BandType = btFooter
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 16
        Width = 60
        Height = 16
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Info = itFullDate
        ParentFont = False
        Text = ''
      end
      object RLLabel8: TRLLabel
        Left = 608
        Top = 16
        Width = 44
        Height = 16
        Caption = 'P'#225'gina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 679
        Top = 16
        Width = 8
        Height = 16
        Caption = '/'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 656
        Top = 16
        Width = 17
        Height = 16
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Info = itPageNumber
        ParentFont = False
        Text = ''
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 693
        Top = 16
        Width = 17
        Height = 16
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Info = itLastPageNumber
        ParentFont = False
        Text = ''
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 88
      Width = 718
      Height = 119
      object RLDBText1: TRLDBText
        Left = 58
        Top = 2
        Width = 52
        Height = 16
        DataField = 'clienteid'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 332
        Top = 2
        Width = 36
        Height = 16
        DataField = 'nome'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 327
        Top = 59
        Width = 35
        Height = 16
        DataField = 'email'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 139
        Top = 77
        Width = 96
        Height = 16
        DataField = 'datanascimento'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel4: TRLLabel
        Left = 3
        Top = 2
        Width = 53
        Height = 16
        Caption = 'C'#243'digo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 286
        Top = 2
        Width = 45
        Height = 16
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel10: TRLLabel
        Left = 286
        Top = 59
        Width = 40
        Height = 16
        Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel11: TRLLabel
        Left = 3
        Top = 77
        Width = 135
        Height = 16
        Caption = 'Data de Nascimento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 3
        Top = 21
        Width = 34
        Height = 16
        Caption = 'CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText5: TRLDBText
        Left = 38
        Top = 21
        Width = 25
        Height = 16
        DataField = 'cep'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel3: TRLLabel
        Left = 286
        Top = 21
        Width = 82
        Height = 16
        Caption = 'Logradouro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText6: TRLDBText
        Left = 369
        Top = 21
        Width = 57
        Height = 16
        DataField = 'endereco'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel6: TRLLabel
        Left = 3
        Top = 40
        Width = 47
        Height = 16
        Caption = 'Bairro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText7: TRLDBText
        Left = 51
        Top = 40
        Width = 36
        Height = 16
        DataField = 'bairro'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel7: TRLLabel
        Left = 286
        Top = 40
        Width = 53
        Height = 16
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText8: TRLDBText
        Left = 340
        Top = 40
        Width = 42
        Height = 16
        DataField = 'cidade'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel12: TRLLabel
        Left = 568
        Top = 40
        Width = 25
        Height = 16
        Caption = 'UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText9: TRLDBText
        Left = 594
        Top = 40
        Width = 43
        Height = 16
        DataField = 'estado'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLLabel13: TRLLabel
        Left = 3
        Top = 59
        Width = 64
        Height = 16
        Caption = 'Telefone:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDBText10: TRLDBText
        Left = 68
        Top = 59
        Width = 49
        Height = 16
        DataField = 'telefone'
        DataSource = dtsClientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDraw3: TRLDraw
        Left = 0
        Top = 101
        Width = 718
        Height = 18
        Align = faBottom
        DrawKind = dkLine
        Pen.Style = psDot
      end
      object RLAngleLabel1: TRLAngleLabel
        Left = 703
        Top = 5
        Width = 14
        Height = 92
        Angle = 90.000000000000000000
        Caption = 'FICHA DE CLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pdfFilter: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0.1.2 \251 Copyright '#169' 1999-20' +
      '21 Fortes Inform'#225'tica'
    FileName = 'C:\Users\dougl\OneDrive\'#193'rea de Trabalho\f.pdf'
    DisplayName = 'Documento PDF'
    Left = 520
    Top = 400
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 600
    Top = 400
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 688
    Top = 400
  end
  object QryClientes: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT clienteId,'
      '        nome,'
      '        endereco,'
      '        cidade,'
      '        bairro,'
      '        estado,'
      '        cep,'
      '        telefone,'
      '        email,'
      '        dataNascimento'
      '  FROM clientes'
      '  ORDER BY nome')
    Params = <>
    Left = 560
    Top = 296
    object QryClientesclienteid: TZIntegerField
      FieldName = 'clienteid'
    end
    object QryClientesnome: TZUnicodeStringField
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object QryClientesemail: TZUnicodeStringField
      FieldName = 'email'
      Size = 100
    end
    object QryClientestelefone: TZUnicodeStringField
      FieldName = 'telefone'
      Size = 15
    end
    object QryClientesendereco: TZUnicodeStringField
      FieldName = 'endereco'
      Size = 60
    end
    object QryClientescidade: TZUnicodeStringField
      FieldName = 'cidade'
      Size = 50
    end
    object QryClientesbairro: TZUnicodeStringField
      FieldName = 'bairro'
      Size = 40
    end
    object QryClientesestado: TZUnicodeStringField
      FieldName = 'estado'
      Size = 2
    end
    object QryClientescep: TZUnicodeStringField
      FieldName = 'cep'
      Size = 10
    end
    object QryClientesdatanascimento: TZDateTimeField
      FieldName = 'datanascimento'
    end
  end
  object dtsClientes: TDataSource
    DataSet = QryClientes
    Left = 648
    Top = 296
  end
end
