unit View.Pessoa.Interfaces;

interface

uses
  System.Generics.Collections,
  Model.Entity.Pessoa,
  Model.Conexao.Types;

type
  IPessoaViewInterface = interface
    ['{85500A2A-56EB-45BF-BC0B-109502703A88}']
    function GetTipoConexao: TTipoConexao;
    property TipoConexao: TTipoConexao read GetTipoConexao;

    procedure ExibirMensagem(AMensagem: string);
    procedure ExibirListagem(APessoaList: TObjectList<TPessoa>);
  end;

implementation

end.
