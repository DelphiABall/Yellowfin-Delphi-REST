unit yellowfinbi.api.images.classes;

interface

uses System.SysUtils, System.Classes, yellowfinbi.api.images.intf;

type
  TYFImageModel = class(TInterfacedObject, IYFImageModel)
  private
    FBytes: TBytes;
  public
    function GetAsBytes: TBytes;
    function GetAsStream: TStream;
    function GetAsBase64: string;

    procedure LoadFromBase64(const Base64String: string);
    procedure LoadFromStream(AStream: TStream);

    procedure SaveToFile(const AFileName: string);
    procedure Assign(RawBytes : TBytes);
  end;

implementation

uses System.NetEncoding, yellowfinbi.api.classfactory;


{ TYFImageModel }

function TYFImageModel.GetAsBytes: TBytes;
begin
  Result := FBytes;
end;

function TYFImageModel.GetAsStream: TStream;
begin
  Result := TMemoryStream.Create;

  if Length(FBytes) > 0 then
    Result.WriteBuffer(FBytes[0], Length(FBytes));

  Result.Position := 0;
end;

procedure TYFImageModel.Assign(RawBytes: TBytes);
begin
  if Length(RawBytes) = 0 then
    FBytes := nil
  else
    FBytes := Copy(RawBytes, 0, Length(RawBytes));
end;

procedure TYFImageModel.LoadFromBase64(const Base64String: string);
begin
  FBytes := TNetEncoding.Base64.DecodeStringToBytes(Base64String);
end;

function TYFImageModel.GetAsBase64: string;
begin
  Result := TNetEncoding.Base64.EncodeBytesToString(FBytes);
end;

procedure TYFImageModel.LoadFromStream(AStream: TStream);
var
  LSize: Integer;
begin
  if Assigned(AStream) then
  begin
    LSize := AStream.Size - AStream.Position;
    SetLength(FBytes, LSize);
    AStream.ReadBuffer(FBytes[0], LSize);
  end;
end;

procedure TYFImageModel.SaveToFile(const AFileName: string);
var
  FS: TFileStream;
begin
  if Length(FBytes) = 0 then
    raise Exception.Create('No image data to save.');

  FS := TFileStream.Create(AFileName, fmCreate);
  try
    FS.WriteBuffer(FBytes[0], Length(FBytes));
  finally
    FS.Free;
  end;
end;

initialization
   TYFFactoryRegistry.RegisterFactory<IYFImageModel>(
    function: IYFImageModel
    begin
      Result := TYFImageModel.Create;
    end
  );

end.
