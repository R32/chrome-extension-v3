package chrome;

/**
* Use the `chrome.browsingData` API to remove browsing data from a user's local profile.
*
* @chrome-permission browsingData
*/
@:native("chrome.browsingData")
extern class BrowsingData {
	/**
	* Reports which types of data are currently selected in the 'Clear browsing data'
	* settings UI. Note: some of the data types included in this API are not available
	* in the settings UI, and some UI settings control more than one data type listed here.
	*/
	overload static function settings( callback : SettingResult->Void ) : Void;
	overload static function settings() : Promise<{SettingResult}>;

	/**
	* Clears various types of browsing data stored in a user's profile.
	*
	* @param dataToRemove The set of data types to remove.
	* @param callback Called when deletion has completed.
	*/
	overload static function remove( options : RemovalOptions, dataToRemove : DataTypeSet, callback : ()->Void ) : Void;
	overload static function remove( options : RemovalOptions, dataToRemove : DataTypeSet ) : Promise<{Void}>;

	/**
	* Clears websites' appcache data.
	*
	* @param callback Called when websites' appcache data has been cleared.
	*/
	overload static function removeAppcache( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeAppcache( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's cache.
	*
	* @param callback Called when the browser's cache has been cleared.
	*/
	overload static function removeCache( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeCache( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' cache storage data.
	*
	* @param callback Called when websites' cache storage has been cleared.
	* @since Chrome 72
	*/
	overload static function removeCacheStorage( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeCacheStorage( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's cookies and server-bound certificates modified within a particular timeframe.
	*
	* @param callback Called when the browser's cookies and server-bound certificates have been cleared.
	*/
	overload static function removeCookies( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeCookies( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's list of downloaded files (_not_ the downloaded files themselves).
	*
	* @param callback Called when the browser's list of downloaded files has been cleared.
	*/
	overload static function removeDownloads( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeDownloads( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' file system data.
	*
	* @param callback Called when websites' file systems have been cleared.
	*/
	overload static function removeFileSystems( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeFileSystems( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's stored form data (autofill).
	*
	* @param callback Called when the browser's form data has been cleared.
	*/
	overload static function removeFormData( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeFormData( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's history.
	*
	* @param callback Called when the browser's history has cleared.
	*/
	overload static function removeHistory( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeHistory( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' IndexedDB data.
	*
	* @param callback Called when websites' IndexedDB data has been cleared.
	*/
	overload static function removeIndexedDB( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeIndexedDB( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' local storage data.
	*
	* @param callback Called when websites' local storage has been cleared.
	*/
	overload static function removeLocalStorage( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeLocalStorage( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears plugins' data.
	*
	* @param callback Called when plugins' data has been cleared.
	* @deprecated Support for Flash has been removed. This function has no effect.
	* @chrome-deprecated-since Chrome 88
	*/
	@:deprecated overload static function removePluginData( options : RemovalOptions, callback : ()->Void ) : Void;
	@:deprecated overload static function removePluginData( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears the browser's stored passwords.
	*
	* @param callback Called when the browser's passwords have been cleared.
	*/
	overload static function removePasswords( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removePasswords( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' service workers.
	*
	* @param callback Called when websites' service workers have been cleared.
	* @since Chrome 72
	*/
	overload static function removeServiceWorkers( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeServiceWorkers( options : RemovalOptions, ) : Promise<{Void}>;

	/**
	* Clears websites' WebSQL data.
	*
	* @param callback Called when websites' WebSQL databases have been cleared.
	*/
	overload static function removeWebSQL( options : RemovalOptions, callback : ()->Void ) : Void;
	overload static function removeWebSQL( options : RemovalOptions, ) : Promise<{Void}>;
}

/**
* Options that determine exactly what data will be removed.
*/
typedef RemovalOptions = {
	/**
	* Remove data accumulated on or after this date, represented in milliseconds
	* since the epoch (accessible via the `getTime` method of the JavaScript `Date` object).
	* If absent, defaults to 0 (which would remove all browsing data).
	*/
	var ?since : Float;

	/**
	* An object whose properties specify which origin types ought to be cleared.
	* If this object isn't specified, it defaults to clearing only "unprotected" origins.
	* Please ensure that you _really_ want to remove application data before
	* adding 'protectedWeb' or 'extensions'.
	*/
	var ?originTypes : {
		/**
		* Normal websites.
		*/
		?unprotectedWeb : Bool,
		/**
		* Websites that have been installed as hosted applications (be careful!).
		*/
		?protectedWeb : Bool,
		/**
		* Extensions and packaged applications a user has installed (be \_really\_ careful!).
		*/
		?extension : Bool,
	};

	/**
	* When present, only data for origins in this list is deleted.
	* Only supported for cookies, storage and cache.
	* Cookies are cleared for the whole registrable domain.
	*
	* @since Chrome 74
	*/
	var ?origins : Array<String>;

	/**
	* When present, data for origins in this list is excluded from deletion.
	* Can't be used together with `origins`. Only supported for cookies,
	* storage and cache. Cookies are excluded for the whole registrable domain.
	*
	* @since Chrome 74
	*/
	var ?excludeOrigins : Array<String>;
}

/**
* A set of data types. Missing data types are interpreted as `false`.
*/
typedef DataTypeSet = {
	/**
	* Websites' appcaches.
	*/
	var ?appcache : Bool;

	/**
	* The browser's cache.
	*/
	var ?cache : Bool;

	/**
	* Cache storage
	*
	* @since Chrome 72
	*/
	var ?cacheStorage : Bool;

	/**
	* The browser's cookies.
	*/
	var ?cookies : Bool;

	/**
	* The browser's download list.
	*/
	var ?downloads : Bool;

	/**
	* Websites' file systems.
	*/
	var ?fileSystems : Bool;

	/**
	* The browser's stored form data.
	*/
	var ?formData : Bool;

	/**
	* The browser's history.
	*/
	var ?history : Bool;

	/**
	* Websites' IndexedDB data.
	*/
	var ?indexedDB : Bool;

	/**
	* Websites' local storage data.
	*/
	var ?localStorage : Bool;

	/**
	* Server-bound certificates.
	*
	* @deprecated Support for server-bound certificates has been removed. This data type will be ignored.
	* @chrome-deprecated-since Chrome 76
	*/
	var ?serverBoundCertificates : Bool;

	/**
	* Stored passwords.
	*/
	var ?passwords : Bool;

	/**
	* Plugins' data.
	*
	* @deprecated Support for Flash has been removed. This data type will be ignored.
	* @chrome-deprecated-since Chrome 88
	*/
	var ?pluginData : Bool;

	/**
	* Service Workers.
	*/
	var ?serviceWorkers : Bool;

	/**
	* Websites' WebSQL data.
	*/
	var ?webSQL : Bool;
}

private typedef SettingResult = {

	var options : RemovalOptions,

	/**
	* All of the types will be present in the result, with values of `true`
	* if they are both selected to be removed and permitted to be removed, otherwise `false`.
	*/
	var dataToRemove : DataTypeSet,

	/**
	* All of the types will be present in the result, with values of `true`
	* if they are permitted to be removed (e.g., by enterprise policy) and `false` if not.
	*/
	var dataRemovalPermitted : DataTypeSet,
}

