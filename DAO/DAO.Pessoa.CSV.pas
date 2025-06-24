unit DAO.Pessoa.CSV;

interface

uses
  Uni,
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  DAO.Pessoa.Interfaces,
  Model.Entity.Pessoa;

const
  INDEX_FIELD_ID = 0;
  INDEX_FIELD_NOME = 1;
  INDEX_FIELD_ENDERECO = 2;
  INDEX_FIELD_TELEFONE = 3;

type

  TPessoaDAOCSV = class(TInterfacedObject, IPessoaDAO)
  private
  public
    function LoadList: TObjectList<TPessoa>;
  end;


implementation

{ TPessoaDAOCSV }

function TPessoaDAOCSV.LoadList: TObjectList<TPessoa>;
const
  SEPARATOR = ';';
var
  LCaminhoArquivoCSV: string;
  LConteudoArquivo: TStringList;
  LIndex: Integer;
  LLinha: TArray<string>;
  LPessoa: TPessoa;
begin
  LCaminhoArquivoCSV := ExtractFilePath(ParamStr(0)) + 'dados.csv';

  if not FileExists(LCaminhoArquivoCSV) then
    raise Exception.Create('Arquivo CSV não encontrado.');

  LConteudoArquivo := TStringList.Create;
  try
    Result := TObjectList<TPessoa>.Create;

    LConteudoArquivo.LoadFromFile(LCaminhoArquivoCSV);

    for LIndex := 0 to LConteudoArquivo.Count - 1 do
    begin
      LLinha := LConteudoArquivo[LIndex].Split([SEPARATOR]);
      if Length(LLinha) = 4 then
      begin
        LPessoa := TPessoa.Create;
        LPessoa.Id := StrToIntDef(LLinha[INDEX_FIELD_ID], 0);
        LPessoa.Nome := LLinha[INDEX_FIELD_NOME];
        LPessoa.Endereco := LLinha[INDEX_FIELD_ENDERECO];
        LPessoa.Telefone := LLinha[INDEX_FIELD_TELEFONE];

        Result.Add(LPessoa);
      end;
    end;
  finally
    LConteudoArquivo.Free;
  end;
end;

end.
