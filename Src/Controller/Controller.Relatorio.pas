unit Controller.Relatorio;

interface

uses
  Vcl.Forms, System.SysUtils, Data.DB, System.Classes,

  IBX.IBDatabase,

  frxClass, frxIBXComponents, frxDCtrl, frxDesgn;

type
  TModeloRelatorio = class abstract
  protected
    FArquivo: string;
  published
    property Arquivo: string read FArquivo;
  public
    constructor Create; virtual; abstract;
  end;

  TModeloRelatorioAbastecimento = class(TModeloRelatorio)
  public
    constructor Create; override;
  end;

  TRelatorio = class
  strict private
    FModeloRelatorio: TModeloRelatorio;
    FDataModule: TDataModule;
    FfrxReport: TfrxReport;
    FfrxIBXComponents: TfrxIBXComponents;
    FIBDatabase: TIBDatabase;
    FIBTransaction : TIBTransaction;
    FfrxDialogControls: TfrxDialogControls;
    FfrxDesigner: TfrxDesigner;
    function frxDesignerSaveReport(Report: TfrxReport;
      SaveAs: Boolean): Boolean;
  public
    procedure ShowReport;
    procedure DesignReport;
    constructor Create(AModeloRelatorio: TModeloRelatorio);
    destructor Destroy;
  end;


implementation

{ TModeloRelatorioAbastecimento }

constructor TModeloRelatorioAbastecimento.Create;
begin
  FArquivo := ExtractFileDir(Application.ExeName) + '\RelatorioAbastecimento.fr3';
end;

{ TRelatorio }

constructor TRelatorio.Create(AModeloRelatorio: TModeloRelatorio);
begin
  inherited Create;
  FModeloRelatorio := AModeloRelatorio;
  FDataModule := TDataModule.Create(Application);

  FIBTransaction := TIBTransaction.Create(FDataModule);
  FIBTransaction.Params.Clear;
  FIBTransaction.Params.Add('read_committed');
  FIBTransaction.Params.Add('rec_version');
  FIBTransaction.Params.Add('nowait');

  FIBDatabase := TIBDatabase.Create(FDataModule);
  FIBDatabase.DatabaseName := '127.0.0.1:' + ExtractFileDir(Application.ExeName) + '\DB\FORTES.FDB';
  FIBDatabase.Params.Clear;
  FIBDatabase.Params.Add('user_name=sysdba');
  FIBDatabase.Params.Add('password=masterkey');
  FIBDatabase.Params.Add('lc_ctype=WIN1252');
  FIBDatabase.LoginPrompt := False;
  FIBDatabase.DefaultTransaction := FIBTransaction;
  FIBTransaction.DefaultDatabase := FIBDatabase;
  FIBDatabase.Open;

  FfrxDesigner := TfrxDesigner.Create(FDataModule);
  FfrxDesigner.OnSaveReport := frxDesignerSaveReport;

  FfrxDialogControls := TfrxDialogControls.Create(FDataModule);

  FfrxIBXComponents := TfrxIBXComponents.Create(FDataModule);
  FfrxIBXComponents.DefaultDatabase := FIBDatabase;

  FfrxReport := TfrxReport.Create(FDataModule);
  FfrxReport.LoadFromFile(AModeloRelatorio.Arquivo);

end;

procedure TRelatorio.DesignReport;
begin
  FfrxReport.DesignReport;
end;

destructor TRelatorio.Destroy;
begin
  FreeAndNil(FfrxIBXComponents);
  FreeAndNil(FfrxDialogControls);
  FreeAndNil(FIBDatabase);
  FreeAndNil(FfrxReport);
  FreeAndNil(FDataModule);
  inherited Destroy;
end;

function TRelatorio.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
begin
  SaveAs := False;
  FfrxReport.SaveToFile(FModeloRelatorio.Arquivo);
end;

procedure TRelatorio.ShowReport;
begin
  FfrxReport.ShowReport;
end;

end.
