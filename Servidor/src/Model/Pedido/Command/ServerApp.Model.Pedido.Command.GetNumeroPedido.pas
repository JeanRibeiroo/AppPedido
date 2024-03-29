unit ServerApp.Model.Pedido.Command.GetNumeroPedido;



interface

uses
  System.Command.Interfaces,
  ServerApp.Model.Pedido.Pedido;



Type

  TModelCommnadGetnumeroPedido = class(TInterfacedObject, ICommand)
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
  ServidorAPI.Model.Exception;



{ TModelCommnadGetnumeroPedido }

constructor TModelCommnadGetnumeroPedido.Create(aValue: IModelPedido);
begin
  FModel := aValue;
end;

destructor TModelCommnadGetnumeroPedido.Destroy;
begin

  inherited;
end;

function TModelCommnadGetnumeroPedido.Execute: ICommand;
var lParams: TDictionary<string, string>;
begin
  Result := Self;
  try
    FModel.Entity.NumeroPedido(TModelPedido.New(FModel.DataSet).MaxValueId)
  Except
    On E:EEmpytQuery do
    begin
      FModel.Entity.NumeroPedido(1);
      Exit;
    end;
    on E: Exception do
      Raise;
  end;
end;

class function TModelCommnadGetnumeroPedido.New(aValue: IModelPedido): ICommand;
begin
  Result := Self.Create(aValue);
end;

end.

