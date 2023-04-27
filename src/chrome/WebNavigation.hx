package chrome;

import chrome.History.TransitionType;
/**
* Use the `chrome.webNavigation` API to receive notifications about the status
* of navigation requests in-flight.
*
* @chrome-permission webNavigation
*/
@:native("chrome.webNavigation")
extern class WebNavigation {
	/**
	* Fired when a navigation is about to occur.
	*/
	static final onBeforeNavigate : CustomChromeEvent<(
		callback : DetailsBase->Void,
		?filters : {
			/**
			* Conditions that the URL being navigated to must satisfy.
			* The 'schemes' and 'ports' fields of UrlFilter are ignored for this event.
			*/
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when a navigation is committed. The document (and the resources it
	* refers to, such as images and subframes) might still be downloading,
	* but at least part of the document has been received from the server and
	* the browser has decided to switch to the new document.
	*/
	static final onCommitted : CustomChromeEvent<(
		callback : (DetailsBase & {
			/**
			* Cause of the navigation.
			*/
			transitionType : TransitionType,
			/**
			* A list of transition qualifiers.
			*/
			transitionQualifiers : Array<TransitionQualifier>,
			/**
			* A UUID of the document loaded.
			*
			* @since Chrome 106
			*/
			documentId : String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when the page's DOM is fully constructed,
	* but the referenced resources may not finish loading.
	*/
	static final onDOMContentLoaded : CustomChromeEvent<(
		callback : (DetailsBase & {
			documentId : String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when a document, including the resources it refers to,
	* is completely loaded and initialized.
	*/
	static final onCompleted : CustomChromeEvent<(
		callback : (DetailsBase & {
			documentId : String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when an error occurs and the navigation is aborted.
	* This can happen if either a network error occurred,
	* or the user aborted the navigation.
	*/
	static final onErrorOccurred : CustomChromeEvent<(
		callback : (DetailsBase & {
			documentId : String,
			error: String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when a new window, or a new tab in an existing window,
	* is created to host a navigation.
	*/
	static final onCreatedNavigationTarget : CustomChromeEvent<(
		callback : ({
			/**
			* The ID of the tab in which the navigation is triggered.
			*/
			sourceTabId: Int,
			/**
			* The ID of the process that runs the renderer for the source frame.
			*/
			sourceProcessId: Int,
			/**
			* The ID of the frame with sourceTabId in which the navigation is triggered.
			* 0 indicates the main frame.
			*/
			sourceFrameId: Int,
			/**
			* The URL to be opened in the new window.
			*/
			url: String,
			/**
			* The ID of the tab in which the url is opened
			*/
			tabId: Int,
			/**
			* The time when the browser was about to create a new view,
			* in milliseconds since the epoch.
			*/
			timeStamp: Float,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when the reference fragment of a frame was updated.
	* All future events for that frame will use the updated URL.
	*/
	static final onReferenceFragmentUpdated : CustomChromeEvent<(
		callback : (DetailsBase & {
			transitionType: TransitionType,
			transitionQualifiers: Array<TransitionQualifier>,
			documentId : String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;

	/**
	* Fired when the contents of the tab is replaced by a different
	* (usually previously pre-rendered) tab.
	*/
	static final onTabReplaced : CustomChromeEvent<(
		callback : ({
			/**
			 * The ID of the tab that was replaced.
			 */
			replacedTabId: Int,

			tabId: Int,

			timeStamp: Float,
		})->Void
	)->Void>;

	/**
	* Fired when the frame's history was updated to a new URL.
	* All future events for that frame will use the updated URL.
	*/
	static final onHistoryStateUpdated : CustomChromeEvent<(
		callback : (DetailsBase & {
			transitionType: TransitionType,
			transitionQualifiers: Array<TransitionQualifier>,
			documentId : String,
		})->Void,
		?filters : {
			url : Array<Events.UrlFilter>
		}
	)->Void>;


	/**
	* Retrieves information about the given frame. A frame refers to an <iframe>
	* or a <frame> of a web page and is identified by a tab ID and a frame ID.
	*
	* @param details Information about the frame to retrieve information about.
	*/
	overload static function getFrame(
		details : {
			/**
			 * The ID of the tab in which the frame is.
			 */
			?tabId : Int,
			/**
			 * The ID of the process that runs the renderer for this tab.
			 *
			 * @deprecated Frames are now uniquely identified by their tab ID and frame ID; the process ID is no longer needed and therefore ignored.
			 * @chrome-deprecated-since Chrome 49
			 */
			?processId : Int,
			/**
			 * The ID of the frame in the given tab.
			 */
			?frameId : Int,
			/**
			 * The UUID of the document. If the frameId and/or tabId are provided they will be validated to match the document found by provided document ID.
			 *
			 * @since Chrome 106
			 */
			?documentId : String,
		},
		callback : (
			details : {
				/**
				* True if the last navigation in this frame was interrupted by an error, i.e. the onErrorOccurred event fired.
				*/
				errorOccurred : Bool,
				/**
				* The URL currently associated with this frame, if the frame identified by the frameId existed at one point in the given tab. The fact that an URL is associated with a given frameId does not imply that the corresponding frame still exists.
				*/
				url : String,
				/**
				* The ID of the parent frame, or `-1` if this is the main frame.
				*/
				parentFrameId : Int,
				/**
				* A UUID of the document loaded.
				*
				* @since Chrome 106
				*/
				documentId : String,
				/**
				* A UUID of the parent document owning this frame. This is not set if there is no parent.
				*
				* @since Chrome 106
				*/
				?parentDocumentId : String,
				/**
				* The lifecycle the document is in.
				*
				* @since Chrome 106
				*/
				documentLifecycle : ExtensionTypes.DocumentLifecycle,
				/**
				* The type of frame the navigation occurred in.
				*
				* @since Chrome 106
				*/
				frameType : ExtensionTypes.FrameType,
			}
		)->Void
	) : Void;

	overload static function getFrame(
		details : {
			?tabId : Int,
			?processId : Int,
			?frameId : Int,
			?documentId : String,
		}
	) : Promise<{
		errorOccurred : Bool,
		url : String,
		parentFrameId : Int,
		documentId : String,
		?parentDocumentId : String,
		documentLifecycle : ExtensionTypes.DocumentLifecycle,
		frameType : ExtensionTypes.FrameType,
	}>;

	/**
	* Retrieves information about all frames of a given tab.
	*
	* @param details Information about the tab to retrieve all frames from.
	*/
	overload static function getAllFrames(
		details : {
			tabId : Int
		},
		callback : (details : Array<{
			/**
			* True if the last navigation in this frame was interrupted by an error, i.e. the onErrorOccurred event fired.
			*/
			errorOccurred : Bool,
			/**
			* The ID of the process that runs the renderer for this frame.
			*/
			processId : Int,
			/**
			* The ID of the frame. 0 indicates that this is the main frame; a positive value indicates the ID of a subframe.
			*/
			frameId : Int,
			/**
			* The ID of the parent frame, or `-1` if this is the main frame.
			*/
			parentFrameId : Int,
			/**
			* The URL currently associated with this frame.
			*/
			url : String,
			/**
			* A UUID of the document loaded.
			*/
			documentId : String,
			/**
			* A UUID of the parent document owning this frame. This is not set if there is no parent.
			*/
			?parentDocumentId : String,
			/**
			* The lifecycle the document is in.
			*/
			documentLifecycle : ExtensionTypes.DocumentLifecycle,
			/**
			* The type of frame the navigation occurred in.
			*/
			frameType : ExtensionTypes.FrameType,
		}>)->Void
	) : Void;

	overload static function getAllFrames(
		details : {
			tabId : Int
		}
	) : Promise<Array<{
			errorOccurred : Bool,
			processId : Int,
			frameId : Int,
			parentFrameId : Int,
			url : String,
			documentId : String,
			?parentDocumentId : String,
			documentLifecycle : ExtensionTypes.DocumentLifecycle,
			frameType : ExtensionTypes.FrameType,
	}>>;
}

private typedef DetailsBase = {
	/**
	* The ID of the tab in which the navigation is about to occur.
	*/
	var tabId : Int;

	var url : String;

	/**
	* The value of -1.
	*
	* @deprecated The processId is no longer set for this event, since the process which will render the resulting document is not known until onCommit.
	* @chrome-deprecated-since Chrome 50
	*/
	var processId : Int;

	/**
	* 0 indicates the navigation happens in the tab content window; a positive value indicates navigation in a subframe. Frame IDs are unique for a given tab and process.
	*/
	var frameId : Int;

	/**
	* The ID of the parent frame, or `-1` if this is the main frame.
	*/
	var parentFrameId : Int;

	/**
	* The time when the browser was about to start the navigation, in milliseconds since the epoch.
	*/
	var timeStamp : Float;

	/**
	* A UUID of the parent document owning this frame. This is not set if there is no parent.
	*
	* @since Chrome 106
	*/
	var ?parentDocumentId : String;

	/**
	* The lifecycle the document is in.
	*
	* @since Chrome 106
	*/
	var documentLifecycle : ExtensionTypes.DocumentLifecycle;

	/**
	* The type of frame the navigation occurred in.
	*
	* @since Chrome 106
	*/
	var frameType : ExtensionTypes.FrameType;
}


/**
* Cause of the navigation. The same transition types as defined in the history API are used.
* These are the same transition types as defined in the
* [history API](https://developer.chrome.com/docs/extensions/reference/history/#transition_types)
* except with `"start_page"` in place of `"auto_toplevel"` (for backwards compatibility).
*
* @since Chrome 44
*/
// extern enum abstract TransitionType(String) to String {}

/**
* @since Chrome 44
*/
extern enum abstract TransitionQualifier(String) to String {
	var CLIENT_REDIRECT = "client_redirect";
	var SERVER_REDIRECT = "server_redirect";
	var FORWARD_BACK = "forward_back";
	var FROM_ADDRESS_BAR = "from_address_bar";
}
