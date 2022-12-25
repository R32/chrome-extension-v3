package chrome;

/**
* Use the `chrome.search` API to search via the default provider.
*
* @since Chrome 87
* @chrome-permission search
*/
@:native("chrome.search")
extern class Search {
	/**
	* Used to query the default search provider. In case of an error,
	* {@link runtime.lastError} will be set.
	*/
	overload static function query( queryInfo: QueryInfo, callback : ()->Void ) : Void;
	overload static function query( queryInfo: QueryInfo ) : Promise<Void>;
}

/**
* @chrome-enum "CURRENT\_TAB" Display results in the calling tab or the tab from the active browser.
* @chrome-enum "NEW\_TAB" Display search results in a new tab.
* @chrome-enum "NEW\_WINDOW" Display search results in a new window.
*/
extern enum abstract Disposition(String) to String {
	var CURRENT_TAB = "CURRENT_TAB";
	var NEW_TAB = "NEW_TAB";
	var NEW_WINDOW = "NEW_WINDOW";
}


typedef QueryInfo = {
	/**
	* String to query with the default search provider.
	*/
	var text : String;

	/**
	* Location where search results should be displayed. `CURRENT_TAB` is the default.
	*/
	var ?disposition : Disposition;

	/**
	* Location where search results should be displayed. `tabId` cannot be used with `disposition`.
	*/
	var ?tabId : Int;
}
