package chrome;

/**
* Desktop Capture API that can be used to capture content of screen,
* individual windows or tabs.
*
* @chrome-permission desktopCapture
*/
@:native("chrome.desktopCapture")
extern class DesktopCapture {
	/**
	* Shows desktop media picker UI with the specified set of sources.
	*
	* @param sources Set of sources that should be shown to the user.
	* The sources order in the set decides the tab order in the picker.
	* @param targetTab Optional tab for which the stream is created.
	* If not specified then the resulting stream can be used only by the calling extension.
	* The stream can only be used by frames in the given tab whose security
	* origin matches `tab.url`. The tab's origin must be a secure origin, e.g. HTTPS.
	* @returns An id that can be passed to cancelChooseDesktopMedia() in case
	* the prompt need to be canceled.
	*/
	overload static function chooseDesktopMedia(
		sources : Array<DesktopCaptureSourceType>,
		targetTab : Tabs.Tab,
		/**
		* @param streamId An opaque string that can be passed to `getUserMedia()`
		* API to generate media stream that corresponds to the source selected
		* by the user. If user didn't select any source (i.e. canceled the prompt)
		* then the callback is called with an empty `streamId`. The created
		* `streamId` can be used only once and expires after a few seconds when
		* it is not used.
		* @param options Contains properties that describe the stream.
		*/
		callback : (streamId : String, options : {canRequestAudioTrack : Bool})->Void
	) : Int;
	overload static function chooseDesktopMedia(
		sources : Array<DesktopCaptureSourceType>,
		callback : (streamId : String, options : {canRequestAudioTrack : Bool})->Void
	) : Int;

	/**
	* Hides desktop media picker dialog shown by chooseDesktopMedia().
	*
	* @param desktopMediaRequestId Id returned by chooseDesktopMedia()
	*/
	static function cancelChooseDesktopMedia( desktopMediaRequestId : Int ) : Void;
}

/**
* Enum used to define set of desktop media sources used in chooseDesktopMedia().
*/
extern enum abstract DesktopCaptureSourceType(String) to String {
	var SCREEN = "screen";
	var WINDOW = "window";
	var TAB = "tab";
	var AUDIO = "audio";
}

/**
* Mirrors [SystemAudioPreferenceEnum](https://w3c.github.io/mediacapture-screen-share/#dom-systemaudiopreferenceenum).
*
* @since Chrome 105
*/
extern enum abstract SystemAudioPreferenceEnum(String) to String {
	var INCLUDE = "include";
	var EXCLUDE = "exclude";
}

/**
* Mirrors [SelfCapturePreferenceEnum](https://w3c.github.io/mediacapture-screen-share/#dom-selfcapturepreferenceenum).
*
* @since Chrome 107
*/
extern enum abstract SelfCapturePreferenceEnum(String) to String {
	var INCLUDE = "include";
	var EXCLUDE = "exclude";
}
