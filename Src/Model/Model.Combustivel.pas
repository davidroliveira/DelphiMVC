unit Model.Combustivel;

interface

uses
  Dao.Persistencia, Dao.Atributo;

type
  [Tabela('COMBUSTIVEL')]
  TCombustivel = class(TPersistencia)
  strict private
    FCODIGO_COMBUSTIVEL: Int64;
    FDESCRICAO_COMBUSTIVEL: String;
    FVALOR_COMBUSTIVEL: Double;
  public
    [Campo('CODIGO_COMBUSTIVEL', True, True)]
    property CODIGO_COMBUSTIVEL: Int64 read FCODIGO_COMBUSTIVEL write FCODIGO_COMBUSTIVEL;

    [Campo('DESCRICAO_COMBUSTIVEL')]
    property DESCRICAO_COMBUSTIVEL: string read FDESCRICAO_COMBUSTIVEL write FDESCRICAO_COMBUSTIVEL;

    [Campo('VALOR_COMBUSTIVEL')]
    property VALOR_COMBUSTIVEL: Double read FVALOR_COMBUSTIVEL write FVALOR_COMBUSTIVEL;

    function Carregar(const AValor: Int64): Boolean; override;
  end;

implementation

{ TCombustivel }

function TCombustivel.Carregar(const AValor: Int64): Boolean;
begin
  CODIGO_COMBUSTIVEL := AValor;

  Result := inherited Carregar;
end;

end.

