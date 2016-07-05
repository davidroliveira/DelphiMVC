unit Model.Bomba;

interface

uses
  Dao.Persistencia, Dao.Atributo;

type
  [Tabela('BOMBA')]
  TBomba = class(TPersistencia)
  strict private
    FCODIGO_BOMBA: Int64;
    FCODIGO_TANQUE: Int64;
    FNUMERO_BOMBA: Int64;
    FSERIE_BOMBA: String;
    FMODELO_BOMBA: String;
    FFABRICANTE_BOMBA: String;
  public
    [Campo('CODIGO_BOMBA', True, True)]
    property CODIGO_BOMBA: Int64 read FCODIGO_BOMBA write FCODIGO_BOMBA;

    [Campo('CODIGO_TANQUE')]
    property CODIGO_TANQUE: Int64 read FCODIGO_TANQUE write FCODIGO_TANQUE;

    [Campo('NUMERO_BOMBA')]
    property NUMERO_BOMBA: Int64 read FNUMERO_BOMBA write FNUMERO_BOMBA;

    [Campo('FABRICANTE_BOMBA')]
    property FABRICANTE_BOMBA: String read FFABRICANTE_BOMBA write FFABRICANTE_BOMBA;

    [Campo('MODELO_BOMBA')]
    property MODELO_BOMBA: String read FMODELO_BOMBA write FMODELO_BOMBA;

    [Campo('SERIE_BOMBA')]
    property SERIE_BOMBA: String read FSERIE_BOMBA write FSERIE_BOMBA;

    function Carregar(const AValor: Int64): Boolean; override;
  end;

implementation

{ TBomba }

function TBomba.Carregar(const AValor: Int64): Boolean;
begin
  CODIGO_BOMBA := AValor;

  Result := inherited Carregar;
end;

end.

