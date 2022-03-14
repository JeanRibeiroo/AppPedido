unit System.DAO.Factory;

interface

uses
  System.DAO.Interfaces,
  System.DAO.Params;
Type
  TModelDAOFactory = class(TInterfacedObject,IModelDAOFactory)
    private
    public
      constructor Create;
      destructor  Destroy;override;
      class function New:IModelDAOFactory;
      function REST: IDAORest;
      function Params: IParams;
  end;

implementation

uses
  System.DAO.DAORest;




{ TModelDAOFactory<T:IInterface> }

constructor TModelDAOFactory.Create;
begin

end;

destructor TModelDAOFactory.Destroy;
begin

  inherited;
end;

class function TModelDAOFactory.New: IModelDAOFactory;
begin
  Result := Self.Create;
end;

function TModelDAOFactory.Params: IParams;
begin
  Result :=  TParams.New;
end;

function TModelDAOFactory.REST: IDAORest;
begin
  Result := TDAORest.New;
end;

end.
