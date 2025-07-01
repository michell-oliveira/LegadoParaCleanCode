unit UnitPrincipal;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  Data.DB,
  Data.DBXSQLite,
  MemDS,
  DBAccess,
  System.Classes,
  System.SysUtils,
  Datasnap.DBClient;

type tpOrigem = (tpCsv, tpSQLite);

type
  TfrmPessoaCadastro = class(TForm)
    GridPessoaExibir: TDBGrid;
    Panel1: TPanel;
    RadioButtonCSV: TRadioButton;
    RadioButtonSQLite: TRadioButton;
    btnCarregar: TButton;
    dsPessoaExibir: TDataSource;
    FCdsDadosExibir: TClientDataSet;
    btnLimpar: TButton;
    procedure btnCarregarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDiretorioDataBase: string;
    procedure CriarEstruturaDataSet;
    procedure LimparDados;
    procedure Exibir(AOrigem: tpOrigem);
    procedure ExibirPessoaSQLite;
    procedure ExibirPessoaCSV;
  public
  end;

var
  frmPessoaCadastro: TfrmPessoaCadastro;

implementation

{$R *.dfm}
uses
  uPessoaCSV,
  uPessoaSQLite;

procedure TfrmPessoaCadastro.btnCarregarClick(Sender: TObject);
begin
  if RadioButtonCSV.Checked then
    Exibir(tpCsv)
  else
  if RadioButtonSQLite.Checked then
    Exibir(tpSQLite)
  else
    ShowMessage('Nenhuma fonte de dados selecionada!');
end;

procedure TfrmPessoaCadastro.btnLimparClick(Sender: TObject);
begin
  LimparDados;
end;

procedure TfrmPessoaCadastro.CriarEstruturaDataSet;
begin
  FCdsDadosExibir.close;
  FCdsDadosExibir.FieldDefs.Clear;
  FCdsDadosExibir.FieldDefs.Add('id', ftInteger);
  FCdsDadosExibir.FieldDefs.Add('nome', ftString, 50);
  FCdsDadosExibir.FieldDefs.Add('endereco', ftString, 80);
  FCdsDadosExibir.FieldDefs.Add('telefone', ftString, 20);
  FCdsDadosExibir.CreateDataSet;
end;

procedure TfrmPessoaCadastro.FormCreate(Sender: TObject);
begin
   FDiretorioDataBase := ExtractFilePath(Application.ExeName);
   CriarEstruturaDataSet;
   dsPessoaExibir.DataSet := FCdsDadosExibir;
end;

procedure TfrmPessoaCadastro.LimparDados;
begin
  if FCdsDadosExibir.RecordCount > 0 then
    FCdsDadosExibir.EmptyDataSet;
end;

procedure TfrmPessoaCadastro.Exibir(AOrigem: tpOrigem);
begin
  LimparDados;
  try
    if AOrigem = tpCsv then
      ExibirPessoaCSV
    else
      ExibirPessoaSQLite;

  except on e:Exception do
     ShowMessage(e.Message);
  end;
end;

procedure TfrmPessoaCadastro.ExibirPessoaCSV;
var
  LPessoaCSV: TPessoaCSV;
begin
  LPessoaCSV := TPessoaCSV.Create(FDiretorioDataBase);
  try
    LPessoaCSV.Exibir(FCdsDadosExibir);
  finally
   LPessoaCSV.free;
  end;
end;

procedure TfrmPessoaCadastro.ExibirPessoaSQLite;
var
  LPessoaSQLite: TPessoaSQLite;
begin
  LPessoaSQLite := TPessoaSQLite.Create(FDiretorioDataBase);
  try
    LPessoaSQLite.Exibir(FCdsDadosExibir);
  finally
   LPessoaSQLite.free;
  end;
end;
end.
