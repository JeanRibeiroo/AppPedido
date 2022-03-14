unit ServidorAPI.Controller.Conexao.Factory;

interface

uses
  ServidorAPI.Controller.Conexao.Interfaces;


Type
  TControllerConexaoFactory = class(TInterfacedObject, IControllerConexaoFactory)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IControllerConexaoFactory;
    function Conexao:IControllerConexao;
  end;

implementation

{ TControllerConexaoFactory.Conexoes }

uses
  ServidorAPI.Controller.Conexao.Conexao;


function TControllerConexaoFactory.Conexao: IControllerConexao;
begin
  Result := TControllerConexao.New;
end;

constructor TControllerConexaoFactory.Create;
begin
end;

destructor TControllerConexaoFactory.Destroy;
begin
  inherited Destroy;
end;

class function TControllerConexaoFactory.New
  : IControllerConexaoFactory;
begin
  Result := Self.Create;
end;

end.
