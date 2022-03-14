unit ServidorAPI.Moodel.ParametrosConn.Interfaces;

interface


Type
  IModelParametrosFireDack = interface;

  IModelParametrosConn = Interface
    ['{45891723-9868-414D-8A8D-07C771B460E1}']
    function ParametroFireDac:IModelParametrosFireDack;
  end;


  IModelParametrosFireDack = interface
    ['{335D02A9-3832-4A06-B298-380FC18E4036}']
    function DataBase(Value : String) : IModelParametrosFireDack;
    function UserName(Value : String): IModelParametrosFireDack;
    function Password(Value : String): IModelParametrosFireDack;
    function Server(Value : String): IModelParametrosFireDack;
    function DriverID(Value : String): IModelParametrosFireDack;
    function Porta(Value : String): IModelParametrosFireDack;

    function getDataBase:String;
    function getUserName:String;
    function getPassword:String;
    function getServer:String;
    function getDriverID:String;
    function getPorta:String;
  end;


implementation

end.
