unit uPessoaCSV;

interface
uses
  System.Classes,
  System.SysUtils,
  Data.DB,
  Datasnap.DBClient;

Const
  NOME_ARQUIVO_CSV = 'dados.csv';

  type TPessoaCSV = class
    FDiretorioDataBase: string;
    private
      function CarregarArquivo: TStringList;
    public
      constructor Create(ADiretorioDataBase: string);
      procedure Exibir(AClientDataSet: TClientDataSet);
  end;

implementation

{ TPessoaCSV }

constructor TPessoaCSV.Create(ADiretorioDataBase: string);
begin
  FDiretorioDataBase := ADiretorioDataBase + NOME_ARQUIVO_CSV;
end;

procedure TPessoaCSV.Exibir(AClientDataSet: TClientDataSet);
var
  LArquivoCSV: TStringList;
  LLinha: string;
  LCampo: TArray<string>;
  I: Integer;
begin
  LArquivoCSV := CarregarArquivo;
  try
    for I := 0 to LArquivoCSV.Count - 1 do
    begin
      LLinha := LArquivoCSV[I];
      LCampo := LLinha.Split([';']);
      if Length(LCampo) = 4 then
      begin
        AClientDataSet.Append;
        AClientDataSet.FieldByName('id').AsInteger := StrToIntDef(LCampo[0], 0);
        AClientDataSet.FieldByName('nome').AsString := LCampo[1];
        AClientDataSet.FieldByName('endereco').AsString := LCampo[2];
        AClientDataSet.FieldByName('telefone').AsString := LCampo[3];
        AClientDataSet.Post;
      end;
    end;
    AClientDataSet.IndexFieldNames := 'id';
  finally
    LArquivoCSV.Free;
  end;
end;

function TPessoaCSV.CarregarArquivo: TStringList;
begin
  if not FileExists(FDiretorioDataBase) then
    raise Exception.Create('Arquivo CSV não encontrado.');

  Result := TStringList.Create;
  Result.LoadFromFile(FDiretorioDataBase);
end;
end.
