unit Dao.Atributo;

interface

type
  Tabela = class(TCustomAttribute)
  strict private
    FNome: string;
  public
    property Nome: string read FNome write FNome;
    constructor Create(const ANome: string);
  end;

  Campo = class(TCustomAttribute)
  strict private
    FNome: string;
    FAutoIncrementa: Boolean;
    FChavePrimaria: Boolean;
  public
    property Nome: string read FNome write FNome;
    property ChavePrimaria: Boolean read FChavePrimaria write FChavePrimaria;
    property AutoIncrementa: Boolean read FAutoIncrementa write FAutoIncrementa;
    constructor Create(ANome: string; AChavePrimaria: Boolean = False;
      AAutoIncrementa: Boolean = False);
  end;

implementation

{ Tabela }

constructor Tabela.Create(const ANome: string);
begin
  FNome := ANome;
end;

{ Campo }

constructor Campo.Create(ANome: string; AChavePrimaria: Boolean = False;
  AAutoIncrementa: Boolean = False);
begin
  FNome := ANome;
  FChavePrimaria := AChavePrimaria;
  FAutoIncrementa := AAutoIncrementa;
end;

end.
