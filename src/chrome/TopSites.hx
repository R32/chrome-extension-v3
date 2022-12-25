package chrome;

/**
* Use the `chrome.topSites` API to access the top sites (i.e. most visited sites)
* that are displayed on the new tab page.
* These do not include shortcuts customized by the user.
*
* @chrome-permission topSites
*/
@:native("chrome.topSites")
extern class TopSites {
	/**
	* Gets a list of top sites.
	*/
	overload static function get( callback : (Array<MostVisitedURL>)->Void ) : Void;
	overload static function get(): Promise<Array<MostVisitedURL>>;
}

/**
* An object encapsulating a most visited URL, such as the default shortcuts on the new tab page.
*/
typedef MostVisitedURL = {

	/**
	* The most visited URL.
	*/
	var url : String;

	/**
	* The title of the page
	*/
	var title : String;
}
