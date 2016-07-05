unit Controller.Abastecimento;

interface

uses
  System.SysUtils, System.Variants, Data.DB,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia, Dao.DB,

  Model.Abastecimento, View.Cadastro.Abastecimento;

type
  TControllerAbastecimento = class(TControllerBase<TFrmAbastecimento,TAbastecimento>)
  strict private
    FCodigoBomba: Int64;
    FDescricaoCombustivel: string;
    FPrecoCombustivel: Double;
    FImposto: Double;
    procedure CalculaTotal;
    procedure CalculaQuantidade;
    procedure InformacoesComplementares;
  protected
    procedure EdtQuantidadeExit(Sender: TObject);
    procedure EdtTotalExit(Sender: TObject);
  public
    procedure AlimentaView; override;
    procedure AlimentaModel; override;

    constructor Create(ACodigoBomba: Int64); overload;

  end;

implementation

{ TControllerAbastecimento }

procedure TControllerAbastecimento.AlimentaModel;
begin
  inherited;
  Model.CODIGO_ABASTECIMENTO := StrToInt64Def(View.EdtCodigo.Text, 0);
  Model.CODIGO_BOMBA := FCodigoBomba;
  Model.DATA_HORA_ABASTECIMENTO := Trunc(View.EdtData.Date) + Frac(View.EdtHora.Time);
  Model.QUANTIDADE_ABASTECIMENTO := StrToFloatDef(View.EdtQuantidade.Text, 0);
  Model.PRECO_COMBUSTIVEL_ABASTECIMENTO := StrToFloatDef(View.EdtPreco.Text, 0);
  Model.VALOR_IMPOSTO_ABASTECIMENTO := StrToFloatDef(View.EdtValorImposto.Text, 0);
  Model.TOTAL_ABASTECIMENTO := StrToFloatDef(View.EdtTotal.Text, 0);
end;

procedure TControllerAbastecimento.AlimentaView;
begin
  inherited;
  View.EdtCodigo.Text := Model.CODIGO_ABASTECIMENTO.ToString;

  if Model.DATA_HORA_ABASTECIMENTO <> 0 then
    View.EdtData.Date := Model.DATA_HORA_ABASTECIMENTO
  else
    View.EdtData.Date := Date;

  if Model.DATA_HORA_ABASTECIMENTO <> 0 then
    View.EdtHora.Time := Model.DATA_HORA_ABASTECIMENTO
  else
    View.EdtHora.Time := Time;

  View.EdtQuantidade.Text := Model.QUANTIDADE_ABASTECIMENTO.ToString;

  if Model.PRECO_COMBUSTIVEL_ABASTECIMENTO <> 0 then
    View.EdtPreco.Text := Model.PRECO_COMBUSTIVEL_ABASTECIMENTO.ToString
  else
    View.EdtPreco.Text := FPrecoCombustivel.ToString;

  View.EdtValorImposto.Text := Model.VALOR_IMPOSTO_ABASTECIMENTO.ToString;

  View.EdtTotal.Text := Model.TOTAL_ABASTECIMENTO.ToString;
end;

procedure TControllerAbastecimento.CalculaTotal;
var
  Valor: Double;
begin
  Valor := StrToFloatDef(View.EdtPreco.Text, 0) * StrToFloatDef(View.EdtQuantidade.Text, 0);

  if View.EdtValorImposto.Text <> FloatToStr((Valor * (FImposto / 100))) then
    View.EdtValorImposto.Text := FloatToStr((Valor * (FImposto / 100)));

  Valor := Valor + StrToFloatDef(View.EdtValorImposto.Text, 0);

  if View.EdtTotal.Text <> Valor.ToString then
    View.EdtTotal.Text := Valor.ToString;
end;

procedure TControllerAbastecimento.CalculaQuantidade;
var
  Valor: Double;
begin
  if StrToFloatDef(View.EdtPreco.Text, 0) = 0 then
    Valor := 0
  else
  begin
    Valor := StrToFloatDef(View.EdtPreco.Text, 0) + (StrToFloatDef(View.EdtPreco.Text, 0) * (FImposto / 100));
    if Valor > 0 then
      Valor := StrToFloatDef(View.EdtTotal.Text, 0) / Valor
  end;

  if View.EdtQuantidade.Text <> Valor.ToString then
    View.EdtQuantidade.Text := Valor.ToString;

  CalculaTotal;

end;

constructor TControllerAbastecimento.Create(ACodigoBomba: Int64);
begin
  inherited Create('CODIGO_BOMBA = ' + ACodigoBomba.ToString);
  FCodigoBomba := ACodigoBomba;

  InformacoesComplementares;
  View.EdtQuantidade.OnExit := EdtQuantidadeExit;
  View.EdtTotal.OnExit := EdtTotalExit;

  View.EdtBomba.Text := FCodigoBomba.ToString;
  View.EdtCombustivel.Text := FDescricaoCombustivel;
  View.EdtPercentualImposto.Text := FImposto.ToString;

end;

procedure TControllerAbastecimento.EdtQuantidadeExit(Sender: TObject);
begin
  CalculaTotal;
end;

procedure TControllerAbastecimento.EdtTotalExit(Sender: TObject);
begin
  CalculaQuantidade;
end;

procedure TControllerAbastecimento.InformacoesComplementares;
const
  ParametroImpostoAbastecimento = 1;
var
  DataSetDados: TDataSet;
begin
  DataSetDados := TConexao.GetInstancia.CriaDataSource(
    'SELECT * ' +
    '  FROM BOMBA ' +
    '  LEFT JOIN TANQUE ' +
    '    ON TANQUE.CODIGO_TANQUE = BOMBA.CODIGO_TANQUE ' +
    '  LEFT JOIN COMBUSTIVEL ' +
    '    ON COMBUSTIVEL.CODIGO_COMBUSTIVEL = TANQUE.CODIGO_COMBUSTIVEL ' +
    ' WHERE BOMBA.CODIGO_BOMBA = ' + FCodigoBomba.ToString).DataSet;
  FDescricaoCombustivel := DataSetDados.FieldByName('DESCRICAO_COMBUSTIVEL').AsString;

  FPrecoCombustivel := DataSetDados.FieldByName('VALOR_COMBUSTIVEL').AsFloat;


  FreeAndNil(DataSetDados);


  DataSetDados := TConexao.GetInstancia.CriaDataSource(
    'SELECT * ' +
    '  FROM PARAMETRO ' +
    ' WHERE CODIGO_PARAMETRO = ' + ParametroImpostoAbastecimento.ToString).DataSet;
  FImposto := StrToFloatDef(DataSetDados.FieldByName('VALOR_PARAMETRO').AsString, 0);


end;

end.
