package chrome;

/**
* The `chrome.management` API provides ways to manage the list of extensions/apps
* that are installed and running. It is particularly useful for extensions that
* [override](https://developer.chrome.com/docs/extensions/override) the built-in New Tab page.
*
* @chrome-permission management
*/
@:native("chrome.management")
extern class Management {
	/**
	* Fired when an app or extension has been installed.
	*/
	static final onInstalled : Event<ExtensionInfo->Void>;

	/**
	* Fired when an app or extension has been uninstalled.
	*/
	static final onUninstalled : Event<(id : String)->Void>;

	/**
	* Fired when an app or extension has been enabled.
	*/
	static final onEnabled : Event<ExtensionInfo->Void>;

	/**
	* Fired when an app or extension has been disabled.
	*/
	static final onDisabled : Event<ExtensionInfo->Void>;

	/**
	* Returns a list of information about installed extensions and apps.
	*/
	overload static function getAll( callback : (Array<ExtensionInfo>)->Void ) : Void;
	overload static function getAll() : Promise<Array<ExtensionInfo>>;

	/**
	* Returns information about the installed extension, app, or theme that has the given ID.
	*
	* @param id The ID from an item of {@link management.ExtensionInfo}.
	*/
	overload static function getAll( id : String, callback : ExtensionInfo->Void ) : Void;
	overload static function getAll( id : String ) : Promise<ExtensionInfo>;

    /**
     * Returns information about the calling extension, app, or theme. Note:
	 * This function can be used without requesting the 'management' permission in the manifest.
     */
	overload static function getSelf( callback : ExtensionInfo->Void ) : Void;
	overload static function getSelf() : Promise<ExtensionInfo>;

	/**
	* Returns a list of [permission warnings](https://developer.chrome.com/docs/extensions/permission_warnings)
	* for the given extension id.
	*
	* @param id The ID of an already installed extension.
	*/
	overload static function getPermissionWarningsById( id : String, callback : (Array<String>)->Void ) : Void;
	overload static function getPermissionWarningsById( id : String ) : Promise<Array<String>>;

	/**
	* Returns a list of [permission warnings](https://developer.chrome.com/docs/extensions/permission_warnings)
	* for the given extension manifest string. Note: This function can be used
	* without requesting the 'management' permission in the manifest.
	*
	* @param manifestStr Extension manifest JSON string.
	*/
	overload static function getPermissionWarningsByManifest( manifestStr : String, callback : (Array<String>)->Void ) : Void;
	overload static function getPermissionWarningsByManifest( manifestStr : String ) : Promise<Array<String>>;

	/**
	* Enables or disables an app or extension. In most cases this function
	* must be called in the context of a user gesture (e.g. an onclick handler for a button),
	* and may present the user with a native confirmation UI as a way of preventing abuse.
	*
	* @param id This should be the id from an item of {@link management.ExtensionInfo}.
	* @param enabled Whether this item should be enabled or disabled.
	*/
	overload static function setEnabled( id : String, callback : ()->Void ) : Void;
	overload static function setEnabled( id : String ) : Promise<Void>;

	/**
	* Uninstalls a currently installed app or extension. Note: This function
	* does not work in managed environments when the user is not allowed to
	* uninstall the specified extension/app.
	*
	* @param id This should be the id from an item of {@link management.ExtensionInfo}.
	*/
	overload static function uninstall( id : String, callback : ()->Void ) : Void;
	overload static function uninstall( id : String, options : UninstallOptions, callback : ()->Void ) : Void;
	overload static function uninstall( id : String, ?options : UninstallOptions ) : Promise<Void>;

	/**
	* Uninstalls the calling extension. Note: This function can be used without
	* requesting the 'management' permission in the manifest. This function
	* does not work in managed environments when the user is not allowed to
	* uninstall the specified extension/app.
	*/
	overload static function uninstuninstallSelfall( callback : ()->Void ) : Void;
	overload static function uninstallSelf( options : UninstallOptions, callback : ()->Void ) : Void;
	overload static function uninstallSelf( ?options : UninstallOptions ) : Promise<Void>;

	/**
	* Launches an application.
	*
	* @param id The extension id of the application.
	*/
	overload static function launchApp( id : String, callback : ()->Void ) : Void;
	overload static function launchApp( id : String ) : Promise<Void>;

	/**
	* Display options to create shortcuts for an app. On Mac,
	* only packaged app shortcuts can be created.
	*
	* @param id This should be the id from an app item of {@link management.ExtensionInfo}.
	*/
	overload static function createAppShortcut( id : String, callback : ()->Void ) : Void;
	overload static function createAppShortcut( id : String ) : Promise<Void>;

	/**
	* Set the launch type of an app.
	*
	* @param id This should be the id from an app item of {@link management.ExtensionInfo}.
	* @param launchType The target launch type. Always check and make sure
	* this launch type is in {@link ExtensionInfo.availableLaunchTypes},
	* because the available launch types vary on different platforms and configurations.
	*/
	overload static function setLaunchType( id : String, launchType : LaunchType, callback : ()->Void ) : Void;
	overload static function setLaunchType( id : String, launchType : LaunchType ) : Promise<Void>;

	/**
	* Generate an app for a URL. Returns the generated bookmark app.
	*
	* @param url The URL of a web page. The scheme of the URL can only be "http" or "https".
	* @param title The title of the generated app.
	*/
	overload static function generateAppForLink( url : String, title : String, callback : ExtensionInfo->Void ) : Void;
	overload static function generateAppForLink( url : String, title : String ) : Promise<ExtensionInfo>;

	/**
	* Launches the replacement\_web\_app specified in the manifest.
	* Prompts the user to install if not already installed.
	*
	* @since Chrome 77
	* @chrome-manifest replacement_web_app
	*/
	overload static function installReplacementWebApp( callback : ()->Void ) : Void;
	overload static function installReplacementWebApp() : Promise<Void>;
}

/**
* Information about an icon belonging to an extension, app, or theme.
*/
typedef IconInfo = {

	/**
	* A number representing the width and height of the icon.
	* Likely values include (but are not limited to) 128, 48, 24, and 16.
	*/
	var size : Int;

	/**
	* The URL for this icon image. To display a grayscale version of the icon
	* (to indicate that an extension is disabled, for example),
	* append `?grayscale=true` to the URL.
	*/
	var url : String;
}

/**
* These are all possible app launch types.
*/
extern enum abstract LaunchType(String) to String {
	var OPEN_AS_REGULAR_TAB = "OPEN_AS_REGULAR_TAB";
	var OPEN_AS_PINNED_TAB = "OPEN_AS_PINNED_TAB";
	var OPEN_AS_WINDOW = "OPEN_AS_WINDOW";
	var OPEN_FULL_SCREEN = "OPEN_FULL_SCREEN";
}

/**
* A reason the item is disabled.
*
* @since Chrome 44
*/
extern enum abstract ExtensionDisabledReason(String) to String {
	var UNKNOWN = "unknown";
	var PERMISSIONS_INCREASE = "permissions_increase";
}

/**
* The type of this extension, app, or theme.
*
* @since Chrome 44
*/
extern enum abstract ExtensionType(String) to String {
	var EXTENSION = "extension";
	var HOSTED_APP = "hosted_app";
	var PACKAGED_APP = "packaged_app";
	var LEGACY_PACKAGED_APP = "legacy_packaged_app";
	var THEME = "theme";
	var LOGIN_SCREEN_EXTENSION = "login_screen_extension";
}

/**
* How the extension was installed. One of
* `admin`: The extension was installed because of an administrative policy,
* `development`: The extension was loaded unpacked in developer mode,
* `normal`: The extension was installed normally via a .crx file,
* `sideload`: The extension was installed by other software on the machine,
* `other`: The extension was installed by other means.
*
* @since Chrome 44
*/
extern enum abstract ExtensionInstallType(String) to String {
	var ADMIN = "admin";
	var DEVELOPMENT = "development";
	var NORMAL = "normal";
	var SIDELOAD = "sideload";
	var OTHER = "other";
}

/**
* Information about an installed extension, app, or theme.
*/
typedef ExtensionInfo = {

	/**
	* The extension's unique identifier.
	*/
	var id : String;

	/**
	* The name of this extension, app, or theme.
	*/
	var name : String;

	/**
	* A short version of the name of this extension, app, or theme.
	*/
	var shortName : String;

	/**
	* The description of this extension, app, or theme.
	*/
	var description : String;

	/**
	* The [version](https://developer.chrome.com/docs/extensions/manifest/version) of this extension, app, or theme.
	*/
	var version : String;

	/**
	* The [version name](https://developer.chrome.com/docs/extensions/manifest/version#version_name) of this extension, app, or theme if the manifest specified one.
	*
	* @since Chrome 50
	*/
	var ?versionName : String;

	/**
	* Whether this extension can be disabled or uninstalled by the user.
	*/
	var mayDisable : Bool;

	/**
	* Whether this extension can be enabled by the user. This is only returned
	* for extensions which are not enabled.
	*
	* @since Chrome 62
	*/
	var ?mayEnable : Bool;

	/**
	* Whether it is currently enabled or disabled.
	*/
	var enabled: Bool;

	/**
	* A reason the item is disabled.
	*/
	var ?disabledReason : ExtensionDisabledReason;

	/**
	* True if this is an app.
	*
	* @deprecated Please use {@link management.ExtensionInfo.type}.
	*/
	var isApp : Bool;

	/**
	* The type of this extension, app, or theme.
	*/
	var type : ExtensionType;

	/**
	* The launch url (only present for apps).
	*/
	var ?appLaunchUrl : String;

	/**
	* The URL of the homepage of this extension, app, or theme.
	*/
	var ?homepageUrl : String;

	/**
	* The update URL of this extension, app, or theme.
	*/
	var ?updateUrl : String;

	/**
	* Whether the extension, app, or theme declares that it supports offline.
	*/
	var offlineEnabled : Bool;

	/**
	* The url for the item's options page, if it has one.
	*/
	var optionsUrl : String;

	/**
	* A list of icon information. Note that this just reflects what was declared
	* in the manifest, and the actual image at that url may be larger or smaller
	* than what was declared, so you might consider using explicit width and
	* height attributes on img tags referencing these images.
	* See the [manifest documentation on icons](https://developer.chrome.com/docs/extensions/manifest/icons) for more details.
	*/
	var ?icons : Array<IconInfo>;

	/**
	* Returns a list of API based permissions.
	*/
	var permissions : Array<String>;

	/**
	* Returns a list of host based permissions.
	*/
	var hostPermissions : Array<String>;

	/**
	* How the extension was installed.
	*/
	var installType : ExtensionInstallType;

	/**
	* The app launch type (only present for apps).
	*/
	var ?launchType : LaunchType;

	/**
	* The currently available launch types (only present for apps).
	*/
	var ?availableLaunchTypes : Array<LaunchType>;
}


/**
* Options for how to handle the extension's uninstallation.
*
* @since Chrome 88
*/
typedef UninstallOptions = {

	/**
	* Whether or not a confirm-uninstall dialog should prompt the user.
	* Defaults to false for self uninstalls. If an extension uninstalls
	* another extension, this parameter is ignored and the dialog is always shown.
	*/
	var ?showConfirmDialog : Bool;
}
