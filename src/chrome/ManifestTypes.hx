package chrome;

/**
* Chrome settings which can be overriden by an extension.
*/
typedef ChromeSettingsOverrides = {

	/**
	* New value for the homepage.
	*/
	var ?homepage : String;

	/**
	* A search engine
	*/
	var ?search_provider : {

		/**
		* Name of the search engine displayed to user. This may only be omitted if _prepopulated\_id_ is set.
		*/
		?name : String,

		/**
		* Omnibox keyword for the search engine. This may only be omitted if _prepopulated\_id_ is set.
		*/
		?keyword : String,

		/**
		* An icon URL for the search engine. This may only be omitted if _prepopulated\_id_ is set.
		*/
		?favicon_url : String,

		/**
		* An search URL used by the search engine.
		*/
		search_url : String,

		/**
		* Encoding of the search term. This may only be omitted if _prepopulated\_id_ is set.
		*/
		?encoding : String,

		/**
		* If omitted, this engine does not support suggestions.
		*/
		?suggest_url : String,

		/**
		* If omitted, this engine does not support image search.
		*/
		?image_url : String,

		/**
		* The string of post parameters to search\_url
		*/
		?search_url_post_params : String,

		/**
		* The string of post parameters to suggest\_url
		*/
		?suggest_url_post_params : String,

		/**
		* The string of post parameters to image\_url
		*/
		?image_url_post_params : String,

		/**
		* A list of URL patterns that can be used, in addition to `search_url`.
		*/
		?alternate_urls : Array<String>,

		/**
		* An ID of the built-in search engine in Chrome.
		*/
		?prepopulated_id : Int,

		/**
		* Specifies if the search provider should be default.
		*/
		is_default : Bool,
	};
	/**
	* An array of length one containing a URL to be used as the startup page.
	*/
	var ?startup_pages : Array<String>;
}

/**
* For `"file"` the source is a file passed via `onLaunched` event.
* For `"device"` contents are fetched from an external device (eg. plugged via USB),
* without using `file_handlers`. Finally, for `"network"` source,
* contents should be fetched via network.
*
* @since Chrome 44
*/
extern enum abstract FileSystemProviderSource(String) to String {
	var FILE = "file";
	var DEVICE = "device";
	var NETWORK = "network";
}

/**
* Represents capabilities of a providing extension.
*
* @since Chrome 44
*/
typedef FileSystemProviderCapabilities = {

	/**
	* Whether configuring via `onConfigureRequested` is supported. By default: `false`.
	*/
	var ?configurable : Bool;

	/**
	* Whether multiple (more than one) mounted file systems are supported. By default: `false`.
	*/
	var ?multiple_mounts : Bool;

	/**
	* Whether setting watchers and notifying about changes is supported. By default: `false`.
	*
	* @since Chrome 45
	*/
	var ?watchable : Bool;

	/**
	* Source of data for mounted file systems.
	*/
	var source : FileSystemProviderSource;
}
