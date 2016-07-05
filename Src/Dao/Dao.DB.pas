unit Dao.DB;

interface

uses
  Data.DB, System.SysUtils, Vcl.Forms,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client,

  FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TConexao = class
  strict private
    FConexao: TFDConnection;
    class var FInstancia: TConexao;
    constructor CreatePrivate;
  public
    constructor Create;
    class function GetInstancia: TConexao;
    property Conexao: TFDConnection read FConexao write FConexao;
    function ExecuteSQL(ASQL: string; var Erro: string): Boolean;
    function CriaDataSource(ASQL: string): TDataSource;
    function CriaQuery(ASQL: string): TFDQuery;
    procedure IniciaTransacao;
    procedure RollbackTransacao;
    procedure CommitaTransacao;
    function Open(var Erro: string): Boolean;
  end;


implementation

{ TConexao }

procedure TConexao.IniciaTransacao;
begin
  FConexao.StartTransaction;
end;

procedure TConexao.CommitaTransacao;
begin
  FConexao.Commit;
end;

constructor TConexao.Create;
begin
  raise Exception.Create('só uma conexão permitida');
end;

constructor TConexao.CreatePrivate;
var
  Erro: string;
begin
  inherited Create;
  FConexao := TFDConnection.Create(nil);
  if not Open(Erro) then
    raise Exception.Create(Erro);
end;

function TConexao.CriaDataSource(ASQL: string): TDataSource;
begin
  try
    Result := TDataSource.Create(nil);
    Result.DataSet := CriaQuery(ASQL);

    if not Assigned(Result.DataSet) then
    begin
      if Assigned(Result) then
        Result.Free;
      Result := nil;
    end;
  except
    if Assigned(Result) then
      Result.Free;
    Result := nil;
  end;

end;

function TConexao.CriaQuery(ASQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  try
    Result.Connection := FConexao;
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Text := ASQL;
    Result.Open;
  except on E: Exception do
    begin
      if Assigned(Result) then
        Result.Free;

      Result := nil;
    end;
  end;
end;

function TConexao.ExecuteSQL(ASQL: string; var Erro: string): Boolean;
begin
  Result := True;
  try
    FConexao.ExecSQL(ASQL);
  except
    on E: Exception do
       begin
         Erro := E.Message;
         Result := False;
       end;
  end;
end;

class function TConexao.GetInstancia: TConexao;
begin
  if not Assigned(FInstancia) then
    FInstancia := TConexao.CreatePrivate;
  Result := FInstancia;
end;

function TConexao.Open(var Erro: string): Boolean;
begin
  Result := False;

  try
    FConexao.Connected := False;

    FConexao.Params.Clear;
    FConexao.Params.Add('Database=' + ExtractFileDir(Application.ExeName) + '\DB\FORTES.FDB');

    FConexao.Params.Add('User_Name=sysdba');
    FConexao.Params.Add('Password=masterkey');

    FConexao.Params.Add('Server=127.0.0.1');

    FConexao.Params.Add('CharacterSet=WIN1252');
    FConexao.Params.Add('DriverID=FB');

    FConexao.Connected := True;
    Result := FConexao.Connected
  except
    on E: Exception do
       begin
         Result := False;
         Erro := E.Message;
       end;
  end;

end;

procedure TConexao.RollbackTransacao;
begin
  FConexao.Rollback;
end;

end.
