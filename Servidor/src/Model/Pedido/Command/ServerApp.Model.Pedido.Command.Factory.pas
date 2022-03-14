unit ServerApp.Model.Pedido.Command.Factory;



interface

uses
  ServerApp.Model.Pedido.Pedido, System.Command.Interfaces;



Type

  TModelPedidoCommandFactory = class(TInterfacedObject, IModelPedidoCommandFactory)
    private
      [weak]
      FModel: IModelPedido;
    public
      constructor  Create(aValue: IModelPedido);
      destructor Destroy; override;
      class function New(aValue: IModelPedido): IModelPedidoCommandFactory;
      function GetNumeroPedido: ICommand;
      function NewPedido: ICommand;
      function NewPedidoProduto: ICommand;
  end;



implementation

uses
  ServerApp.Model.Pedido.Command.GetNumeroPedido,
  ServerApp.Model.Pedido.Command.NewPedido,
  ServerApp.Model.Pedido.Command.NewPedidoProduto;



{ TModelPedidoCommandFactory }




{ TModelPedidoCommandFactory }

constructor TModelPedidoCommandFactory.Create(aValue: IModelPedido);
begin
  FModel := aValue;
end;

destructor TModelPedidoCommandFactory.Destroy;
begin

  inherited;
end;

function TModelPedidoCommandFactory.GetNumeroPedido: ICommand;
begin
  Result := TModelCommnadGetnumeroPedido.New(FModel);
end;

class function TModelPedidoCommandFactory.New(
  aValue: IModelPedido): IModelPedidoCommandFactory;
begin
  Result := Self.Create(aValue);
end;

function TModelPedidoCommandFactory.NewPedido: ICommand;
begin
  Result := TModelCommnadNewPedido.New(FModel);
end;

function TModelPedidoCommandFactory.NewPedidoProduto: ICommand;
begin
  Result := TModelCommnadNewPedidoProduto.New(FModel);
end;

end.
