unit DAO.Pessoa.Factory;

interface

uses
  Model.Conexao.Types,
  DAO.Pessoa.Interfaces;

type

  TPessoaDAOFactory = class
    class function CreateDAO(ATipoConexao: TTipoConexao): IPessoaDAO;
  end;

implementation

uses
  DAO.Pessoa.CSV,
  DAO.Pessoa.SQLite;

{ TPessoaDAOFactory }

class function TPessoaDAOFactory.CreateDAO(ATipoConexao: TTipoConexao): IPessoaDAO;
begin
  case ATipoConexao of
    tcCSV: Result := TPessoaDAOCSV.Create;
    tcSQLite: Result := TPessoaDAOSQLite.Create;
  end;
end;

end.
