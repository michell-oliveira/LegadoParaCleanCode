unit UnitPrincipal;

interface

uses
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,
  Vcl.ExtCtrls, UniProvider, SQLiteUniProvider, Data.DBXSQLite, Vcl.Dialogs,
  Uni, MemDS, DBAccess, System.Classes, System.SysUtils, Datasnap.DBClient;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    RadioButtonCSV: TRadioButton;
    RadioButtonSQLite: TRadioButton;
    Button2: TButton;
    UniConnection1: TUniConnection;
    UniQuery1: TUniQuery;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  arq: string;
  sl: TStringList;
  linha: string;
  arr: TArray<string>;
  i: Integer;
begin
  if RadioButtonCSV.Checked then
  begin
    UniConnection1.ProviderName := 'SQLite';
    UniConnection1.Database := ExtractFilePath(ParamStr(0)) + 'dados.csv';

    ClientDataSet1.Close;
    ClientDataSet1.FieldDefs.Clear;
    ClientDataSet1.FieldDefs.Add('id', ftInteger);
    ClientDataSet1.FieldDefs.Add('nome', ftString, 100);
    ClientDataSet1.FieldDefs.Add('endereco', ftString, 150);
    ClientDataSet1.FieldDefs.Add('telefone', ftString, 20);
    ClientDataSet1.CreateDataSet;

    arq := ExtractFilePath(Application.ExeName) + 'dados.csv';

    if not FileExists(arq) then
    begin
      ShowMessage('Arquivo CSV não encontrado.');
      Exit;
    end;

    ClientDataSet1.EmptyDataSet;
    sl := TStringList.Create;
    try
      sl.LoadFromFile(arq);
      for i := 0 to sl.Count - 1 do
      begin
        linha := sl[i];
        arr := linha.Split([';']);
        if Length(arr) = 4 then
        begin
          ClientDataSet1.Append;
          ClientDataSet1.FieldByName('id').AsInteger := StrToIntDef(arr[0], 0);
          ClientDataSet1.FieldByName('nome').AsString := arr[1];
          ClientDataSet1.FieldByName('endereco').AsString := arr[2];
          ClientDataSet1.FieldByName('telefone').AsString := arr[3];
          ClientDataSet1.Post;
        end;
      end;
    finally
      sl.Free;
    end;

    DataSource1.DataSet := ClientDataSet1;
  end
  else if RadioButtonSQLite.Checked then
  begin
    UniConnection1.ProviderName := 'SQLite';
    UniConnection1.Database := ExtractFilePath(ParamStr(0)) + 'dados.sqlite';
    UniQuery1.Close;
    UniQuery1.SQL.Text := 'SELECT p.id, p.nome, e.endereco, t.telefone ' +
                          'FROM pessoas p ' +
                          'LEFT JOIN enderecos e ON e.id_pessoa = p.id ' +
                          'LEFT JOIN telefones t ON t.id_pessoa = p.id';
    UniQuery1.Open;
    DataSource1.Dataset := UniQuery1;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if DataSource1.DataSet <> nil then
  begin
    if DataSource1.DataSet = ClientDataSet1 then
      ClientDataSet1.EmptyDataSet
    else if DataSource1.DataSet = UniQuery1 then
    begin
      UniQuery1.Close;
    end;
  end;
end;

end.
