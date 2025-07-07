unit View.Pessoa;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Data.DB,
  Vcl.ExtCtrls,
  UniProvider,
  SQLiteUniProvider,
  Data.DBXSQLite,
  Vcl.Dialogs,
  Uni,
  MemDS,
  DBAccess,
  System.Classes,
  System.SysUtils,
  Datasnap.DBClient, uADStanIntf, uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf, uADDAptIntf,
  uADCompDataSet, uADCompClient, Conexao.Tipo;

type
  TFrmPessoa = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    RadioButtonCSV: TRadioButton;
    RadioButtonSQLite: TRadioButton;
    btnCarregar: TButton;
    dtsPessoa: TDataSource;
    btnLimpar: TButton;
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure RadioButtonCSVClick(Sender: TObject);
    procedure RadioButtonSQLiteClick(Sender: TObject);
  private
    FCdsPessoa: TClientDataSet;
    FTipoConexao: TTipoConexao;
    procedure Carregar;
    procedure CriarCdsPessoa;
    procedure Limpar;
  public
  end;

var
  FrmPessoa: TFrmPessoa;

implementation

uses
  Controller.Pessoa;

{$R *.dfm}

procedure TFrmPessoa.btnCarregarClick(Sender: TObject);
begin
  if FTipoConexao = TTipoConexao.TipoNaoInformado then
  begin
    ShowMessage('Tipo de conexão não informado');
    Exit;
  end;
  Limpar;
  Carregar;
end;

procedure TFrmPessoa.btnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TFrmPessoa.Carregar;
var
  LControllerPessoa: TControllerPessoa;
  LListarPessoa: TDataSet;
begin
  LControllerPessoa := TControllerPessoa.Create;
  try
    LListarPessoa := LControllerPessoa.ListarPessoa(FTipoConexao);
    LListarPessoa.First;
    while not LListarPessoa.Eof do
    begin
      FCdsPessoa.Append;
      FCdsPessoa.CopyFields(LListarPessoa);
      FCdsPessoa.Post;
      LListarPessoa.Next;
    end;
    dtsPessoa.DataSet := FCdsPessoa;
  finally
    LControllerPessoa.Free;
  end;
end;

procedure TFrmPessoa.CriarCdsPessoa;
begin
  FCdsPessoa := TClientDataSet.Create(Self);
  FCdsPessoa.close;
  FCdsPessoa.FieldDefs.Clear;
  FCdsPessoa.FieldDefs.Add('id', ftInteger);
  FCdsPessoa.FieldDefs.Add('nome', ftString, 30);
  FCdsPessoa.FieldDefs.Add('endereco', ftString, 30);
  FCdsPessoa.FieldDefs.Add('telefone', ftString, 15);
  FCdsPessoa.CreateDataSet;
  FCdsPessoa.Open;
end;

procedure TFrmPessoa.FormCreate(Sender: TObject);
begin
  FTipoConexao := TTipoConexao.TipoNaoInformado;
  CriarCdsPessoa;
end;

procedure TFrmPessoa.FormDestroy(Sender: TObject);
begin
  FCdsPessoa.Free;
end;

procedure TFrmPessoa.Limpar;
begin
  if FCdsPessoa.RecordCount > 0 then
    FCdsPessoa.EmptyDataSet;
end;

procedure TFrmPessoa.RadioButtonCSVClick(Sender: TObject);
begin
  FTipoConexao := TTipoConexao.CSV;
end;

procedure TFrmPessoa.RadioButtonSQLiteClick(Sender: TObject);
begin
  FTipoConexao := TTipoConexao.SQLite;
end;

end.
