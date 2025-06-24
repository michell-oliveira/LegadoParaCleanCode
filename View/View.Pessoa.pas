unit View.Pessoa;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Data.DB,
  Vcl.ExtCtrls,
  UniProvider,
  SQLiteUniProvider,
  Data.DBXSQLite,
  Vcl.Dialogs,
  Uni,
  MemDS,
  DBAccess,
  System.Classes,
  System.SysUtils,
  Datasnap.DBClient,
  System.Generics.Collections,
  View.Pessoa.Interfaces,
  Presenter.Pessoa,
  Model.Entity.Pessoa, 
  Aurelius.Bind.BaseDataset, 
  Aurelius.Bind.Dataset,
  Model.Conexao.Types;

type
  TPessoaView = class(TForm, IPessoaViewInterface)
    dbgrdPessoa: TDBGrid;
    Panel1: TPanel;
    RadioButtonCSV: TRadioButton;
    RadioButtonSQLite: TRadioButton;
    btnCarregar: TButton;
    conConexao: TUniConnection;
    unqryPessoa: TUniQuery;
    dsPessoa: TDataSource;
    cdsPessoa: TClientDataSet;
    btnLimpar: TButton;
    adsPessoa: TAureliusDataset;
    procedure btnCarregarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    function GetTipoConexao: TTipoConexao;
  public
    property TipoConexao: TTipoConexao read GetTipoConexao;
    procedure ExibirListagem(APessoaList: TObjectList<TPessoa>);
    procedure ExibirMensagem(AMensagem: string);
  end;

var
  PessoaView: TPessoaView;

implementation

{$R *.dfm}

procedure TPessoaView.btnCarregarClick(Sender: TObject);
var
  LPessoaPresenter: TPessoaPresenter;
begin
  LPessoaPresenter := TPessoaPresenter.Create(Self);
  try
    LPessoaPresenter.CarregarListagem;
  finally
    FreeAndNil(LPessoaPresenter);
  end;
end;

procedure TPessoaView.btnLimparClick(Sender: TObject);
begin
  adsPessoa.Close;
  adsPessoa.Open;
end;

procedure TPessoaView.ExibirListagem(APessoaList: TObjectList<TPessoa>);
var
  LPessoa: TPessoa;
begin
  adsPessoa.Close;
  adsPessoa.SetSourceList(APessoaList, True);
  adsPessoa.Open;
end;

procedure TPessoaView.ExibirMensagem(AMensagem: string);
begin
  ShowMessage(AMensagem);
end;

function TPessoaView.GetTipoConexao: TTipoConexao;
begin
  if RadioButtonCSV.Checked then
    Result := tcCSV
  else
  if RadioButtonSQLite.Checked then
    Result := tcSQLite
  else
    Result := tcNaoInformado;
end;

end.
