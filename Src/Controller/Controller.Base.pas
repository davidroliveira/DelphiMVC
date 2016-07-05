unit Controller.Base;

interface

uses
  Classes, Controls, System.Rtti, Vcl.Forms, Dialogs,

  Dao.Persistencia, View.Cadastro.Base, Dao.DB;

type
  TStatus = (stInsercao, stEdicao, stNavegacao);

  TControllerBase<FrmCadastro: TFrmCadastroBase; Persistencia: TPersistencia> = class
  strict private
    FStatus: TStatus;
    FView: FrmCadastro;
    FModel: Persistencia;
    FOnAfterPost: TNotifyEvent;
    function GetStatus: TStatus;
    procedure SetStatus(const Value: TStatus);
  protected
    property Status: TStatus read GetStatus write SetStatus;

    property View: FrmCadastro read FView write FView;
    property Model: Persistencia read FModel write FModel;
    property OnAfterPost: TNotifyEvent read FOnAfterPost write FOnAfterPost;

    procedure InserirClick(Sender: TObject); virtual;
    procedure AlterarClick(Sender: TObject); virtual;
    procedure ExcluirClick(Sender: TObject); virtual;
    procedure SalvarClick(Sender: TObject); virtual;
    procedure CancelarClick(Sender: TObject); virtual;

    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);

    procedure AlimentaView; virtual; abstract;
    procedure AlimentaModel; virtual; abstract;

  public
    function ShowModal: TModalResult;

    constructor Create(Filter: string = ''); virtual;
  end;


implementation


{ TControllerBase<FrmCadastro, Persistencia> }

procedure TControllerBase<FrmCadastro, Persistencia>.AlterarClick(
  Sender: TObject);
begin
  Model.Carregar(View.DBGridPrincipal.DataSource.DataSet.FieldByName(Model.NomeCampoChavePrimaria).AsInteger);
  AlimentaView;
  FView.PageControlPrincipal.ActivePage := FView.TSDados;

  Status := stEdicao;
end;

procedure TControllerBase<FrmCadastro, Persistencia>.CancelarClick(
  Sender: TObject);
begin
  FModel.Clear;
  AlimentaView;
  FView.PageControlPrincipal.ActivePage := FView.TSLista;
  Status := stNavegacao;
end;

procedure TControllerBase<FrmCadastro, Persistencia>.PageControlChanging(
  Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := Status = stNavegacao;

  if (AllowChange) and (FView.PageControlPrincipal.ActivePage = FView.tsLista) then
  begin
    if FView.DBGridPrincipal.DataSource.DataSet.IsEmpty then
      InserirClick(FView.BtnAlterar)
    else
      AlterarClick(FView.BtnAlterar);
  end;
end;

constructor TControllerBase<FrmCadastro, Persistencia>.Create(Filter: string = '');
var
  Contexto: TRttiContext;
begin
  FModel := Contexto.GetType(TClass(Persistencia)).GetMethod('Create').Invoke(TClass(Persistencia), []).AsType<Persistencia>;

  FView := Contexto.GetType(TClass(FrmCadastro)).GetMethod('Create').Invoke(TClass(FrmCadastro), [Application]).AsType<FrmCadastro>;
  FView.BtnInserir.OnClick := InserirClick;
  FView.BtnAlterar.OnClick := AlterarClick;
  FView.BtnExcluir.OnClick := ExcluirClick;
  FView.BtnSalvar.OnClick := SalvarClick;
  FView.BtnCancelar.OnClick := CancelarClick;
  FView.PageControlPrincipal.ActivePage := FView.TSLista;

  if Filter = '' then
    FView.DBGridPrincipal.DataSource := TConexao.GetInstancia.CriaDataSource('SELECT * FROM ' + FModel.NomedaTabela)
  else
    FView.DBGridPrincipal.DataSource := TConexao.GetInstancia.CriaDataSource('SELECT * FROM ' + FModel.NomedaTabela + ' WHERE ' + Filter);

  FView.PageControlPrincipal.OnChanging := PageControlChanging;

  Status := stNavegacao;
end;

procedure TControllerBase<FrmCadastro, Persistencia>.ExcluirClick(
  Sender: TObject);
var Erro: string;
begin
  Model.Carregar(View.DBGridPrincipal.DataSource.DataSet.FieldByName(Model.NomeCampoChavePrimaria).AsInteger);
  if Model.Excluir(Erro) then
    ShowMessage('Registro excluído com sucesso!')
  else
    ShowMessage('Erro: ' + Erro);


  View.DBGridPrincipal.DataSource.DataSet.Refresh;
  Status := stNavegacao;
end;

function TControllerBase<FrmCadastro, Persistencia>.GetStatus: TStatus;
begin
  Result := FStatus;
end;

procedure TControllerBase<FrmCadastro, Persistencia>.InserirClick(
  Sender: TObject);
begin
  FModel.Clear;
  AlimentaView;
  FView.PageControlPrincipal.ActivePage := FView.TSDados;
  Status := stInsercao;

end;

procedure TControllerBase<FrmCadastro, Persistencia>.SalvarClick(
  Sender: TObject);
var Erro: String;
begin
  AlimentaModel;

  if Status = stEdicao then
  begin
    if Model.Alterar(Erro) then
      ShowMessage('Registro Alterado com sucesso!!')
    else
      ShowMessage('Erro: ' + Erro);
  end
  else if Status = stInsercao then
  begin
    if Model.Inserir(Erro) then
      ShowMessage('Registro Incluido com sucesso!!')
    else
      ShowMessage('Erro: ' + Erro);
  end;
  inherited;

  View.DBGridPrincipal.DataSource.DataSet.Refresh;
  View.PageControlPrincipal.ActivePage := View.TSLista;

  Status := stNavegacao;

  if Assigned(FOnAfterPost) then
    FOnAfterPost(Self);
end;

procedure TControllerBase<FrmCadastro, Persistencia>.SetStatus(
  const Value: TStatus);
begin
  FStatus := Value;

  View.BtnInserir.Enabled := Status = stNavegacao;
  View.BtnAlterar.Enabled := Status = stNavegacao;
  View.BtnExcluir.Enabled := Status = stNavegacao;

  View.BtnSalvar.Enabled   := Status <> stNavegacao;
  View.BtnCancelar.Enabled := Status <> stNavegacao;

  if Status = stNavegacao then
    View.PageControlPrincipal.ActivePage := View.TSLista
  else
    View.PageControlPrincipal.ActivePage := View.TSDados;

end;

function TControllerBase<FrmCadastro, Persistencia>.ShowModal: TModalResult;
begin
  Result := FView.ShowModal;
end;

end.
