unit Controller.Combustivel;

interface

uses
  System.SysUtils, System.Variants,

  Controller.Base, View.Cadastro.Base, Dao.Persistencia,

  Model.Combustivel, View.Cadastro.Combustivel;

type
  TControllerCombustivel = class(TControllerBase<TFrmCombustivel,TCombustivel>)
  public
    procedure AlimentaView; override;
    procedure AlimentaModel; override;
  end;

implementation

{ TControllerCombustivel }

procedure TControllerCombustivel.AlimentaModel;
begin
  inherited;
  Model.CODIGO_COMBUSTIVEL := StrToInt64Def(View.EdtCodigo.Text, 0);
  Model.DESCRICAO_COMBUSTIVEL := View.EdtDescricao.Text;
  Model.VALOR_COMBUSTIVEL := StrToFloatDef(View.EdtValor.Text, 0);
end;

procedure TControllerCombustivel.AlimentaView;
begin
  inherited;
  View.EdtCodigo.Text := Model.CODIGO_COMBUSTIVEL.ToString;
  View.EdtDescricao.Text := Model.DESCRICAO_COMBUSTIVEL;
  View.EdtValor.Text := FormatFloat('0.00#,##', Model.VALOR_COMBUSTIVEL);
end;

end.
