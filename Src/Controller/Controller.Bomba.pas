unit Controller.Bomba;

interface

uses
  System.SysUtils, System.Variants, Data.DB,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia, Dao.DB,

  Model.Bomba, View.Cadastro.Bomba;

type
  TControllerBomba = class(TControllerBase<TFrmBomba,TBomba>)
  strict private
    DSTanque: TDataSource;
  public
    procedure AlimentaView; override;
    procedure AlimentaModel; override;

    constructor Create(Filter: string = ''); override;

    destructor Destroy; override;
  end;

implementation

{ TControllerBomba }

procedure TControllerBomba.AlimentaModel;
begin
  inherited;
  Model.CODIGO_BOMBA := StrToInt64Def(View.EdtCodigo.Text, 0);
  Model.CODIGO_TANQUE := View.LkpTanque.KeyValue;
  Model.NUMERO_BOMBA := StrToInt64Def(View.EdtNumero.Text, 0);
  Model.FABRICANTE_BOMBA := View.EdtFabricante.Text;
  Model.MODELO_BOMBA := View.EdtModelo.Text;
  Model.SERIE_BOMBA := View.EdtSerie.Text;
end;

procedure TControllerBomba.AlimentaView;
begin
  inherited;
  View.EdtCodigo.Text := Model.CODIGO_TANQUE.ToString;
  View.LkpTanque.KeyValue := Model.CODIGO_TANQUE.ToString;
  View.EdtNumero.Text := Model.NUMERO_BOMBA.ToString;
  View.EdtFabricante.Text := Model.FABRICANTE_BOMBA;
  View.EdtModelo.Text := Model.MODELO_BOMBA;
  View.EdtSerie.Text := Model.SERIE_BOMBA;
end;

constructor TControllerBomba.Create(Filter: string = '');
begin
  inherited Create(Filter);
  DSTanque := TConexao.GetInstancia.CriaDataSource(
    'SELECT * ' +
    '  FROM TANQUE ' +
    '  LEFT JOIN COMBUSTIVEL ' +
    '    ON COMBUSTIVEL.CODIGO_COMBUSTIVEL = TANQUE.CODIGO_COMBUSTIVEL ' +
    '  ORDER BY DESCRICAO_COMBUSTIVEL');
  DSTanque.DataSet.FieldByName('DESCRICAO_COMBUSTIVEL').DisplayWidth := 10;
  View.LkpTanque.ListSource := DSTanque;
  View.LkpTanque.KeyField := 'CODIGO_TANQUE';
  View.LkpTanque.ListField := 'CODIGO_TANQUE;DESCRICAO_COMBUSTIVEL;CAPACIDADE_TANQUE';
  View.LkpTanque.DropDownWidth := View.LkpTanque.Width * 2;
end;

destructor TControllerBomba.Destroy;
begin
  DSTanque.Free;
  inherited Destroy();
end;

end.
