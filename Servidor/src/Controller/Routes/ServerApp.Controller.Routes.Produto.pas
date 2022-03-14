unit ServerApp.Controller.Routes.Produto;



interface

uses
  Horse.HTTP;


procedure DoGetById(Req: THorseRequest; Res: THorseResponse);


procedure Registry;

implementation

uses
  System.JSON,
  System.SysUtils,
  BackEnd.Controller.DAO.DAO,
  ServerApp.Model.Pedido.Produto,
  Horse;



procedure DoGetById(Req: THorseRequest; Res: THorseResponse);
begin
  var lDAO :=  TControllerDAO.New;
  var lJsonProduto := TModelProduto.New(lDAO.DataSet).Get(Req.Params['IdProduto'].ToInteger);

  Res.Send<TJSONObject>(lJsonProduto);
end;


procedure Registry;
begin
   THorse
    .Get('/produtos/:IdProduto',DoGetById);
end;

end.

