unit Model.Abastecimento;

interface

uses
  Dao.Persistencia, Dao.Atributo;

type
  [Tabela('ABASTECIMENTO')]
  TAbastecimento = class(TPersistencia)
  strict private
    FCODIGO_ABASTECIMENTO: Int64;
    FCODIGO_BOMBA: Int64;
    FDATA_HORA_ABASTECIMENTO: TDateTime;
    FQUANTIDADE_ABASTECIMENTO: Double;
    FPRECO_COMBUSTIVEL_ABASTECIMENTO: Double;
    FVALOR_IMPOSTO_ABASTECIMENTO: Double;
    FTOTAL_ABASTECIMENTO: Double;
  public
    [Campo('CODIGO_ABASTECIMENTO', True, True)]
    property CODIGO_ABASTECIMENTO: Int64 read FCODIGO_ABASTECIMENTO write FCODIGO_ABASTECIMENTO;

    [Campo('CODIGO_BOMBA')]
    property CODIGO_BOMBA: Int64 read FCODIGO_BOMBA write FCODIGO_BOMBA;

    [Campo('DATA_HORA_ABASTECIMENTO')]
    property DATA_HORA_ABASTECIMENTO: TDateTime read FDATA_HORA_ABASTECIMENTO write FDATA_HORA_ABASTECIMENTO;

    [Campo('QUANTIDADE_ABASTECIMENTO')]
    property QUANTIDADE_ABASTECIMENTO: Double read FQUANTIDADE_ABASTECIMENTO write FQUANTIDADE_ABASTECIMENTO;

    [Campo('PRECO_COMBUSTIVEL_ABASTECIMENTO')]
    property PRECO_COMBUSTIVEL_ABASTECIMENTO: Double read FPRECO_COMBUSTIVEL_ABASTECIMENTO write FPRECO_COMBUSTIVEL_ABASTECIMENTO;

    [Campo('VALOR_IMPOSTO_ABASTECIMENTO')]
    property VALOR_IMPOSTO_ABASTECIMENTO: Double read FVALOR_IMPOSTO_ABASTECIMENTO write FVALOR_IMPOSTO_ABASTECIMENTO;

    [Campo('TOTAL_ABASTECIMENTO')]
    property TOTAL_ABASTECIMENTO: Double read FTOTAL_ABASTECIMENTO write FTOTAL_ABASTECIMENTO;

    function Carregar(const AValor: Int64): Boolean; override;
  end;

implementation

{ TAbastecimento }

function TAbastecimento.Carregar(const AValor: Int64): Boolean;
begin
  CODIGO_ABASTECIMENTO := AValor;

  Result := inherited Carregar;
end;

end.

