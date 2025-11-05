unit yellowfinbi.api.images.intf;

interface

uses yellowfinbi.api.common, System.SysUtils, System.Classes;

type
  TYFImagesTypes = class(TYFTypes)
    type
      {$SCOPEDENUMS ON}
      thumbSize = (THUMB_STRETCH_100x60, THUMB_SCALE_100x100,
                   THUMB_SCALE_200x200, THUMB_CROP_290x170,
                   THUMB_SCALEWIDTH_MAXHEIGHT_290x400, THUMB_SCALEFILL_50x50,
                   THUMB_SCALE_250x250, THUMB_SCALE_900x400,
                   THUMB_SCALE_405x318);
      imageLoadType = (IMAGE, IMAGE_THUMBNAIL, DASHBOARD_THUMBNAIL, MULTI_CHART_THUMBNAIL);
      {$SCOPEDENUMS OFF}
  end;

  IYFImageModel = interface
    ['{ABCDEF01-2345-6789-ABCD-0123456789AB}']
    function GetAsBytes: TBytes;
    function GetAsStream: TStream;
    function GetAsBase64: string;

    procedure LoadFromBase64(const Base64String: string);
    procedure LoadFromStream(AStream: TStream);

    procedure SaveToFile(const AFileName: string);
    procedure Assign(RawBytes : TBytes);
  end;


implementation

end.
