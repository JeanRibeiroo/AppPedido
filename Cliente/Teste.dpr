program Teste;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Pedido in 'src\View\Pedido.pas' {Form1},
  App.View.Components.ListItens.Item001 in 'src\View\Components\ListItens\App.View.Components.ListItens.Item001.pas',
  App.View.Components.ListItens.Factory in 'src\View\Components\ListItens\App.View.Components.ListItens.Factory.pas',
  App.View.Healpers.Img in 'src\View\Healpers\App.View.Healpers.Img.pas',
  App.Controller.Pedido.Pedido in 'src\Controller\Pedido\App.Controller.Pedido.Pedido.pas',
  System.DAO.DAORest in 'src\Model\DAO\System.DAO.DAORest.pas',
  System.DAO.Factory in 'src\Model\DAO\System.DAO.Factory.pas',
  System.DAO.Interfaces in 'src\Model\DAO\System.DAO.Interfaces.pas',
  System.DAO.Params in 'src\Model\DAO\System.DAO.Params.pas',
  App.Controller.Cliente.Cliente in 'src\Controller\Cliente\App.Controller.Cliente.Cliente.pas',
  App.Controller.Produto.Produto in 'src\Controller\Produto\App.Controller.Produto.Produto.pas',
  System.Command.Interfaces in '..\System\Command\System.Command.Interfaces.pas',
  System.Command.Invoker in '..\System\Command\System.Command.Invoker.pas',
  System.Iterator.Interfaces in '..\System\Iterator\System.Iterator.Interfaces.pas',
  System.Iterator.Iterator in '..\System\Iterator\System.Iterator.Iterator.pas',
  App.Model.Entity.Cliente.Cliente in '..\System\Entity\Cliente\App.Model.Entity.Cliente.Cliente.pas',
  App.Model.Entity.Pedido.Pedido in '..\System\Entity\Pedido\App.Model.Entity.Pedido.Pedido.pas',
  App.Model.Entity.Pedido.PedidoProdutos in '..\System\Entity\Pedido\App.Model.Entity.Pedido.PedidoProdutos.pas',
  App.Model.Entity.Produto.Produto in '..\System\Entity\Produto\App.Model.Entity.Produto.Produto.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
