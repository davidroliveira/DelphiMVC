unit Model.Parametro;

interface

uses
  Dao.Persistencia, Dao.Atributo;

type
  [Tabela('PARAMETRO')]
  TParametro = class(TPersistencia)
  strict private
    FCODIGO_PARAMETRO: Int64;
    FDESCRICAO_PARAMETRO: String;
    FVALOR_PARAMETRO: String;
  public
    [Campo('CODIGO_PARAMETRO', True, True)]
    property CODIGO_PARAMETRO: Int64 read FCODIGO_PARAMETRO write FCODIGO_PARAMETRO;

    [Campo('DESCRICAO_PARAMETRO')]
    property DESCRICAO_PARAMETRO: string read FDESCRICAO_PARAMETRO write FDESCRICAO_PARAMETRO;

    [Campo('VALOR_PARAMETRO')]
    property VALOR_PARAMETRO: String read FVALOR_PARAMETRO write FVALOR_PARAMETRO;

    function Carregar(const AValor: Int64): Boolean; override;
  end;

implementation

{ TParametro }

function TParametro.Carregar(const AValor: Int64): Boolean;
begin
  CODIGO_PARAMETRO := AValor;

  Result := inherited Carregar;
end;

end.

