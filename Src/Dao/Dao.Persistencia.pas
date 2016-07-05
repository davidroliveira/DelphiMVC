unit Dao.Persistencia;

interface

uses
  Rtti, StrUtils, System.Variants, Classes, System.SysUtils, Vcl.Forms,
  System.TypInfo,

  Dao.DB, Dao.Atributo,

  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.DApt;

type
  TPersistencia = class
  strict private
    FSQL: string;
    function GetValue(const APropriedade: TRttiProperty): String;
    procedure SetValue(APropriedade: TRttiProperty; AValor: Variant);
    function GetNomedaTabela: string;
    function GetCampoChavePrimaria: string;
  public
    property SQL: string read FSQL write FSQL;
    property NomedaTabela: string read GetNomedaTabela;
    property NomeCampoChavePrimaria: string read GetCampoChavePrimaria;

    function Inserir(out Erro: string): Boolean;
    function Alterar(out Erro: string): Boolean;
    function Excluir(out Erro: string): Boolean;

    function Carregar(const AValor: Int64): Boolean; overload; virtual; abstract;
    function Carregar: Boolean; overload;

    procedure Clear;

  end;

implementation

{ TPersistencia }

function TPersistencia.Alterar(out Erro: string): Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ASql, ACampo, AWhere, AErro: string;
begin
  AWhere := NullAsStringValue;
  ACampo := NullAsStringValue;
  Result := True;
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);

    for AAtributo in ATipo.GetAttributes do
    begin
      Application.ProcessMessages;
      if AAtributo is Tabela then
        ASql := 'UPDATE ' + Tabela(AAtributo).Nome + ' SET ';
    end;

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        Application.ProcessMessages;
        if AAtributo is Campo then
        begin
          if (not Campo(AAtributo).AutoIncrementa) and (not Campo(AAtributo).ChavePrimaria) then
            ACampo := ACampo + Campo(AAtributo).Nome + ' = ' + GetValue(APropriedade) + ','
          else if Campo(AAtributo).ChavePrimaria then
          begin
            if AWhere = NullAsStringValue then
              AWhere := '(' + Campo(AAtributo).Nome + ' = ' + GetValue(APropriedade) + ')'
            else
              AWhere := AWhere + ' AND (' + Campo(AAtributo).Nome + ')';
          end;
        end;
      end;
    end;

    ACampo := Copy(ACampo, 1, ACampo.Length - 1);
    ASql := ASql + ACampo + ' WHERE ' + AWhere;

    if Trim(FSQL) <> NullAsStringValue then
      ASql := FSQL;

    Result := TConexao.GetInstancia.ExecuteSQL(ASql, AErro);

    if not result then
      raise Exception.Create(AErro);

  finally
    SQL := NullAsStringValue;
    AContexto.Free;
  end;
  Erro := AErro;
end;

function TPersistencia.Carregar: Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ASql, AWhere: string;
  QueryTmp: TFDQuery;
begin
  AWhere := NullAsStringValue;
  Result := True;
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      Application.ProcessMessages;
      if AAtributo is Tabela then
        ASql := 'SELECT * FROM ' + Tabela(AAtributo).Nome;
    end;

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        Application.ProcessMessages;
        if AAtributo is Campo then
        begin
          if Campo(AAtributo).ChavePrimaria then
            AWhere := '(' + Campo(AAtributo).Nome + ' = ' + GetValue(APropriedade) + ')'
        end;
      end;
    end;

    ASql := ASql + ' WHERE ' + AWhere;

    if Trim(FSQL) <> NullAsStringValue then
      ASQL := FSQL;

    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql);
    Result := Assigned(QueryTmp) and (QueryTmp.RecordCount > 0);

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        if AAtributo is Campo then
        begin
          if Assigned(QueryTmp.FindField(Campo(AAtributo).Nome)) then
          begin
            if QueryTmp.IsEmpty then
              SetValue(APropriedade, Null)
            else
              SetValue(APropriedade, QueryTmp.FieldByName(Campo(AAtributo).Nome).Value);
          end;
        end;
      end;
    end;

  finally
    if Assigned(QueryTmp) then
      QueryTmp.Free;

    SQL := NullAsStringValue;
    AContexto.Free;
  end;
end;

procedure TPersistencia.Clear;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ASql, AWhere: string;
  QueryTmp: TFDQuery;
begin
  AWhere := ' 1=2 ';
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      Application.ProcessMessages;
      if AAtributo is Tabela then
        ASql := 'SELECT * FROM ' + Tabela(AAtributo).Nome;
    end;

    ASql := ASql + ' WHERE ' + AWhere;

    if Trim(FSQL) <> NullAsStringValue then
      ASQL := FSQL;

    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql);

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        if AAtributo is Campo then
        begin
          if Assigned(QueryTmp.FindField(Campo(AAtributo).Nome)) then
            SetValue(APropriedade, Null)
        end;
      end;
    end;

  finally
    if Assigned(QueryTmp) then
      QueryTmp.Free;

    SQL := NullAsStringValue;
    AContexto.Free;
  end;
end;

function TPersistencia.Excluir(out Erro: string): Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ASql, AWhere, AErro: string;
begin
  AWhere := NullAsStringValue;
  Result := True;
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      Application.ProcessMessages;
      if AAtributo is Tabela then
        ASql := 'DELETE FROM ' + Tabela(AAtributo).Nome;
    end;

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        Application.ProcessMessages;
        if AAtributo is Campo then
        begin
          if Campo(AAtributo).ChavePrimaria then
          begin
            if AWhere = NullAsStringValue then
              AWhere := '(' + Campo(AAtributo).Nome + ' = ' + GetValue(APropriedade) + ')'
            else
              AWhere := AWhere + ' AND (' + Campo(AAtributo).Nome + ')';
          end;
        end;
      end;
    end;

    ASql := ASql + ' WHERE ' + AWhere;

    if Trim(FSQL) <> NullAsStringValue then
      ASql := FSQL;

    Result := TConexao.GetInstancia.ExecuteSQL(ASql, AErro);

    if not result then
      raise Exception.Create(AErro);

  finally
    SQL := NullAsStringValue;
    AContexto.Free;
  end;
  Erro := AErro;
end;

function TPersistencia.GetCampoChavePrimaria: string;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
begin
  Result := NullAsStringValue;
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);

    for APropriedade in ATipo.GetProperties do
    begin
      Application.ProcessMessages;
      for AAtributo in APropriedade.GetAttributes do
      begin
        Application.ProcessMessages;
        if AAtributo is Campo then
        begin
          if Campo(AAtributo).ChavePrimaria then
            Result := Campo(AAtributo).Nome;
        end;
      end;
    end;
  finally
    AContexto.Free;
  end;
end;

function TPersistencia.GetNomedaTabela: string;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  AAtributo: TCustomAttribute;
begin
  Result := NullAsStringValue;
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      Application.ProcessMessages;
      if AAtributo is Tabela then
        Result := Tabela(AAtributo).Nome;
    end;
  finally
    AContexto.Free;
  end;

end;

function TPersistencia.GetValue(const APropriedade: TRttiProperty): String;
begin
  case APropriedade.PropertyType.TypeKind of
    tkUnknown: Result := APropriedade.GetValue(Self).ToString;
    tkInteger: Result := APropriedade.GetValue(Self).ToString;
    tkChar: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    tkEnumeration: Result := IntToStr(Integer(APropriedade.GetValue(Self).AsBoolean));
    tkFloat:
      begin
        //if APropriedade.PropertyType.Name = 'TDateTime' then
        if APropriedade.PropertyType.Handle = TypeInfo(TDate) then
          Result := QuotedStr(FormatDateTime('DD.MM.YYYY', APropriedade.GetValue(Self).AsType<TDate>))
        else if APropriedade.PropertyType.Handle = TypeInfo(TTime) then
          Result := QuotedStr(FormatDateTime('HH:NN:SS', APropriedade.GetValue(Self).AsType<TTime>))
        else if APropriedade.PropertyType.Handle = TypeInfo(TDateTime) then
          Result := QuotedStr(FormatDateTime('DD.MM.YYYY HH:NN:SS', APropriedade.GetValue(Self).AsType<TDateTime>))
        else
          Result := StringReplace(FormatFloat('0.00', APropriedade.GetValue(Self).AsCurrency), FormatSettings.DecimalSeparator, '.', [rfReplaceAll, rfIgnoreCase]);
      end;
    tkString: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    //tkSet: ;
    //tkClass: ;
    //tkMethod: ;
    tkWChar: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    tkLString: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    tkWString: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    //tkVariant: ;
    //tkArray: ;
    //tkRecord: ;
    //tkInterface: ;
    tkInt64: Result := APropriedade.GetValue(Self).ToString;
    //tkDynArray: ;
    tkUString: Result := QuotedStr(APropriedade.GetValue(Self).ToString);
    //tkClassRef: ;
    //tkPointer: ;
    //tkProcedure: ;
  end;

  if (Result = '0') then
    Result := 'null';

end;

function TPersistencia.Inserir(out Erro: string): Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ASql, ACampo, AValor, AChave, ANomeTabela, AErro: string;
  QueryTmp: TFDQuery;
begin
  ACampo := NullAsStringValue;
  AValor := NullAsStringValue;

  TConexao.GetInstancia.IniciaTransacao;
  AContexto := TRttiContext.Create;
  try
    try
      ATipo := AContexto.GetType(ClassType);

      for AAtributo in ATipo.GetAttributes do
      begin
        Application.ProcessMessages;
        if AAtributo is Tabela then
        begin
          ASql := 'INSERT INTO ' + Tabela(AAtributo).Nome;
          ANomeTabela := Tabela(AAtributo).Nome;
        end;
      end;

      for APropriedade in ATipo.GetProperties do
      begin
        Application.ProcessMessages;
        for AAtributo in APropriedade.GetAttributes do
        begin
          Application.ProcessMessages;
          if AAtributo is Campo then
          begin
            if not (Campo(AAtributo).AutoIncrementa) then
            begin
              ACampo := ACampo + Campo(AAtributo).Nome + ',';
              AValor := AValor + GetValue(APropriedade) + ',';
            end
            else
              AChave := Campo(AAtributo).Nome;
          end;
        end;
      end;

      ACampo := Copy(ACampo, 1, ACampo.Length - 1);
      AValor := Copy(AValor, 1, AValor.Length - 1);

      ASql := ASql + '(' + ACampo + ') VALUES (' + AValor + ')';

      if Trim(FSQL) <> NullAsStringValue then
        ASql := ASql + SQL;

      Result := TConexao.GetInstancia.ExecuteSQL(ASql, AErro);

      ASql := 'SELECT ' + AChave + ' FROM ' + ANomeTabela + ' ORDER BY ' + AChave + ' DESC';

      QueryTmp := TConexao.GetInstancia.CriaQuery(ASql);
      QueryTmp.FetchAll;

      for APropriedade in ATipo.GetProperties do
      begin
        Application.ProcessMessages;
        for AAtributo in APropriedade.GetAttributes do
        begin
          Application.ProcessMessages;
          if (AAtributo is Campo) and (Campo(AAtributo).AutoIncrementa) then
            APropriedade.SetValue(Self, tvalue.FromVariant(QueryTmp.Fields[0].AsInteger));
        end;
      end;

    //except on E: Exception do
    finally
      ASql := NullAsStringValue;
      TConexao.GetInstancia.CommitaTransacao;
      AContexto.Free;
    end;
  except
    TConexao.GetInstancia.RollbackTransacao;
    Raise;
  end;
  Erro := AErro;
end;

procedure TPersistencia.SetValue(APropriedade: TRttiProperty; AValor: Variant);
var
  Valor: TValue;
  TipoVariavel: Word;
begin
  TipoVariavel := VarType(AValor);

  case TipoVariavel of
    varInteger: Valor := StrToInt(Avalor);
    varInt64: Valor := StrToInt64(Avalor);
    271 : Valor := VarToDateTime(AValor); //DateTimeToStr(Avalor)
    else
    begin
      APropriedade.SetValue(Self, Tvalue.FromVariant(AValor));
      Exit;
    end;
  end;

  APropriedade.SetValue(Self, Valor);

end;

end.
