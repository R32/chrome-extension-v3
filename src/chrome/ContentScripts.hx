package chrome;

import chrome.ExtensionTypes.RunAt;

/**
* The stage in the document lifecycle when the javascript file is injected.
*
* @chrome-enum "document\_idle" The browser chooses a time to inject scripts between
* "document\_end" and immediately after the window.onload event fires.
* The exact moment of injection depends on how complex the document is and how long
* it is taking to load, and is optimized for page load speed. Content scripts running
* at "document\_idle" do not need to listen for the window.onload event;
* they are guaranteed to run after the DOM is complete. If a script definitely needs
* to run after window.onload, the extension can check if onload has already fired by
* using the document.readyState property.
* @chrome-enum "document\_start" Scripts are injected after any files from css,
* but before any other DOM is constructed or any other script is run.
* @chrome-enum "document\_end" Scripts are injected immediately after the DOM is complete,
* but before subresources like images and frames have loaded.
*/
//extern enum abstract RunAt(String) to String {
//	var DOCUMENT_IDLE = "document_idle";
//	var DOCUMENT_START = "document_start";
//	var DOCUMENT_END = "document_end";
//}

typedef ContentScript = {

	/**
	* Specifies which pages this content script will be injected into.
	* See [Match Patterns](https://developer.chrome.com/docs/extensions/match_patterns)
	* for more details on the syntax of these strings.
	*/
	var matches : Array<String>;

	/**
	* Excludes pages that this content script would otherwise be injected into.
	* See [Match Patterns](https://developer.chrome.com/docs/extensions/match_patterns)
	* for more details on the syntax of these strings.
	*/
	var ?exclude_matches : Array<String>;

	/**
	* The list of CSS files to be injected into matching pages.
	* These are injected in the order they appear in this array,
	* before any DOM is constructed or displayed for the page.
	*/
	var ?css : Array<String>;

	/**
	* The list of JavaScript files to be injected into matching pages.
	* These are injected in the order they appear in this array.
	*/
	var ?js : Array<String>;

	/**
	* If specified true, it will inject into all frames,
	* even if the frame is not the top-most frame in the tab.
	* Each frame is checked independently for URL requirements;
	* it will not inject into child frames if the URL requirements are not met.
	* Defaults to false, meaning that only the top frame is matched.
	*/
	var ?all_frames : Bool;

	/**
	* Whether the script should inject into any frames where the URL belongs
	* to a scheme that would never match a specified Match Pattern, including about:,
	* data:, blob:, and filesystem: schemes. In these cases, in order to determine
	* if the script should inject, the origin of the URL is checked.
	* If the origin is `null` (as is the case for data: URLs), then the "initiator"
	* or "creator" origin is used (i.e., the origin of the frame that created or
	* navigated this frame). Note that this may not be the parent frame,
	* if the frame was navigated by another frame in the document hierarchy.
	*
	* @since Chrome 99
	*/
	var ?match_origin_as_fallback : Bool;

	/**
	* Whether the script should inject into an about:blank frame where the parent
	* or opener frame matches one of the patterns declared in matches. Defaults to false.
	*/
	var ?match_about_blank : Bool;

	/**
	* Applied after matches to include only those URLs that also match this glob.
	* Intended to emulate the [@include](https://wiki.greasespot.net/Metadata_Block#.40include)
	* Greasemonkey keyword.
	*/
	var ?include_globs : Array<String>;

	/**
	* Applied after matches to exclude URLs that match this glob.
	* Intended to emulate the [@exclude](https://wiki.greasespot.net/Metadata_Block#.40exclude)
	* Greasemonkey keyword.
	*/
	var ?exclude_globs : Array<String>;

	/**
	* Specifies when JavaScript files are injected into the web page.
	* The preferred and default value is `document_idle`.
	*/
	var ?run_at : RunAt;
}
