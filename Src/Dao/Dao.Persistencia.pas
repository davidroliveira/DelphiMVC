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

    function Inserir: Boolean;
    function Alterar: Boolean;
    function Excluir: Boolean;

    function Carregar(const AValor: Int64): Boolean; overload; virtual; abstract;
    function Carregar: Boolean; overload;

    procedure Clear;

  end;

implementation

function TPersistencia.Alterar: Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ANomeTabela, ACampo, ASql, AWhere: string;
  Parametros, ParametrosPK: array of TParametroQuery;
  Parametro, ParametroPK: TParametroQuery;
  QueryTmp: TFDQuery;
begin
  Result := False;
  ACampo := NullAsStringValue;
  setLength(Parametros,0);
  setLength(ParametrosPK,0);
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      if AAtributo is Tabela then
      begin
        ANomeTabela := Tabela(AAtributo).Nome;
        Break;
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
          ACampo := ACampo + '       ' + Campo(AAtributo).Nome + ',' + sLineBreak;
          if APropriedade.GetValue(Self).AsVariant <> Null then
          begin
            if (Campo(AAtributo).ChavePrimaria) then
            begin
              SetLength(ParametrosPK, Length(ParametrosPK)+1);
              ParametrosPK[high(ParametrosPK)].Name := Campo(AAtributo).Nome;
              ParametrosPK[high(ParametrosPK)].Value := APropriedade.GetValue(Self).AsVariant;
            end
            else
            begin
              SetLength(Parametros, Length(Parametros)+1);
              Parametros[high(Parametros)].Name := Campo(AAtributo).Nome;
              Parametros[high(Parametros)].Value := APropriedade.GetValue(Self).AsVariant;
            end;
          end
        end;
      end;
    end;
    AWhere := NullAsStringValue;
    for ParametroPK in ParametrosPK do
    begin
      if AWhere = NullAsStringValue then
        AWhere := AWhere + 'WHERE '
      else
        AWhere := AWhere + '  AND ';
      AWhere := AWhere + '(' + ParametroPK.Name + ' = :' + ParametroPK.Name + ')';
    end;
      
    ACampo := Trim(ACampo);
    ACampo := Copy(ACampo, 1, ACampo.Length - 1);
    ASql :=
      'SELECT ' + ACampo + sLineBreak +
      '  FROM ' + ANomeTabela + sLineBreak +
      ' ' + AWhere;
    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql, ParametrosPK);
    try
      QueryTmp.Edit;
      for Parametro in Parametros do
        QueryTmp.FieldByName(Parametro.Name).Value := Parametro.Value;
      QueryTmp.Post;
      for APropriedade in ATipo.GetProperties do
      begin
        Application.ProcessMessages;
        for AAtributo in APropriedade.GetAttributes do
        begin
          Application.ProcessMessages;
          if (AAtributo is Campo) then
            APropriedade.SetValue(Self, Tvalue.FromVariant(QueryTmp.FieldByName(Campo(AAtributo).Nome).Value));
        end;
      end;
      QueryTmp.Close;
      Result := True;
    finally
      FreeAndNil(QueryTmp);
    end;
  finally
    AContexto.Free;
  end;
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
  QueryTmp := nil;
  try
    ATipo := AContexto.GetType(ClassType);
//    for AAtributo in ATipo.GetAttributes do
//    begin
//      Application.ProcessMessages;
//      if AAtributo is Tabela then
//        ASql := 'SELECT * FROM ' + Tabela(AAtributo).Nome;
//    end;
//
//    for APropriedade in ATipo.GetProperties do
//    begin
//      Application.ProcessMessages;
//      for AAtributo in APropriedade.GetAttributes do
//      begin
//        Application.ProcessMessages;
//        if AAtributo is Campo then
//        begin
//          if Campo(AAtributo).ChavePrimaria then
//            AWhere := '(' + Campo(AAtributo).Nome + ' = ' + GetValue(APropriedade) + ')'
//        end;
//      end;
//    end;
//
//    ASql := ASql + ' WHERE ' + AWhere;
//
//    if Trim(FSQL) <> NullAsStringValue then
//      ASQL := FSQL;
//
//    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql);
//    Result := Assigned(QueryTmp) and (QueryTmp.RecordCount > 0);
//
//    for APropriedade in ATipo.GetProperties do
//    begin
//      Application.ProcessMessages;
//      for AAtributo in APropriedade.GetAttributes do
//      begin
//        if AAtributo is Campo then
//        begin
//          if Assigned(QueryTmp.FindField(Campo(AAtributo).Nome)) then
//          begin
//            if QueryTmp.IsEmpty then
//              SetValue(APropriedade, Null)
//            else
//              SetValue(APropriedade, QueryTmp.FieldByName(Campo(AAtributo).Nome).Value);
//          end;
//        end;
//      end;
//    end;
  finally
    QueryTmp.Free;
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
  QueryTmp := nil;
  try
    ATipo := AContexto.GetType(ClassType);
//    for AAtributo in ATipo.GetAttributes do
//    begin
//      Application.ProcessMessages;
//      if AAtributo is Tabela then
//        ASql := 'SELECT * FROM ' + Tabela(AAtributo).Nome;
//    end;
//
//    ASql := ASql + ' WHERE ' + AWhere;
//
//    if Trim(FSQL) <> NullAsStringValue then
//      ASQL := FSQL;
//
//    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql);
//
//    for APropriedade in ATipo.GetProperties do
//    begin
//      Application.ProcessMessages;
//      for AAtributo in APropriedade.GetAttributes do
//      begin
//        if AAtributo is Campo then
//        begin
//          if Assigned(QueryTmp.FindField(Campo(AAtributo).Nome)) then
//            SetValue(APropriedade, Null)
//        end;
//      end;
//    end;
  finally
    QueryTmp.Free;
    AContexto.Free;
  end;
end;

function TPersistencia.Excluir: Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ANomeTabela, ACampo, AWhere, ASql: string;
  ParametrosPK: array of TParametroQuery;
  ParametroPK: TParametroQuery;
  QueryTmp: TFDQuery;
begin
  Result := False;
  setLength(ParametrosPK,0);
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);

    for AAtributo in ATipo.GetAttributes do
    begin
      if AAtributo is Tabela then
      begin
        ANomeTabela := Tabela(AAtributo).Nome;
        Break;
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
          if APropriedade.GetValue(Self).AsVariant <> Null then
          begin
            if (Campo(AAtributo).ChavePrimaria) then
            begin
              ACampo := ACampo + '       ' + Campo(AAtributo).Nome + ',' + sLineBreak;
              SetLength(ParametrosPK, Length(ParametrosPK)+1);
              ParametrosPK[high(ParametrosPK)].Name := Campo(AAtributo).Nome;
              ParametrosPK[high(ParametrosPK)].Value := APropriedade.GetValue(Self).AsVariant;
            end
          end
        end;
      end;
    end;
    AWhere := NullAsStringValue;
    for ParametroPK in ParametrosPK do
    begin
      if AWhere = NullAsStringValue then
        AWhere := AWhere + 'WHERE '
      else
        AWhere := AWhere + '  AND ';
      AWhere := AWhere + '(' + ParametroPK.Name + ' = :' + ParametroPK.Name + ')';
    end;

    ACampo := Trim(ACampo);
    ACampo := Copy(ACampo, 1, ACampo.Length - 1);
    ASql :=
      'SELECT ' + ACampo + sLineBreak +
      '  FROM ' + ANomeTabela + sLineBreak +
      ' ' + AWhere;
    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql, ParametrosPK);
    try
      QueryTmp.Delete;
      for APropriedade in ATipo.GetProperties do
      begin
        Application.ProcessMessages;
        for AAtributo in APropriedade.GetAttributes do
        begin
          Application.ProcessMessages;
          if (AAtributo is Campo) then
            APropriedade.SetValue(Self, Tvalue.FromVariant(Null));
        end;
      end;
      QueryTmp.Close;
      Result := True;
    finally
      FreeAndNil(QueryTmp);
    end;
  finally
    AContexto.Free;
  end;
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

function TPersistencia.Inserir: Boolean;
var
  AContexto: TRttiContext;
  ATipo: TRttiType;
  APropriedade: TRttiProperty;
  AAtributo: TCustomAttribute;
  ANomeTabela, ACampo, ASql: string;
  Parametros: array of TParametroQuery;
  Parametro: TParametroQuery;
  QueryTmp: TFDQuery;
begin
  Result := False;
  ACampo := NullAsStringValue;
  setLength(Parametros,0);
  AContexto := TRttiContext.Create;
  try
    ATipo := AContexto.GetType(ClassType);
    for AAtributo in ATipo.GetAttributes do
    begin
      if AAtributo is Tabela then
      begin
        ANomeTabela := Tabela(AAtributo).Nome;
        Break;
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
          ACampo := ACampo + '       ' + Campo(AAtributo).Nome + ',' + sLineBreak;
          if APropriedade.GetValue(Self).AsVariant <> Null then
          begin
            if not (Campo(AAtributo).ChavePrimaria) then
            begin
              SetLength(Parametros, Length(Parametros)+1);
              Parametros[high(Parametros)].Name := Campo(AAtributo).Nome;
              Parametros[high(Parametros)].Value := APropriedade.GetValue(Self).AsVariant;
            end;
          end
        end;
      end;
    end;

    ACampo := Trim(ACampo);
    ACampo := Copy(ACampo, 1, ACampo.Length - 1);
    ASql :=
      'SELECT ' + ACampo + sLineBreak +
      '  FROM ' + ANomeTabela + sLineBreak +
      ' WHERE 1=2';
    QueryTmp := TConexao.GetInstancia.CriaQuery(ASql, []);
    try
      QueryTmp.Insert;
      for Parametro in Parametros do
        QueryTmp.FieldByName(Parametro.Name).Value := Parametro.Value;
      QueryTmp.Post;
      for APropriedade in ATipo.GetProperties do
      begin
        Application.ProcessMessages;
        for AAtributo in APropriedade.GetAttributes do
        begin
          Application.ProcessMessages;
          if (AAtributo is Campo) then
            APropriedade.SetValue(Self, Tvalue.FromVariant(QueryTmp.FieldByName(Campo(AAtributo).Nome).Value));
        end;
      end;
      QueryTmp.Close;
      Result := True;
    finally
      FreeAndNil(QueryTmp);
    end;
  finally
    AContexto.Free;
  end;
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
