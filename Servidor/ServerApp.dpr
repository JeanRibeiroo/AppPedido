program ServerApp;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  Horse,
  Horse.Logger.Provider.Console,
  Horse.Jhonson,
  Horse.HandleException,
  ServidorAPI.Model.Conexao.FireDac in 'src\Model\Conexao\FireDac\ServidorAPI.Model.Conexao.FireDac.pas',
  ServidorAPI.Model.Conexao.TableFireDac in 'src\Model\Conexao\FireDac\ServidorAPI.Model.Conexao.TableFireDac.pas',
  ServidorAPI.Model.Conexao.Factory.Conexoes in 'src\Model\Conexao\ServidorAPI.Model.Conexao.Factory.Conexoes.pas',
  ServidorAPI.Model.Conexao.Factory.DataSet in 'src\Model\Conexao\ServidorAPI.Model.Conexao.Factory.DataSet.pas',
  ServidorAPI.Model.Conexao.Interfaces in 'src\Model\Conexao\ServidorAPI.Model.Conexao.Interfaces.pas',
  ServidorAPI.Model.Exception in 'src\Model\Conexao\ServidorAPI.Model.Exception.pas',
  ServidorAPI.Moodel.ParametrosConn.Interfaces in 'src\Model\Conexao\ServidorAPI.Moodel.ParametrosConn.Interfaces.pas',
  ServidorAPI.Moodel.ParametrosConn in 'src\Model\Conexao\ServidorAPI.Moodel.ParametrosConn.pas',
  Server.Model.DAO in 'src\Model\DAO\Server.Model.DAO.pas',
  Server.Model.SQL in 'src\Model\SQL\Server.Model.SQL.pas',
  ServidorAPI.Controller.Conexao.Conexao in 'src\Controller\Conexao\ServidorAPI.Controller.Conexao.Conexao.pas',
  ServidorAPI.Controller.Conexao.Factory in 'src\Controller\Conexao\ServidorAPI.Controller.Conexao.Factory.pas',
  ServidorAPI.Controller.Conexao.Interfaces in 'src\Controller\Conexao\ServidorAPI.Controller.Conexao.Interfaces.pas',
  BackEnd.Controller.DAO.DAO in 'src\Controller\DAO\BackEnd.Controller.DAO.DAO.pas',
  Horse.Logger.Manager,
  ServerApp.Controller.Routes.Cliente in 'src\Controller\Routes\ServerApp.Controller.Routes.Cliente.pas',
  ServerApp.Controller.Routes.Produto in 'src\Controller\Routes\ServerApp.Controller.Routes.Produto.pas',
  ServerApp.Controller.Routes.Pedido in 'src\Controller\Routes\ServerApp.Controller.Routes.Pedido.pas',
  ServerApp.Model.Pedido.Pedido in 'src\Model\Pedido\ServerApp.Model.Pedido.Pedido.pas',
  ServerApp.Model.Cliente.Cliente in 'src\Model\Cliente\ServerApp.Model.Cliente.Cliente.pas',
  ServerApp.Model.Pedido.PedidoProduto in 'src\Model\Pedido\ServerApp.Model.Pedido.PedidoProduto.pas',
  ServerApp.Model.Pedido.Produto in 'src\Model\Produto\ServerApp.Model.Pedido.Produto.pas',
  System.Command.Interfaces in '..\System\Command\System.Command.Interfaces.pas',
  System.Command.Invoker in '..\System\Command\System.Command.Invoker.pas',
  App.Model.Entity.Cliente.Cliente in '..\System\Entity\Cliente\App.Model.Entity.Cliente.Cliente.pas',
  App.Model.Entity.Pedido.Pedido in '..\System\Entity\Pedido\App.Model.Entity.Pedido.Pedido.pas',
  App.Model.Entity.Pedido.PedidoProdutos in '..\System\Entity\Pedido\App.Model.Entity.Pedido.PedidoProdutos.pas',
  App.Model.Entity.Produto.Produto in '..\System\Entity\Produto\App.Model.Entity.Produto.Produto.pas',
  System.Iterator.Interfaces in '..\System\Iterator\System.Iterator.Interfaces.pas',
  System.Iterator.Iterator in '..\System\Iterator\System.Iterator.Iterator.pas',
  ServerApp.Model.Pedido.Command.GetNumeroPedido in 'src\Model\Pedido\Command\ServerApp.Model.Pedido.Command.GetNumeroPedido.pas',
  ServerApp.Model.Pedido.Command.Factory in 'src\Model\Pedido\Command\ServerApp.Model.Pedido.Command.Factory.pas',
  ServerApp.Model.Pedido.Command.NewPedido in 'src\Model\Pedido\Command\ServerApp.Model.Pedido.Command.NewPedido.pas',
  ServerApp.Model.Pedido.Command.NewPedidoProduto in 'src\Model\Pedido\Command\ServerApp.Model.Pedido.Command.NewPedidoProduto.pas',
  ServerApp.Controller.Routes.PedidoProduto in 'src\Controller\Routes\ServerApp.Controller.Routes.PedidoProduto.pas';

begin
  THorseLoggerManager.RegisterProvider( THorseLoggerProviderConsole.New() );
  THorse.Routes.Prefix('AppPedidos');
  THorse
    .Use( THorseLoggerManager.HorseCallback() )
    .Use(Jhonson())
    .Use(HandleException);

  ServerApp.Controller.Routes.Cliente.Registry;
  ServerApp.Controller.Routes.Produto.Registry;
  ServerApp.Controller.Routes.Pedido.Registry;
  ServerApp.Controller.Routes.PedidoProduto.Registry;

  THorse.Get('/ping',
    procedure(Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(8080,
      procedure(Horse: THorse)
      begin
        Writeln(Format('Server is runing on %s:%d', [Horse.Host, Horse.Port]));
      end
    );
end.
