package chrome;

/**
* The `chrome.extension` API has utilities that can be used by any extension page.
* It includes support for exchanging messages between an extension and its
* content scripts or between extensions, as described in detail in
* [Message Passing](https://developer.chrome.com/docs/extensions/messaging).
*/
@:native("chrome.extension")
extern class Extension {

	/**
	* Returns an array of the JavaScript 'window' objects for each of the pages running inside the current extension.
	*
	* @returns Array of global objects
	* @chrome-disallow-service-workers
	*/
	static function getViews( ?fetchProperties : {
		/**
		* The type of view to get. If omitted, returns all views (including background pages and tabs).
		*/
		?type : ViewType,

		/**
		* The window to restrict the search to. If omitted, returns all views.
		*/
		?windowId : Int,

		/**
		* Find a view according to a tab id. If this field is omitted, returns all views.
		*
		* @since Chrome 54
		*/
		?tabId : Int,
	}) : Array<Window>;

	/**
	* Returns the JavaScript 'window' object for the background page running inside
	* the current extension. Returns null if the extension has no background page.
	*
	* @chrome-disallow-service-workers
	*/
	static function getBackgroundPage() : Null<Window>;

	/**
	* Retrieves the state of the extension's access to Incognito-mode.
	* This corresponds to the user-controlled per-extension 'Allowed in Incognito'
	* setting accessible via the chrome://extensions page.
	*
	* @param callback isAllowedAccess True if the extension has access to Incognito mode, false otherwise.
	*/
	overload static function isAllowedIncognitoAccess( callback : (isAllowedAccess : Bool)->Void) : Void;
	overload static function isAllowedIncognitoAccess() : Promise<Bool>;

	/**
	* Retrieves the state of the extension's access to the 'file://' scheme.
	* This corresponds to the user-controlled per-extension 'Allow access to
	* File URLs' setting accessible via the chrome://extensions page.
	*
	* @param callback isAllowedAccess True if the extension can access the 'file://' scheme, false otherwise.
	*/
	overload static function isAllowedFileSchemeAccess( callback : (isAllowedAccess : Bool)->Void) : Void;
	overload static function isAllowedFileSchemeAccess() : Promise<Bool>;

	/**
	* Sets the value of the ap CGI parameter used in the extension's update URL.
	* This value is ignored for extensions that are hosted in the Chrome Extension Gallery.
	*/
	static function setUpdateUrlData( data : String ) : Void;
}

/**
* The type of extension view.
*
* @since Chrome 44
*/
extern enum abstract ViewType(String) to String {
	var TAB = "tab";
	var POPUP = "popup";
}

/**
* True for content scripts running inside incognito tabs,
* and for extension pages running inside an incognito process.
* The latter only applies to extensions with 'split' incognito\_behavior.
*/
typedef InIncognitoContext = Bool;


