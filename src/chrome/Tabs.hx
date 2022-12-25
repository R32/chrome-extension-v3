package chrome;

/**
* Use the `chrome.tabs` API to interact with the browser's tab system.
* You can use this API to create, modify, and rearrange tabs in the browser.
*/
@:native("chrome.tabs")
extern class Tabs {
	/**
	* Fired when a tab is created. Note that the tab's URL and tab group membership
	* may not be set at the time this event is fired, but you can listen to onUpdated events
	* so as to be notified when a URL is set or the tab is added to a tab group.
	*/
	static final onCreated : Event<Tab->Void>;

	/**
	* Fired when a tab is updated.
	*/
	static final onUpdated : Event<(tabId : Int, changeInfo : ChangeInfo)->Void>;

	/**
	* Fired when a tab is moved within a window. Only one move event is fired,
	* representing the tab the user directly moved. Move events are not fired
	* for the other tabs that must move in response to the manually-moved tab.
	* This event is not fired when a tab is moved between windows;
	* for details, see {@link tabs.onDetached}.
	*/
	static final onMoved : Event<(tabId : Int, moveInfo : {windowId : Int, fromIndex : Int, toIndex : Int})->Void>;

	/**
	* Fires when the active tab in a window changes. Note that the tab's URL may
	* not be set at the time this event fired, but you can listen to
	* onUpdated events so as to be notified when a URL is set.
	*/
	static final onActivated : Event<{tabId : Int, windowId : Int}->Void>;

	/**
	* Fired when the highlighted or selected tabs in a window changes.
	*/
	static final onHighlighted : Event<{windowId : Int, tabIds : Array<Int>}->Void>;

	/**
	* Fired when a tab is detached from a window; for example, because it was moved between windows.
	*/
	static final onDetached : Event<(tabId : Int, detachInfo : {oldWindowId : Int, oldPosition : Int})->Void>;

	/**
	* Fired when a tab is attached to a window; for example, because it was moved between windows.
	*/
	static final onAttached : Event<(tabId : Int, attachInfo : {newWindowId : Int, newPosition : Int})->Void>;

	/**
	* Fired when a tab is closed.
	*/
	static final onRemoved : Event<(tabId : Int, removeInfo : {windowId : Int, isWindowClosing : Bool})->Void>;

	/**
	* Fired when a tab is replaced with another tab due to prerendering or instant.
	*/
	static final onReplaced : Event<(addedTabId : Int, removedTabId : Int)->Void>;

	/**
	* Fired when a tab is zoomed.
	*/
	static final onZoomChange : Event<{tabId : Int, oldZoomFactor : Float, newZoomFactor : Float, zoomSettings : ZoomSettings}->Void>;

	/**
	* Retrieves details about the specified tab.
	*/
	overload static function get( tabId : Int, callback : Tab->Void ) : Void;
	overload static function get( tabId : Int ) : Promise<Tab>;

	/**
	* Gets the tab that this script call is being made from.
	* May be undefined if called from a non-tab context
	* (for example, a background page or popup view).
	*/
	overload static function getCurrent( callback : Tab->Void ) : Void;
	overload static function getCurrent() : Promise<Tab>;

	/**
	* Connects to the content script(s) in the specified tab.
	* The {@link runtime.onConnect} event is fired in each content script
	* running in the specified tab for the current extension.
	* For more details, see [Content Script Messaging](https://developer.chrome.com/docs/extensions/messaging).
	*
	* @returns A port that can be used to communicate with the content scripts
	* running in the specified tab. The port's {@link runtime.Port} event
	* is fired if the tab closes or does not exist.
	*/
	static function connect( tabId : Int, ?connectInfo : {?name : String, ?frameId : Int, ?documentId : String} ) : Runtime.Port;

	/**
	* Sends a single message to the content script(s) in the specified tab,
	* with an optional callback to run when a response is sent back.
	* The {@link runtime.onMessage} event is fired in each content script
	* running in the specified tab for the current extension.
	*
	* @param message The message to send. This message should be a JSON-ifiable object.
	*/
	overload static function sendMessage( tabId : Int, message : Dynamic, callback : Dynamic->Void ) : Void;
	overload static function sendMessage( tabId : Int, message : Dynamic,  options : {?frameId : Int, ?documentId : String}, callback : Dynamic->Void ) : Void;
	overload static function sendMessage( tabId : Int, message : Dynamic, ?options : {?frameId : Int, ?documentId : String} ) : Promise<Dynamic>;

	/**
	* Creates a new tab.
	*/
	overload static function create( props : CreateProperties, callback : Tab->Void ) : Void;
	overload static function create( props : CreateProperties ) : Promise<Tab>;

	/**
	* Duplicates a tab.
	*
	* @param tabId The ID of the tab to duplicate.
	*/
	overload static function duplicate( tabId : Int, callback : ?Tab->Void ) : Void;
	overload static function duplicate( tabId : Int ) : Promise<Tab>;

	/**
	* Gets all tabs that have the specified properties,
	* or all tabs if no properties are specified.
	*/
	overload static function query( querys : QueryInfo, callback : (Array<Tab>)->Void ) : Void;
	overload static function query( querys : QueryInfo ) : Promise<Array<Tab>>;

	/**
	* Highlights the given tabs and focuses on the first of group.
	* Will appear to do nothing if the specified tab is currently active.
	*/
	overload static function highlight( dest : {?windowId : Int, tabs : EitherType<Int, Array<Int>>}, callback : Windows.Window->Void ) : Void;
	overload static function highlight( dest : {?windowId : Int, tabs : EitherType<Int, Array<Int>>} ) : Promise<Windows.Window>;

	/**
	* Modifies the properties of a tab. Properties that are not specified in `updateProperties` are not modified.
	*/
	overload static function update( props : UpdateProperties, callback : Tab->Void ) : Void;
	overload static function update( props : UpdateProperties ) : Promise<Tab>;
	overload static function update( tabId : Int, props : UpdateProperties ) : Promise<Tab>;
	overload static function update( tabId : Int, props : UpdateProperties, callback : Tab->Void ) : Void;

	/**
	* Moves one or more tabs to a new position within its window, or to a new window. Note that tabs can only be moved to and from normal (window.type === "normal") windows.
	*
	* @param tabIds The tab ID or list of tab IDs to move.
	*
	* @param props.windowId: Defaults to the window the tab is currently in.
	* @param props.index: The position to move the window to. Use `-1` to place the tab at the end of the window.
	*/
	overload static function move( tabId : Int, props : {?windowId : Int, index : Int}, callback : Tab->Void ) : Void;
	overload static function move( tabId : Int, props : {?windowId : Int, index : Int} ) : Promise<Tab>;
	overload static function move( tabIds : Array<Int>, props : {?windowId : Int, index : Int} ) : Promise<Array<Tab>>;
	overload static function move( tabIds : Array<Int>, props : {?windowId : Int, index : Int}, callback : (Array<Tab>)->Void ) : Void;

	/**
	* Reload a tab.
	*
	* @param tabId The ID of the tab to reload; defaults to the selected tab of the current window.
	* @param props.bypassCache Whether to bypass local caching. Defaults to `false`.
	*/
	overload static function reload( tabId : Int, callback : ()->Void ) : Void;
	overload static function reload( tabId : Int,  props : {?bypassCache : Bool}, callback : ()->Void ) : Void;
	overload static function reload( tabId : Int, ?props : {?bypassCache : Bool} ) : Promise<Void>;

	/**
	* Closes one or more tabs.
	*
	* @param tabIds The tab ID or list of tab IDs to close.
	*/
	overload static function remove( tabIds : EitherType<Int,Array<Int>>, callback : ()->Void ) : Void;
	overload static function remove( tabIds : EitherType<Int,Array<Int>> ) : Promise<Void>;

	/**
	* Adds one or more tabs to a specified group, or if no group is specified,
	* adds the given tabs to a newly created group.
	*
	* @param options.tabIds : The tab ID or list of tab IDs to add to the specified group.
	* @param options.groupId : The ID of the group to add the tabs to. If not specified, a new group will be created.
	* @param options.createProperties.windowId : The window of the new group. Defaults to the current window.
	*
	* @since Chrome 88
	*/
	overload static function group( options : {tabIds : EitherType<Int,Array<Int>>, ?groupId : Int, ?createProperties : {?windowId : Int}}, callback : (groupId:Int)->Void ) : Void;
	overload static function group( options : {tabIds : EitherType<Int,Array<Int>>, ?groupId : Int, ?createProperties : {?windowId : Int}} ) : Promise<Int>;

	/**
	* Removes one or more tabs from their respective groups. If any groups become empty, they are deleted.
	*
	* @param tabIds The tab ID or list of tab IDs to remove from their respective groups.
	* @since Chrome 88
	*/
	overload static function ungroup( tabIds : EitherType<Int,Array<Int>>, callback : ()->Void ) : Void;
	overload static function ungroup( tabIds : EitherType<Int,Array<Int>> ) : Promise<Void>;

	/**
	* Detects the primary language of the content in a tab.
	*
	* @param tabId Defaults to the active tab of the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*/
	overload static function detectLanguage( callback : (language : String)->Void ) : Void;
	overload static function detectLanguage( tabIds : Int, callback : (language : String)->Void ) : Void;
	overload static function detectLanguage( ?tabIds : Int ) : Promise<String>;

	/**
	* Captures the visible area of the currently active tab in the specified window.
	* In order to call this method, the extension must have either the
	* [<all\_urls>](https://developer.chrome.com/docs/extensions/declare_permissions) permission
	* or the [activeTab](https://developer.chrome.com/docs/extensions/activeTab) permission.
	* In addition to sites that extensions can normally access, this method
	* allows extensions to capture sensitive sites that are otherwise restricted,
	* including chrome:-scheme pages, other extensions' pages, and data: URLs.
	* These sensitive sites can only be captured with the activeTab permission.
	* File URLs may be captured only if the extension has been granted file access.
	*
	* @param windowId The target window. Defaults to the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	* @param dataUrl A data URL that encodes an image of the visible area of the captured tab. May be assigned to the 'src' property of an HTML `img` element for display.
	*/
	overload static function captureVisibleTab( callback : (dataUrl : String)->Void ) : Void;
	overload static function captureVisibleTab( windowId : Int, callback : (dataUrl : String)->Void ) : Void;
	overload static function captureVisibleTab( windowId : Int, options : ExtensionTypes.ImageDetails, callback : String->Void ) : Void;
	overload static function captureVisibleTab( ?windowId : Int, ?options : ExtensionTypes.ImageDetails ) : Promise<String>;

	/**
	* Zooms a specified tab.
	*
	* @param tabId The ID of the tab to zoom; defaults to the active tab of the current window.
	* @param zoomFactor The new zoom factor. A value of `0` sets the tab to its current default zoom factor. Values greater than `0` specify a (possibly non-default) zoom factor for the tab.
	*/
	overload static function setZoom( zoomFactor : Float, callback : ()->Void ) : Void;
	overload static function setZoom( zoomFactor : Float ) : Promise<Void>;
	overload static function setZoom( tabId : Int, zoomFactor : Float ) : Promise<Void>;
	overload static function setZoom( tabId : Int, zoomFactor : Float, callback : ()->Void ) : Void;

	/**
	* Gets the current zoom factor of a specified tab.
	*
	* @param tabId The ID of the tab to get the current zoom factor from;
	* defaults to the active tab of the current window.
	* @param callback Called with the tab's current zoom factor after it has been fetched.
	*/
	overload static function getZoom( callback : (zoomFactor : Float)->Void ) : Void;
	overload static function getZoom( tabId : Int, callback : (zoomFactor : Float)->Void ) : Void;
	overload static function getZoom( ?tabId : Int ) : Promise<Float>;

	/**
	* Sets the zoom settings for a specified tab, which define how zoom changes
	* are handled. These settings are reset to defaults upon navigating the tab.
	*
	* @param tabId The ID of the tab to change the zoom settings for;
	* defaults to the active tab of the current window.
	* @param zoomSettings Defines how zoom changes are handled and at what scope.
	* @param callback Called after the zoom settings are changed.
	*/
	overload static function setZoomSettings( zoomSettings: ZoomSettings, callback : ()->Void ) : Void;
	overload static function setZoomSettings( zoomSettings: ZoomSettings ) : Promise<Void>;
	overload static function setZoomSettings( tabId : Int, zoomSettings: ZoomSettings ) : Promise<Void>;
	overload static function setZoomSettings( tabId : Int, zoomSettings: ZoomSettings, callback : ()->Void ) : Void;

	/**
	* Gets the current zoom settings of a specified tab.
	*
	* @param tabId The ID of the tab to get the current zoom settings from;
	* defaults to the active tab of the current window.
	* @param callback Called with the tab's current zoom settings.
	*/
	overload static function getZoomSettings( callback : ZoomSettings->Void ) : Void;
	overload static function getZoomSettings( tabId : Int, callback : ZoomSettings->Void ) : Void;
	overload static function getZoomSettings( ?tabId : Int ) : Promise<ZoomSettings>;

	/**
	* Discards a tab from memory. Discarded tabs are still visible on the tab strip and are reloaded when activated.
	*
	* @param tabId The ID of the tab to be discarded. If specified,
	* the tab is discarded unless it is active or already discarded. If omitted,
	* the browser discards the least important tab. This can fail if no discardable tabs exist.
	* @param callback Called after the operation is completed.
	* @since Chrome 54
	*/
	overload static function discard( callback : Tab->Void ) : Void;
	overload static function discard( tabId : Int, callback : Tab->Void ) : Void;
	overload static function discard( ?tabId : Int ) : Promise<Tab>;

	/**
	* Go foward to the next page, if one is available.
	*
	* @param tabId The ID of the tab to navigate forward; defaults to the selected tab of the current window.
	* @since Chrome 72
	*/
	overload static function goForward( callback : ()->Void ) : Void;
	overload static function goForward( tabId : Int, callback : ()->Void ) : Void;
	overload static function goForward( ?tabId : Int ) : Promise<Void>;

	/**
	* Go back to the previous page, if one is available.
	*
	* @param tabId The ID of the tab to navigate back; defaults to the selected tab of the current window.
	* @since Chrome 72
	*/
	overload static function goBack( callback : ()->Void ) : Void;
	overload static function goBack( tabId : Int, callback : ()->Void ) : Void;
	overload static function goBack( ?tabId : Int ) : Promise<Void>;

	/**
	* The maximum number of times that {@link captureVisibleTab} can be called per second.
	* {@link captureVisibleTab} is expensive and should not be called too often.
	*
	* @since Chrome 92
	*/
	static inline var MAX_CAPTURE_VISIBLE_TAB_CALLS_PER_SECOND = 2;
	/**
	* An ID that represents the absence of a browser tab.
	*
	* @since Chrome 46
	*/
	static inline var TAB_ID_NONE = -1;
}

private typedef ChangeInfo = {
	/**
	* The tab's loading status.
	*/
	var ?status : TabStatus;

	/**
	* The tab's URL if it has changed.
	*/
	var ?url : String;

	/**
	* The tab's new group.
	*
	* @since Chrome 88
	*/
	var ?groupId : Int;

	/**
	* The tab's new pinned state.
	*/
	var ?pinned : Bool;

	/**
	* The tab's new audible state.
	*
	* @since Chrome 45
	*/
	var ?audible : Bool;

	/**
	* The tab's new discarded state.
	*
	* @since Chrome 54
	*/
	var ?discarded : Bool;

	/**
	* The tab's new auto-discardable state.
	*
	* @since Chrome 54
	*/
	var ?autoDiscardable : Bool;

	/**
	* The tab's new muted state and the reason for the change.
	*
	* @since Chrome 46
	*/
	var ?mutedInfo : MutedInfo;

	/**
	* The tab's new favicon URL.
	*/
	var ?favIconUrl : String;

	/**
	* The tab's new title.
	*
	* @since Chrome 48
	*/
	var ?title : String;
}


private typedef CreateProperties = {
	/**
	* The window in which to create the new tab. Defaults to the
	* [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*/
	var ?windowId : Int;

	/**
	* The position the tab should take in the window. The provided value is
	* clamped to between zero and the number of tabs in the window.
	*/
	var ?index : Int;

	/**
	* The URL to initially navigate the tab to. Fully-qualified URLs must
	* include a scheme (i.e., 'http://www.google.com', not 'www.google.com').
	* Relative URLs are relative to the current page within the extension.
	* Defaults to the New Tab Page.
	*/
	var ?url : String;

	/**
	* Whether the tab should become the active tab in the window.
	* Does not affect whether the window is focused (see {@link windows.update}).
	* Defaults to `true`.
	*/
	var ?active : Bool;

	/**
	* Whether the tab should become the selected tab in the window. Defaults to `true`
	*
	* @deprecated Please use _active_.
	*/
	var ?selected : Bool;

	/**
	* Whether the tab should be pinned. Defaults to `false`
	*/
	var ?pinned : Bool;

	/**
	* The ID of the tab that opened this tab. If specified,
	* the opener tab must be in the same window as the newly created tab.
	*/
	var ?openerTabId : Int;
}


private typedef QueryInfo = {
	/**
	* Whether the tabs are active in their windows.
	*/
	var ?active : Bool;

	/**
	* Whether the tabs are pinned.
	*/
	var ?pinned : Bool;

	/**
	* Whether the tabs are audible.
	*
	* @since Chrome 45
	*/
	var ?audible : Bool;

	/**
	* Whether the tabs are muted.
	*
	* @since Chrome 45
	*/
	var ?muted : Bool;

	/**
	* Whether the tabs are highlighted.
	*/
	var ?highlighted : Bool;

	/**
	* Whether the tabs are discarded. A discarded tab is one whose content has
	* been unloaded from memory, but is still visible in the tab strip.
	* Its content is reloaded the next time it is activated.
	*
	* @since Chrome 54
	*/
	var ?discarded : Bool;

	/**
	* Whether the tabs can be discarded automatically by the browser when resources are low.
	*
	* @since Chrome 54
	*/
	var ?autoDiscardable : Bool;

	/**
	* Whether the tabs are in the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*/
	var ?currentWindow : Bool;

	/**
	* Whether the tabs are in the last focused window.
	*/
	var ?lastFocusedWindow : Bool;

	/**
	* The tab loading status.
	*/
	var ?status : TabStatus;

	/**
	* Match page titles against a pattern.
	* This property is ignored if the extension does not have the `"tabs"` permission.
	*/
	var ?title : String;

	/**
	* Match tabs against one or more [URL patterns](https://developer.chrome.com/docs/extensions/match_patterns). Fragment identifiers are not matched. This property is ignored if the extension does not have the `"tabs"` permission.
	*/
	var ?url : EitherType<String, Array<String>>;

	/**
	* The ID of the group that the tabs are in, or {@link tabGroups.TAB_GROUP_ID_NONE} for ungrouped tabs.
	*
	* @since Chrome 88
	*/
	var ?groupId : Int;

	/**
	* The ID of the parent window, or {@link windows.WINDOW_ID_CURRENT}
	* for the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
	*/
	var ?windowId : Int;

	/**
	* The type of window the tabs are in.
	*/
	var ?windowType : Windows.WindowType;

	/**
	* The position of the tabs within their windows.
	*/
	var ?index : Int;
}


private typedef UpdateProperties = {
	/**
	* A URL to navigate the tab to. JavaScript URLs are not supported;
	* use {@link scripting.executeScript} instead.
	*/
	var ?url : String;

	/**
	* Whether the tab should be active. Does not affect whether the window is focused (see {@link windows.update}).
	*/
	var ?active : Bool;

	/**
	* Adds or removes the tab from the current selection.
	*/
	var ?highlighted : Bool;

	/**
	* Whether the tab should be selected.
	*
	* @deprecated Please use _highlighted_.
	*/
	var ?selected : Bool;

	/**
	* Whether the tab should be pinned.
	*/
	var ?pinned : Bool;

	/**
	* Whether the tab should be muted.
	*
	* @since Chrome 45
	*/
	var ?muted : Bool;

	/**
	* The ID of the tab that opened this tab. If specified, the opener tab must
	* be in the same window as this tab.
	*/
	var ?openerTabId : Int;

	/**
	* Whether the tab should be discarded automatically by the browser when resources are low.
	*
	* @since Chrome 54
	*/
	var ?autoDiscardable : Bool;
}


/**
* The tab's loading status.
*
* @since Chrome 44
*/
extern enum abstract TabStatus(String) to String {
	var LOADING = "loading";
	var COMPLETE = "complete";
	var UNLOADED = "unloaded";
}

/**
* An event that caused a muted state change.
*
* @chrome-enum "user" A user input action set the muted state.
* @chrome-enum "capture" Tab capture was started, forcing a muted state change.
* @chrome-enum "extension" An extension, identified by the extensionId field, set the muted state.
* @since Chrome 46
*/
extern enum abstract MutedInfoReason(String) to String {
	var USER = "user";
	var CAPTURE = "capture";
	var EXTENSION = "extension";
}

/**
* The tab's muted state and the reason for the last state change.
*
* @since Chrome 46
*/
typedef MutedInfo = {
	/**
	* Whether the tab is muted (prevented from playing sound).
	* The tab may be muted even if it has not played or is not currently playing sound.
	* Equivalent to whether the 'muted' audio indicator is showing.
	*/
	var muted : Bool;

	/**
	* The reason the tab was muted or unmuted. Not set if the tab's mute state has never been changed.
	*/
	var ?reason : MutedInfoReason;

	/**
	* The ID of the extension that changed the muted state.
	* Not set if an extension was not the reason the muted state last changed.
	*/
	var ?extensionId : String;
}

typedef Tab = {
	/**
	* The ID of the tab. Tab IDs are unique within a browser session.
	* Under some circumstances a tab may not be assigned an ID;
	* for example, when querying foreign tabs using the {@link sessions} API,
	* in which case a session ID may be present. Tab ID can also be set to
	* `chrome.tabs.TAB_ID_NONE` for apps and devtools windows.
	*/
	var ?id : Int;

	/**
	* The zero-based index of the tab within its window.
	*/
	var index : Int;

	/**
	* The ID of the group that the tab belongs to.
	*
	* @since Chrome 88
	*/
	var groupId : Int;

	/**
	* The ID of the window that contains the tab.
	*/
	var windowId : Int;

	/**
	* The ID of the tab that opened this tab, if any. This property is
	* only present if the opener tab still exists.
	*/
	var ?openerTabId : Int;

	/**
	* Whether the tab is selected.
	*
	* @deprecated Please use {@link tabs.Tab.highlighted}.
	*/
	var selected : Bool;

	/**
	* Whether the tab is highlighted.
	*/
	var highlighted : Bool;

	/**
	* Whether the tab is active in its window. Does not necessarily mean the window is focused.
	*/
	var active : Bool;

	/**
	* Whether the tab is pinned.
	*/
	var pinned : Bool;

	/**
	* Whether the tab has produced sound over the past couple of seconds(but it might not be heard if also muted).
	* Equivalent to whether the 'speaker audio' indicator is showing.
	*
	* @since Chrome 45
	*/
	var ?audible : Bool;

	/**
	* Whether the tab is discarded. A discarded tab is one whose content has been
	* unloaded from memory, but is still visible in the tab strip.
	* Its content is reloaded the next time it is activated.
	*
	* @since Chrome 54
	*/
	var discarded : Bool;

	/**
	* Whether the tab can be discarded automatically by the browser when resources are low.
	*
	* @since Chrome 54
	*/
	var autoDiscardable : Bool;

	/**
	* The tab's muted state and the reason for the last state change.
	*
	* @since Chrome 46
	*/
	var ?mutedInfo : MutedInfo;

	/**
	* The last committed URL of the main frame of the tab. This property is
	* only present if the extension's manifest includes the `"tabs"` permission
	* and may be an empty string if the tab has not yet committed. See also {@link Tab.pendingUrl}.
	*/
	var ?url : String;

	/**
	* The URL the tab is navigating to, before it has committed.
	* This property is only present if the extension's manifest
	* includes the `"tabs"` permission and there is a pending navigation.
	*
	* @since Chrome 79
	*/
	var ?pendingUrl : String;

	/**
	* The title of the tab. This property is only present if the
	* extension's manifest includes the `"tabs"` permission.
	*/
	var ?title : String;

	/**
	* The URL of the tab's favicon. This property is only present if the
	* extension's manifest includes the `"tabs"` permission. It may also
	* be an empty string if the tab is loading.
	*/
	var ?favIconUrl : String;

	/**
	* The tab's loading status.
	*/
	var ?status : TabStatus;

	/**
	* Whether the tab is in an incognito window.
	*/
	var incognito : Bool;

	/**
	* The width of the tab in pixels.
	*/
	var ?width : Float;

	/**
	* The height of the tab in pixels.
	*/
	var ?height : Float;

	/**
	* The session ID used to uniquely identify a tab obtained from the {@link sessions} API.
	*/
	var ?sessionId : String;
}

/**
* Defines how zoom changes are handled, i.e., which entity is responsible for
* the actual scaling of the page; defaults to `automatic`.
*
* @chrome-enum "automatic" Zoom changes are handled automatically by the browser.
* @chrome-enum "manual" Overrides the automatic handling of zoom changes. The `onZoomChange` event will still be dispatched, and it is the extension's responsibility to listen for this event and manually scale the page. This mode does not support `per-origin` zooming, and thus ignores the `scope` zoom setting and assumes `per-tab`.
* @chrome-enum "disabled" Disables all zooming in the tab. The tab reverts to the default zoom level, and all attempted zoom changes are ignored.
* @since Chrome 44
*/
extern enum abstract ZoomSettingsMode(String) to String {
	var AUTOMATIC = "automatic";
	var MANUAL = "manual";
	var DISABLED = "disabled";
}

/**
* Defines whether zoom changes persist for the page's origin, or only
* take effect in this tab; defaults to `per-origin` when in `automatic` mode,
* and `per-tab` otherwise.
*
* @chrome-enum "per-origin" Zoom changes persist in the zoomed page's origin, i.e., all other tabs navigated to that same origin are zoomed as well. Moreover, `per-origin` zoom changes are saved with the origin, meaning that when navigating to other pages in the same origin, they are all zoomed to the same zoom factor. The `per-origin` scope is only available in the `automatic` mode.
* @chrome-enum "per-tab" Zoom changes only take effect in this tab, and zoom changes in other tabs do not affect the zooming of this tab. Also, `per-tab` zoom changes are reset on navigation; navigating a tab always loads pages with their `per-origin` zoom factors.
* @since Chrome 44
*/
extern enum abstract ZoomSettingsScope(String) to String {
	var PER_ORIGIN = "per-origin";
	var PER_TAB = "per-tab";
}

typedef ZoomSettings = {
	/**
	* Defines how zoom changes are handled, i.e., which entity is responsible
	* for the actual scaling of the page; defaults to `automatic`.
	*/
	var ?mode : ZoomSettingsMode;

	/**
	* Defines whether zoom changes persist for the page's origin,
	* or only take effect in this tab; defaults to `per-origin` when
	* in `automatic` mode, and `per-tab` otherwise.
	*/
	var ?scope : ZoomSettingsScope;

	/**
	* Used to return the default zoom level for the current tab in calls to tabs.getZoomSettings.
	*
	* @since Chrome 43
	*/
	var ?defaultZoomFactor : Float;
}
