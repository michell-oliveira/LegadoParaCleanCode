unit Model.Entity.Endereco;

interface

uses
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Criteria.Dictionary,
  Aurelius.Validation.Attributes;

const
  TABLE_NAME = 'enderecos';
  FIELD_ID = 'id';
  FIELD_ID_PESSOA = 'id_pessoa';
  FIELD_ENDERECO = 'endereco';

type
  [Entity]
  [Table(TABLE_NAME)]
  [Id('FId', TIdGenerator.None)]

  TEndereco = class
  private
    [Column(FIELD_ID, []), DisplayName('Id')]
    FId: Integer;

    [Column(FIELD_ID_PESSOA, []), DisplayName('Id Pessoa')]
    FIdPessoa: Integer;

    [Column(FIELD_ENDERECO, []), DisplayName('Endereço')]
    FEndereco: string;

  public
    property Id: Integer read FId write FId;
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    property Endereco: string read FEndereco write FEndereco;
  end;

implementation

initialization
  RegisterEntity(TEndereco);

end.
