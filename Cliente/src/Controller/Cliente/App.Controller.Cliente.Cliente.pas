unit App.Controller.Cliente.Cliente;

interface

uses
  App.Model.Entity.Cliente.Cliente, System.JSON;

Type

  IControllerCliente = Interface
    ['{DD315C3B-1748-47CE-9945-F82E52BD997D}']
    function Entity(aValue: IEntityCliente): IControllerCliente; overload;
    function Entity: IEntityCliente; overload;
    function Get: IControllerCliente;
  End;

  TControllerCliente = class(TInterfacedObject, IControllerCliente)
    private
      FEntity: IEntityCliente;
      const SYS_API_URL_BASE = 'http://localhost:8080/AppPedidos';
      procedure JsonToEntity(aValue: TJsonObject);
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IControllerCliente;
      function Entity(aValue: IEntityCliente): IControllerCliente; overload;
      function Entity: IEntityCliente; overload;
      function Get: IControllerCliente;
  end;

implementation

uses
  System.DAO.Factory,
  System.SysUtils;

{ TControllerCliente }

constructor TControllerCliente.Create;
begin
  FEntity := TEntityCliente.New;
end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

function TControllerCliente.Entity(aValue: IEntityCliente): IControllerCliente;
begin
  Result := Self;
  FEntity := aValue;
end;

function TControllerCliente.Entity: IEntityCliente;
begin
  Result := FEntity;
end;

function TControllerCliente.Get: IControllerCliente;
begin
  Result := Self;
  try
    var lJsonCliente :=
      TModelDAOFactory.New
         .REST
         .BaseURL(SYS_API_URL_BASE)
         .Resource(Format('/clientes/%d',[FEntity.Codigo]))
         .Accept('application/json')
         .Select
           .ToJsonObject;
    JsonToEntity(lJsonCliente);
    lJsonCliente.Free;
  Except
    on E: Exception do
     raise Exception.Create('Não foi possivel consultar o Cliente. - ' + E.Message);
  end;
end;

procedure TControllerCliente.JsonToEntity(aValue: TJsonObject);
begin
  FEntity
    .Codigo(aValue.GetValue<Integer>('codigo'))
    .Nome(aValue.GetValue<string>('nome'))
    .Cidade(aValue.GetValue<string>('cidade'))
    .UF(aValue.GetValue<string>('uf'));
end;

class function TControllerCliente.New: IControllerCliente;
begin
  Result := Self.Create;
end;

end.
