object PessoaView: TPessoaView
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 400
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 584
    Height = 50
    Caption = 'Fonte de Dados'
    TabOrder = 0
    object RadioButtonCSV: TRadioButton
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = 'CSV'
      TabOrder = 0
    end
    object RadioButtonSQLite: TRadioButton
      Left = 120
      Top = 16
      Width = 97
      Height = 17
      Caption = 'SQLite'
      TabOrder = 1
    end
    object btnCarregar: TButton
      Left = 392
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Carregar'
      TabOrder = 2
      OnClick = btnCarregarClick
    end
    object btnLimpar: TButton
      Left = 473
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = btnLimparClick
    end
  end
  object dbgrdPessoa: TDBGrid
    Left = 8
    Top = 64
    Width = 584
    Height = 322
    DataSource = dsPessoa
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object conConexao: TUniConnection
    Left = 320
    Top = 112
  end
  object unqryPessoa: TUniQuery
    Connection = conConexao
    Left = 432
    Top = 168
  end
  object dsPessoa: TDataSource
    DataSet = adsPessoa
    Left = 432
    Top = 232
  end
  object cdsPessoa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 112
  end
  object adsPessoa: TAureliusDataset
    FieldDefs = <>
    Left = 296
    Top = 208
  end
end
