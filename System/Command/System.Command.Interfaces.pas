unit System.Command.Interfaces;

interface


Type

  ICommand = Interface
    ['{38C2BDDC-4F52-473D-91A7-C36B8D640E51}']
    function Execute : ICommand;
  End;

  IInvoker =  Interface
    ['{BC3716E8-079B-4540-B597-37D651B29D26}']
    function Add( aValue : ICommand) : IInvoker;
    function Execute : IInvoker;
  End;

implementation

end.
