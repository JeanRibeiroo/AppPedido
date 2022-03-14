unit App.Model.Entity.Cliente.Cliente;

interface

Type

  IEntityCliente = Interface
    ['{D29C2435-CBA1-4225-8F93-7FC5221073E4}']
    function Codigo(aValue: Integer): IEntityCliente; overload;
    function Codigo: Integer; overload;
    function Nome(aValue: string): IEntityCliente; overload;
    function Nome: string; overload;
    function Cidade(aValue: string): IEntityCliente; overload;
    function Cidade: string; overload;
    function UF(aValue: string): IEntityCliente; overload;
    function UF: string; overload;
  End;

  TEntityCliente = class(TInterfacedObject, IEntityCliente)
    private
       FCodigo: Integer;
       FNome: string;
       FCidade: string;
       FUF: string;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IEntityCliente;
      function Codigo(aValue: Integer): IEntityCliente; overload;
      function Codigo: Integer; overload;
      function Nome(aValue: string): IEntityCliente; overload;
      function Nome: string; overload;
      function Cidade(aValue: string): IEntityCliente; overload;
      function Cidade: string; overload;
      function UF(aValue: string): IEntityCliente; overload;
      function UF: string; overload;
  end;

implementation

{ TEntityCliente }

function TEntityCliente.Cidade: string;
begin
  Result := FCidade;
end;

function TEntityCliente.Cidade(aValue: string): IEntityCliente;
begin
  Result := Self;
  FCidade := aValue;
end;

function TEntityCliente.Codigo(aValue: Integer): IEntityCliente;
begin
  Result := Self;
  FCodigo := aValue;
end;

function TEntityCliente.Codigo: Integer;
begin
  Result := FCodigo;
end;

constructor TEntityCliente.Create;
begin

end;

destructor TEntityCliente.Destroy;
begin

  inherited;
end;

class function TEntityCliente.New: IEntityCliente;
begin
  Result := Self.Create;
end;

function TEntityCliente.Nome(aValue: string): IEntityCliente;
begin
  Result := Self;
  FNome := aValue;
end;

function TEntityCliente.Nome: string;
begin
  Result := FNome;
end;

function TEntityCliente.UF: string;
begin
  Result := FUF;
end;

function TEntityCliente.UF(aValue: string): IEntityCliente;
begin
  Result := Self;
  FUF := aValue;
end;

end.

