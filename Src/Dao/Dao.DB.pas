unit Dao.DB;

interface

uses
  Data.DB, System.SysUtils, Vcl.Forms,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client,

  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.MSSQL,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TParametroQuery = record
    Name: string;
    Value: Variant;
  end;
  TConexao = class
  strict private
    FConexao: TFDConnection;
    class var FInstancia: TConexao;
    constructor CreatePrivate;
  public
    constructor Create;
    class function GetInstancia: TConexao;
    property Conexao: TFDConnection read FConexao write FConexao;
    function ExecuteSQL(const ASQL: string; const Parametros: array of TParametroQuery): Boolean;
    function CriaDataSource(const ASQL: string; const Parametros: array of TParametroQuery): TDataSource;
    function CriaQuery(const ASQL: string; const Parametros: array of TParametroQuery): TFDQuery; overload;
    function Open(var Erro: string): Boolean;
  end;

implementation

uses Lib.SO;

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

function TConexao.CriaDataSource(const ASQL: string; const Parametros: array of TParametroQuery): TDataSource;
begin
  try
    Result := TDataSource.Create(nil);
    Result.DataSet := CriaQuery(ASQL, Parametros);
  finally
    if Assigned(Result) then
    begin
      if not Assigned(Result.DataSet) then
        Result.DataSet.Free;
      Result.Free;
    end;
  end;
end;

function TConexao.CriaQuery(const ASQL: string; const Parametros: array of TParametroQuery): TFDQuery;
var
  I: Integer;
  Parametro: TParametroQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConexao;
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Text := ASQL;
  for Parametro in Parametros do
    Result.Params.ParamByName(Parametro.Name).Value := Parametro.Value;
  Result.Open();
end;

function TConexao.ExecuteSQL(const ASQL: string; const Parametros: array of TParametroQuery): Boolean;
begin
  FConexao.ExecSQL(ASQL);
  Result := True;
end;

class function TConexao.GetInstancia: TConexao;
begin
  if not Assigned(FInstancia) then
    FInstancia := TConexao.CreatePrivate;
  Result := FInstancia;
end;

function TConexao.Open(var Erro: string): Boolean;
begin
  try
    FConexao.Connected := False;
    FConexao.Params.Clear;
    FConexao.Params.LoadFromFile(ChangeFileExt(TLibSO.ApplicationFileName, '.ini'));
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

end.
