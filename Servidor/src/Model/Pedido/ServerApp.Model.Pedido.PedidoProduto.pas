unit ServerApp.Model.Pedido.PedidoProduto;


interface

uses
  System.JSON,
  ServidorAPI.Model.Conexao.Interfaces,
  App.Model.Entity.Pedido.Pedido, App.Model.Entity.Pedido.PedidoProdutos;

Type

  IModelPedidoProduto = Interface
    ['{12E8CE4E-D43D-4CBD-B234-19840204C205}']
    function Entity(aValue: IEntityPedidoProdutos): IModelPedidoProduto; overload;
    function Entity: IEntityPedidoProdutos; overload;
    function SetParams(aValue: TJSONObject): IModelPedidoProduto; overload;
    function DataSet: IModelDataset;
    function Get(aIdPedidoProduto: Integer): TJSONObject;
    function GetList(aIdPedido: Integer): TJSONArray;
    function Insert: IModelPedidoProduto;
    function UpDate(aId: Integer): IModelPedidoProduto;
    function Delete(aId: Integer): IModelPedidoProduto;
  End;

  TModelPedidoProduto = class(TInterfacedObject, IModelPedidoProduto)
    private
      [weak]
      FDataSet: IModelDataset;
      FEntity: IEntityPedidoProdutos;
    public
      constructor Create(aDataSet: IModelDataset);
      destructor Destroy; override;
      class function New(aDataSet: IModelDataset): IModelPedidoProduto;
      function Entity(aValue: IEntityPedidoProdutos): IModelPedidoProduto; overload;
      function Entity: IEntityPedidoProdutos; overload;
      function SetParams(aValue: TJSONObject): IModelPedidoProduto; overload;
      function DataSet: IModelDataset;
      function Get(aIdPedidoProduto: Integer): TJSONObject;
      function GetList(aIdPedido: Integer): TJSONArray;
      function Insert: IModelPedidoProduto;
      function UpDate(aId: Integer): IModelPedidoProduto;
      function Delete(aId: Integer): IModelPedidoProduto;
  end;

implementation

uses
  Server.Model.DAO,
  System.Classes,
  System.SysUtils,
  ServerApp.Model.Pedido.Produto;

{ TModelPedidoProduto }

constructor TModelPedidoProduto.Create(aDataSet: IModelDataset);
begin
  FDataSet := aDataSet;
   FEntity := TEntityPedidoProdutos.New;
end;

function TModelPedidoProduto.DataSet: IModelDataset;
begin
  Result := FDataSet;
end;

function TModelPedidoProduto.Delete(aId: Integer): IModelPedidoProduto;
begin
  try
    TDAOGeneric.New(FDataSet)
      .SQL
       .Tabela('PedidoProduto')
       .Where('AND IdPedidoProduto = ' + aId.ToString)
      .&End
      .Delete;
  Except
    on E: Exception do
      raise Exception.Create('Erro Delete PedidoProduto - ' + E.Message);
  end;
end;

destructor TModelPedidoProduto.Destroy;
begin

  inherited;
end;

function TModelPedidoProduto.Entity(
  aValue: IEntityPedidoProdutos): IModelPedidoProduto;
begin
  Result := Self;
  FEntity := aValue;
end;

function TModelPedidoProduto.Entity: IEntityPedidoProdutos;
begin
  Result := FEntity;
end;

function TModelPedidoProduto.Get(aIdPedidoProduto: Integer): TJSONObject;
begin
  Result :=
  TDAOGeneric.New(FDataSet)
     .SQL
       .Tabela('PedidoProduto')
       .Fields('idPedidoProduto, Quantidade, ValorUnitario, ValorTotal, CodigoProduto, NumeroPedido')
       .Where('AND Codigo = ' + aIdPedidoProduto.ToString )
     .&End
     .Select
     .DataSetAsJsonObject;

end;

function TModelPedidoProduto.GetList(aIdPedido: Integer): TJSONArray;
begin
  Result :=
    TDAOGeneric.New(FDataSet)
       .SQL
         .Tabela('PedidoProduto')
         .Fields('idPedidoProduto, Quantidade, ValorUnitario, ValorTotal, CodigoProduto, NumeroPedido')
         .Where('AND NumeroPedido = ' + aIdPedido.ToString )
       .&End
       .Select
       .DataSetAsJsonArray;

  for var lPedidoProduto in Result do
  begin
    var lJsonProduto := TModelProduto.New(FDataSet).Get(TJSONObject(lPedidoProduto).GetValue<Integer>('codigoproduto'));
    TJSONObject(lPedidoProduto).AddPair('Produto', lJsonProduto);
  end;

end;

function TModelPedidoProduto.Insert: IModelPedidoProduto;
begin
  Result :=  Self;
  try
      TDAOGeneric.New(FDataSet)
        .SQL
          .Tabela('PedidoProduto')
          .Fields('Quantidade, ValorUnitario, ValorTotal, CodigoProduto, NumeroPedido')
          .Value(Format('%d, replace(%s,'','',''.''), replace(%s,'','',''.''), %d, %d ',
               [FEntity.Quantidade,
                QuotedStr(FloatToStr(FEntity.ValorUnitario)),
                QuotedStr(FloatToStr(FEntity.ValorTotal)),
                FEntity.CodigoProduto,
                FEntity.NumeroPedido
               ])
          )
        .&End
        .Insert;
  Except
    on E: Exception do
      raise Exception.Create('Erro ao Inserir o Pedido - ' + E.Message);
  end;
end;

class function TModelPedidoProduto.New(aDataSet: IModelDataset): IModelPedidoProduto;
begin
  Result := Self.Create(aDataSet);
end;


function TModelPedidoProduto.SetParams(aValue: TJSONObject): IModelPedidoProduto;
begin
  Result := Self;
  FEntity
    .IdPedidoProduto(aValue.GetValue<Integer>('idpedidoproduto'))
    .Quantidade(aValue.GetValue<Integer>('quantidade'))
    .ValorUnitario(aValue.GetValue<Real>('valorunitario'))
    .ValorTotal(aValue.GetValue<Real>('valortotal'))
    .CodigoProduto(aValue.GetValue<Integer>('codigoproduto'))
    .NumeroPedido(aValue.GetValue<Integer>('numeropedido'));
end;

function TModelPedidoProduto.UpDate(aId: Integer): IModelPedidoProduto;
begin
  try
    TDAOGeneric.New(FDataSet)
      .SQL
        .Tabela('PedidoProduto')
        .Params(Format('Quantidade = %d, ValorUnitario = replace(''%f'','','',''.''), ValorTotal = replace(''%f'','','',''.'') ',
             [FEntity.Quantidade,
              FEntity.ValorUnitario,
              FEntity.ValorTotal
             ])
        )
       .Where('AND IdPedidoProduto = ' + aId.ToString)
      .&End
      .Update;
  Except
    on E: Exception do
      raise Exception.Create('Erro UpDate PedidoProduto - ' + E.Message);
  end;
end;

end.

