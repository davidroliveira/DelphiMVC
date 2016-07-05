unit View.Cadastro.Bomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Base, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.DBCtrls;

type
  TFrmBomba = class(TFrmCadastroBase)
    EdtCodigo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LkpTanque: TDBLookupComboBox;
    EdtFabricante: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    EdtModelo: TEdit;
    Label5: TLabel;
    EdtSerie: TEdit;
    Label6: TLabel;
    EdtNumero: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
