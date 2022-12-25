package chrome;

// The MV3 API `action` incorrectly references the MV2-only API `browserAction`.

/**
* A tuple of RGBA values.
*
* type ColorArray = [number, number, number, number];
*/
typedef ColorArray = Array<Int>;

/**
* Pixel data for an image. Must be an ImageData object; for example, from a `canvas` element.
*/
typedef ImageDataType = js.html.ImageData;
