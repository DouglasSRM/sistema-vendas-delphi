object dtmPrincipal: TdtmPrincipal
  Height = 237
  Width = 583
  PixelsPerInch = 120
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    SQLHourGlass = True
    DisableSavepoints = False
    HostName = 'localhost'
    Port = 5433
    Database = 'vendas'
    User = 'postgres'
    Password = 'admin'
    Protocol = 'postgresql'
    LibraryLocation = 'C:\libpq.dll'
    Left = 48
    Top = 48
  end
  object QryScriptCategorias: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'DO $$'
      'BEGIN'
      
        '  IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = '#39'categor' +
        'ias'#39' AND relkind = '#39'r'#39') THEN'
      ''
      #9'CREATE TABLE public.categorias ('
      '    '#9' categoriaid serial NOT NULL,'
      '    '#9' descricao character varying(30) NOT NULL,'
      '    '#9' CONSTRAINT categorias_pkey PRIMARY KEY (categoriaid));'
      ''
      #9'ALTER TABLE IF EXISTS public.categorias'
      '    '#9'OWNER to postgres;'
      ''
      '  END IF;'
      'END $$;')
    Params = <>
    Left = 200
    Top = 48
  end
  object QryScriptClientes: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'DO $$'
      'BEGIN'
      
        '  IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = '#39'cliente' +
        's'#39' AND relkind = '#39'r'#39') THEN'
      ''
      #9'  CREATE TABLE public.clientes ('
      '    '#9#9'clienteid serial NOT NULL,'
      '    '#9#9'nome character varying(60) NOT NULL,'
      '    '#9#9'endereco character varying(60),'
      '        cidade character varying(50),'
      '        bairro character varying(40),'
      '        estado character varying(2),'
      '        cep character varying(10),'
      '        telefone character varying(15),'
      '        email character varying(100),'
      '        datanascimento timestamp without time zone,'
      '        CONSTRAINT clientes_pkey PRIMARY KEY (clienteid));'
      ''
      #9'  ALTER TABLE IF EXISTS public.clientes'
      '    '#9'OWNER to postgres;'
      ''
      '  END IF;'
      'END $$;')
    Params = <>
    Left = 336
    Top = 48
  end
  object QryScriptProdutos: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'DO $$'
      'BEGIN'
      
        '  IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = '#39'produto' +
        's'#39' AND relkind = '#39'r'#39') THEN'
      ''
      #9'  CREATE TABLE public.produtos ('
      '    '#9#9'produtoid serial NOT NULL,'
      '    '#9#9'nome character varying(60) NOT NULL,'
      '    '#9#9'descricao character varying(255),'
      '   '#9#9'  valor numeric(18, 5) DEFAULT 0.00000,'
      '    '#9#9'quantidade numeric(18, 5) DEFAULT 0.00000,'
      '    '#9#9'categoriaid integer,'
      '    '#9#9'PRIMARY KEY (produtoid),'
      
        '    '#9#9'CONSTRAINT "FK_ProdutosCategorias" FOREIGN KEY (categoriai' +
        'd)'
      
        '        '#9#9'REFERENCES public.categorias (categoriaid) MATCH SIMPL' +
        'E'
      '        '#9#9'ON UPDATE NO ACTION'
      '        '#9#9'ON DELETE NO ACTION);'
      ''
      #9'  ALTER TABLE IF EXISTS public.produtos'
      '    '#9'OWNER to postgres;'
      ''
      '  END IF;'
      'END $$;')
    Params = <>
    Left = 472
    Top = 48
  end
  object QryScriptVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'DO $$'
      'BEGIN'
      
        '  IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = '#39'vendas'#39 +
        ' AND relkind = '#39'r'#39') THEN'
      ''
      #9'  CREATE TABLE public.vendas ('
      '      vendaid serial NOT NULL,'
      '      clienteid integer NOT NULL,'
      
        '      datavenda timestamp without time zone DEFAULT CURRENT_TIME' +
        'STAMP,'
      #9'    totalvenda numeric(18, 5) DEFAULT 0.00000,'
      '      PRIMARY KEY (vendaid),'
      '      CONSTRAINT "FK_VendasClientes" FOREIGN KEY (clienteid)'
      '          REFERENCES public.clientes (clienteid) MATCH SIMPLE'
      '          ON UPDATE NO ACTION'
      '          ON DELETE NO ACTION);'
      ''
      #9'  ALTER TABLE IF EXISTS public.vendas'
      '    '#9'OWNER to postgres;'
      ''
      '  END IF;'
      'END $$;')
    Params = <>
    Left = 256
    Top = 144
  end
  object QryScriptItensVendas: TZQuery
    Connection = ConexaoDB
    SQL.Strings = (
      'DO $$'
      'BEGIN'
      
        '  IF NOT EXISTS (SELECT 1 FROM pg_class WHERE relname = '#39'vendasi' +
        'tens'#39' AND relkind = '#39'r'#39') THEN'
      ''
      #9'  CREATE TABLE public.vendasitens ('
      '    '#9#9'vendaid integer NOT NULL,'
      '    '#9#9'produtoid integer NOT NULL,'
      '    '#9#9'valorunitario numeric(18, 5) DEFAULT 0.00000,'
      '    '#9#9'quantidade numeric(18, 5) DEFAULT 0.00000,'
      '    '#9#9'totalproduto numeric(18, 5) DEFAULT 0.00000,'
      '    '#9#9'PRIMARY KEY (vendaid, produtoid),'
      
        '    '#9#9'CONSTRAINT "FK_VendasItensProdutos" FOREIGN KEY (produtoid' +
        ')'
      '        '#9#9'REFERENCES public.produtos (produtoid) MATCH SIMPLE'
      '        '#9#9'ON UPDATE NO ACTION'
      '        '#9#9'ON DELETE NO ACTION);'
      ''
      #9'  ALTER TABLE IF EXISTS public.vendasitens'
      '    '#9'OWNER TO postgres;'
      ''
      '  END IF;'
      'END $$;')
    Params = <>
    Left = 416
    Top = 144
  end
end
