package chrome;

import js.html.LocalMediaStream;
/**
* Use the `chrome.tabCapture` API to interact with tab media streams.
*
* @chrome-permission tabCapture
* @chrome-disallow-service-workers
*/
@:native("chrome.tabCapture")
extern class TabCapture {
	/**
	* Event fired when the capture status of a tab changes.
	* This allows extension authors to keep track of the capture status
	* of tabs to keep UI elements like page actions in sync.
	*/
	static final onStatusChanged : Event<CaptureInfo->Void>;

	/**
	* Captures the visible area of the currently active tab. Capture can only
	* be started on the currently active tab after the extension has been _invoked_,
	* similar to the way that [activeTab](https://developer.chrome.com/docs/extensions/activeTab#invoking-activeTab) works.
	* Capture is maintained across page navigations within the tab, and stops
	* when the tab is closed, or the media stream is closed by the extension.
	*
	* @param options Configures the returned media stream.
	* @param callback Callback with either the tab capture MediaStream or `null`.
	* `null` indicates an error has occurred and the client may query {@link runtime.lastError}
	* to access the error details.
	*/
	static function capture( options : CaptureOptions, callback : (stream : LocalMediaStream)->Void) : Void;

	/**
	* Returns a list of tabs that have requested capture or are being captured,
	* i.e. status != stopped and status != error. This allows extensions to
	* inform the user that there is an existing tab capture that would prevent
	* a new tab capture from succeeding (or to prevent redundant requests for the same tab).
	*
	* @param callback Callback invoked with CaptureInfo\[\] for captured tabs.
	*/
	static function getCapturedTabs( callback : (Array<CaptureInfo>)->Void) : Void;

	/**
	* Creates a stream ID to capture the target tab. Similar to chrome.tabCapture.capture() method,
	* but returns a media stream ID, instead of a media stream, to the consumer tab.
	*
	* @param callback Callback to invoke with the result. If successful,
	* the result is an opaque string that can be passed to the `getUserMedia()` API
	* to generate a media stream that corresponds to the target tab. The created `streamId`
	* can only be used once and expires after a few seconds if it is not used.
	* @since Chrome 71
	*/
	overload static function getMediaStreamId( callback : (streamId : String)->Void) : Void;
	overload static function getMediaStreamId( options : GetMediaStreamOptions, callback : (streamId : String)->Void) : Void;
}

extern enum abstract TabCaptureState(String) to String {
	var PENDING = "pending";
	var ACTIVE = "active";
	var STOPPED = "stopped";
	var ERROR = "error";
}

typedef CaptureInfo = {

	/**
	* The id of the tab whose status changed.
	*/
	var tabId : Int;

	/**
	* The new capture status of the tab.
	*/
	var status : TabCaptureState;

	/**
	* Whether an element in the tab being captured is in fullscreen mode.
	*/
	var fullscreen : Bool;
}

typedef MediaStreamConstraint = {

	var mandatory : Dynamic<Any>;

	var ?optional : Dynamic<Any>;
}

typedef CaptureOptions = {

	var ?audio : Bool;

	var ?video : Bool;

	var ?audioConstraints : MediaStreamConstraint;

	var ?videoConstraints : MediaStreamConstraint;
}

/**
* @since Chrome 71
*/
typedef GetMediaStreamOptions = {

	/**
	* Optional tab id of the tab which will later invoke `getUserMedia()` to
	* consume the stream. If not specified then the resulting stream can be
	* used only by the calling extension. The stream can only be used by frames
	* in the given tab whose security origin matches the consumber tab's origin.
	* The tab's origin must be a secure origin, e.g. HTTPS.
	*/
	var ?consumerTabId : Int;

	/**
	* Optional tab id of the tab which will be captured. If not specified then
	* the current active tab will be selected. Only tabs for which the extension
	* has been granted the `activeTab` permission can be used as the target tab.
	*/
	var ?targetTabId : Int;
}
