unit ServidorAPI.Moodel.ParametrosConn;


interface

uses
  ServidorAPI.Model.Conexao.Interfaces;

Type
  TModelParametroConn<T: IInterface> = class(TInterfacedObject,IModelConexaoParametros<T>)
    private
      FDataBase:String;
      FUserName:String;
      FPassword:String;
      FServer:String;
      FDriverID:String;
      FPorta:String;
      FDriverLink:string;
      [weak]
      FParent: T;
    public
      constructor Create(aParent: T);
      destructor  Destroy;override;
      class function New(aParent: T):IModelConexaoParametros<T>;
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


implementation

{ TModelItens }

function TModelParametroConn<T>.&End: T;
begin
  Result := FParent;
end;

constructor TModelParametroConn<T>.Create(aParent: T);
begin
  FParent := aParent;
end;

function TModelParametroConn<T>.DataBase(Value: string): IModelConexaoParametros<T>;
begin
  Result := Self;
  FDataBase := Value;
end;

destructor TModelParametroConn<T>.Destroy;
begin

  inherited;
end;

function TModelParametroConn<T>.DriveId(Value : String): IModelConexaoParametros<T>;
begin
  Result := Self;
  FDriverID := Value;
end;

function TModelParametroConn<T>.DriverLink(Value: string): IModelConexaoParametros<T>;
begin
  Result := Self;
  FDriverLink := Value;
end;

function TModelParametroConn<T>.getDataBase: String;
begin
  Result := FDataBase;
end;

function TModelParametroConn<T>.getDriverID: String;
begin
  Result := FDriverID;
end;

function TModelParametroConn<T>.getDriverLink: string;
begin
  Result := FDriverLink;
end;

function TModelParametroConn<T>.getPassword: String;
begin
  Result := FPassword;
end;

function TModelParametroConn<T>.getPorta: String;
begin
  Result := FPorta;
end;

function TModelParametroConn<T>.getServer: String;
begin
  Result := FServer;
end;

function TModelParametroConn<T>.getUserName: String;
begin
  Result := FUserName;
end;

class function TModelParametroConn<T>.New(aParent: T): IModelConexaoParametros<T>;
begin
  Result := Self.Create(aParent);
end;

function TModelParametroConn<T>.Password(Value : String): IModelConexaoParametros<T>;
begin
  Result := Self;
  FPassword := Value;
end;

function TModelParametroConn<T>.Porta(Value: string): IModelConexaoParametros<T>;
begin
  Result := Self;
  FPorta := Value;
end;

function TModelParametroConn<T>.Server(Value: string): IModelConexaoParametros<T>;
begin
   Result := Self;
   FServer := Value;
end;

function TModelParametroConn<T>.UserName(Value: string): IModelConexaoParametros<T>;
begin
  Result := Self;
  FUserName := Value;
end;

end.