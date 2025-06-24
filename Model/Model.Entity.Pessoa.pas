unit Model.Entity.Pessoa;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Criteria.Dictionary,
  Aurelius.Validation.Attributes,
  Model.Entity.Endereco,
  Model.Entity.Telefone;

const
  TABLE_NAME = 'pessoas';
  FIELD_ID = 'id';
  FIELD_NOME = 'nome';

type
  [Entity]
  [Table(TABLE_NAME)]
  [Id('FId', TIdGenerator.None)]

  TPessoa = class
  private
    [Column(FIELD_ID, []), DisplayName('Id')]
    FId: Integer;

    [Column(FIELD_NOME, []), DisplayName('Nome')]
    FNome: string;

    [Association]
    [OneToOne(false)]
    [JoinColumn(FIELD_ID, [], Model.Entity.Endereco.FIELD_ID_PESSOA)]
    FEndereco: TEndereco;

    [Association]
    [OneToOne(false)]
    [JoinColumn(FIELD_ID, [], Model.Entity.Telefone.FIELD_ID_PESSOA)]
    FTelefone: TTelefone;

    function GetEndereco: string;
    function GetTelefone: string;
    procedure SetEndereco(const Value: string);
    procedure SetTelefone(const Value: string);

  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Endereco: string read GetEndereco write SetEndereco;
    property Telefone: string read GetTelefone write SetTelefone;
  end;

implementation

{ TPessoa }

function TPessoa.GetEndereco: string;
begin
  if not Assigned(FEndereco) then
    FEndereco := TEndereco.Create;

  Result := FEndereco.Endereco;
end;

function TPessoa.GetTelefone: string;
begin
  if not Assigned(FTelefone) then
    FTelefone := TTelefone.Create;

  Result := FTelefone.Telefone;
end;

procedure TPessoa.SetEndereco(const Value: string);
begin
  if not Assigned(FEndereco) then
    FEndereco := TEndereco.Create;

  FEndereco.Endereco := Value;
end;

procedure TPessoa.SetTelefone(const Value: string);
begin
  if not Assigned(FTelefone) then
    FTelefone := TTelefone.Create;

  FTelefone.Telefone := Value;
end;

initialization
  RegisterEntity(TPessoa);

end.
