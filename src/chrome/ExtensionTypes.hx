package chrome;

/**
* The format of an image.
*
* @since Chrome 44
*/
extern enum abstract ImageFormat(String) to String {
	var JPEG = "jpeg";
	var PNG = "png";
}

/**
* Details about the format and quality of an image.
*/
typedef ImageDetails = {
	/**
	* The format of the resulting image. Default is `"jpeg"`.
	*/
	var ?format : ImageFormat;

	/**
	* When format is `"jpeg"`, controls the quality of the resulting image.
	* This value is ignored for PNG images. As quality is decreased,
	* the resulting image will have more visual artifacts, and the number
	* of bytes needed to store it will decrease.
	*/
	var ?quality : Float;
}

/**
* The soonest that the JavaScript or CSS will be injected into the tab.
*
* @since Chrome 44
*/
extern enum abstract RunAt(String) to String {
	var DOCUMENT_START = "document_start";
	var DOCUMENT_END = "document_end";
	var DOCUMENT_IDLE = "document_idle";
}

/**
* The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of injected CSS.
*
* @since Chrome 66
*/
extern enum abstract CSSOrigin(String) to String {
	var AUTHOR = "author";
	var USER = "user";
}

/**
* Details of the script or CSS to inject. Either the code or the file property must be set, but both may not be set at the same time.
*/
typedef InjectDetails = {
	/**
	* JavaScript or CSS code to inject.
	*
	* **Warning:**
	* Be careful using the `code` parameter. Incorrect use of it may open your
	* extension to [cross site scripting](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.
	*/
	var ?code : String;

	/**
	* JavaScript or CSS file to inject.
	*/
	var ?file : String;

	/**
	* If allFrames is `true`, implies that the JavaScript or CSS should be
	* injected into all frames of current page. By default, it's `false` and
	* is only injected into the top frame. If `true` and `frameId` is set,
	* then the code is inserted in the selected frame and all of its child frames.
	*/
	var ?allFrames : Bool;

	/**
	* The [frame](https://developer.chrome.com/docs/extensions/reference/webNavigation/#frame_ids)
	* where the script or CSS should be injected. Defaults to 0 (the top-level frame).
	*
	* @since Chrome 50
	*/
	var ?frameId : Int;

	/**
	* If matchAboutBlank is true, then the code is also injected in about:blank
	* and about:srcdoc frames if your extension has access to its parent document.
	* Code cannot be inserted in top-level about:-frames. By default it is `false`.
	*/
	var ?matchAboutBlank : Bool;

	/**
	* The soonest that the JavaScript or CSS will be injected into the tab.
	* Defaults to "document\_idle".
	*/
	var ?runAt : RunAt;

	/**
	* The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins) of
	* the CSS to inject. This may only be specified for CSS, not JavaScript.
	* Defaults to `"author"`.
	*
	* @since Chrome 66
	*/
	var ?cssOrigin : CSSOrigin;
}

/**
* Details of the CSS to remove. Either the code or the file property must be set, but both may not be set at the same time.
*
* @since Chrome 87
*/
typedef DeleteInjectionDetails = {
	/**
	* CSS code to remove.
	*/
	var ?code : String;

	/**
	* CSS file to remove.
	*/
	var ?file : String;

	/**
	* If allFrames is `true`, implies that the CSS should be removed from
	* all frames of current page. By default, it's `false` and is only removed
	* from the top frame. If `true` and `frameId` is set, then the code is
	* removed from the selected frame and all of its child frames.
	*/
	var ?allFrames : Bool;

	/**
	* The [frame](https://developer.chrome.com/docs/extensions/reference/webNavigation/#frame_ids)
	* from where the CSS should be removed. Defaults to 0 (the top-level frame).
	*/
	var ?frameId : Int;

	/**
	* If matchAboutBlank is true, then the code is also removed from about:blank
	* and about:srcdoc frames if your extension has access to its parent document.
	* By default it is `false`.
	*/
	var ?matchAboutBlank : Bool;

	/**
	* The [origin](https://www.w3.org/TR/css3-cascade/#cascading-origins)
	* of the CSS to remove. Defaults to `"author"`.
	*/
	var ?cssOrigin : CSSOrigin;
}

/**
* The type of frame.
*
* @since Chrome 106
*/
extern enum abstract FrameType(String) to String {
	var OUTERMOST_FRAME = "outermost_frame";
	var FENCED_FRAME = "fenced_frame";
	var SUB_FRAME = "sub_frame";
}

/**
* The document lifecycle of the frame.
*
* @since Chrome 106
*/
extern enum abstract DocumentLifecycle(String) to String {
	var PRERENDER = "prerender";
	var ACTIVE = "active";
	var CACHED = "cached";
	var PENDING_DELETION = "pending_deletion";
}
