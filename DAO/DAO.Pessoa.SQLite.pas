unit DAO.Pessoa.SQLite;

interface

uses
  System.SysUtils,
  Data.DB,
  Uni,
  Model.Pessoa;

type
  TDAOPessoaSQLite = class(TInterfacedObject, IModelPessoa)
  const
    QUERY_BASE =
      'select pessoas.id, pessoas.nome, enderecos.endereco, telefones.telefone ' +
      '  from pessoas ' +
      '  left join enderecos on enderecos.id_pessoa = pessoas.id ' +
      '  left join telefones on telefones.id_pessoa = pessoas.id ';
  private
    FConexao: TUniConnection;
    procedure SetConexao;
  public
    constructor Create;
    destructor Destroy; override;
    function GetData: TDataSet;
  end;

implementation

{ TDAOPessoaSQLite }

constructor TDAOPessoaSQLite.Create;
begin
  inherited Create;
  SetConexao;
end;

function TDAOPessoaSQLite.GetData: TDataSet;
var
  LQuery: TUniQuery;
begin
  LQuery := TUniQuery.Create(nil);
  LQuery.Connection := FConexao;
  LQuery.SQL.Text := QUERY_BASE;
  LQuery.Open;

  Result := LQuery;
end;

destructor TDAOPessoaSQLite.Destroy;
begin
  FConexao.Free;
  inherited;
end;

procedure TDAOPessoaSQLite.SetConexao;
begin
  FConexao := TUniConnection.Create(nil);
  FConexao.ProviderName := 'SQLite';
  FConexao.Database := ExtractFilePath(ParamStr(0)) + 'dados.sqlite';;
end;

end.
