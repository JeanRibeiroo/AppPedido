unit ServidorAPI.Model.Conexao.Factory.DataSet;

interface

uses ServidorAPI.Model.Conexao.Interfaces;

Type
  TModelConexaoFactoryDataSet = class(TInterfacedObject,
    IModelConexaoFactoryDataSet)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelConexaoFactoryDataSet;
    function DataSetFireDack(Conexao:IModelConexao): IModelDataSet;
  end;

implementation

uses
  ServidorAPI.Model.Conexao.TableFireDac;

{ TModelConexaoFactoryDataSet }


constructor TModelConexaoFactoryDataSet.Create;
begin

end;

function TModelConexaoFactoryDataSet.DataSetFireDack(Conexao:IModelConexao): IModelDataSet;
begin

  Result := TModelConexaoTable.New(Conexao);
end;


destructor TModelConexaoFactoryDataSet.Destroy;
begin

  inherited Destroy;
end;

class function TModelConexaoFactoryDataSet.New: IModelConexaoFactoryDataSet;
begin
  Result := Self.Create;
end;

end.
