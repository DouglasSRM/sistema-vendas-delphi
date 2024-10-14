object dtmPrincipal: TdtmPrincipal
  Height = 330
  Width = 663
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
    Left = 264
    Top = 120
  end
end
