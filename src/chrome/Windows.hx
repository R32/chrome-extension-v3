package chrome;

/**
* Use the `chrome.windows` API to interact with browser windows.
* You can use this API to create, modify,
* and rearrange windows in the browser.
*/
@:native("chrome.windows")
extern class Windows {
	/**
	* The windowId value that represents the absence of a Chrome browser window.
	*/
	static inline var WINDOW_ID_NONE = -1;

	/**
	* The windowId value that represents the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*
	*/
	static inline var WINDOW_ID_CURRENT = -2;

	/**
	* Fired when a window is created.
	*/
	static final onCreated : CustomChromeEvent<(callback : Window->Void, ?filters : {windowTypes : Array<WindowType>})->Void> ;

	/**
	* Fired when a window is removed (closed).
	*/
	static final onRemoved : CustomChromeEvent<(callback : Int->Void, ?filters : {windowTypes : Array<WindowType>})->Void>;

	/**
	* Fired when the currently focused window changes.
	* Returns `chrome.windows.WINDOW_ID_NONE` if all Chrome windows have lost focus.
	* **Note:** On some Linux window managers, `WINDOW_ID_NONE` is always sent
	* immediately preceding a switch from one Chrome window to another.
	*/
	static final onFocusChanged : CustomChromeEvent<(callback : Int->Void, ?filters : {windowTypes : Array<WindowType>})->Void>;

	/**
	* Fired when a window has been resized; this event is only dispatched
	* when the new bounds are committed, and not for in-progress changes.
	*
	* @since Chrome 86
	*/
	static final onBoundsChanged : Event<(callback : Int->Void, ?filters : {windowTypes : Array<WindowType>})->Void>;

	/**
	* Gets details about a window.
	*/
	overload static function get( windowId : Int, callback : Window->Void ) : Void;
	overload static function get( windowId : Int, options : QueryOptions, callback : Window->Void ) : Void;
	overload static function get( windowId : Int, ?options : QueryOptions ) : Promise<Window>;

	/**
	* Gets the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*/
	overload static function getCurrent( callback : Window->Void ) : Void;
	overload static function getCurrent( options : QueryOptions, callback : Window->Void ) : Void;
	overload static function getCurrent( ?options : QueryOptions ) : Promise<Window>;

	/**
	* Gets the window that was most recently focused — typically the window 'on top'.
	*/
	overload static function getLastFocused( callback : Window->Void ) : Void;
	overload static function getLastFocused( options : QueryOptions, callback : Window->Void ) : Void;
	overload static function getLastFocused( ?options : QueryOptions ) : Promise<Window>;

	/**
	* Gets all windows.
	*/
	overload static function getAll( callback : (Array<Window>)->Void ) : Void;
	overload static function getAll( options : QueryOptions, callback : (Array<Window>)->Void ) : Void;
	overload static function getAll( ?options : QueryOptions ) : Promise<Array<Window>>;

	/**
	* Creates (opens) a new browser window with any optional sizing, position, or default URL provided.
	*/
	overload static function create( callback : Window->Void ) : Void;
	overload static function create( data : CreateData, callback : Window->Void ) : Void;
	overload static function create( ?data : CreateData ) : Promise<Window>;

	/**
	* Updates the properties of a window. Specify only the properties that to be changed;
	* unspecified properties are unchanged.
	*/
	overload static function update( windowId : Int, callback : Window->Void ) : Void;
	overload static function update( windowId : Int, info : UpdateInfo, callback : Window->Void ) : Void;
	overload static function update( windowId : Int, ?info : UpdateInfo ) : Promise<Window>;

	/**
	* Removes (closes) a window and all the tabs inside it.
	*/
	overload static function remove( windowId : Int, callback : ()->Void ) : Void;
	overload static function remove( windowId : Int ) : Promise<Void>;
}

private typedef CreateData = {
	/**
	* A URL or array of URLs to open as tabs in the window. Fully-qualified
	* URLs must include a scheme, e.g., 'http://www.google.com', not 'www.google.com'.
	* Non-fully-qualified URLs are considered relative within the extension.
	* Defaults to the New Tab Page.
	*/
	var ?url : EitherType<String,Array<String>>;

	/**
	* The ID of the tab to add to the new window.
	*/
	var ?tabId : Int;

	/**
	* The number of pixels to position the new window from the left edge of the screen.
	* If not specified, the new window is offset naturally from the last focused window.
	* This value is ignored for panels.
	*/
	var ?left : Float;

	/**
	* The number of pixels to position the new window from the top edge of the screen.
	* If not specified, the new window is offset naturally from the last focused window.
	* This value is ignored for panels.
	*/
	var ?top : Float;

	/**
	* The width in pixels of the new window, including the frame.
	* If not specified, defaults to a natural width.
	*/
	var ?width : Float;

	/**
	* The height in pixels of the new window, including the frame.
	* If not specified, defaults to a natural height.
	*/
	var ?height : Float;

	/**
	* If `true`, opens an active window. If `false`, opens an inactive window.
	*/
	var ?focused : Bool;

	/**
	* Whether the new window should be an incognito window.
	*/
	var ?incognito : Bool;

	/**
	* Specifies what type of browser window to create.
	*/
	var ?type : CreateType;

	/**
	* The initial state of the window. The `minimized`, `maximized`, and `fullscreen`
	* states cannot be combined with `left`, `top`, `width`, or `height`.
	*
	* @since Chrome 44
	*/
	var ?state : WindowState;

	/**
	* If `true`, the newly-created window's 'window.opener' is set to the caller
	* and is in the same [unit of related browsing contexts](https://www.w3.org/TR/html51/browsers.html#unit-of-related-browsing-contexts) as the caller.
	*
	* @since Chrome 64
	*/
	var ?setSelfAsOpener : Bool;
}

private typedef UpdateInfo = {
	/**
	* The offset from the left edge of the screen to move the window to in pixels.
	* This value is ignored for panels.
	*/
	var ?left : Float;

	/**
	* The offset from the top edge of the screen to move the window to in pixels.
	* This value is ignored for panels.
	*/
	var ?top : Float;

	/**
	* The width to resize the window to in pixels. This value is ignored for panels.
	*/
	var ?width : Float;

	/**
	* The height to resize the window to in pixels. This value is ignored for panels.
	*/
	var ?height : Float;

	/**
	* If `true`, brings the window to the front; cannot be combined with the state
	* 'minimized'. If `false`, brings the next window in the z-order to the front;
	* cannot be combined with the state 'fullscreen' or 'maximized'.
	*/
	var ?focused : Bool;

	/**
	* If `true`, causes the window to be displayed in a manner that draws the
	* user's attention to the window, without changing the focused window.
	* The effect lasts until the user changes focus to the window.
	* This option has no effect if the window already has focus.
	* Set to `false` to cancel a previous `drawAttention` request.
	*/
	var ?drawAttention : Bool;

	/**
	* The new state of the window. The 'minimized', 'maximized', and 'fullscreen'
	* states cannot be combined with 'left', 'top', 'width', or 'height'.
	*/
	var ?state : WindowState;
}

/**
* The type of browser window this is. In some circumstances a window may not be
* assigned a `type` property; for example, when querying closed windows from the {@link sessions} API.
*
* @chrome-enum "normal" A normal browser window.
* @chrome-enum "popup" A browser popup.
* @chrome-enum "panel" _Deprecated in this API._ A Chrome App panel-style window. Extensions can only see their own panel windows.
* @chrome-enum "app" _Deprecated in this API._ A Chrome App window. Extensions can only see their app own windows.
* @chrome-enum "devtools" A Developer Tools window.
* @since Chrome 44
*/
extern enum abstract WindowType(String) to String {
	var NORMAL = "normal";
	var POPUP = "popup";
	var PANEL = "panel";
	var APP = "app";
	var DEVTOOLS = "devtools";
}

/**
* The state of this browser window. In some circumstances a window may not be assigned a `state` property; for example, when querying closed windows from the {@link sessions} API.
*
* @chrome-enum "normal" Normal window state (not minimized, maximized, or fullscreen).
* @chrome-enum "minimized" Minimized window state.
* @chrome-enum "maximized" Maximized window state.
* @chrome-enum "fullscreen" Fullscreen window state.
* @chrome-enum "locked-fullscreen" Locked fullscreen window state. This fullscreen state cannot be exited by user action and is available only to allowlisted extensions on Chrome OS.
* @since Chrome 44
*/
extern enum abstract WindowState(String) to String {
	var NORMAL = "normal";
	var MINIMIZED = "minimized";
	var MAXIMIZED = "maximized";
	var FULLSCREEN = "fullscreen";
	var LOCKED_FULLSCREEN = "locked-fullscreen";
}


typedef Window = {
	/**
	* The ID of the window. Window IDs are unique within a browser session.
	* In some circumstances a window may not be assigned an `ID` property;
	* for example, when querying windows using the {@link sessions} API,
	* in which case a session ID may be present.
	*/
	var ?id : Int;

	/**
	* Whether the window is currently the focused window.
	*/
	var focused : Bool;

	/**
	* The offset of the window from the top edge of the screen in pixels.
	* In some circumstances a window may not be assigned a `top` property;
	* for example, when querying closed windows from the {@link sessions} API.
	*/
	var ?top : Float;

	/**
	* The offset of the window from the left edge of the screen in pixels.
	* In some circumstances a window may not be assigned a `left` property;
	* for example, when querying closed windows from the {@link sessions} API.
	*/
	var ?left : Float;

	/**
	* The width of the window, including the frame, in pixels.
	* In some circumstances a window may not be assigned a `width` property;
	* for example, when querying closed windows from the {@link sessions} API.
	*/
	var ?width : Float;

	/**
	* The height of the window, including the frame, in pixels.
	* In some circumstances a window may not be assigned a `height` property;
	* for example, when querying closed windows from the {@link sessions} API.
	*/
	var ?height : Int;

	/**
	* Array of {@link tabs.Tab} objects representing the current tabs in the window.
	*/
	var ?tabs : Array<Tabs.Tab>;

	/**
	* Whether the window is incognito.
	*/
	var incognito: Bool;

	/**
	* The type of browser window this is.
	*/
	var ?type : WindowType;

	/**
	* The state of this browser window.
	*/
	var ?state : WindowState;

	/**
	* Whether the window is set to be always on top.
	*/
	var alwaysOnTop: Bool;

	/**
	* The session ID used to uniquely identify a window, obtained from the {@link sessions} API.
	*/
	var ?sessionId : String;
}

/**
* Specifies what type of browser window to create. 'panel' is deprecated
* and is available only to existing allowlisted extensions on Chrome OS.
*
* @since Chrome 44
*/
extern enum abstract CreateType(String) to String {
	var NORMAL = "normal";
	var POPUP = "popup";
	var PANEL = "panel";
}

typedef QueryOptions = {
	/**
	* If true, the {@link windows.Window} object has a `tabs` property that
	* contains a list of the {@link tabs.Tab} objects. The `Tab` objects only
	* contain the `url`, `pendingUrl`, `title`, and `favIconUrl` properties
	* if the extension's manifest file includes the `"tabs"` permission.
	*/
	var ?populate : Bool;

	/**
	* If set, the {@link windows.Window} returned is filtered based on its type.
	* If unset, the default filter is set to `['normal', 'popup']`.
	*/
	var ?windowTypes : Array<WindowType>;
}
