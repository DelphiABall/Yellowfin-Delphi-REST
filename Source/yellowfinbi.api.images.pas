unit yellowfinbi.api.images;

interface

uses yellowfinbi.api.images.intf, yellowfinbi.api.common, yellowfinbi.api.transport,
  yellowfinbi.api.transport.classes;

type
  TYF_Images = class
  public
    /// <summary>
    ///   Get an Image based on its ID
    /// </summary>
    class function GetImages (const ServerDetails : IYFServerDetails;
                              const yf_AccessToken : string;
                              const yf_ImageID: Int64;
                              const ThumbSize : TYFImagesTypes.thumbSize;
                              const ImageLoadType : TYFImagesTypes.imageLoadType;
                              var Image: IYFImageModel): IYFTransportResponse;
  end;

implementation

uses
  System.SysUtils, REST.Types, yellowfinbi.api.classfactory;

{ TYF_Images }

class function TYF_Images.GetImages(const ServerDetails: IYFServerDetails;
  const yf_AccessToken: string; const yf_ImageID: Int64;
  const ThumbSize: TYFImagesTypes.thumbSize;
  const ImageLoadType : TYFImagesTypes.imageLoadType;
  var Image: IYFImageModel): IYFTransportResponse;
begin
  var ThumbSizeStr := TYFImagesTypes.ValueToString<TYFImagesTypes.thumbSize>(ThumbSize);
  var ImageLoadTypeStr := TYFImagesTypes.ValueToString<TYFImagesTypes.imageLoadType>(ImageLoadType);

  var aURL := Format('api/images/%d?thumbSize=%s&imageLoadType=%s',[yf_ImageID, ThumbSizeStr, ImageLoadTypeStr]);

  // Build the request and send it
  var Transport := TYFTransport.Create(nil,
        TRESTRequestMethod.rmGet,
        ServerDetails,
        aURL,
        yf_AccessToken,
        nil); // no body required
  Transport.Accepts := 'image/*';

  try
    Result := Transport.Execute;

    if Image = nil then
      Image := yellowfinbi.api.classfactory.TYFFactoryRegistry.ResolveFactory<IYFImageModel>()(); // TYFImageModel.Create;

    Image.Assign(Transport.RESTResponse.RawBytes);

  finally
    Transport.Free;
  end;
end;

end.
