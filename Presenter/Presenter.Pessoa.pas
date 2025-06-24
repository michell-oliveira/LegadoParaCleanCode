unit Presenter.Pessoa;

interface

uses
  System.Generics.Collections,
  View.Pessoa.Interfaces,
  Model.Entity.Pessoa,
  DAO.Pessoa.Interfaces;

type
  TPessoaPresenter = class
    FPessoaView: IPessoaViewInterface;
    FPessoaDAO: IPessoaDAO;
  private
  public
    constructor Create(APessoaView: IPessoaViewInterface);
    procedure CarregarListagem;
  end;

implementation

uses
  Model.Conexao.Types,
  DAO.Pessoa.Factory;

{ TPessoaPresenter }

procedure TPessoaPresenter.CarregarListagem;
var
  LPessoaList: TObjectList<TPessoa>;
begin
  if FPessoaView.TipoConexao = tcNaoInformado then
  begin
    FPessoaView.ExibirMensagem('Tipo da conexão não foi informado!');
    Exit;
  end;

  LPessoaList := FPessoaDAO.LoadList;
  FPessoaView.ExibirListagem(LPessoaList);
end;

constructor TPessoaPresenter.Create(APessoaView: IPessoaViewInterface);
begin
  FPessoaView := APessoaView;
  FPessoaDAO := TPessoaDAOFactory.CreateDAO(FPessoaView.TipoConexao);
end;

end.
