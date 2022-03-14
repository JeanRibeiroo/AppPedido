unit ServerApp.Model.Pedido.Command.NewPedidoProduto;



interface

uses
  System.Command.Interfaces,
  ServerApp.Model.Pedido.Pedido;



Type

  TModelCommnadNewPedidoProduto = class(TInterfacedObject, ICommand)
    private
      [weak]
      FModel: IModelPedido;
    public
      constructor Create(aValue: IModelPedido);
      destructor Destroy; override;
      class function New(aValue: IModelPedido): ICommand;
      function Execute : ICommand;
  end;

implementation

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  ServidorAPI.Model.Exception,
  ServerApp.Model.Pedido.PedidoProduto;



{ TModelCommnadNewPedidoProduto }

constructor TModelCommnadNewPedidoProduto.Create(aValue: IModelPedido);
begin
  FModel := aValue;
end;

destructor TModelCommnadNewPedidoProduto.Destroy;
begin

  inherited;
end;

function TModelCommnadNewPedidoProduto.Execute: ICommand;
var lParams: TDictionary<string, string>;
begin
  Result := Self;
  FModel.Entity.ListPedidoProduto.Firt;
  while FModel.Entity.ListPedidoProduto.HasNext do
  begin
    FModel.Entity.ListPedidoProduto.Itens.NumeroPedido(FModel.Entity.NumeroPedido);
    TModelPedidoProduto.New(FModel.DataSet)
      .Entity(FModel.Entity.ListPedidoProduto.Itens)
      .Insert;
    FModel.Entity.ListPedidoProduto.Next;
  end;
end;

class function TModelCommnadNewPedidoProduto.New(aValue: IModelPedido): ICommand;
begin
  Result := Self.Create(aValue);
end;

end.



