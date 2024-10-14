unit uFrmAtualizaDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmAtualizaDB = class(TForm)
    pnlOut: TPanel;
    pnlInner: TPanel;
    imgSql: TImage;
    lbTitle: TLabel;
    chkConexao: TCheckBox;
    chkCategorias: TCheckBox;
    chkProdutos: TCheckBox;
    chkClientes: TCheckBox;
    chkVendas: TCheckBox;
    chkItensVendas: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAtualizaDB: TfrmAtualizaDB;

implementation

{$R *.dfm}

end.
