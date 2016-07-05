unit View.Cadastro.Tanque;

interface


uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Base, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls,
  Vcl.Samples.Spin;

type
  TFrmTanque = class(TFrmCadastroBase)
    Label4: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    EdtCodigo: TEdit;
    LkpCombustivel: TDBLookupComboBox;
    EdtCapacidade: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
