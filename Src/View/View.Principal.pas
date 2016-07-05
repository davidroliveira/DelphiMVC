unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Form.Base, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TFrmMestre)
    BtnCombustivel: TButton;
    BtnTanque: TButton;
    BtnParametros: TButton;
    BtnAbastecimento: TButton;
    BtnBombas: TButton;
    BtnRelatorioAbastecimento: TButton;
    BtnDesignerRelatorioAbastecimento: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
