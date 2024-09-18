object dtmPrincipal: TdtmPrincipal
  Height = 330
  Width = 663
  PixelsPerInch = 120
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    Connected = True
    SQLHourGlass = True
    DisableSavepoints = False
    HostName = ''
    Port = 0
    Database = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Initi' +
      'al Catalog=vendas;Data Source=DOUGLASNT\SERVERCURSO'
    User = 'sa'
    Password = 'mudar@123'
    Protocol = 'ado'
    Left = 264
    Top = 120
  end
end
