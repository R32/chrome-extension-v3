package chrome;

/**
* Use the `chrome.idle` API to detect when the machine's idle state changes.
*
* @chrome-permission idle
*/
@:native("chrome.idle")
extern class Idle {

	/**
	* Fired when the system changes to an active, idle or locked state.
	* The event fires with "locked" if the screen is locked or the screensaver activates,
	* "idle" if the system is unlocked and the user has not generated any input for a specified
	* number of seconds, and "active" when the user generates input on an idle system.
	*/
	static final onStateChanged : Event<IdleState->Void>;

	/**
	* Returns "locked" if the system is locked, "idle" if the user has not
	* generated any input for a specified number of seconds, or "active" otherwise.
	*
	* @param detectionIntervalInSeconds The system is considered idle if
	* detectionIntervalInSeconds seconds have elapsed since the last user input detected.
	*/
	static function queryState( detectionIntervalInSeconds : Float, callback : IdleState->Void ) : Void;

	/**
	* Sets the interval, in seconds, used to determine when the system is in
	* an idle state for onStateChanged events. The default interval is 60 seconds.
	*
	* @param intervalInSeconds Threshold, in seconds, used to determine when
	* the system is in an idle state.
	*/
	static function setDetectionInterval( intervalInSeconds : Float ) : Void;

	/**
	* Gets the time, in seconds, it takes until the screen is locked automatically
	* while idle. Returns a zero duration if the screen is never locked automatically.
	* Currently supported on Chrome OS only.
	*
	* @param callback(delay) Time, in seconds, until the screen is locked automatically
	* while idle. This is zero if the screen never locks automatically.
	*
	* @since Chrome 73
	* @chrome-platform chromeos
	* @chrome-platform lacros
	*/
	static function getAutoLockDelay( callback : (delay : Float)->Void ) : Void;
}

/**
* @since Chrome 44
*/
extern enum abstract IdleState(String) to String {
	var ACTIVE = "active";
	var IDLE = "idle";
	var LOCKED = "locked";
}
