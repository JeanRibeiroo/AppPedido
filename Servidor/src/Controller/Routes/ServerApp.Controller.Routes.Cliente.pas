unit ServerApp.Controller.Routes.Cliente;

interface

uses
  Horse.HTTP;


procedure DoGetById(Req: THorseRequest; Res: THorseResponse);


procedure Registry;

implementation

uses
  System.JSON,
  System.SysUtils,
  ServerApp.Model.Cliente.Cliente,
  BackEnd.Controller.DAO.DAO, Horse;



procedure DoGetById(Req: THorseRequest; Res: THorseResponse);
begin
  var lDAO :=  TControllerDAO.New;
  var lJsonCliente := TModelCliente.New(lDAO.DataSet).Get(Req.Params['IdCliente'].ToInteger);

  Res.Send<TJSONObject>(lJsonCliente);
end;


procedure Registry;
begin
   THorse
    .Get('/clientes/:IdCliente',DoGetById);
end;

end.
