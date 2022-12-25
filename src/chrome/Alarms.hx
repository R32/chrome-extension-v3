package chrome;

/**
* Use the `chrome.alarms` API to schedule code to run periodically or at a specified time in the future.
*
* @chrome-permission alarms
*/
@:native("chrome.alarms")
extern class Alarms {
	/**
	* Fired when an alarm has elapsed. Useful for event pages.
	*/
	static final onAlarm : Event<Alarm->Void>;

	/**
	* Creates an alarm. Near the time(s) specified by `alarmInfo`, the `onAlarm` event is fired. If there is another alarm with the same name (or no name if none is specified), it will be cancelled and replaced by this alarm.
	*
	* In order to reduce the load on the user's machine, Chrome limits alarms to at most once every 1 minute but may delay them an arbitrary amount more. That is, setting `delayInMinutes` or `periodInMinutes` to less than `1` will not be honored and will cause a warning. `when` can be set to less than 1 minute after "now" without warning but won't actually cause the alarm to fire for at least 1 minute.
	*
	* To help you debug your app or extension, when you've loaded it unpacked, there's no limit to how often the alarm can fire.
	*
	* @param name Optional name to identify this alarm. Defaults to the empty string.
	* @param alarmInfo Describes when the alarm should fire. The initial time must be specified by either `when` or `delayInMinutes` (but not both). If `periodInMinutes` is set, the alarm will repeat every `periodInMinutes` minutes after the initial event. If neither `when` or `delayInMinutes` is set for a repeating alarm, `periodInMinutes` is used as the default for `delayInMinutes`.
	*/
	overload static function create( name : String, alarmInfo : AlarmCreateInfo ) : Void;
	overload static function create( alarmInfo : AlarmCreateInfo ) : Void;

	/**
	* Retrieves details about the specified alarm.
	*
	* @param name The name of the alarm to get. Defaults to the empty string.
	*/
	overload static function get( callback : Alarm->Void ) : Void;
	overload static function get( name : String, callback : Alarm->Void ) : Void;
	overload static function get( ?name : String ) : Promise<Alarm>;

	/**
	* Gets an array of all the alarms.
	*/
	overload static function getAll( callback : Array<Alarm>->Void ) : Void;
	overload static function getAll() : Promise<Array<Alarm>>;

	/**
	* Clears the alarm with the given name.
	*
	* @param name The name of the alarm to clear. Defaults to the empty string.
	*/
	overload static function clear( callback : Bool->Void ) : Void;
	overload static function clear( name : String, callback : Bool->Void ) : Void;
	overload static function clear( ?name : String ) : Promise<Bool>;

	/**
	* Clears all alarms.
	*/
	overload static function clearAll( callback : Bool->Void ) : Void;
	overload static function clearAll() : Promise<Bool>;
}

typedef Alarm = {
	/**
	* Name of this alarm.
	*/
	var name : String;

	/**
	* Time at which this alarm was scheduled to fire, in milliseconds past the epoch (e.g. `Date.now() + n`). For performance reasons, the alarm may have been delayed an arbitrary amount beyond this.
	*/
	var scheduledTime : Float;

	/**
	* If not null, the alarm is a repeating alarm and will fire again in `periodInMinutes` minutes.
	*/
	var ?periodInMinutes : Float;
}


typedef AlarmCreateInfo = {
	/**
	* Time at which the alarm should fire, in milliseconds past the epoch (e.g. `Date.now() + n`).
	*/
	var ?when : Float;

	/**
	* Length of time in minutes after which the `onAlarm` event should fire.
	*/
	var ?delayInMinutes : Float;

	/**
	* If set, the onAlarm event should fire every `periodInMinutes` minutes after the initial event specified by `when` or `delayInMinutes`. If not set, the alarm will only fire once.
	*/
	var ?periodInMinutes : Float;
}
