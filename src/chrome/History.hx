package chrome;

/**
* Use the `chrome.history` API to interact with the browser's record of visited pages. You can add, remove, and query for URLs in the browser's history. To override the history page with your own version, see [Override Pages](https://developer.chrome.com/docs/extensions/override).
*
* @chrome-permission history
*/
@:native("chrome.history")
extern class History {
	/**
	* Fired when a URL is visited, providing the HistoryItem data for that URL.
	* This event fires before the page has loaded.
	*/
	static final onVisited : Event<HistoryItem->Void>;

	/**
	* Fired when one or more URLs are removed from the history service.
	* When all visits have been removed the URL is purged from history.
	*
	* allHistory: True if all history was removed. If true, then urls will be empty.
	*/
	static final onVisitRemoved : Event<{allHistory : Bool, ?urls : Array<String>}->Void>;

	/**
	* Searches the history for the last visit time of each page matching the query.
	*/
	overload static function search( query : SearchQuery, callback : (Array<HistoryItem>)->Void ) : Void;
	overload static function search( query : SearchQuery ) : Promise<Array<HistoryItem>>;

	/**
	* Retrieves information about visits to a URL.
	*/
	overload static function getVisits( details : UrlDetails, callback : (Array<VisitItem>)->Void ) : Void;
	overload static function getVisits( details : UrlDetails ) : Promise<Array<VisitItem>>;

	/**
	* Adds a URL to the history at the current time with a
	* [transition type](https://developer.chrome.com/docs/extensions/reference/history/#transition_types) of "link".
	*/
	overload static function addUrl( details : UrlDetails, callback : ()->Void ) : Void;
	overload static function addUrl( details : UrlDetails ) : Promise<Void>;

	/**
	* Removes all occurrences of the given URL from the history.
	*/
	overload static function deleteUrl( details : UrlDetails, callback : ()->Void ) : Void;
	overload static function deleteUrl( details : UrlDetails ) : Promise<Void>;

	/**
	* Removes all items within the specified date range from the history.
	* Pages will not be removed from the history unless all visits fall within the range.
	*
	* @param range.startTime : Items added to history after this date, represented in milliseconds since the epoch.
	* @param range.endTime : Items added to history before this date, represented in milliseconds since the epoch.
	*/
	overload static function deleteRange( range : {startTime : Float, endTime: Float}, callback : ()->Void ) : Void;
	overload static function deleteRange( range : {startTime : Float, endTime: Float} ) : Promise<Void>;

	/**
	* Deletes all items from the history.
	*/
	overload static function deleteAll( callback : ()->Void ) : Void;
	overload static function deleteAll() : Promise<Void>;
}

private typedef SearchQuery = {
	/**
	* A free-text query to the history service. Leave empty to retrieve all pages.
	*/
	var text : String;

	/**
	* Limit results to those visited after this date, represented in milliseconds since the epoch. If not specified, this defaults to 24 hours in the past.
	*/
	var ?startTime : Float;

	/**
	* Limit results to those visited before this date, represented in milliseconds since the epoch.
	*/
	var ?endTime : Float;

	/**
	* The maximum number of results to retrieve. Defaults to 100.
	*/
	var ?maxResults : Int;
}

/**
* The [transition type](https://developer.chrome.com/docs/extensions/reference/history/#transition_types)
* for this visit from its referrer.
*
* @since Chrome 44
*/
extern enum abstract TransitionType(String) to String {
	var LINK = "link";
	var TYPED = "typed";
	var AUTO_BOOKMARK = "auto_bookmark";
	var AUTO_SUBFRAME = "auto_subframe";
	var MANUAL_SUBFRAME = "manual_subframe";
	var GENERATED = "generated";
	var AUTO_TOPLEVEL = "auto_toplevel";
	var FORM_SUBMIT = "form_submit";
	var RELOAD = "reload";
	var KEYWORD = "keyword";
	var KEYWORD_GENERATED = "keyword_generated";
}

/**
* An object encapsulating one result of a history query.
*/
typedef HistoryItem = {

	/**
	* The unique identifier for the item.
	*/
	var id : String;

	/**
	* The URL navigated to by a user.
	*/
	var ?url : String;

	/**
	* The title of the page when it was last loaded.
	*/
	var ?title : String;

	/**
	* When this page was last loaded, represented in milliseconds since the epoch.
	*/
	var ?lastVisitTime : Float;

	/**
	* The number of times the user has navigated to this page.
	*/
	var ?visitCount : Int;

	/**
	* The number of times the user has navigated to this page by typing in the address.
	*/
	var ?typedCount : Int;
}

/**
* An object encapsulating one visit to a URL.
*/
typedef VisitItem = {

	/**
	* The unique identifier for the item.
	*/
	var id : String;

	/**
	* The unique identifier for this visit.
	*/
	var visitId: String;

	/**
	* When this visit occurred, represented in milliseconds since the epoch.
	*/
	var ?visitTime : Float;

	/**
	* The visit ID of the referrer.
	*/
	var referringVisitId : String;

	/**
	* The [transition type](https://developer.chrome.com/docs/extensions/reference/history/#transition_types) for this visit from its referrer.
	*/
	var transition : TransitionType;
}

/**
* @since Chrome 88
*/
typedef UrlDetails = {
	/**
	* The URL for the operation. It must be in the format as returned from a call to history.search.
	*/
	var url : String;
}
