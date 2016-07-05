unit Controller.Parametro;

interface

uses
  System.SysUtils, System.Variants,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia,

  Model.Parametro, View.Parametro;

type
  TControllerParametro = class(TControllerBase<TFrmParametro,TParametro>)
  public
    procedure AlimentaView; override;
    procedure AlimentaModel; override;

    constructor Create(Filter: string = ''); override;
  end;

implementation

{ TControllerParametro }

procedure TControllerParametro.AlimentaModel;
begin
  inherited;
  Model.CODIGO_PARAMETRO := StrToInt64Def(View.EdtCodigo.Text, 0);
  Model.DESCRICAO_PARAMETRO := View.EdtDescricao.Text;
  Model.VALOR_PARAMETRO := View.EdtValor.Text;
end;

procedure TControllerParametro.AlimentaView;
begin
  inherited;
  View.EdtCodigo.Text := Model.CODIGO_PARAMETRO.ToString;
  View.EdtDescricao.Text := Model.DESCRICAO_PARAMETRO;
  View.EdtValor.Text := Model.VALOR_PARAMETRO;
end;

constructor TControllerParametro.Create(Filter: string = '');
begin
  inherited Create(Filter);
  View.BtnInserir.Visible := false;
  View.BtnExcluir.Visible := false;

end;

end.
