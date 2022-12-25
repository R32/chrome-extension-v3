package chrome;

/**
* Use the `chrome.notifications` API to create rich notifications using templates
* and show these notifications to users in the system tray.
*
* @chrome-permission notifications
*/
@:native("chrome.notifications")
extern class Notifications {
	/**
	* The notification closed, either by the system or by user action.
	*/
	static final onClosed : Event<(notificationId : String, byUser : Bool)->Void>;

	/**
	* The user clicked in a non-button area of the notification.
	*/
	static final onClicked : Event<(notificationId : String)->Void>;

	/**
	* The user pressed a button in the notification.
	*/
	static final onButtonClicked : Event<(notificationId : String, buttonIndex : Int)->Void>;

	/**
	* The user changes the permission level. As of Chrome 47,
	* only ChromeOS has UI that dispatches this event.
	*/
	static final onPermissionLevelChanged : Event<(level : PermissionLevel)->Void>;

	/**
	* The user clicked on a link for the app's notification settings.
	* As of Chrome 47, only ChromeOS has UI that dispatches this event.
	* As of Chrome 65, that UI has been removed from ChromeOS, too.
	*
	* @deprecated Custom notification settings button is no longer supported.
	* @chrome-deprecated-since Chrome 65
	*/
	@:deprecated
	static final onShowSettings : Event<()->Void>;


	/**
	* Creates and displays a notification.
	*
	* @param notificationId

	Identifier of the notification. If not set or empty, an ID will automatically be generated.
	If it matches an existing notification, this method first clears that notification before
	proceeding with the create operation. The identifier may not be longer than 500 characters.

	The `notificationId` parameter is required before Chrome 42.
	* @param options Contents of the notification.
	* @param callback

	Returns the notification id (either supplied or generated) that represents the created notification.

	The callback is required before Chrome 42.
	*/
	overload static function create( options: NotificationOptions, ?callback : (notificationId : String)->Void ) : Void;
	overload static function create( notificationId: String, options: NotificationOptions, ?callback : String->Void ) : Void;

	/**
	* Updates an existing notification.
	*
	* @param notificationId The id of the notification to be updated.
	* This is returned by {@link notifications.create} method.
	* @param options Contents of the notification to update to.
	* @param callback

	Called to indicate whether a matching notification existed.

	The callback is required before Chrome 42.
	*/
	static function update( notificationId: String, options: NotificationOptions, ?callback : (wasUpdated : Bool)->Void ) : Void;

	/**
	* Clears the specified notification.
	*
	* @param notificationId The id of the notification to be cleared.
	* This is returned by {@link notifications.create} method.
	* @param callback

	Called to indicate whether a matching notification existed.

	The callback is required before Chrome 42.
	*/
	static function clear( notificationId: String, ?callback : (wasCleared : Bool)->Void ) : Void;

	/**
	* Retrieves all the notifications of this app or extension.
	*
	* @param callback Returns the set of notification\_ids currently in the system.
	*/
	static function getAll( callback : (notifications : Dynamic<Any>)->Void ) : Void;

	/**
	* Retrieves whether the user has enabled notifications from this app or extension.
	*
	* @param callback Returns the current permission level.
	*/
	static function getPermissionLevel( callback : PermissionLevel->Void ) : Void;
}

/**
* @chrome-enum "basic" icon, title, message, expandedMessage, up to two buttons
* @chrome-enum "image" icon, title, message, expandedMessage, image, up to two buttons
* @chrome-enum "list" icon, title, message, items, up to two buttons.
* Users on Mac OS X only see the first item.
* @chrome-enum "progress" icon, title, message, progress, up to two buttons
*/
extern enum abstract TemplateType(String) to String {
	var BASIC = "basic";
	var IMAGE = "image";
	var LIST = "list";
	var PROGRESS = "progress";
}

/**
* @chrome-enum "granted" User has elected to show notifications from the app
* or extension. This is the default at install time.
* @chrome-enum "denied" User has elected not to show notifications from the app or extension.
*/
extern enum abstract PermissionLevel(String) to String {
	var GRANTED = "granted";
	var DENIED = "denied";
}

typedef NotificationItem = {
	/**
	* Title of one item of a list notification.
	*/
	var title : String;

	/**
	* Additional details about this item.
	*/
	var message : String;
}

typedef NotificationBitmap = {}

typedef NotificationButton = {

	var title: String;

	/**
	* @deprecated Button icons not visible for Mac OS X users.
	* @chrome-deprecated-since Chrome 59
	*/
	var ?iconUrl : String;
}

typedef NotificationOptions = {

	/**
	* Which type of notification to display. _Required for {@link notifications.create}_ method.
	*/
	var ?type : TemplateType;

	/**
	* A URL to the sender's avatar, app icon, or a thumbnail for image notifications.
	*
	* URLs can be a data URL, a blob URL, or a URL relative to a resource within
	* this extension's .crx file _Required for {@link notifications.create}_ method.
	*/
	var ?iconUrl : String;

	/**
	* A URL to the app icon mask. URLs have the same restrictions as
	* {@link notifications.NotificationOptions.iconUrl iconUrl}.
	*
	* The app icon mask should be in alpha channel, as only the alpha channel
	* of the image will be considered.
	*
	* @deprecated The app icon mask is not visible for Mac OS X users.
	* @chrome-deprecated-since Chrome 59
	*/
	var ?appIconMaskUrl : String;

	/**
	* Title of the notification (e.g. sender name for email). _Required for
	* {@link notifications.create}_ method.
	*/
	var ?title : String;

	/**
	* Main notification content. _Required for {@link notifications.create}_ method.
	*/
	var ?message : String;

	/**
	* Alternate notification content with a lower-weight font.
	*/
	var ?contextMessage : String;

	/**
	* Priority ranges from -2 to 2. -2 is lowest priority. 2 is highest. Zero is default. On platforms that don't support a notification center (Windows, Linux & Mac), -2 and -1 result in an error as notifications with those priorities will not be shown at all.
	*/
	var ?priority : Int;

	/**
	* A timestamp associated with the notification, in milliseconds past the epoch (e.g. `Date.now() + n`).
	*/
	var ?eventTime : Float;

	/**
	* Text and icons for up to two notification action buttons.
	*/
	var ?buttons : Array<NotificationButton>;

	/**
	* A URL to the image thumbnail for image-type notifications. URLs have the same restrictions as {@link notifications.NotificationOptions.iconUrl iconUrl}.
	*
	* @deprecated The image is not visible for Mac OS X users.
	* @chrome-deprecated-since Chrome 59
	*/
	var ?imageUrl : String;

	/**
	* Items for multi-item notifications. Users on Mac OS X only see the first item.
	*/
	var ?items : Array<NotificationItem>;

	/**
	* Current progress ranges from 0 to 100.
	*/
	var ?progress : Int;

	/**
	* @deprecated This UI hint is ignored as of Chrome 67
	* @chrome-deprecated-since Chrome 67
	*/
	var ?isClickable : Bool;

	/**
	* Indicates that the notification should remain visible on screen until
	* the user activates or dismisses the notification. This defaults to false.
	*
	* @since Chrome 50
	*/
	var ?requireInteraction : Bool;

	/**
	* Indicates that no sounds or vibrations should be made when
	* the notification is being shown. This defaults to false.
	*
	* @since Chrome 70
	*/
	var ?silent : Bool;
}
