unit Server.Model.DAO;

interface

uses
  Data.DB,
  System.JSON,
  ServidorAPI.Model.Conexao.Interfaces,
  Server.Model.SQL;

Type


  IDAOGeneric = Interface
    ['{EAF45915-B595-4812-9EEE-B5BDB034D719}']
    function SQL: ISQL<IDAOGeneric>;
    function Select: IDAOGeneric;
    function Insert : IDAOGeneric;
    function Update : IDAOGeneric;
    function Delete : IDAOGeneric;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function DataSetAsJsonPaginate : TJsonObject;
    function DataSetAsInteger : Integer;
    function DataSetToStream : String;
    function DataSet: TDataSet;
  End;

  TDAOGeneric = class(TInterfacedObject, IDAOGeneric)
    private
      [weak]
      FDataSet: IModelDataSet;
      FSQL: ISQL<IDAOGeneric>;
      FResult : TJSONValue;
      FDataSource : TDataSource;
      FNotFree: Boolean;
    public
      constructor Create(DataSet: IModelDataSet; aNotFree: Boolean = True);
      destructor Destroy; override;
      class function New(DataSet: IModelDataSet; aNotFree: Boolean = True): IDAOGeneric;
      function SQL: ISQL<IDAOGeneric>;
      function Select: IDAOGeneric;
      function Insert : IDAOGeneric;
      function Update : IDAOGeneric;
      function Delete : IDAOGeneric;
      function DataSetAsJsonArray : TJsonArray;
      function DataSetAsJsonObject : TJsonObject;
      function DataSetAsJsonPaginate : TJsonObject;
      function DataSetAsInteger : Integer;
      function DataSetToStream : String;
      function DataSet: TDataSet;
  end;

implementation

uses
  DataSet.Serialize;

{ TDAOGeneric }


constructor TDAOGeneric.Create(DataSet: IModelDataSet; aNotFree: Boolean = True);
begin
  FNotFree := aNotFree;
  FDataSet := DataSet;
  FSQL := TSQL<IDAOGeneric>.New(self);
  FDataSource := TDataSource.Create(nil);
  FResult := nil;
end;

destructor TDAOGeneric.Destroy;
begin
  if FNotFree then
    FDataSource.Free;
  inherited;
end;

function TDAOGeneric.DataSet: TDataSet;
begin
  Result := TDataSet.Create(nil);
  Result := FDataSource.DataSet;
end;

function TDAOGeneric.DataSetAsInteger: Integer;
begin
  Result := FDataSource.DataSet.FieldByName('ID').AsInteger;;
end;

function TDAOGeneric.DataSetAsJsonArray: TJsonArray;
begin
  if Assigned(FResult) then
  begin
    Result := TJsonArray(FResult);
    Exit;
  end;
  Result := FDataSource.DataSet.ToJSONArray;
end;

function TDAOGeneric.DataSetAsJsonObject: TJsonObject;
begin
  if Assigned(FResult) then
  begin
    Result := TJSONObject(FResult);
    Exit;
  end;
  Result := FDataSource.DataSet.ToJSONObject;
end;

function TDAOGeneric.DataSetAsJsonPaginate: TJsonObject;
begin
  if Assigned(FResult) then
  begin
    Result := TJSONObject(FResult);
    Exit;
  end;
  Result := TJSONObject.Create;
  Result.AddPair('data', FDataSource.DataSet.ToJSONArray);
  Result.AddPair('records', TJSONNumber.Create(
     TDataSet(FDataSet.Open(FSQL.SelectRecordCount).EndDataSet)
        .FieldByName('RECORDCOUNT')
        .AsInteger));

end;

function TDAOGeneric.DataSetToStream: String;
begin

end;

function TDAOGeneric.Delete: IDAOGeneric;
begin
  Result := Self;
  FDataSet.Exec(FSQL.Delet).EndDataSet;

end;

function TDAOGeneric.Insert: IDAOGeneric;
begin
  Result := Self;
  FDataSet.Exec(FSQL.Insert).EndDataSet;
  FDataSource.DataSet := TDataSet(FDataSet.Open('SELECT LAST_INSERT_ID() AS ID FROM ' + FSQL.Tabela).EndDataSet);

end;

function TDAOGeneric.Select: IDAOGeneric;
begin
  Result := Self;

  FDataSource.DataSet := TDataSet(FDataSet.Open(FSQL.Select).EndDataSet);

end;

class function TDAOGeneric.New(DataSet: IModelDataSet; aNotFree: Boolean = True): IDAOGeneric;
begin
  Result := Self.Create(DataSet, aNotFree);
end;

function TDAOGeneric.SQL: ISQL<IDAOGeneric>;
begin
  Result := FSQL;
end;

function TDAOGeneric.Update: IDAOGeneric;
begin
  Result := Self;
  FDataSet.Exec(FSQL.Update).EndDataSet;

end;

end.
