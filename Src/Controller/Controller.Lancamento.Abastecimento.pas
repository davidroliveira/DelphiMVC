unit Controller.Lancamento.Abastecimento;

interface

uses
  System.SysUtils, System.Variants, Vcl.Forms, Vcl.Controls, Data.DB,
  Vcl.ButtonGroup, Vcl.Dialogs,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia, Dao.DB,

  Model.Abastecimento, View.Lancamento.Abastecimento, View.Cadastro.Abastecimento,


  Controller.Abastecimento;

type
  TControllerAbastecimentoLancamento = class
  strict private
    FView: TFrmLancamentoAbastecimento;
    FControllerAbastecimento : TControllerAbastecimento;
    FModel: TAbastecimento;
    FDataSetBombas: TDataSet;
    procedure GeraDataSetBombas;
    procedure PopulaGroupBombas;
  protected
    property View: TFrmLancamentoAbastecimento read FView write FView;

    procedure ButtonGroupBombasButtonClicked(Sender: TObject;
      Index: Integer);

  public
    function ShowModal: TModalResult;

    constructor Create; virtual;

  end;

implementation

{ TControllerAbastecimentoLancamento }

procedure TControllerAbastecimentoLancamento.ButtonGroupBombasButtonClicked(
  Sender: TObject; Index: Integer);
var
  CodigoBomba: Int64;
begin
  CodigoBomba := Int64(FView.ButtonGroupBombas.Items[index].Data);

  FControllerAbastecimento := TControllerAbastecimento.Create(CodigoBomba);
  FControllerAbastecimento.ShowModal;
  FreeAndNil(FControllerAbastecimento);

end;

constructor TControllerAbastecimentoLancamento.Create;
begin
  Application.CreateForm(TFrmLancamentoAbastecimento, FView);
  FView.ButtonGroupBombas.OnButtonClicked := ButtonGroupBombasButtonClicked;
  GeraDataSetBombas;
  PopulaGroupBombas;
end;

procedure TControllerAbastecimentoLancamento.GeraDataSetBombas;
begin
  FDataSetBombas := TConexao.GetInstancia.CriaDataSource(
    'SELECT * ' +
    '  FROM BOMBA ' +
    '  LEFT JOIN TANQUE ' +
    '    ON TANQUE.CODIGO_TANQUE = BOMBA.CODIGO_TANQUE ' +
    '  LEFT JOIN COMBUSTIVEL ' +
    '    ON COMBUSTIVEL.CODIGO_COMBUSTIVEL = TANQUE.CODIGO_COMBUSTIVEL ' +
    '  ORDER BY BOMBA.NUMERO_BOMBA').DataSet;
end;

procedure TControllerAbastecimentoLancamento.PopulaGroupBombas;
var
  NovoBtn: TGrpButtonItem;
begin
  FView.ButtonGroupBombas.Items.Clear;
  FDataSetBombas.First;

  while not FDataSetBombas.Eof do
  begin
    NovoBtn := FView.ButtonGroupBombas.Items.Add;
    NovoBtn.Data := pointer(FDataSetBombas.FieldByName('CODIGO_BOMBA').AsInteger);
    NovoBtn.Caption :=
      '   Bomba: ' + FDataSetBombas.FieldByName('NUMERO_BOMBA').AsString + sLineBreak +
      '   Tanque: ' + FDataSetBombas.FieldByName('CODIGO_TANQUE').AsString + sLineBreak +
      '   Combustível: ' + FDataSetBombas.FieldByName('DESCRICAO_COMBUSTIVEL').AsString;
    NovoBtn.ImageIndex := FDataSetBombas.FieldByName('CODIGO_BOMBA').AsInteger;
    FDataSetBombas.Next;
  end;
end;

function TControllerAbastecimentoLancamento.ShowModal: TModalResult;
begin
  Result := FView.ShowModal;
end;

end.
