unit uPessoaSQLite;

interface
  uses
    System.SysUtils,
    UniProvider,
    SQLiteUniProvider,
    Data.DBXSQLite,
    Data.DB,
    Datasnap.DBClient,
    Uni,
    MemDS,
    DBAccess;

Const
  NOME_ARQUIVO_SQLITE = 'dados.sqlite';
  NOME_PROVEDOR_DADOS = 'SQLite';

   type
    TPessoaSQLite = class
      FConexao: TUniConnection;
      private
        FDiretorioDataBase: string;
        procedure ConectarDataBase;
        procedure ConsultarPessoa(AClientDataSet: TClientDataSet);
      public
        constructor Create(ADiretorioDataBase: string);
        destructor Destroy;

        procedure Exibir(AClientDataSet: TClientDataSet);
    end;

implementation

{ TPessoaSQLite }

procedure TPessoaSQLite.ConectarDataBase;
begin
  try
    FConexao.ProviderName := NOME_PROVEDOR_DADOS;
    FConexao.Database := FDiretorioDataBase + NOME_ARQUIVO_SQLITE;
    FConexao.Connect;
  Except
    raise Exception.Create('Não foi possível conectar ao banco de dados');
  end;
end;

procedure TPessoaSQLite.ConsultarPessoa(AClientDataSet: TClientDataSet);
var
  LQuery: TUniQuery;
begin
  LQuery := TUniQuery.Create(nil);
  try
    LQuery.Connection := FConexao;

    LQuery.Close;
    LQuery.SQL.Text := 'SELECT p.id, p.nome, e.endereco, t.telefone ' +
                          'FROM pessoas p ' +
                          'LEFT JOIN enderecos e ON e.id_pessoa = p.id ' +
                          'LEFT JOIN telefones t ON t.id_pessoa = p.id';
    LQuery.Open;

    while not LQuery.eof do
    begin
      AClientDataSet.Insert;
      AClientDataSet.FieldByName('id').AsInteger :=  LQuery.FieldByName('id').AsInteger;
      AClientDataSet.FieldByName('nome').AsString :=  LQuery.FieldByName('nome').AsString;
      AClientDataSet.FieldByName('endereco').AsString :=  LQuery.FieldByName('endereco').AsString;
      AClientDataSet.FieldByName('telefone').AsString :=  LQuery.FieldByName('telefone').AsString;
      AClientDataSet.Post;
      LQuery.Next;
    end;
    AClientDataSet.IndexFieldNames := 'id';
  finally
    LQuery.Free;
  end;
end;

constructor TPessoaSQLite.Create(ADiretorioDataBase: string);
begin
  FDiretorioDataBase := ADiretorioDataBase;
  FConexao := TUniConnection.Create(nil);
end;

destructor TPessoaSQLite.Destroy;
begin
  inherited;
  FConexao.Free;
end;

procedure TPessoaSQLite.Exibir(AClientDataSet: TClientDataSet);
begin
  try
    ConectarDataBase;
    ConsultarPessoa(AClientDataSet);
  except on e:Exception do
    raise Exception.Create(e.Message);
  end;
end;
end.
