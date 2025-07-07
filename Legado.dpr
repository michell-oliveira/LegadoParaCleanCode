program Legado;

uses
  Vcl.Forms,
  View.Pessoa in 'View\View.Pessoa.pas' {FrmPessoa},
  DAO.Pessoa.SQLite in 'DAO\DAO.Pessoa.SQLite.pas',
  Controller.Pessoa in 'Controller\Controller.Pessoa.pas',
  Model.Pessoa in 'Model\Model.Pessoa.pas',
  DAO.Pessoa.CSV in 'DAO\DAO.Pessoa.CSV.pas',
  Conexao.Tipo in 'Tipos\Conexao.Tipo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPessoa, FrmPessoa);
  Application.Run;
end.
