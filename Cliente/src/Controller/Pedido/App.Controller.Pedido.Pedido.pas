unit App.Controller.Pedido.Pedido;

interface

uses
  App.Model.Entity.Pedido.Pedido,
  App.Model.Entity.Pedido.PedidoProdutos,
  FMX.Types,
  System.SysUtils, System.JSON;

Type

  IControllerPedido = Interface
    ['{B2FB4F46-CA58-4874-B8F3-397DA9613ABA}']
    function Entity(aValue: IEntityPedido): IControllerPedido; overload;
    function Entity: IEntityPedido; overload;
    function AddProduto(aValue: IEntityPedidoProdutos): IControllerPedido;
    function EditItemList(aValue: IEntityPedidoProdutos): IControllerPedido;
    function DeleteItemList: IControllerPedido;
    function SomaValorTotal: IControllerPedido;
    function ReturnOperacao(aValue: TProc<string>): IControllerPedido;
    function ShowGrid(aGrid: TFmxObject): IControllerPedido;
    function GetPedido: IControllerPedido;
    function GetPedidoProdutoList(aId: Integer): IEntityPedidoProdutos;
    function Salvar: IControllerPedido;
    function DeleteItemBd: IControllerPedido;
    function EditItemBd: IControllerPedido;
  End;

  TControllerPedido = class(TInterfacedObject, IControllerPedido)
    private
      FEntity: IEntityPedido;
      FReturnOperacao: TProc<string>;
      const SYS_API_URL_BASE = 'http://localhost:8080/AppPedidos';
      function EntityToJson: TJSONObject;
      function EntityPedidoProdutoToJson(aValue: IEntityPedidoProdutos): TJSONObject;
      procedure JsonToEntity(aValue: TJSONObject);
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IControllerPedido;
      function Entity(aValue: IEntityPedido): IControllerPedido; overload;
      function Entity: IEntityPedido; overload;
      function AddProduto(aValue: IEntityPedidoProdutos): IControllerPedido;
      function DeleteItemList: IControllerPedido;
      function EditItemList(aValue: IEntityPedidoProdutos): IControllerPedido;
      function SomaValorTotal: IControllerPedido;
      function Salvar: IControllerPedido;
      function DeleteItemBd: IControllerPedido;
      function EditItemBd: IControllerPedido;
      function ReturnOperacao(aValue: TProc<string>): IControllerPedido;
      function ShowGrid(aGrid: TFmxObject): IControllerPedido;
      function GetPedido: IControllerPedido;
      function GetPedidoProdutoList(aId: Integer): IEntityPedidoProdutos;

  end;

implementation

uses
  FMX.ListBox,
  System.DAO.Factory,
  App.View.Components.ListItens.Factory;

{ TControllerPedido }

function TControllerPedido.AddProduto(aValue: IEntityPedidoProdutos): IControllerPedido;
begin
  Result := Self;

  FEntity.ListPedidoProduto
    .Add(aValue);
end;

constructor TControllerPedido.Create;
begin
  FEntity := TEntityPedido.New;
end;

function TControllerPedido.DeleteItemBd: IControllerPedido;
begin
  Result := Self;
  if FEntity.NumeroPedido = 0 then
    Exit;

 TModelDAOFactory.New
      .REST
       .BaseURL(SYS_API_URL_BASE)
       .Resource(Format('/pedidos/produtos/%d',
       [FEntity.ListPedidoProduto.GetItem(FEntity.IdPedidoProduto).idPedidoProduto]))
       .Accept('application/json')
       .Delete;
end;

function TControllerPedido.DeleteItemList: IControllerPedido;
begin
  Result := Self;
  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    if FEntity.ListPedidoProduto.ItemIndex = FEntity.IdPedidoProduto then
    begin
      FEntity.ListPedidoProduto.Delete(FEntity.ListPedidoProduto.ItemIndex);
      Exit;
    end;
    FEntity.ListPedidoProduto.Next;
  end;
end;

destructor TControllerPedido.Destroy;
begin

  inherited;
end;

function TControllerPedido.Entity(aValue: IEntityPedido): IControllerPedido;
begin
  Result := Self;
  FEntity := aValue;
end;

function TControllerPedido.EditItemBd: IControllerPedido;
begin
  Result := Self;
  if FEntity.NumeroPedido = 0 then
    Exit;

  var lPedidoProduto := FEntity.ListPedidoProduto.GetItem(FEntity.IdPedidoProduto);

  TModelDAOFactory.New
      .REST
       .BaseURL(SYS_API_URL_BASE)
       .Resource(Format('/pedidos/produtos/%d',
       [lPedidoProduto.idPedidoProduto]))
       .Accept('application/json')
       .AddBody(EntityPedidoProdutoToJson(lPedidoProduto))
       .Put;
end;

function TControllerPedido.EditItemList(aValue: IEntityPedidoProdutos): IControllerPedido;
begin
  Result := Self;
  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    if FEntity.ListPedidoProduto.ItemIndex = FEntity.IdPedidoProduto then
    begin
      FEntity.ListPedidoProduto.Itens
       .CodigoProduto(aValue.CodigoProduto)
         .Quantidade(aValue.Quantidade)
         .ValorUnitario(aValue.ValorUnitario)
         .Produto
           .Codigo(aValue.Produto.Codigo)
           .Descricao(aValue.Produto.Descricao)
           .PrecoVenda(aValue.Produto.PrecoVenda);
      Exit;
    end;
    FEntity.ListPedidoProduto.Next;
  end;
end;

function TControllerPedido.Entity: IEntityPedido;
begin
  Result := FEntity;
end;

function TControllerPedido.EntityPedidoProdutoToJson(aValue: IEntityPedidoProdutos): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result
    .AddPair('idpedidoproduto', TJSONNumber.Create(aValue.IdPedidoProduto))
    .AddPair('quantidade', TJSONNumber.Create(aValue.Quantidade))
    .AddPair('valorunitario', TJSONNumber.Create(aValue.ValorUnitario))
    .AddPair('valortotal', TJSONNumber.Create(aValue.ValorTotal))
    .AddPair('codigoproduto', TJSONNumber.Create(aValue.CodigoProduto))
    .AddPair('numeropedido', TJSONNumber.Create(aValue.NumeroPedido));
end;

function TControllerPedido.EntityToJson: TJSONObject;
begin
  Result := TJSONObject.Create;
  var lPedido := TJSONObject.Create;
  var lItens := TJSONArray.Create;

  lPedido
    .AddPair('numeropedido', TJSONNumber.Create(FEntity.NumeroPedido))
    .AddPair('dtaemissao', TJSONString.Create(DateToStr(Now)))
    .AddPair('valortotal', TJSONNumber.Create(FEntity.ValorTotal))
    .AddPair('codigocliente', TJSONNumber.Create(FEntity.CodigoCliente));

  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    lItens.AddElement(EntityPedidoProdutoToJson(FEntity.ListPedidoProduto.Itens));
    FEntity.ListPedidoProduto.Next;
  end;

  Result.AddPair('Pedido',lPedido);
  lPedido.AddPair('Itens',lItens);
end;

function TControllerPedido.GetPedido: IControllerPedido;
begin
  Result := Self;
  try
    var lJsonPedido :=
      TModelDAOFactory.New
         .REST
         .BaseURL(SYS_API_URL_BASE)
         .Resource(Format('/pedidos/%d',[FEntity.NumeroPedido]))
         .Accept('application/json')
         .Select
           .ToJsonObject;
    JsonToEntity(lJsonPedido);
    lJsonPedido.Free;
  Except
    on E: Exception do
     raise Exception.Create('N�o foi possivel consultar o Pedido. - ' + E.Message);
  end;
end;

function TControllerPedido.GetPedidoProdutoList(aId: Integer): IEntityPedidoProdutos;
begin
  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    if FEntity.ListPedidoProduto.ItemIndex = aId then
    begin
      Result := FEntity.ListPedidoProduto.Itens;
      Exit;
    end;
    FEntity.ListPedidoProduto.Next;
  end;
end;

procedure TControllerPedido.JsonToEntity(aValue: TJSONObject);
begin
  var lPedido := aValue.GetValue<TJSONObject>('Pedido');
  var lCliente := lPedido.GetValue<TJSONObject>('Cliente');
  var lListPedidoProduto := lPedido.GetValue<TJSONArray>('Itens');
  FEntity
    .NumeroPedido(lPedido.GetValue<Integer>('numeropedido'))
    .DataEmissao(StrToDate(lPedido.GetValue<string>('dtaemissao')))
    .CodigoCliente(lPedido.GetValue<Integer>('codigocliente'))
      .Cliente
        .Nome(lCliente.GetValue<string>('nome'))
        .Cidade(lCliente.GetValue<string>('cidade'))
        .UF(lCliente.GetValue<string>('uf'));

  for var lPedidoProduto in lListPedidoProduto do
  begin
    var lEntity := TEntityPedidoProdutos.New;
    var lProduto := lPedidoProduto.GetValue<TJSONObject>('Produto');
    lEntity
      .IdPedidoProduto(lPedidoProduto.GetValue<Integer>('idpedidoproduto'))
      .Quantidade(lPedidoProduto.GetValue<Integer>('quantidade'))
      .ValorUnitario(lPedidoProduto.GetValue<Real>('valorunitario'))
      .ValorTotal(lPedidoProduto.GetValue<Real>('valortotal'))
      .CodigoProduto(lPedidoProduto.GetValue<Integer>('codigoproduto'))
      .NumeroPedido(lPedidoProduto.GetValue<Integer>('numeropedido'))
      .Produto
        .Codigo(lProduto.GetValue<Integer>('codigo'))
        .Descricao(lProduto.GetValue<string>('descricao'))
        .PrecoVenda(lProduto.GetValue<Real>('precovendas'));

    FEntity.ListPedidoProduto.Add(lEntity);
  end;
end;

class function TControllerPedido.New: IControllerPedido;
begin
  Result := Self.Create;
end;

function TControllerPedido.ReturnOperacao(
  aValue: TProc<string>): IControllerPedido;
begin
  Result := Self;
  FReturnOperacao := aValue;
end;

function TControllerPedido.Salvar: IControllerPedido;
begin
  Result := Self;

  if FEntity.CodigoCliente = 0 then
     raise Exception.Create('Voc� precisa consulta um Cliente para Salvar.');

  if FEntity.ListPedidoProduto.Count = -1 then
    raise Exception.Create('Voc� precisa adicionar no minimo 1 Produto para Salvar.');

  var lPedido := EntityToJson;

  TModelDAOFactory.New
      .REST
       .BaseURL(SYS_API_URL_BASE)
       .Resource('/pedidos')
       .Accept('application/json')
       .AddBody(lPedido)
       .Post;
end;

function TControllerPedido.ShowGrid(aGrid: TFmxObject): IControllerPedido;
begin
  Result := Self;

  TListBox(aGrid).Clear;
  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    TComponentsListItensFactory.New
      .Container(aGrid)
      .ListItem001(aGrid)
      .This
        .Id(FEntity.ListPedidoProduto.ItemIndex)
        .Title(Format('%d  -  %s  -  %f  -  %f',
          [FEntity.ListPedidoProduto.Itens.Quantidade,
           FEntity.ListPedidoProduto.Itens.Produto.Descricao,
           FEntity.ListPedidoProduto.Itens.ValorUnitario,
           FEntity.ListPedidoProduto.Itens.ValorTotal ])
        )
       //.OnExcluir()
       .Component;
    FEntity.ListPedidoProduto.Next;
  end;
end;

function TControllerPedido.SomaValorTotal: IControllerPedido;
begin
  Result := Self;
  var lValorTotal := 0.0;
  var lValorItem := 0.0;
  FEntity.ListPedidoProduto.Firt;
  while FEntity.ListPedidoProduto.HasNext do
  begin
    lValorItem :=
    FEntity.ListPedidoProduto.Itens.Quantidade * FEntity.ListPedidoProduto.Itens.ValorUnitario;

    FEntity.ListPedidoProduto.Itens.ValorTotal(lValorItem);
    lValorTotal := lValorTotal + lValorItem;

    FEntity.ListPedidoProduto.Next;
  end;
  FEntity.ValorTotal(lValorTotal);
  FReturnOperacao(FormatFloat('R$#,,0.00',FEntity.ValorTotal));
end;


end.
