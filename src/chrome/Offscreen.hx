package chrome;

/**
* Use the `offscreen` API to create and manage offscreen documents.
*
* @since Pending
* @chrome-permission offscreen
* @chrome-min-manifest MV3
*/
@:native("chrome.offscreen")
extern class Offscreen {

	/**
	* Creates a new offscreen document for the extension.
	*
	* @param params The parameters describing the offscreen document to create.
	* @param callback Invoked when the offscreen document is created and has completed its initial page load.
	*/
	overload static function createDocument( params : CreateParameters, callback : ()->Void ) : Void;
	overload static function createDocument( params : CreateParameters ) : Promise<Void>;

	/**
	* Closes the currently-open offscreen document for the extension.
	*
	* @param callback Invoked when the offscreen document has been closed.
	*/
	overload static function closeDocument( callback : ()->Void ) : Void;
	overload static function closeDocument() : Promise<Void>;
}

/**
* @chrome-enum "TESTING" A reason used for testing purposes only.
* @chrome-enum "AUDIO\_PLAYBACK" The offscreen document is responsible for playing audio.
* @chrome-enum "IFRAME\_SCRIPTING" The offscreen document needs to embed and script an iframe in order to modify the iframe's content.
* @chrome-enum "DOM\_SCRAPING" The offscreen document needs to embed an iframe and scrape its DOM to extract information.
* @chrome-enum "BLOBS" The offscreen document needs to interact with Blob objects (including `URL.createObjectURL()`).
* @chrome-enum "DOM\_PARSER" The offscreen document needs to use the `DOMParser` API.
* @chrome-enum "USER\_MEDIA" The offscreen document needs to interact with media streams from user media (e.g. `getUserMedia()`).
* @chrome-enum "DISPLAY\_MEDIA" The offscreen document needs to interact with media streams from display media (e.g. `getDisplayMedia()`
* @chrome-enum "WEB\_RTC" The offscreen document needs to use WebRTC APIs.
* @chrome-enum "CLIPBOARD" The offscreen document needs to interact with the clipboard APIs (e.g. `Navigator.clipboard`).
*/
extern enum abstract Reason(String) to String {
	var TESTING = "TESTING";
	var AUDIO_PLAYBACK = "AUDIO_PLAYBACK";
	var IFRAME_SCRIPTING = "IFRAME_SCRIPTING";
	var DOM_SCRAPING = "DOM_SCRAPING";
	var BLOBS = "BLOBS";
	var DOM_PARSER = "DOM_PARSER";
	var USER_MEDIA = "USER_MEDIA";
	var DISPLAY_MEDIA = "DISPLAY_MEDIA";
	var WEB_RTC = "WEB_RTC";
	var CLIPBOARD = "CLIPBOARD";
}

typedef CreateParameters = {

	/**
	* The reason(s) the extension is creating the offscreen document.
	*/
	var reasons : Array<Reason>;

	/**
	* The (relative) URL to load in the document.
	*/
	var url : String;

	/**
	* A developer-provided string that explains, in more detail,
	* the need for the background context. The user agent \_may\_ use this in display to the user.
	*/
	var justification : String;
}
