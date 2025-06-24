unit DAO.Pessoa.Interfaces;

interface

uses
  System.Generics.Collections,
  Model.Entity.Pessoa;

type

  IPessoaDAO = interface
    ['{D31A1D8D-5F95-4823-BCC5-1A1664E7C4ED}']
    function LoadList: TObjectList<TPessoa>;
  end;

implementation

end.
