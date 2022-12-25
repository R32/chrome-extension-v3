package chrome;

/**
* Use the `chrome.dom` API to access special DOM APIs for Extensions
*
* @since Chrome 88
*/
@:native("chrome.dom")
extern class Dom {
	/**
	* Gets the open shadow root or the closed shadow root hosted by the specified element.
	* If the element doesn't attach the shadow root, it will return null.
	*
	* @returns See [https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot](https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot)
	*/
	static function openOrClosedShadowRoot( element : DOMElement ) : Dynamic;
}
