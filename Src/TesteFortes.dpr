program TesteFortes;

uses
  Vcl.Controls,
  Vcl.Forms,
  Dao.Atributo in 'Dao\Dao.Atributo.pas',
  Dao.DB in 'Dao\Dao.DB.pas',
  Dao.Persistencia in 'Dao\Dao.Persistencia.pas',
  Controller.Base in 'Controller\Controller.Base.pas',
  Controller.Principal in 'Controller\Controller.Principal.pas',
  Controller.Combustivel in 'Controller\Controller.Combustivel.pas',
  View.Form.Base in 'View\View.Form.Base.pas' {FrmMestre},
  View.Cadastro.Base in 'View\View.Cadastro.Base.pas' {FrmCadastroBase},
  View.Cadastro.Combustivel in 'View\View.Cadastro.Combustivel.pas' {FrmCombustivel},
  View.Cadastro.Tanque in 'View\View.Cadastro.Tanque.pas' {FrmTanque},
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  View.Parametro in 'View\View.Parametro.pas' {FrmParametro},
  View.Lancamento.Abastecimento in 'View\View.Lancamento.Abastecimento.pas' {FrmLancamentoAbastecimento},
  View.Cadastro.Bomba in 'View\View.Cadastro.Bomba.pas' {FrmBomba},
  View.Cadastro.Abastecimento in 'View\View.Cadastro.Abastecimento.pas' {FrmAbastecimento},
  Model.Combustivel in 'Model\Model.Combustivel.pas',
  Model.Tanque in 'Model\Model.Tanque.pas',
  Model.Parametro in 'Model\Model.Parametro.pas',
  Model.Bomba in 'Model\Model.Bomba.pas',
  Model.Abastecimento in 'Model\Model.Abastecimento.pas',
  Controller.Lancamento.Abastecimento in 'Controller\Controller.Lancamento.Abastecimento.pas',
  Controller.Tanque in 'Controller\Controller.Tanque.pas',
  Controller.Parametro in 'Controller\Controller.Parametro.pas',
  Controller.Bomba in 'Controller\Controller.Bomba.pas',
  Controller.Abastecimento in 'Controller\Controller.Abastecimento.pas',
  Controller.Relatorio in 'Controller\Controller.Relatorio.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TControllerPrincipal.Create;
  Application.Run;
end.
