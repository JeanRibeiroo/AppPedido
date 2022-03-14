unit ServerApp.Model.Pedido.Produto;


interface

uses
  ServidorAPI.Model.Conexao.Interfaces,
  System.JSON;

Type

  IModelProduto = Interface
    ['{12E8CE4E-D43D-4CBD-B234-19840204C205}']
    function Get(aIdPedido: Integer): TJSONObject;
  End;

  TModelProduto = class(TInterfacedObject, IModelProduto)
    private
      [weak]
      FDataSet: IModelDataset;
    public
      constructor Create(aDataSet: IModelDataset);
      destructor Destroy; override;
      class function New(aDataSet: IModelDataset): IModelProduto;
      function Get(aIdProduto: Integer): TJSONObject;
  end;

implementation

uses
  Server.Model.DAO,
  System.Classes,
  System.SysUtils;

{ TModelProduto }

constructor TModelProduto.Create(aDataSet: IModelDataset);
begin
  FDataSet := aDataSet;
end;

destructor TModelProduto.Destroy;
begin

  inherited;
end;

function TModelProduto.Get(aIdProduto: Integer): TJSONObject;
begin
  Result :=
  TDAOGeneric.New(FDataSet)
    .SQL
      .Tabela('Produto')
      .Fields('Codigo, Descricao, PrecoVendas')
      .Where('AND Codigo = ' + aIdProduto.ToString)
    .&End
    .Select
    .DataSetAsJsonObject;
end;

class function TModelProduto.New(aDataSet: IModelDataset): IModelProduto;
begin
  Result := Self.Create(aDataSet);
end;

end.

