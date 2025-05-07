object Form1: TForm1
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
    object Button2: TButton
      Left = 392
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Carregar'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 473
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 64
    Width = 584
    Height = 322
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object UniConnection1: TUniConnection
    Left = 320
    Top = 112
  end
  object UniQuery1: TUniQuery
    Connection = UniConnection1
    Left = 432
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = UniQuery1
    Left = 432
    Top = 232
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 112
  end
end
