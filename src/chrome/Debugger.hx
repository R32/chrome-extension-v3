package chrome;

/**
* The `chrome.debugger` API serves as an alternate transport for
* Chrome's [remote debugging protocol](https://developer.chrome.com/devtools/docs/debugger-protocol).
* Use `chrome.debugger` to attach to one or more tabs to instrument network interaction,
* debug JavaScript, mutate the DOM and CSS, etc. Use the Debuggee `tabId` to target tabs
* with sendCommand and route events by `tabId` from onEvent callbacks.
*
* @chrome-permission debugger
*/
@:native("chrome.debugger")
extern class Debugger {
	/**
	* Fired whenever debugging target issues instrumentation event.
	*/
	static final onEvent : Event<(source : Debuggee, method : String, ?params : Dynamic<Any>)->Void>;

	/**
	* Fired when browser terminates debugging session for the tab.
	* This happens when either the tab is being closed or Chrome DevTools is
	* being invoked for the attached tab.
	*/
	static final onDetach : Event<(source : Debuggee, reason : DetachReason)->Void>;

	/**
	* Attaches debugger to the given target.
	*
	* @param target Debugging target to which you want to attach.
	* @param ver Required debugging protocol version ("0.1").
	* One can only attach to the debuggee with matching major version
	* and greater or equal minor version. List of the protocol versions can be
	* obtained [here](https://developer.chrome.com/devtools/docs/debugger-protocol).
	* @param callback Called once the attach operation succeeds or fails.
	* Callback receives no arguments. If the attach fails, {@link runtime.lastError}
	* will be set to the error message.
	*/
	overload static function attach( target : Debuggee, ver : String, callback : ()->Void ) : Void;
	overload static function attach( target : Debuggee, ver : String ) : Promise<Void>;

	/**
	* Detaches debugger from the given target.
	*
	* @param target Debugging target from which you want to detach.
	* @param callback Called once the detach operation succeeds or fails.
	* Callback receives no arguments. If the detach fails, {@link runtime.lastError}
	* will be set to the error message.
	*/
	overload static function detach( target : Debuggee,  callback : ()->Void ) : Void;
	overload static function detach( target : Debuggee ) : Promise<Void>;

	/**
	* Sends given command to the debugging target.
	*
	* @param target Debugging target to which you want to send the command.
	* @param method Method name. Should be one of the methods defined by the
	* [remote debugging protocol](https://developer.chrome.com/devtools/docs/debugger-protocol).
	* @param commandParams JSON object with request parameters.
	* This object must conform to the remote debugging params scheme for given method.
	* @param callback Response body. If an error occurs while posting the message,
	* the callback will be called with no arguments and {@link runtime.lastError}
	* will be set to the error message.
	*/
	overload static function sendCommand( target : Debuggee, method : String, callback : (Dynamic<Any>)->Void ) : Void;
	overload static function sendCommand( target : Debuggee, method : String,  commandParams : Dynamic<Any>, callback : (Dynamic<Any>)->Void ) : Void;
	overload static function sendCommand( target : Debuggee, method : String, ?commandParams : Dynamic<Any> ) : Promise<Dynamic<Any>>;

	/**
	* Returns the list of available debug targets.
	*/
	overload static function getTargets( callback : (Array<TargetInfo>)->Void ) : Void;
	overload static function getTargets() : Promise<Array<TargetInfo>>;
}

/**
* Debuggee identifier. Either tabId or extensionId must be specified
*/
typedef Debuggee = {

	/**
	* The id of the tab which you intend to debug.
	*/
	var ?tabId : Int;

	/**
	* The id of the extension which you intend to debug. Attaching to
	* an extension background page is only possible when the
	* `--silent-debugger-extension-api` command-line switch is used.
	*/
	var ?extensionId : String;

	/**
	* The opaque id of the debug target.
	*/
	var ?targetId : String;
}

/**
* Target type.
*
* @since Chrome 44
*/
extern enum abstract TargetInfoType(String) to String {
	var PAGE = "page";
	var BACKGROUND_PAGE = "background_page";
	var WORKER = "worker";
	var OTHER = "other";
}

/**
* Connection termination reason.
*
* @since Chrome 44
*/
extern enum abstract DetachReason(String) to String {
	var TARGET_CLOSED = "target_closed";
	var CANCELED_BY_USER = "canceled_by_user";
}

/**
* Debug target information
*/
typedef TargetInfo = {

	/**
	* Target type.
	*/
	var type : TargetInfoType;

	/**
	* Target id.
	*/
	var id : String;

	/**
	* The tab id, defined if type == 'page'.
	*/
	var ?tabId : Int;

	/**
	* The extension id, defined if type = 'background\_page'.
	*/
	var ?extensionId : String;

	/**
	* True if debugger is already attached.
	*/
	var attached : Bool;

	/**
	* Target page title.
	*/
	var title : String;

	/**
	* Target URL.
	*/
	var url : String;

	/**
	* Target favicon URL.
	*/
	var ?faviconUrl : String;
}
