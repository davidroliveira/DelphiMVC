unit Controller.Tanque;

interface

uses
  System.SysUtils, System.Variants, Data.DB,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia, Dao.DB,

  Model.Tanque, View.Cadastro.Tanque;

type
  TControllerTanque = class(TControllerBase<TFrmTanque,TTanque>)
  strict private
    DSCombustivel: TDataSource;
  public
    procedure AlimentaView; override;
    procedure AlimentaModel; override;

    constructor Create(Filter: string = ''); override;

    destructor Destroy; override;
  end;

implementation

{ TControllerTanque }

procedure TControllerTanque.AlimentaModel;
begin
  inherited;
  Model.CODIGO_TANQUE := StrToInt64Def(View.EdtCodigo.Text, 0);
  Model.CODIGO_COMBUSTIVEL := View.LkpCombustivel.KeyValue;
  Model.CAPACIDADE_TANQUE := StrToFloatDef(View.EdtCapacidade.Text, 0);
end;

procedure TControllerTanque.AlimentaView;
begin
  inherited;
  View.EdtCodigo.Text := Model.CODIGO_TANQUE.ToString;
  View.LkpCombustivel.KeyValue := Model.CODIGO_COMBUSTIVEL;
  View.EdtCapacidade.Text := Model.CAPACIDADE_TANQUE.ToString;
end;

constructor TControllerTanque.Create(Filter: string = '');
begin
  inherited Create(Filter);
  DSCombustivel := TConexao.GetInstancia.CriaDataSource('SELECT * FROM COMBUSTIVEL ORDER BY DESCRICAO_COMBUSTIVEL');
  View.LkpCombustivel.ListSource := DSCombustivel;
  View.LkpCombustivel.KeyField := 'CODIGO_COMBUSTIVEL';
  View.LkpCombustivel.ListField := 'DESCRICAO_COMBUSTIVEL';
end;

destructor TControllerTanque.Destroy;
begin
  DSCombustivel.Free;
  inherited Destroy();
end;

end.
