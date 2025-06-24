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
  arq: string;
  sl: TStringList;
  linha: string;
  arr: TArray<string>;
  i: Integer;
begin

  LPessoaPresenter := TPessoaPresenter.Create(Self);
  try
    LPessoaPresenter.CarregarListagem;
  finally
    FreeAndNil(LPessoaPresenter);
  end;

//  if RadioButtonCSV.Checked then
//  begin
//    UniConnection1.ProviderName := 'SQLite';
//    UniConnection1.Database := ExtractFilePath(ParamStr(0)) + 'dados.csv';
//
//
//
//    arq := ExtractFilePath(Application.ExeName) + 'dados.csv';
//
//    if not FileExists(arq) then
//    begin
//      ShowMessage('Arquivo CSV não encontrado.');
//      Exit;
//    end;
//
//    ClientDataSet1.EmptyDataSet;
    sl := TStringList.Create;
//    try
//      sl.LoadFromFile(arq);
//      for i := 0 to sl.Count - 1 do
//      begin
//        linha := sl[i];
        arr := linha.Split([';']);
//        if Length(arr) = 4 then
//        begin
//          ClientDataSet1.Append;
//          ClientDataSet1.FieldByName('id').AsInteger := StrToIntDef(arr[0], 0);
//          ClientDataSet1.FieldByName('nome').AsString := arr[1];
//          ClientDataSet1.FieldByName('endereco').AsString := arr[2];
//          ClientDataSet1.FieldByName('telefone').AsString := arr[3];
//          ClientDataSet1.Post;
//        end;
//      end;
//    finally
//      sl.Free;
//    end;
//
//    DataSource1.DataSet := ClientDataSet1;
//  end
//  else if RadioButtonSQLite.Checked then
//  begin
//    UniConnection1.ProviderName := 'SQLite';
//    UniConnection1.Database := ExtractFilePath(ParamStr(0)) + 'dados.sqlite';
//    UniQuery1.Close;
//    UniQuery1.SQL.Text := 'SELECT p.id, p.nome, e.endereco, t.telefone ' +
//                          'FROM pessoas p ' +
//                          'LEFT JOIN enderecos e ON e.id_pessoa = p.id ' +
//                          'LEFT JOIN telefones t ON t.id_pessoa = p.id';
//    UniQuery1.Open;
//    DataSource1.Dataset := UniQuery1;
//  end;
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
