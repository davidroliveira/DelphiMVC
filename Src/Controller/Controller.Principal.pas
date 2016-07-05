unit Controller.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  System.Rtti,

  View.Principal, View.Form.Base,

  Controller.Combustivel,
  Controller.Tanque,
  Controller.Parametro,
  Controller.Bomba,
  Controller.Lancamento.Abastecimento,

  Controller.Relatorio;

type
  TControllerPrincipal = class
  strict private
    FView: TFrmPrincipal;
    FControllerCombustivel: TControllerCombustivel;
    FControllerTanque: TControllerTanque;
    FControllerParametro: TControllerParametro;
    FControllerBomba: TControllerBomba;
    FControllerAbastecimento: TControllerAbastecimentoLancamento;

    FModeloRelatorioAbastecimento: TModeloRelatorioAbastecimento;
    FRelatorio: TRelatorio;

  protected
    property View: TFrmPrincipal read FView write FView;

    procedure CombustivelClick(Sender: TObject);
    procedure TanqueClick(Sender: TObject);
    procedure ParametroClick(Sender: TObject);
    procedure BombaClick(Sender: TObject);
    procedure AbastecimentoClick(Sender: TObject);
    procedure RelatorioAbastecimentoClick(Sender: TObject);
    procedure DesignerRelatorioAbastecimentoClick(Sender: TObject);


  public
    function ShowModal: TModalResult;

    constructor Create; virtual;

  end;

implementation

{ TControllerPrincipal }

procedure TControllerPrincipal.AbastecimentoClick(Sender: TObject);
begin
  FControllerAbastecimento := TControllerAbastecimentoLancamento.Create;
  FControllerAbastecimento.ShowModal;
  FreeAndNil(FControllerAbastecimento);
end;

procedure TControllerPrincipal.BombaClick(Sender: TObject);
begin
  FControllerBomba := TControllerBomba.Create;
  FControllerBomba.ShowModal;
  FreeAndNil(FControllerBomba);
end;

procedure TControllerPrincipal.CombustivelClick(Sender: TObject);
begin
  FControllerCombustivel := TControllerCombustivel.Create;
  FControllerCombustivel.ShowModal;
  FreeAndNil(FControllerCombustivel);
end;

constructor TControllerPrincipal.Create;
begin
  Application.CreateForm(TFrmPrincipal, FView);
  FView.BtnCombustivel.OnClick := CombustivelClick;
  FView.BtnTanque.OnClick := TanqueClick;
  FView.BtnParametros.OnClick := ParametroClick;
  FView.BtnBombas.OnClick := BombaClick;
  FView.BtnAbastecimento.OnClick := AbastecimentoClick;
  FView.BtnRelatorioAbastecimento.OnClick := RelatorioAbastecimentoClick;
  FView.BtnDesignerRelatorioAbastecimento.OnClick := DesignerRelatorioAbastecimentoClick;
end;

procedure TControllerPrincipal.DesignerRelatorioAbastecimentoClick(
  Sender: TObject);
begin
  FModeloRelatorioAbastecimento := TModeloRelatorioAbastecimento.Create;
  FRelatorio := TRelatorio.Create(FModeloRelatorioAbastecimento);
  FRelatorio.DesignReport;
  FreeAndNil(FRelatorio);
  FreeAndNil(FModeloRelatorioAbastecimento);
end;

procedure TControllerPrincipal.ParametroClick(Sender: TObject);
begin
  FControllerParametro := TControllerParametro.Create;
  FControllerParametro.ShowModal;
  FreeAndNil(FControllerParametro);
end;

procedure TControllerPrincipal.RelatorioAbastecimentoClick(Sender: TObject);
begin
  FModeloRelatorioAbastecimento := TModeloRelatorioAbastecimento.Create;
  FRelatorio := TRelatorio.Create(FModeloRelatorioAbastecimento);
  FRelatorio.ShowReport;
  FreeAndNil(FRelatorio);
  FreeAndNil(FModeloRelatorioAbastecimento);
end;

function TControllerPrincipal.ShowModal: TModalResult;
begin
  Result := FView.ShowModal;
end;

procedure TControllerPrincipal.TanqueClick(Sender: TObject);
begin
  FControllerTanque := TControllerTanque.Create;
  FControllerTanque.ShowModal;
  FreeAndNil(FControllerTanque);
end;

end.
