package chrome;

/**
* Use the `chrome.sessions` API to query and restore tabs and windows from a browsing session.
*
* @chrome-permission sessions
*/
@:native("chrome.sessions")
extern class Sessions {
	/**
	* The maximum number of {@link sessions.Session} that will be included in a requested list.
	*/
	static inline var MAX_SESSION_RESULTS = 25;

	/**
	* Fired when recently closed tabs and/or windows are changed.
	* This event does not monitor synced sessions changes.
	*/
	static final onChanged : Event<()->Void>;

	/**
	* Gets the list of recently closed tabs and/or windows.
	*/
	overload static function getRecentlyClosed( callback : (Array<Session>)->Void ) : Void;
	overload static function getRecentlyClosed( filter : Filter, callback : (Array<Session>)->Void ) : Void;
	overload static function getRecentlyClosed( ?filter : Filter ) : Promise<Array<Session>>;

	/**
	* Retrieves all devices with synced sessions.
	*/
	overload static function getDevices( callback : (Array<Device>)->Void ) : Void;
	overload static function getDevices( filter : Filter, callback : (Array<Device>)->Void ) : Void;
	overload static function getDevices( ?filter : Filter ) : Promise<Array<Device>>;

	/**
	* Reopens a {@link windows.Window} or {@link tabs.Tab},
	* with an optional callback to run when the entry has been restored.
	*
	* @param sessionId The {@link windows.Window.sessionId}, or {@link tabs.Tab.sessionId} to restore.
	* If this parameter is not specified, the most recently closed session is restored.
	*/
	overload static function restore( callback : Session->Void ) : Void;
	overload static function restore( sessionId : String, callback : Session->Void ) : Void;
	overload static function restore( ?filter : Filter ) : Promise<Session>;
}

typedef Filter = {

	/**
	* The maximum number of entries to be fetched in the requested list.
	* Omit this parameter to fetch the maximum number of entries ({@link sessions.MAX_SESSION_RESULTS}).
	*/
	var ?maxResults : Int;
}

typedef Session = {

	/**
	* The time when the window or tab was closed or modified,
	* represented in milliseconds since the epoch.
	*/
	var lastModified : Float;

	/**
	* The {@link tabs.Tab}, if this entry describes a tab.
	* Either this or {@link sessions.Session.window} will be set.
	*/
	var ?tab : Tabs.Tab;

	/**
	* The {@link windows.Window}, if this entry describes a window.
	* Either this or {@link sessions.Session.tab} will be set.
	*/
	var ?window : Window;
}

typedef Device = {

	/**
	* The name of the foreign device.
	*/
	var deviceName : String;

	/**
	* A list of open window sessions for the foreign device,
	* sorted from most recently to least recently modified session.
	*/
	var sessions : Array<Session>;
}
