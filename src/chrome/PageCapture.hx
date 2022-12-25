package chrome;

/**
* Use the `chrome.pageCapture` API to save a tab as MHTML.
*
* @chrome-permission pageCapture
*/
@:native("chrome.pageCapture")
extern class PageCapture {

	/**
	* Saves the content of the tab with given id as MHTML.
	*
	* @param callback Called when the MHTML has been generated.
	*/
	static function saveAsMHTML( details : {tabId : Int}, callback : ArrayBuffer->Void ) : Void;
}
