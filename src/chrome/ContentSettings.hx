package chrome;

/**
* Use the `chrome.contentSettings` API to change settings that control whether
* websites can use features such as cookies, JavaScript, and plugins.
* More generally speaking, content settings allow you to customize
* Chrome's behavior on a per-site basis instead of globally.
*
* @chrome-permission contentSettings
*/
@:native("chrome.contentSettings")
extern class ContentSettings {
	/**
	* Whether to allow cookies and other local data to be set by websites. One of
	* `allow`: Accept cookies,
	* `block`: Block cookies,
	* `session\_only`: Accept cookies only for the current session.
	* Default is `allow`.
	* The primary URL is the URL representing the cookie origin. The secondary URL is the URL of the top-level frame.
	*/
	static final cookies : ContentSetting<CookiesContentSetting>;

	/**
	* Whether to show images. One of
	* `allow`: Show images,
	* `block`: Don't show images.
	* Default is `allow`.
	* The primary URL is the URL of the top-level frame. The secondary URL is the URL of the image.
	*/
	static final images : ContentSetting<ImagesContentSetting>;

	/**
	* Whether to run JavaScript. One of
	* `allow`: Run JavaScript,
	* `block`: Don't run JavaScript.
	* Default is `allow`.
	* The primary URL is the URL of the top-level frame. The secondary URL is not used.
	*/
	static final javascript : ContentSetting<JavascriptContentSetting>;

	/**
	* Whether to allow Geolocation. One of
	* `allow`: Allow sites to track your physical location,
	* `block`: Don't allow sites to track your physical location,
	* `ask`: Ask before allowing sites to track your physical location.
	* Default is `ask`.
	* The primary URL is the URL of the document which requested location data. The secondary URL is the URL of the top-level frame (which may or may not differ from the requesting URL).
	*/
	static final location : ContentSetting<LocationContentSetting>;

	/**
	* _Deprecated._ With Flash support removed in Chrome 88,
	* this permission no longer has any effect.
	* Value is always `block`. Calls to `set()` and `clear()` will be ignored.
	*/
	@:deprecated
	static final plugins : ContentSetting<PluginsContentSetting>;

	/**
	* Whether to allow sites to show pop-ups. One of
	* `allow`: Allow sites to show pop-ups,
	* `block`: Don't allow sites to show pop-ups.
	* Default is `block`.
	* The primary URL is the URL of the top-level frame. The secondary URL is not used.
	*/
	static final popups : ContentSetting<PopupsContentSetting>;

	/**
	* Whether to allow sites to show desktop notifications. One of
	* `allow`: Allow sites to show desktop notifications,
	* `block`: Don't allow sites to show desktop notifications,
	* `ask`: Ask when a site wants to show desktop notifications.
	* Default is `ask`.
	* The primary URL is the URL of the document which wants to show the notification. The secondary URL is not used.
	*/
	static final notifications : ContentSetting<NotificationsContentSetting>;

	/**
	* _Deprecated._ No longer has any effect.
	* Fullscreen permission is now automatically granted for all sites.
	* Value is always `allow`.
	*/
	@:deprecated
	static final fullscreen : ContentSetting<FullscreenContentSetting>;

	/**
	* _Deprecated._ No longer has any effect.
	* Mouse lock permission is now automatically granted for all sites.
	* Value is always `allow`.
	*/
	@:deprecated
	static final mouselock : ContentSetting<MouselockContentSetting>;

	/**
	* Whether to allow sites to access the microphone. One of
	* `allow`: Allow sites to access the microphone,
	* `block`: Don't allow sites to access the microphone,
	* `ask`: Ask when a site wants to access the microphone.
	* Default is `ask`.
	* The primary URL is the URL of the document which requested microphone access. The secondary URL is not used.
	* NOTE: The 'allow' setting is not valid if both patterns are ''.
	*
	* @since Chrome 46
	*/
	static final microphone : ContentSetting<MicrophoneContentSetting>;

	/**
	* Whether to allow sites to access the camera. One of
	* `allow`: Allow sites to access the camera,
	* `block`: Don't allow sites to access the camera,
	* `ask`: Ask when a site wants to access the camera.
	* Default is `ask`.
	* The primary URL is the URL of the document which requested camera access. The secondary URL is not used.
	* NOTE: The 'allow' setting is not valid if both patterns are ''.
	*
	* @since Chrome 46
	*/
	static final camera : ContentSetting<CameraContentSetting>;

	/**
	* _Deprecated._ Previously, controlled whether to allow sites to run plugins unsandboxed,
	* however, with the Flash broker process removed in Chrome 88,
	* this permission no longer has any effect.
	* Value is always `block`. Calls to `set()` and `clear()` will be ignored.
	*/
	@:deprecated
	static final unsandboxedPlugins : ContentSetting<PpapiBrokerContentSetting>;

	/**
	* Whether to allow sites to download multiple files automatically. One of
	* `allow`: Allow sites to download multiple files automatically,
	* `block`: Don't allow sites to download multiple files automatically,
	* `ask`: Ask when a site wants to download files automatically after the first file.
	* Default is `ask`.
	* The primary URL is the URL of the top-level frame. The secondary URL is not used.
	*/
	static final automaticDownloads : ContentSetting<MultipleAutomaticDownloadsContentSetting>;
}

/**
* The only content type using resource identifiers is {@link contentSettings.plugins}.
* For more information, see [Resource Identifiers](https://developer.chrome.com/docs/extensions/reference/contentSettings/#resource-identifiers).
*/
typedef ResourceIdentifier = {

	/**
	* The resource identifier for the given content type.
	*/
	var id : String;

	/**
	* A human readable description of the resource.
	*/
	var ?description : String;
}

/**
* The scope of the ContentSetting. One of
* `regular`: setting for regular profile (which is inherited by the incognito
* profile if not overridden elsewhere),
* `incognito\_session\_only`: setting for incognito profile that can only be
* set during an incognito session and is deleted when the incognito session ends
* (overrides regular settings).
*
* @since Chrome 44
*/
extern enum abstract Scope(String) to String {
	var REGULAR = "regular";
	var INCOGNITO_SESSION_ONLY = "incognito_session_only";
}

extern class ContentSetting<T> {

	/**
	* Clear all content setting rules set by this extension.
	*/
	overload function clear( details : {scope : Scope}, callback : ()->Void ) : Void;
	overload function clear( details : {scope : Scope} ) : Promise<Void>;

	/**
	* Gets the current content setting for a given pair of URLs.
	*/
	overload function get( details : GetDetails, callback : ({setting : T})->Void ) : Void;
	overload function get( details : GetDetails ) : Promise<{setting : T}>;

	/**
	* Applies a new content setting rule.
	*/
	overload function set( details : SetDetails, callback : ()->Void ) : Void;
	overload function set( details : SetDetails ) : Promise<Void>;

	overload function getResourceIdentifiers( callback : (Array<ResourceIdentifier>)->Void ) : Void;
	overload function getResourceIdentifiers() : Promise<Array<ResourceIdentifier>>;
}

private typedef GetDetails = {
	/**
	* The primary URL for which the content setting should be retrieved.
	* Note that the meaning of a primary URL depends on the content type.
	*/
	var primaryUrl : String;

	/**
	* The secondary URL for which the content setting should be retrieved.
	* Defaults to the primary URL. Note that the meaning of a secondary URL
	* depends on the content type, and not all content types use secondary URLs.
	*/
	var ?secondaryUrl : String;

	/**
	* A more specific identifier of the type of content for which
	* the settings should be retrieved.
	*/
	var ?resourceIdentifier : ResourceIdentifier;

	/**
	* Whether to check the content settings for an incognito session. (default false)
	*/
	var ?incognito : Bool;
}

private typedef SetDetails = {
	/**
	* The pattern for the primary URL. For details on the format of a pattern, see [Content Setting Patterns](https://developer.chrome.com/docs/extensions/reference/contentSettings/#patterns).
	*/
	var primaryPattern : String;

	/**
	* The pattern for the secondary URL. Defaults to matching all URLs. For details on the format of a pattern, see [Content Setting Patterns](https://developer.chrome.com/docs/extensions/reference/contentSettings/#patterns).
	*/
	var ?secondaryPattern : String;

	/**
	* The resource identifier for the content type.
	*/
	var ?resourceIdentifier : ResourceIdentifier;

	/**
	* The setting applied by this rule. See the description of the individual ContentSetting objects for the possible values.
	*/
	var setting : Dynamic;

	/**
	* Where to set the setting (default: regular).
	*/
	var ?scope : Scope;
}

/**
* @since Chrome 44
*/
extern enum abstract CookiesContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var SESSION_ONLY = "session_only";
}

/**
* @since Chrome 44
*/
extern enum abstract ImagesContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
}

/**
* @since Chrome 44
*/
extern enum abstract JavascriptContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
}

/**
* @since Chrome 44
*/
extern enum abstract LocationContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var ASK = "ASK";
}

/**
* @since Chrome 44
*/
extern enum abstract PluginsContentSetting(String) to String {
	var BLOCK = "block";
}

/**
* @since Chrome 44
*/
extern enum abstract PopupsContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
}

/**
* @since Chrome 44
*/
extern enum abstract NotificationsContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var ASK = "ASK";
}

/**
* @since Chrome 44
*/
extern enum abstract FullscreenContentSetting(String) to String {
	var ALLOW = "allow";
}

/**
* @since Chrome 44
*/
extern enum abstract MouselockContentSetting(String) to String {
	var ALLOW = "allow";
}

/**
* @since Chrome 44
*/
extern enum abstract MicrophoneContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var ASK = "ASK";
}

/**
* @since Chrome 44
*/
extern enum abstract CameraContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var ASK = "ASK";
}

/**
* @since Chrome 44
*/
extern enum abstract PpapiBrokerContentSetting(String) to String {
	var BLOCK = "block";
}

/**
* @since Chrome 44
*/
extern enum abstract MultipleAutomaticDownloadsContentSetting(String) to String {
	var ALLOW = "allow";
	var BLOCK = "block";
	var ASK = "ASK";
}
