unit ServidorAPI.Model.Conexao.Interfaces;

interface

uses
  FireDAC.Comp.Client, System.Classes;

Type
  IModelConexaoParametros<T> = interface;

  IModelConexao = interface
    ['{D29750E7-384A-48E7-B9BA-FE391249CAB3}']
    function Conectar: Integer;
    function Disconnected(IndexConn : Integer): IModelConexao;
    function StartTransaction: IModelConexao;
    function Commit: IModelConexao;
    function Rollback: IModelConexao;
    function &EndConexao: TComponent;
    function Parametros: IModelConexaoParametros<IModelConexao>;
  end;

  IModelConexaoParametros<T> = interface
    ['{0ADB6870-009F-4C07-AD4C-B96D19F35911}']
    function DataBase(Value: string): IModelConexaoParametros<T>;
    function UserName(Value: string): IModelConexaoParametros<T>;
    function PassWord(Value: string): IModelConexaoParametros<T>;
    function DriveId(Value: string): IModelConexaoParametros<T>;
    function Server(Value: string): IModelConexaoParametros<T>;
    function DriverLink(Value: string): IModelConexaoParametros<T>;
    function Porta(Value: string): IModelConexaoParametros<T>;
    function getDataBase:String;
    function getUserName:String;
    function getPassword:String;
    function getServer:String;
    function getDriverID:String;
    function getPorta:String;
    function getDriverLink:string;
    function &End: T;
  end;


  IModelDataSet = interface
    ['{E491B3ED-65CB-4276-8EAD-9DDEF465B9BF}']
    function Open(ASQL: string): IModelDataSet;
    function Exec(ASQL: string): IModelDataSet;
    function &EndDataSet: TComponent;
  end;


  IModelConexaoFactoryConexoes = interface
    ['{00BC9287-25B6-41DF-9CB1-833079E228E4}']
    function ConexaoFireDack: IModelConexao;
  end;

  IModelConexaoFactoryDataSet = interface
    ['{0ACC12C8-EE00-4011-9F07-CB78DD993A21}']
    function DataSetFireDack(Conexao:IModelConexao):IModelDataSet;
  end;

implementation

end.
