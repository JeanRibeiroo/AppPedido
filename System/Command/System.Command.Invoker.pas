unit System.Command.Invoker;

interface

uses
  System.Command.Interfaces,
  System.Iterator.Interfaces;

Type

  TInvoker = class(TInterfacedObject,IInvoker)
    private
      FList: IModelIterator<ICommand>;
    public
      constructor Create;
      destructor  Destroy; override;
      class function New: IInvoker;
      function Add( aValue : ICommand) : IInvoker;
      function Execute : IInvoker;
  end;

implementation

uses
  System.Iterator.Iterator;



{ TInvoker }

function TInvoker.Add(aValue: ICommand): IInvoker;
begin
  Result := Self;
  FList.Add(aValue);
end;

constructor TInvoker.Create;
begin
  FList := TModelIterator<ICommand>.New;
end;

destructor TInvoker.Destroy;
begin

  inherited;
end;

function TInvoker.Execute: IInvoker;
begin
  Result := Self;
  while FList.HasNext do
  begin
    FList.Itens.Execute;
    FList.Next;
  end;
end;

class function TInvoker.New: IInvoker;
begin
  Result := Self.Create;
end;

end.
