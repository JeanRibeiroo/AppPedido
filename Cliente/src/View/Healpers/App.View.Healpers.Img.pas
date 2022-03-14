unit App.View.Healpers.Img;

interface

uses
  FMX.Objects;

Type

  TImageHelpers = class helper for TImage
    procedure ResourceImage(aResource: string);
  end;

implementation

uses
  System.Classes,
  Winapi.Windows;

{ TImageHelpers }

procedure TImageHelpers.ResourceImage(aResource: string);
var lResource:TResourceStream;
begin
  lResource := TResourceStream.Create(HInstance,aResource,RT_RCDATA);
  try
    Self.Bitmap.LoadFromStream(lResource);
  finally
    lResource.Free;
  end;
end;

end.
