program Legado;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {frmPessoaCadastro},
  uPessoaCSV in 'uPessoaCSV.pas',
  uPessoaSQLite in 'uPessoaSQLite.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPessoaCadastro, frmPessoaCadastro);
  Application.Run;
end.
