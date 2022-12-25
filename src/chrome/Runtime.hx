package chrome;

import js.html.FileSystemDirectoryEntry in DirectoryEntry;

/**
* Use the `chrome.runtime` API to retrieve the background page,
* return details about the manifest, and listen for and respond to events
* in the app or extension lifecycle. You can also use this API to convert
* the relative path of URLs to fully-qualified URLs.
*/
@:native("chrome.runtime")
extern class Runtime {

	/**
	* The ID of the extension/app.
	*/
	static final id : String;

	/**
	* Fired when a profile that has this extension installed first starts up.
	* This event is not fired when an incognito profile is started, even if
	* this extension is operating in 'split' incognito mode.
	*/
	static final onStartup : Event<()->Void>;

	/**
	* Fired when the extension is first installed, when the extension is updated
	* to a new version, and when Chrome is updated to a new version.
	*/
	static final onInstalled : Event<{reason : OnInstalledReason, ?previousVersion : String, ?id : String}->Void>;

	/**
	* Sent to the event page just before it is unloaded. This gives the extension
	* opportunity to do some clean up. Note that since the page is unloading,
	* any asynchronous operations started while handling this event are not guaranteed
	* to complete. If more activity for the event page occurs before it gets unloaded
	* the onSuspendCanceled event will be sent and the page won't be unloaded.
	*/
	static final onSuspend : Event<()->Void>;

	/**
	* Sent after onSuspend to indicate that the app won't be unloaded after all.
	*/
	static final onSuspendCanceled : Event<()->Void>;

	/**
	* Fired when an update is available, but isn't installed immediately because
	* the app is currently running. If you do nothing, the update will be installed
	* the next time the background page gets unloaded, if you want it to be
	* installed sooner you can explicitly call chrome.runtime.reload().
	* If your extension is using a persistent background page, the background page
	* of course never gets unloaded, so unless you call chrome.runtime.reload()
	* manually in response to this event the update will not get installed
	* until the next time Chrome itself restarts. If no handlers are listening
	* for this event, and your extension has a persistent background page,
	* it behaves as if chrome.runtime.reload() is called in response to this event.
	*/
	static final onUpdateAvailable : Event<{name : Dynamic<Any>, version : String}->Void>;

	/**
	* Fired when a Chrome update is available, but isn't installed immediately
	* because a browser restart is required.
	*
	* @deprecated Please use {@link runtime.onRestartRequired}.
	*/
	@:deprecated
	static final onBrowserUpdateAvailable : Event<()->Void>;

	/**
	* Fired when a connection is made from either an extension process or
	* a content script (by {@link runtime.connect}).
	*/
	static final onConnect : Event<Port->Void>;

	/**
	* Fired when a connection is made from another extension (by {@link runtime.connect}).
	*/
	static final onConnectExternal : Event<Port->Void>;

	/**
	* Fired when a connection is made from a native application. Currently only supported on Chrome OS.
	*
	* @since Chrome 74
	* @chrome-permission nativeMessaging
	*/
	static final onConnectNative : Event<Port->Void>;

	/**
	* Fired when a message is sent from either an extension process
	* (by {@link runtime.sendMessage}) or a content script (by {@link tabs.sendMessage}).
	*/
	static final onMessage : Event<(message : Any, sender : MessageSender, sendResponse : ()->Void)->Void> ;
	/**
	*  Note return true; in the listener: this tells the browser that
	* you intend to use the sendResponse argument after the listener has returned
	*/
	@:native("onMessage")
	static final onMessageAsync : Event<(message : Any, sender : MessageSender, sendResponse : ()->Void)->Bool>;

	/**
	* Fired when a message is sent from another extension/app
	* (by {@link runtime.sendMessage}).Cannot be used in a content script.
	*/
	static final onMessageExternal : Event<(message : Any, sender : MessageSender, sendResponse : ()->Void)->Void> ;
	/**
	*  Note return true; in the listener: this tells the browser that
	* you intend to use the sendResponse argument after the listener has returned
	*/
	@:native("onMessageExternal")
	static final onMessageExternalAsync : Event<(message : Any, sender : MessageSender, sendResponse : ()->Void)->Bool>;

	/**
	* Fired when an app or the device that it runs on needs to be restarted.
	* The app should close all its windows at its earliest convenient time to
	* let the restart to happen. If the app does nothing, a restart will be
	* enforced after a 24-hour grace period has passed. Currently,
	* this event is only fired for Chrome OS kiosk apps.
	*/
	static final onRestartRequired : Event<OnRestartRequiredReason->Void>;

	/**
	* Retrieves the JavaScript 'window' object for the background page running
	* inside the current extension/app. If the background page is an event page,
	* the system will ensure it is loaded before calling the callback.
	* If there is no background page, an error is set.
	*
	* @chrome-disallow-service-workers
	*/
	overload static function getBackgroundPage( callback : Window->Void ) : Void;
	overload static function getBackgroundPage() : Promise<Window>;

	/**
	* Open your Extension's options page, if possible.
	*
	* The precise behavior may depend on your manifest's
	* `[options_ui](https://developer.chrome.com/docs/extensions/optionsV2)`
	* or `[options_page](https://developer.chrome.com/docs/extensions/options)` key,
	* or what Chrome happens to support at the time.
	* For example, the page may be opened in a new tab, within chrome://extensions, within an App,
	* or it may just focus an open options page. It will never cause the caller page to reload.
	*
	* If your Extension does not declare an options page, or Chrome failed to create
	* one for some other reason, the callback will set {@link lastError}.
	*/
	overload static function openOptionsPage( callback : ()->Void ) : Void;
	overload static function openOptionsPage() : Promise<Void>;

	/**
	* Returns details about the app or extension from the manifest.
	* The object returned is a serialization of the full [manifest file](https://developer.chrome.com/docs/extensions/manifest).
	*
	* @returns The manifest details.
	*/
	static function getManifest() : Dynamic<Any>;

	/**
	* Converts a relative path within an app/extension install directory to a fully-qualified URL.
	*
	* @param path A path to a resource within an app/extension expressed relative to its install directory.
	* @returns The fully-qualified URL to the resource.
	*/
	static function getURL( path : String ) : String;

	/**
	* Sets the URL to be visited upon uninstallation. This may be used to clean
	* up server-side data, do analytics, and implement surveys. Maximum 255 characters.
	*
	* @param url URL to be opened after the extension is uninstalled.
	* This URL must have an http: or https: scheme. Set an empty string to not
	* open a new tab upon uninstallation.
	* @param callback Called when the uninstall URL is set. If the given URL is invalid,
	* {@link runtime.lastError} will be set.
	*/
	overload static function setUninstallURL( url : String, callback : ()->Void ) : Void;
	overload static function setUninstallURL( url : String ) : Promise<Void>;

	/**
	* Reloads the app or extension. This method is not supported in kiosk mode.
	* For kiosk mode, use chrome.runtime.restart() method.
	*/
	static function reload() : Void;

	/**
	* Requests an immediate update check be done for this app/extension.
	*
	* **Important**: Most extensions/apps should **not** use this method,
	* since Chrome already does automatic checks every few hours, and you can
	* listen for the {@link runtime.onUpdateAvailable} event without needing to
	* call requestUpdateCheck.
	*
	* This method is only appropriate to call in very limited circumstances,
	* such as if your extension/app talks to a backend service, and the
	* backend service has determined that the client extension/app version is
	* very far out of date and you'd like to prompt a user to update. Most other
	* uses of requestUpdateCheck, such as calling it unconditionally based on a
	* repeating timer, probably only serve to waste client, network, and server resources.
	*
	* Note: When called with a callback, instead of returning an object this function
	* will return the two properties as separate arguments passed to the callback.
	*/
	overload static function requestUpdateCheck( callback : {status : RequestUpdateCheckStatus, ?version : String}->Void ) : Void;
	overload static function requestUpdateCheck() : Promise<{status : RequestUpdateCheckStatus, ?version : String}>;

	/**
	* Restart the ChromeOS device when the app runs in kiosk mode. Otherwise, it's no-op.
	*/
	static function restart() : Void;

	/**
	* Restart the ChromeOS device when the app runs in kiosk mode after the given
	* seconds. If called again before the time ends, the reboot will be delayed.
	* If called with a value of -1, the reboot will be cancelled. It's a no-op
	* in non-kiosk mode. It's only allowed to be called repeatedly by the first
	* extension to invoke this API.
	*
	* @param seconds Time to wait in seconds before rebooting the device, or -1 to cancel a scheduled reboot.
	* @param callback A callback to be invoked when a restart request was successfully rescheduled.
	* @since Chrome 53
	*/
	overload static function restartAfterDelay( seconds : Int, callback : ()->Void ) : Void;
	overload static function restartAfterDelay( seconds : Int ) : Promise<Void>;

	/**
	* Attempts to connect listeners within an extension/app (such as the background page),
	* or other extensions/apps. This is useful for content scripts connecting to
	* their extension processes, inter-app/extension communication,
	* and [web messaging](https://developer.chrome.com/docs/extensions/manifest/externally_connectable).
	* Note that this does not connect to any listeners in a content script.
	* Extensions may connect to content scripts embedded in tabs via {@link tabs.connect}.
	*
	* @param extensionId The ID of the extension or app to connect to. If omitted, a connection will be attempted with your own extension. Required if sending messages from a web page for [web messaging](https://developer.chrome.com/docs/extensions/manifest/externally_connectable).
	* @returns Port through which messages can be sent and received. The port's {@link Port onDisconnect} event is fired if the extension/app does not exist.
	*/
	static function connect( ?extensionId : String, ?connectInfo : {?name : String, ?includeTlsChannelId : Bool} ) : Port;

	/**
	* Connects to a native application in the host machine.
	* See [Native Messaging](https://developer.chrome.com/docs/extensions/nativeMessaging)
	* for more information.
	*
	* @param application The name of the registered application to connect to.
	* @returns Port through which messages can be sent and received with the application
	* @chrome-permission nativeMessaging
	*/
	static function connectNative( application : String ) : Port;

	/**
	* Sends a single message to event listeners within your extension/app or
	* a different extension/app. Similar to {@link runtime.connect} but only
	* sends a single message, with an optional response. If sending to your extension,
	* the {@link runtime.onMessage} event will be fired in every frame of your extension
	* (except for the sender's frame), or {@link runtime.onMessageExternal},
	* if a different extension. Note that extensions cannot send messages to
	* content scripts using this method. To send messages to content scripts,
	* use {@link tabs.sendMessage}.
	*
	* @param extensionId The ID of the extension/app to send the message to. If omitted, the message will be sent to your own extension/app. Required if sending messages from a web page for [web messaging](https://developer.chrome.com/docs/extensions/manifest/externally_connectable).
	* @param message The message to send. This message should be a JSON-ifiable object.
	*/
	overload static function sendMessage( message : Any, options : {?includeTlsChannelId : Bool}, callback : Any->Void ) : Void;
	overload static function sendMessage( extensionId : String, message : Any, options : {?includeTlsChannelId : Bool}, callback : Any->Void ) : Void;
	overload static function sendMessage( message : Any, ?options : {?includeTlsChannelId : Bool} ) : Promise<Any>;
	overload static function sendMessage( extensionId : String, message : Any, ?options : {?includeTlsChannelId : Bool} ) : Promise<Any>;

	/**
	* Send a single message to a native application.
	*
	* @param application The name of the native messaging host.
	* @param message The message that will be passed to the native messaging host.
	* @chrome-permission nativeMessaging
	*/
	overload static function sendNativeMessage( application : String, message : Dynamic<Any>, callback : Any->Void ) : Void;
	overload static function sendNativeMessage( application : String, message : Dynamic<Any> ) : Promise<Any>;

	/**
	* Returns information about the current platform.
	*
	* @param callback Called with results
	*/
	overload static function getPlatformInfo( callback : PlatformInfo->Void ) : Void;
	overload static function getPlatformInfo() : Promise<PlatformInfo>;

	/**
	* Returns a DirectoryEntry for the package directory.
	*
	* @chrome-disallow-service-workers
	*/
	static function getPackageDirectoryEntry( callback : DirectoryEntry->Void ) : Void;
}

/**
* An object which allows two way communication with other pages.
* See [Long-lived connections](https://developer.chrome.com/docs/extensions/messaging#connect) for more information.
*/
typedef Port = {

	/**
	* The name of the port, as specified in the call to runtime.connect.
	*/
	var name : String;

	/**
	* This property will **only** be present on ports passed to
	* {@link runtime.onConnect onConnect} /
	* {@link runtime.onConnectExternal onConnectExternal} /
	* {@link runtime.onConnectNative onConnectNative} listeners.
	*/
	var ?sender : MessageSender;

	/**
	* Fired when the port is disconnected from the other end(s).
	* {@link runtime.lastError} may be set if the port was disconnected by an error.
	* If the port is closed via {@link Port.disconnect disconnect}, then
	* this event is _only_ fired on the other end. This event is fired at most once
	* (see also [Port lifetime](https://developer.chrome.com/docs/extensions/messaging#port-lifetime)).
	*/
	var onDisconnect : Event<Port->Void>;

	/**
	* This event is fired when {@link Port.postMessage postMessage} is called
	* by the other end of the port.
	*/
	var onMessage : Event<(Any, Port)->Void>;

	/**
	* Immediately disconnect the port. Calling `disconnect()` on an
	* already-disconnected port has no effect. When a port is disconnected,
	* no new events will be dispatched to this port.
	*/
	function disconnect() : Void;

	/**
	* Send a message to the other end of the port. If the port is disconnected, an error is thrown.
	*
	* @param message The message to send. This object should be JSON-ifiable.
	*/
	function postMessage( message : Any ) : Void;
}

/**
* An object containing information about the script context that sent a message or request.
*/
typedef MessageSender = {
	/**
	* The {@link tabs.Tab} which opened the connection, if any. This property
	* will **only** be present when the connection was opened from a tab (including content scripts),
	* and **only** if the receiver is an extension, not an app.
	*/
	// TODO:
	var ?tab : Tabs.Tab;

	/**
	* The [frame](https://developer.chrome.com/docs/extensions/reference/webNavigation/#frame_ids)
	* that opened the connection. 0 for top-level frames, positive for child frames.
	* This will only be set when `tab` is set.
	*/
	var ?frameId : Int;

	/**
	* The ID of the extension or app that opened the connection, if any.
	*/
	var ?id : String;

	/**
	* The URL of the page or frame that opened the connection. If the sender is
	* in an iframe, it will be iframe's URL not the URL of the page which hosts it.
	*/
	var ?url : String;

	/**
	* The name of the native application that opened the connection, if any.
	*
	* @since Chrome 74
	*/
	var ?nativeApplication : String;

	/**
	* The TLS channel ID of the page or frame that opened the connection,
	* if requested by the extension or app, and if available.
	*/
	var ?tlsChannelId : String;

	/**
	* The origin of the page or frame that opened the connection.
	* It can vary from the url property (e.g., about:blank)
	* or can be opaque (e.g., sandboxed iframes). This is useful for identifying
	* if the origin can be trusted if we can't immediately tell from the URL.
	*
	* @since Chrome 80
	*/
	var ?origin : String;

	/**
	* A UUID of the document that opened the connection.
	*
	* @since Chrome 106
	*/
	var ?documentId : String;

	/**
	* The lifecycle the document that opened the connection is in at the time
	* the port was created. Note that the lifecycle state of the document may
	* have changed since port creation.
	*
	* @since Chrome 106
	*/
	var ?documentLifecycle : String;
}


/**
* An object containing information about the current platform.
*/
typedef PlatformInfo = {
	/**
	* The operating system Chrome is running on.
	*/
	var os : PlatformOs;

	/**
	* The machine's processor architecture.
	*/
	var arch : PlatformArch;

	/**
	* The native client architecture. This may be different from arch on some platforms.
	*/
	var nacl_arch : PlatformNaclArch;
}


/**
* The operating system Chrome is running on.
*
* @since Chrome 44
*/
extern enum abstract PlatformOs(String) to String {
	var MAC     = "mac";
	var WIN     = "win";
	var ANDROID = "android";
	var CROS    = "cros";
	var LINUX   = "linux";
	var OPENBSD = "openbsd";
	var FUCHSIA = "fuchsia";
}

/**
* The machine's processor architecture.
*
* @since Chrome 44
*/
extern enum abstract PlatformArch(String) to String {
	var ARM     = "arm";
	var ARM64   = "arm64";
	var X86_32  = "x86-32";
	var X86_64  = "x86-64";
	var MIPS    = "mips";
	var MIPS64  = "mips64";
}

/**
* The native client architecture. This may be different from arch on some platforms.
*
* @since Chrome 44
*/
extern enum abstract PlatformNaclArch(String) to String {
	var ARM     = "arm";
	var X86_32  = "x86-32";
	var X86_64  = "x86-64";
	var MIPS    = "mips";
	var MIPS64  = "mips64";
}

/**
* Result of the update check.
*
* @since Chrome 44
*/
extern enum abstract RequestUpdateCheckStatus(String) to String {
	var THROTTLED = "throttled";
	var NO_UPDATE = "no_update";
	var UPDATE_AVAILABLE = "update_available";
}

/**
* The reason that this event is being dispatched.
*
* @since Chrome 44
*/
extern enum abstract OnInstalledReason(String) to String {
	var INSTALL = "install";
	var UPDATE = "update";
	var CHROME_UPDATE = "chrome_update";
	var SHARED_MODULE_UPDATE = "shared_module_update";
}

/**
* The reason that the event is being dispatched. 'app\_update' is used when
* the restart is needed because the application is updated to a newer version.
* 'os\_update' is used when the restart is needed because the browser/OS is updated
* to a newer version. 'periodic' is used when the system runs for more than the
* permitted uptime set in the enterprise policy.
*
* @since Chrome 44
*/
extern enum abstract OnRestartRequiredReason(String) to String {
	var APP_UPDATE = "app_update";
	var OS_UPDATE = "os_update";
	var PERIODIC = "periodic";
}
