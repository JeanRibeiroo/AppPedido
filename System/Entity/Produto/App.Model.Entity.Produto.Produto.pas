unit App.Model.Entity.Produto.Produto;

interface

Type

   IEntityProduto = Interface
     ['{64F82ADB-15EE-48FE-A35B-C38CDD19019B}']
     function Codigo(aValue: Integer): IEntityProduto; overload;
     function Codigo: Integer; overload;
     function Descricao(aValue: string): IEntityProduto; overload;
     function Descricao: string; overload;
     function PrecoVenda(aValue: Currency): IEntityProduto; overload;
     function PrecoVenda: Currency; overload;
   End;

   TEntityProduto = class(TInterfacedObject, IEntityProduto)
     private
        FCodigo: Integer;
        FDescricao: string;
        FPrecoVenda: Currency;
     public
       constructor Create;
       destructor Destroy; override;
       class function New: TEntityProduto;
       function Codigo(aValue: Integer): IEntityProduto; overload;
       function Codigo: Integer; overload;
       function Descricao(aValue: string): IEntityProduto; overload;
       function Descricao: string; overload;
       function PrecoVenda(aValue: Currency): IEntityProduto; overload;
       function PrecoVenda: Currency; overload;
   end;

implementation

{ TEntityProduto }

function TEntityProduto.Codigo(aValue: Integer): IEntityProduto;
begin
  Result := Self;
  FCodigo := aValue;
end;

function TEntityProduto.Codigo: Integer;
begin
  Result := FCodigo;
end;

constructor TEntityProduto.Create;
begin

end;

function TEntityProduto.Descricao: string;
begin
  Result := FDescricao;
end;

function TEntityProduto.Descricao(aValue: string): IEntityProduto;
begin
  Result := Self;
  FDescricao := aValue;
end;

destructor TEntityProduto.Destroy;
begin

  inherited;
end;

class function TEntityProduto.New: TEntityProduto;
begin
  Result := Self.Create;
end;

function TEntityProduto.PrecoVenda(aValue: Currency): IEntityProduto;
begin
  Result := Self;
  FPrecoVenda := aValue;
end;

function TEntityProduto.PrecoVenda: Currency;
begin
  Result := FPrecoVenda;
end;

end.
