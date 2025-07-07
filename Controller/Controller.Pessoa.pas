unit Controller.Pessoa;

interface

uses
  Data.DB,
  DAO.Pessoa.SQLite,
  DAO.Pessoa.CSV,
  Conexao.Tipo;

type
  TControllerPessoa = class
  private
    FDAOPessoaSQLite: TDAOPessoaSQLite;
    FDAOPessoaCSV: TDAOPessoaCSV;
  public
    constructor Create;
    destructor Destroy; override;
    function ListarPessoa(const AValue: TTipoConexao): TDataSet;
  end;

implementation

{ TControllerPessoa }

constructor TControllerPessoa.Create;
begin
  FDAOPessoaSQLite := TDAOPessoaSQLite.Create;
  FDAOPessoaCSV := TDAOPessoaCSV.Create;
  inherited Create;
end;

destructor TControllerPessoa.Destroy;
begin
  FDAOPessoaSQLite.Free;
  FDAOPessoaCSV.Free;
  inherited;
end;

function TControllerPessoa.ListarPessoa(const AValue: TTipoConexao): TDataSet;
begin
  Result := nil;

  case AValue of
    TTipoConexao.SQLite:
      Result := FDAOPessoaSQLite.GetData;
    TTipoConexao.CSV:
      Result := FDAOPessoaCSV.GetData;
  end;
end;

end.
