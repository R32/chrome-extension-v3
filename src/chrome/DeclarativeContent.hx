package chrome;

import chrome.BrowserAction.ImageDataType;
/**
* Use the `chrome.declarativeContent` API to take actions depending on
* the content of a page, without requiring permission to read the page's content.
*
* @chrome-permission declarativeContent
*/
@:native("chrome.declarativeContent")
extern class DeclarativeContent {
	// export const onPageChanged: events.Event<never, PageStateMatcher, RequestContentScript | SetIcon | ShowPageAction | ShowAction>;
	static final onPageChanged : Event<Dynamic->Void>;
}

/**
* Matches the state of a web page based on various criteria.
*/
@:native("chrome.declarativeContent.PageStateMatcher")
extern class PageStateMatcher {

	function new( arg : EitherType<PageStateMatcher, {
		?pageUrl : Events.UrlFilter,
		?css : Array<String>,
		?isBookmarked : Bool,
	}> );

	/**
	* Matches if the conditions of the `UrlFilter` are fulfilled for
	* the top-level URL of the page.
	*/
	var pageUrl : Events.UrlFilter;

	/**
	* Matches if all of the CSS selectors in the array match displayed elements
	* in a frame with the same origin as the page's main frame. All selectors
	* in this array must be [compound selectors](https://www.w3.org/TR/selectors4/#compound)
	* to speed up matching. Note: Listing hundreds of CSS selectors or
	* listing CSS selectors that match hundreds of times per page can slow down web sites.
	*/
	var css : Array<String>;

	/**
	* Matches if the bookmarked state of the page is equal to the specified value.
	* Requres the [bookmarks permission](https://developer.chrome.com/docs/extensions/declare_permissions).
	*
	* @since Chrome 45
	*/
	var isBookmarked : Bool;
}

/**
* Declarative event action that shows the extension's {@link pageAction page action}
* while the corresponding conditions are met. This action can be used without
* [host permissions](https://developer.chrome.com/docs/extensions/declare_permissions#host-permissions), but the extension must have a page action. If the extension has the [activeTab](https://developer.chrome.com/docs/extensions/activeTab) permission,
* clicking the page action grants access to the active tab.
*
* @deprecated Please use {@link declarativeContent.ShowAction}.
* @chrome-deprecated-since Chrome 97
*/
@:native("chrome.declarativeContent.ShowPageAction")
extern class ShowPageAction {
	function new( ?arg : ShowPageAction );
}

/**
* Declarative event action that shows the extension's toolbar action
* ({@link pageAction page action} or {@link browserAction browser action})
* while the corresponding conditions are met. This action can be used without
* [host permissions](https://developer.chrome.com/docs/extensions/declare_permissions#host-permissions).
* If the extension has the [activeTab](https://developer.chrome.com/docs/extensions/activeTab) permission,
* clicking the page action grants access to the active tab.
*
* @since Chrome 97
*/
@:native("chrome.declarativeContent.ShowAction")
extern class ShowAction {
	function new( ?arg : ShowAction );
}

/**
* Declarative event action that sets the n-dip square icon for the
* extension's {@link pageAction page action} or {@link browserAction browser action}
* while the corresponding conditions are met. This action can be used without
* [host permissions](https://developer.chrome.com/docs/extensions/declare_permissions#host-permissions),
* but the extension must have a page or browser action.
*
* Exactly one of `imageData` or `path` must be specified. Both are dictionaries
* mapping a number of pixels to an image representation. The image representation
* in `imageData` is an [ImageData](https://developer.mozilla.org/en-US/docs/Web/API/ImageData) object;
* for example, from a `canvas` element, while the image representation in `path`
* is the path to an image file relative to the extension's manifest.
* If `scale` screen pixels fit into a device-independent pixel,
* the `scale * n` icon is used. If that scale is missing,
* another image is resized to the required size.
*/
@:native("chrome.declarativeContent.SetIcon")
extern class SetIcon {
	function new( arg : EitherType<SetIcon, {?imageData : EitherType<ImageDataType, Dynamic>}> );

	/**
	* Either an `ImageData` object or a dictionary {size -> ImageData} representing an icon to be set. If the icon is specified as a dictionary, the image used is chosen depending on the screen's pixel density. If the number of image pixels that fit into one screen space unit equals `scale`, then an image with size `scale * n` is selected, where _n_ is the size of the icon in the UI. At least one image must be specified. Note that `details.imageData = foo` is equivalent to `details.imageData = {'16': foo}`.
	*/
	var imageData : EitherType<ImageDataType, Dynamic>;
}

/**
* Declarative event action that injects a content script.
*
* **WARNING:** This action is still experimental and is not supported on stable builds of Chrome.
*/
@:native("chrome.declarativeContent.RequestContentScript")
extern class RequestContentScript {

	function new( arg : EitherType<RequestContentScript, {
		?css : Array<String>,
		?js : Array<String>,
		?allFrames : Bool,
		?matchAboutBlank : Bool
	}> );

	/**
	* Names of CSS files to be injected as a part of the content script.
	*/
	var css : Array<String>;

	/**
	* Names of JavaScript files to be injected as a part of the content script.
	*/
	var js : Array<String>;

	/**
	* Whether the content script runs in all frames of the matching page, or in only the top frame. Default is `false`.
	*/
	var allFrames : Bool;

	/**
	* Whether to insert the content script on `about:blank` and `about:srcdoc`. Default is `false`.
	*/
	var matchAboutBlank : Bool;
}
