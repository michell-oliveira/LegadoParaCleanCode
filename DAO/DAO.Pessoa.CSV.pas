unit DAO.Pessoa.CSV;

interface

uses
  Data.DB,
  Datasnap.DBClient,
  Model.Pessoa;

type
  TDAOPessoaCSV = class(TInterfacedObject, IModelPessoa)
  private
    FArquivo: string;
    FClientDataSet: TClientDataSet;
    procedure LoadCSV;
    procedure CriarEstruturaClientDataSet;
  public
    constructor Create;
    destructor Destroy; override;
    function GetData: TDataSet;
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

{ TDAOPessoaCSV }

constructor TDAOPessoaCSV.Create;
begin
  FArquivo := ExtractFilePath(ParamStr(0)) + 'dados.csv';

  if not FileExists(FArquivo) then
    raise Exception.Create('Arquivo dados.csv não encontrado.');

end;

procedure TDAOPessoaCSV.CriarEstruturaClientDataSet;
begin
  FClientDataSet := TClientDataSet.Create(nil);
  FClientDataSet.FieldDefs.Add('ID', ftInteger);
  FClientDataSet.FieldDefs.Add('Nome', ftString, 100);
  FClientDataSet.FieldDefs.Add('Endereco', ftString, 150);
  FClientDataSet.FieldDefs.Add('Telefone', ftString, 20);
  FClientDataSet.CreateDataSet;
end;

destructor TDAOPessoaCSV.Destroy;
begin
  FClientDataSet.Free;
  inherited;
end;

function TDAOPessoaCSV.GetData: TDataSet;
begin
  CriarEstruturaClientDataSet;
  LoadCSV;
  Result := FClientDataSet;
end;

procedure TDAOPessoaCSV.LoadCSV;
var
  LArquivoCSV: TStringList;
  LLinha: string;
  LFields: TArray<string>;
  LIndice: Integer;
begin
  LArquivoCSV := TStringList.Create;
  try
    LArquivoCSV.LoadFromFile(FArquivo);
    if LArquivoCSV.Count = 0 then
      Exit;

    for LIndice := 0 to LArquivoCSV.Count - 1 do
    begin
      LLinha := LArquivoCSV[LIndice];
      LFields := LLinha.Split([';']);

      if Length(LFields) = FClientDataSet.Fields.Count then
      begin
        FClientDataSet.Append;
        FClientDataSet.Fields[0].AsInteger := StrToIntDef(LFields[0], 0);
        FClientDataSet.Fields[1].AsString  := LFields[1];
        FClientDataSet.Fields[2].AsString  := LFields[2];
        FClientDataSet.Fields[3].AsString  := LFields[3];
        FClientDataSet.Post;
      end;
    end;
  finally
    LArquivoCSV.Free;
  end;
end;
end.
