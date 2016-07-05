unit View.Cadastro.Combustivel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Cadastro.Base, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmCombustivel = class(TFrmCadastroBase)
    EdtValor: TEdit;
    Label4: TLabel;
    EdtDescricao: TEdit;
    Label2: TLabel;
    Label1: TLabel;
    EdtCodigo: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
