unit Model.Entity.Telefone;

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
  TABLE_NAME = 'telefones';
  FIELD_ID = 'id';
  FIELD_ID_PESSOA = 'id_pessoa';
  FIELD_TELEFONE = 'telefone';

type
  [Entity]
  [Table(TABLE_NAME)]
  [Id('FId', TIdGenerator.None)]

  TTelefone = class
  private

    [Column(FIELD_ID, []), DisplayName('Id')]
    FId: Integer;

    [Column(FIELD_ID_PESSOA, []), DisplayName('Id Pessoa')]
    FIdPessoa: Integer;

    [Column(FIELD_TELEFONE, []), DisplayName('Telefone')]
    FTelefone: string;

  public
    property Id: Integer read FId write FId;
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    property Telefone: string read FTelefone write FTelefone;
  end;

implementation

initialization
  RegisterEntity(TTelefone);
end.
