unit Server.Model.SQL;

interface

uses
  System.Generics.Collections, System.JSON;

Type
   ISQL<T> = Interface
     ['{22DFCCC8-B7D1-46D1-9C44-C09DE49EFB81}']
     function Insert: string;
     function Update: string;
     function Delet: string;
     function Select : string; overload;
     function Select (var aSQL : String) : ISQL<T>; overload;
     function SelectRecordCount: string;
     function Tabela(aSQL: string) : ISQL<T>; overload;
     function Tabela: string; overload;
     function Fields (aSQL : String) :ISQL<T>;
     function Value (aSQL : String) :ISQL<T>;
     function Params ( aParams : String ) :ISQL<T>;
     function Where (aSQL : String) : ISQL<T>;
     function GroupBy (aSQL : String) : ISQL<T>;
     function OrderBy (aSQL : String) : ISQL<T>; overload;
     function OrderBy (aParams : TDictionary<string, string>): ISQL<T>; overload;
     function Limit (aLimit, aOffset: Integer): ISQL<T>; overload;
     function Limit (aParams : TDictionary<string, string>): ISQL<T>; overload;
     function Join (aSQL : String) : ISQL<T>;
     function SQL : string;
     function JsonToSQL (aValue: TJSONObject) : ISQL<T>;
     function &End : T;
   End;

   TSQL<T: IInterface> = class(TInterfacedObject, ISQL<T>)
     private
       [weak]
       FParent: T;
       FSQL: string;
       FTabela: string;
       FField: string;
       FValue: String;
       FParams: String;
       FWhere: string;
       FOrderBy: string;
       FGroupBy: string;
       FLimit: string;
       FJsonParams: TJSONObject;
       procedure GetParamsJsonInsert(aValue: TJSONObject);
       procedure GetParamsJsonUpDate(aValue: TJSONObject);
     public
       constructor Create(aParent: T);
       destructor Destroy; override;
       class function New(aParent: T): ISQL<T>;
       function Insert: string;
       function Update: string;
       function Delet: string;
       function Select : string; overload;
       function Select (var aSQL : String) : ISQL<T>; overload;
       function SelectId(var aSQL: String): ISQL<T>;
       function SelectRecordCount: string;
       function Tabela(aSQL: string) : ISQL<T>; overload;
       function Tabela: string; overload;
       function Fields (aSQL : String) :ISQL<T>;
       function Value (aSQL : String) :ISQL<T>;
       function Params ( aParams : String ) :ISQL<T>;
       function Where (aSQL : String) : ISQL<T>;
       function GroupBy (aSQL : String) : ISQL<T>;
       function OrderBy (aSQL : String) : ISQL<T>; overload;
       function OrderBy (aParams : TDictionary<string, string>): ISQL<T>; overload;
       function Limit (aLimit, aOffset: Integer): ISQL<T>; overload;
       function Limit (aParams : TDictionary<string, string>): ISQL<T>; overload;
       function Join (aSQL : String) : ISQL<T>;
       function SQL : string;
       function JsonToSQL (aValue: TJSONObject) : ISQL<T>;
       function &End : T;
   end;


implementation

uses
  System.SysUtils;

{ TSQL<T> }

constructor TSQL<T>.Create(aParent: T);
begin
  FParent := aParent;
  FSQL :=  EmptyStr;
  FTabela :=  EmptyStr;
  FField :=  EmptyStr;
  FValue :=  EmptyStr;
  FParams := EmptyStr;
  FWhere :=  EmptyStr;
  FOrderBy :=  EmptyStr;
  FGroupBy :=  EmptyStr;
  FLimit :=  EmptyStr;
  FJsonParams := nil;
end;

function TSQL<T>.Delet: string;
begin
  Result := Format('DELETE FROM %s %s;',[FTabela,FWhere]);
end;

destructor TSQL<T>.Destroy;
begin

  inherited;
end;

function TSQL<T>.&End: T;
begin
  Result := FParent;
end;

function TSQL<T>.Fields(aSQL: String): ISQL<T>;
begin
  Result := Self;
  FField :=  FField + aSQL;
end;

procedure TSQL<T>.GetParamsJsonInsert(aValue: TJSONObject);
var LJsonPar: TJSONPair;
begin

  for LJsonPar in aValue do
  begin
     FField := FField + LJsonPar.JsonString.Value + ', ';
    if LJsonPar.JsonValue is TJSONString  then
      FValue := FValue + QuotedStr(LJsonPar.JsonValue.Value) + ', '
    else
      FValue := FValue + LJsonPar.JsonValue.Value + ', ';
  end;
   Delete(FField, Length(FField)-1, 1);
   Delete(FValue, Length(FValue)-1, 1);
end;

procedure TSQL<T>.GetParamsJsonUpDate(aValue: TJSONObject);
var LJsonPar: TJSONPair;
begin
  if Assigned(FJsonParams) then
  begin
    for LJsonPar in FJsonParams do
    begin
      FParams := FParams + LJsonPar.JsonString.Value + ' = ';
      if LJsonPar.JsonValue is TJSONString  then
        FParams := FParams + QuotedStr(LJsonPar.JsonValue.Value) + ', '
      else
        FParams := FParams + LJsonPar.JsonValue.Value + ', ';
    end;
    Delete(FParams, Length(FParams)-1, 1);
  end;
end;

function TSQL<T>.GroupBy(aSQL: String): ISQL<T>;
begin
  Result := Self;
  FGroupBy := Format(' GROUP BY %s ',[aSQL]);
end;

function TSQL<T>.JsonToSQL(aValue: TJSONObject): ISQL<T>;
begin
  Result := self;
  FJsonParams := aValue;
end;

function TSQL<T>.Insert: string;
begin
   if Assigned(FJsonParams) then
     GetParamsJsonInsert(FJsonParams);

   Result :=  Format('INSERT INTO %s ( %s ) VALUES ( %s )',[FTabela, FField, FValue]);
end;

function TSQL<T>.Join(aSQL: String): ISQL<T>;
begin
  Result := Self;
end;

function TSQL<T>.Limit (aParams : TDictionary<string, string>): ISQL<T>;
var
  LLimit : string;
  LOffset : string;
begin
  Result := Self;
  aParams.TryGetValue('limit', LLimit);
  aParams.TryGetValue('offset', LOffset);

  if LOffset.IsEmpty then
    LOffset := IntToStr(0);
  if LLimit.IsEmpty then
    LLimit := IntToStr(50);

  FLimit := Format('LIMIT %s, %s',[LOffset, LLimit]);
end;

function TSQL<T>.Limit(aLimit, aOffset: Integer): ISQL<T>;
begin
  Result := Self;
  FOrderBy := Format('LIMIT %d %d',[aLimit, aOffset]);
end;

class function TSQL<T>.New(aParent: T): ISQL<T>;
begin
  Result := Self.Create(aParent);
end;

function TSQL<T>.OrderBy(aParams: TDictionary<string, string>): ISQL<T>;
var
  LOrder : string;
  LSort : string;
begin
  Result := Self;
  aParams.TryGetValue('sort', LSort);
  aParams.TryGetValue('order', LOrder);
  if (LSort.IsEmpty) or (LOrder.IsEmpty) then
  begin
     FOrderBy := EmptyStr;
     Exit;
  end;
  FOrderBy := Format('ORDER BY %s %s',[LSort, LOrder]);
end;

function TSQL<T>.Params( aParams : String ): ISQL<T>;
begin
  Result := Self;
  FParams := aParams;
end;

function TSQL<T>.OrderBy(aSQL: String): ISQL<T>;
begin
  Result := Self;
  FOrderBy := Format('ORDER BY %s',[aSQL]);
end;

function TSQL<T>.Select(var aSQL: String): ISQL<T>;
begin

end;

function TSQL<T>.Select: string;
begin
  Result :=  Format('SELECT %s FROM %s %s %s %s %s',[FField, FTabela, FWhere, FGroupBy, FOrderBy, FLimit])
end;

function TSQL<T>.SelectId(var aSQL: String): ISQL<T>;
begin

end;

function TSQL<T>.SelectRecordCount: string;
begin
   Result :=  Format('SELECT Count(*) AS RECORDCOUNT FROM %s %s %s %s ',[FTabela, FWhere, FGroupBy, FOrderBy])
end;

function TSQL<T>.SQL: string;
begin
  Result :=  FSQL;
end;

function TSQL<T>.Tabela: string;
begin
  Result := FTabela;
end;

function TSQL<T>.Tabela(aSQL: string): ISQL<T>;
begin
  Result := Self;
  FTabela := aSQL;
end;

function TSQL<T>.Update: string;
begin
   GetParamsJsonUpDate(FJsonParams);
   Result :=  Format('UPDATE %s SET %s %s',[FTabela, FParams, FWhere]);
end;

function TSQL<T>.Value(aSQL: String): ISQL<T>;
begin
  Result := Self;
  FValue := FValue + aSQL;
end;

function TSQL<T>.Where(aSQL: String): ISQL<T>;
begin
  Result := Self;
  FWhere := Format(' WHERE 1 = 1 %s ',[aSQL]);
end;

end.
