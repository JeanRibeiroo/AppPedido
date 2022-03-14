unit App.Model.Entity.Pedido.Pedido;

interface

uses
  App.Model.Entity.Pedido.PedidoProdutos,
  App.Model.Entity.Cliente.Cliente,
  System.Iterator.Interfaces;

Type

  IEntityPedido = Interface
    ['{F9B69167-6C33-4762-B186-CA36BE19AEB4}']
    function NumeroPedido(aValue: Integer): IEntityPedido; overload;
    function NumeroPedido: Integer; overload;
    function IdPedidoProduto(aValue: Integer): IEntityPedido; overload;
    function IdPedidoProduto: Integer; overload;
    function DataEmissao(aValue: TDate): IEntityPedido; overload;
    function DataEmissao: TDate; overload;
    function CodigoCliente(aValue: Integer): IEntityPedido; overload;
    function CodigoCliente: Integer; overload;
    function ValorTotal(aValue: Real): IEntityPedido; overload;
    function ValorTotal: Real; overload;
    function Cliente(aValue: IEntityCliente): IEntityPedido; overload;
    function Cliente: IEntityCliente; overload;
    function ListPedidoProduto(aValue: IModelIterator<IEntityPedidoProdutos>): IEntityPedido; overload;
    function ListPedidoProduto: IModelIterator<IEntityPedidoProdutos>; overload;
  End;

  TEntityPedido = class(TInterfacedObject, IEntityPedido)
    private
       FNumeroPedido: Integer;
       FIdPedidoProduto: Integer;
       FDataEmissao: TDate;
       FCodigoCliente: Integer;
       FValorTotal: Real;
       FCliente: IEntityCliente;
       FListPedidoProduto: IModelIterator<IEntityPedidoProdutos>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IEntityPedido;
      function NumeroPedido(aValue: Integer): IEntityPedido; overload;
      function NumeroPedido: Integer; overload;
      function IdPedidoProduto(aValue: Integer): IEntityPedido; overload;
      function IdPedidoProduto: Integer; overload;
      function DataEmissao(aValue: TDate): IEntityPedido; overload;
      function DataEmissao: TDate; overload;
      function CodigoCliente(aValue: Integer): IEntityPedido; overload;
      function CodigoCliente: Integer; overload;
      function ValorTotal(aValue: Real): IEntityPedido; overload;
      function ValorTotal: Real; overload;
      function Cliente(aValue: IEntityCliente): IEntityPedido; overload;
      function Cliente: IEntityCliente; overload;
      function ListPedidoProduto(aValue: IModelIterator<IEntityPedidoProdutos>): IEntityPedido; overload;
      function ListPedidoProduto: IModelIterator<IEntityPedidoProdutos>; overload;
  end;

implementation

uses
  System.Iterator.Iterator;

{ TEntityPedido }

function TEntityPedido.Cliente: IEntityCliente;
begin
  Result := FCliente;
end;

function TEntityPedido.Cliente(aValue: IEntityCliente): IEntityPedido;
begin
  Result := Self;
  FCliente := aValue;
end;

function TEntityPedido.CodigoCliente: Integer;
begin
  Result := FCodigoCliente;
end;

function TEntityPedido.CodigoCliente(aValue: Integer): IEntityPedido;
begin
  Result := Self;
  FCodigoCliente := aValue;
end;

constructor TEntityPedido.Create;
begin
  FCliente := TEntityCliente.New;
  FListPedidoProduto := TModelIterator<IEntityPedidoProdutos>.New;
  FCodigoCliente := 0;
  FNumeroPedido := 0;
end;

function TEntityPedido.DataEmissao(aValue: TDate): IEntityPedido;
begin
  Result := Self;
  FDataEmissao := aValue;
end;

function TEntityPedido.DataEmissao: TDate;
begin
  Result := FDataEmissao;
end;

destructor TEntityPedido.Destroy;
begin

  inherited;
end;

function TEntityPedido.IdPedidoProduto: Integer;
begin
  Result := FIdPedidoProduto;
end;

function TEntityPedido.IdPedidoProduto(aValue: Integer): IEntityPedido;
begin
  Result := Self;
  FIdPedidoProduto := aValue;
end;

function TEntityPedido.ListPedidoProduto: IModelIterator<IEntityPedidoProdutos>;
begin
  Result := FListPedidoProduto;
end;

function TEntityPedido.ListPedidoProduto(
  aValue: IModelIterator<IEntityPedidoProdutos>): IEntityPedido;
begin
  Result := Self;
  FListPedidoProduto := aValue;
end;

class function TEntityPedido.New: IEntityPedido;
begin
  Result := Self.Create;
end;

function TEntityPedido.NumeroPedido: Integer;
begin
  Result := FNumeroPedido;
end;

function TEntityPedido.NumeroPedido(aValue: Integer): IEntityPedido;
begin
  Result := Self;
  FNumeroPedido := aValue;
end;

function TEntityPedido.ValorTotal: Real;
begin
  Result := FValorTotal;
end;

function TEntityPedido.ValorTotal(aValue: Real): IEntityPedido;
begin
  Result := Self;
  FValorTotal := aValue;
end;

end.
