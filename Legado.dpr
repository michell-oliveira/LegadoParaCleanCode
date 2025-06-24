program Legado;

uses
  Vcl.Forms,
  View.Pessoa in 'View\View.Pessoa.pas' {PessoaView},
  Presenter.Pessoa in 'Presenter\Presenter.Pessoa.pas',
  View.Pessoa.Interfaces in 'View\View.Pessoa.Interfaces.pas',
  Model.Conexao.Types in 'Model\Model.Conexao.Types.pas',
  Model.Entity.Pessoa in 'Model\Model.Entity.Pessoa.pas',
  Model.Entity.Endereco in 'Model\Model.Entity.Endereco.pas',
  Model.Entity.Telefone in 'Model\Model.Entity.Telefone.pas',
  DAO.Pessoa.Interfaces in 'DAO\DAO.Pessoa.Interfaces.pas',
  DAO.Pessoa.CSV in 'DAO\DAO.Pessoa.CSV.pas',
  DAO.Pessoa.SQLite in 'DAO\DAO.Pessoa.SQLite.pas',
  DAO.Pessoa.Factory in 'DAO\DAO.Pessoa.Factory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPessoaView, PessoaView);
  Application.Run;
end.
