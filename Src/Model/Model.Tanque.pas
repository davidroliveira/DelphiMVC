unit Model.Tanque;

interface

uses
  Dao.Persistencia, Dao.Atributo;

type
  [Tabela('TANQUE')]
  TTanque = class(TPersistencia)
  strict private
    FCODIGO_TANQUE: Int64;
    FCODIGO_COMBUSTIVEL: Int64;
    FCAPACIDADE_TANQUE: Double;
  public
    [Campo('CODIGO_TANQUE', True, True)]
    property CODIGO_TANQUE: Int64 read FCODIGO_TANQUE write FCODIGO_TANQUE;

    [Campo('CODIGO_COMBUSTIVEL')]
    property CODIGO_COMBUSTIVEL: Int64 read FCODIGO_COMBUSTIVEL write FCODIGO_COMBUSTIVEL;

    [Campo('CAPACIDADE_TANQUE')]
    property CAPACIDADE_TANQUE: Double read FCAPACIDADE_TANQUE write FCAPACIDADE_TANQUE;

    function Carregar(const AValor: Int64): Boolean; override;
  end;

implementation

{ TTanque }

function TTanque.Carregar(const AValor: Int64): Boolean;
begin
  CODIGO_TANQUE := AValor;

  Result := inherited Carregar;
end;

end.

