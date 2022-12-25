package chrome;

/**
* Use the `chrome.power` API to override the system's power management features.
*
* @chrome-permission power
*/
@:native("chrome.power")
extern class Power {
	/**
	* Requests that power management be temporarily disabled.
	* `level` describes the degree to which power management should be disabled.
	* If a request previously made by the same app is still active,
	* it will be replaced by the new request.
	*/
	static function requestKeepAwake( level : Level ) : Void;

	/**
	* Releases a request previously made via requestKeepAwake().
	*/
	static function releaseKeepAwake() : Void;
}

/**
* @chrome-enum "system" Prevent the system from sleeping in response to user inactivity.
* @chrome-enum "display" Prevent the display from being turned off or dimmed or the system
* from sleeping in response to user inactivity.
*/
extern enum abstract Level(String) to String {
	var SYSTEM = "system";
	var DISPLAY = "display";
}