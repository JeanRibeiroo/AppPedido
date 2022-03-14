unit ServerApp.Model.Cliente.Cliente;


interface

uses
  ServidorAPI.Model.Conexao.Interfaces,
  System.JSON;

Type

  IModelCliente = Interface
    ['{12E8CE4E-D43D-4CBD-B234-19840204C205}']
    function Get(aIdPedido: Integer): TJSONObject;
  End;

  TModelCliente = class(TInterfacedObject, IModelCliente)
    private
      [weak]
      FDataSet: IModelDataset;
    public
      constructor Create(aDataSet: IModelDataset);
      destructor Destroy; override;
      class function New(aDataSet: IModelDataset): IModelCliente;
      function Get(aIdCliente: Integer): TJSONObject;
  end;

implementation

uses
  Server.Model.DAO,
  System.Classes,
  System.SysUtils;

{ TModelCliente }

constructor TModelCliente.Create(aDataSet: IModelDataset);
begin
  FDataSet := aDataSet;
end;

destructor TModelCliente.Destroy;
begin

  inherited;
end;

function TModelCliente.Get(aIdCliente: Integer): TJSONObject;
begin
  Result :=
  TDAOGeneric.New(FDataSet)
     .SQL
       .Tabela('Cliente')
       .Fields('Codigo, Nome, Cidade, UF')
       .Where('AND Codigo = ' + aIdCliente.ToString )
     .&End
     .Select
     .DataSetAsJsonObject;
end;

class function TModelCliente.New(aDataSet: IModelDataset): IModelCliente;
begin
  Result := Self.Create(aDataSet);
end;

end.

