unit DAO.Pessoa.SQLite;

interface

uses
  System.SysUtils,
  Uni,
  System.Generics.Collections,
  DAO.Pessoa.Interfaces,
  Model.Entity.Pessoa;

type

  TPessoaDAOSQlite = class(TInterfacedObject, IPessoaDAO)
  private
    FConnection: TUniConnection;
  public
    constructor Create;
    destructor Destroy;
    function LoadList: TObjectList<TPessoa>;
  end;

implementation

uses
  Aurelius.Engine.ObjectManager,
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.UniDac,
  Aurelius.Sql.SQLite,
  Aurelius.Criteria.Base,
  Aurelius.Criteria.Linq,
  Aurelius.Criteria.Projections;

{ TPessoaDAOSQlite }

constructor TPessoaDAOSQlite.Create;
begin
  FConnection := TUniConnection.Create(nil);
  FConnection.ProviderName := 'SQLite';
  FConnection.Database := ExtractFilePath(ParamStr(0)) + 'dados.sqlite';
end;

destructor TPessoaDAOSQlite.Destroy;
begin
  FreeAndNil(FConnection);
end;

function TPessoaDAOSQlite.LoadList: TObjectList<TPessoa>;
var
  LConn: IDBConnection;
  LObjectManager: TObjectManager;
  LCriteria: TCriteria<TPessoa>;
begin
  FConnection.Connect;

  try
    LConn := TUniDacConnectionAdapter.Create(FConnection, False);
    LObjectManager := TObjectManager.Create(LConn);

    try
      LObjectManager.OwnsObjects := False;

      LCriteria := LObjectManager.Find<TPessoa>;
      Result := TObjectList<TPessoa>(LCriteria.List);
    finally
      FreeAndNil(LObjectManager);
    end;
  finally
    FConnection.Disconnect;
  end;
end;

end.
