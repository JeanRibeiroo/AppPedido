unit ServerApp.Model.Pedido.Command.NewPedido;



interface

uses
  System.Command.Interfaces,
  ServerApp.Model.Pedido.Pedido;



Type

  TModelCommnadNewPedido = class(TInterfacedObject, ICommand)
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



{ TModelCommnadNewPedido }

constructor TModelCommnadNewPedido.Create(aValue: IModelPedido);
begin
  FModel := aValue;
end;

destructor TModelCommnadNewPedido.Destroy;
begin

  inherited;
end;

function TModelCommnadNewPedido.Execute: ICommand;
var lParams: TDictionary<string, string>;
begin
  Result := Self;
  FModel.Insert;
end;

class function TModelCommnadNewPedido.New(aValue: IModelPedido): ICommand;
begin
  Result := Self.Create(aValue);
end;

end.


