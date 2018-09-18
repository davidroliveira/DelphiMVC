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
    FChavePrimaria: Boolean;
  public
    property Nome: string read FNome write FNome;
    property ChavePrimaria: Boolean read FChavePrimaria write FChavePrimaria;
    constructor Create(ANome: string; AChavePrimaria: Boolean = False);
  end;

implementation

constructor Tabela.Create(const ANome: string);
begin
  FNome := ANome;
end;

constructor Campo.Create(ANome: string; AChavePrimaria: Boolean = False);
begin
  FNome := ANome;
  FChavePrimaria := AChavePrimaria;
end;

end.
