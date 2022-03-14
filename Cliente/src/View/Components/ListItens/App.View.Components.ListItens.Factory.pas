unit App.View.Components.ListItens.Factory;

interface

uses
  FMX.Types,
  App.View.Components.ListItens.Item001,
  System.Classes;

Type

  IComponentsListItensFactory = Interface
    ['{E37D388F-DDB4-4446-B013-31F8C2019F39}']
    function Container(aValue : TFmxObject ) : IComponentsListItensFactory;
    function ListItem001( aOwner : Tcomponent ) : IComponents<TItem001>;
  End;

  TComponentsListItensFactory = Class(TInterfacedObject, IComponentsListItensFactory)
    private
      FContainer: TFmxObject;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: IComponentsListItensFactory;
      function Container(aValue : TFmxObject ) : IComponentsListItensFactory;
      function ListItem001( aOwner : Tcomponent ) : IComponents<TItem001>;
  End;



implementation

{ TComponentsListItensFactory }

function TComponentsListItensFactory.Container(
  aValue: TFmxObject): IComponentsListItensFactory;
begin
   Result := Self;
   FContainer := aValue;
end;

constructor TComponentsListItensFactory.Create;
begin

end;

destructor TComponentsListItensFactory.Destroy;
begin

  inherited;
end;

function TComponentsListItensFactory.ListItem001(
  aOwner: Tcomponent): IComponents<TItem001>;
begin
   Result := (TItem001.Create(aOwner) as IComponents<TItem001>).Container(FContainer);
end;

class function TComponentsListItensFactory.New: IComponentsListItensFactory;
begin
  Result := Self.Create;
end;

end.
