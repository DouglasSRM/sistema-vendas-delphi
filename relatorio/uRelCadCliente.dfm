object frmRelClientes: TfrmRelClientes
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'frmRelCadCliente'
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
    Left = 0
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
      Height = 52
      BandType = btHeader
      object RLDraw1: TRLDraw
        Left = 0
        Top = 34
        Width = 718
        Height = 18
        Align = faBottom
        DrawKind = dkLine
        Pen.Width = 2
      end
      object RLLabel1: TRLLabel
        Left = 3
        Top = 3
        Width = 217
        Height = 24
        Caption = 'Listagem de Clientes'
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
      Top = 140
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
    object RLBand2: TRLBand
      Left = 38
      Top = 90
      Width = 718
      Height = 24
      BandType = btColumnHeader
      object RLPanel1: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 24
        Align = faClient
        Color = clInfoBk
        ParentColor = False
        Transparent = False
        object RLLabel7: TRLLabel
          Left = 655
          Top = 2
          Width = 60
          Height = 16
          Alignment = taRightJustify
          Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel6: TRLLabel
          Left = 387
          Top = 2
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
        object RLLabel3: TRLLabel
          Left = 86
          Top = 2
          Width = 41
          Height = 16
          Caption = 'Nome'
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
          Top = 2
          Width = 49
          Height = 16
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 114
      Width = 718
      Height = 26
      object RLDBText1: TRLDBText
        Left = 3
        Top = 6
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
        Left = 86
        Top = 6
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
        Left = 387
        Top = 6
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
        Left = 666
        Top = 6
        Width = 49
        Height = 16
        Alignment = taRightJustify
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
      'SELECT clientes.clienteid,'
      '        clientes.nome,'
      '        clientes.email,'
      '        clientes.telefone'
      'FROM clientes')
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
  end
  object dtsClientes: TDataSource
    DataSet = QryClientes
    Left = 648
    Top = 296
  end
end
