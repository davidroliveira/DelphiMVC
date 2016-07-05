unit View.Cadastro.Abastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Base, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmAbastecimento = class(TFrmCadastroBase)
    EdtCodigo: TEdit;
    Label1: TLabel;
    Label6: TLabel;
    EdtQuantidade: TEdit;
    EdtPreco: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    EdtTotal: TEdit;
    Label5: TLabel;
    EdtData: TDateTimePicker;
    EdtHora: TDateTimePicker;
    Label2: TLabel;
    EdtValorImposto: TEdit;
    Label7: TLabel;
    EdtBomba: TEdit;
    Label8: TLabel;
    EdtCombustivel: TEdit;
    Label9: TLabel;
    EdtPercentualImposto: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
