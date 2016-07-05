unit View.Cadastro.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, View.Form.Base,

  Dao.DB;

type
  TFrmCadastroBase = class(TFrmMestre)
    PageControlPrincipal: TPageControl;
    TSLista: TTabSheet;
    TSDados: TTabSheet;
    PnlBotton: TPanel;
    BtnInserir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    Panel1: TPanel;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    DBGridPrincipal: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
