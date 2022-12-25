package chrome;

/**
* Use the `chrome.contextMenus` API to add items to Google Chrome's context menu.
* You can choose what types of objects your context menu additions apply to,
* such as images, hyperlinks, and pages.
*
* @chrome-permission contextMenus
*/
@:native("chrome.contextMenus")
extern class ContextMenus {
	/**
	* The maximum number of top level extension items that can be added to an extension action context menu. Any items beyond this limit will be ignored.
	*/
	static inline var ACTION_MENU_TOP_LEVEL_LIMIT = 6;

	/**
	* Fired when a context menu item is clicked.
	*/
	static final onClicked : Event<(info : OnClickData, ?tab : Tabs.Tab)->Void>;

	/**
	* Creates a new context menu item. If an error occurs during creation,
	* it may not be detected until the creation callback fires;
	* details will be in {@link runtime.lastError}.
	*
	* @param callback Called when the item has been created in the browser.
	* If an error occurs during creation, details will be available in {@link runtime.lastError}.
	* @returns The ID of the newly created item.
	*/
	static function create( props : CreateProperties ) : EitherType<Int, String>;

	/**
	* Updates a previously created context menu item.
	*
	* @param id The ID of the item to update.
	* @param updateProperties The properties to update.
	* Accepts the same values as the {@link contextMenus.create} function.
	* @param callback Called when the context menu has been updated.
	*/
	static function update( id : EitherType<Int, String>, props : UpdateProperties, callback : ()->Void ) : Void;

	/**
	* Removes a context menu item.
	*
	* @param menuItemId The ID of the context menu item to remove.
	* @param callback Called when the context menu has been removed.
	*/
	static function remove( menuItemId : EitherType<Int, String>, callback : ()->Void ) : Void;

	/**
	* Removes all context menu items added by this extension.
	*
	* @param callback Called when removal is complete.
	*/
	static function removeAll( callback : ()->Void ) : Void;
}

private typedef CreateProperties = {
	/**
	* The type of menu item. Defaults to `normal`.
	*/
	var ?type : ItemType;

	/**
	* The unique ID to assign to this item. Mandatory for event pages.
	* Cannot be the same as another ID for this extension.
	*/
	var ?id : String;

	/**
	* The text to display in the item; this is _required_ unless `type` is `separator`.
	* When the context is `selection`, use `%s` within the string to show the selected text.
	* For example, if this parameter's value is "Translate '%s' to Pig Latin" and
	* the user selects the word "cool", the context menu item for
	* the selection is "Translate 'cool' to Pig Latin".
	*/
	var ?title : String;

	/**
	* The initial state of a checkbox or radio button: `true` for selected,
	* `false` for unselected. Only one radio button can be selected at a time in a given group.
	*/
	var ?checked : Bool;

	/**
	* List of contexts this menu item will appear in. Defaults to `['page']`.
	*/
	var ?contexts : Array<ContextType>; // [ContextType, ...ContextType[]]

	/**
	* Whether the item is visible in the menu.
	*
	* @since Chrome 62
	*/
	var ?visible : Bool;

	/**
	* A function that is called back when the menu item is clicked. Event pages
	* cannot use this; instead, they should register a listener for {@link contextMenus.onClicked}.
	*
	* @param info Information about the item clicked and the context where the click happened.
	* @param tab The details of the tab where the click took place. This parameter
	* is not present for platform apps.
	*/
	var ?onclick : ( info : OnClickData, tab: Tabs.Tab )->Void;

	/**
	* The ID of a parent menu item; this makes the item a child of a previously added item.
	*/
	var ?parentId : EitherType<Int, String>;

	/**
	* Restricts the item to apply only to documents or frames whose URL matches one of the given patterns. For details on pattern formats, see [Match Patterns](https://developer.chrome.com/docs/extensions/match_patterns).
	*/
	var ?documentUrlPatterns : Array<String>;

	/**
	* Similar to `documentUrlPatterns`, filters based on the `src` attribute of `img`, `audio`, and `video` tags and the `href` attribute of `a` tags.
	*/
	var ?targetUrlPatterns : Array<String>;

	/**
	* Whether this context menu item is enabled or disabled. Defaults to `true`.
	*/
	var ?enabled : Bool;
}


private typedef UpdateProperties = {

	var ?type : ItemType;

	var ?title : String;

	var ?checked : Bool;

	var ?contexts : Array<ContextType>;//[ContextType, ...ContextType[]],

	/**
	* Whether the item is visible in the menu.
	*
	* @since Chrome 62
	*/
	var ?visible : Bool;

	/**
	* @param tab The details of the tab where the click took place.
	* This parameter is not present for platform apps.
	*/
	var ?onclick : ( info : OnClickData, tab : Tabs.Tab )->Void;

	/**
	* The ID of the item to be made this item's parent.
	* Note: You cannot set an item to become a child of its own descendant.
	*/
	var ?parentId : EitherType<Int, String>;

	var ?documentUrlPatterns : Array<String>;

	var ?targetUrlPatterns : Array<String>;

	var ?enabled : Bool;
}
/**
* The different contexts a menu can appear in. Specifying 'all' is equivalent to the combination of all other contexts except for 'launcher'. The 'launcher' context is only supported by apps and is used to add menu items to the context menu that appears when clicking the app icon in the launcher/taskbar/dock/etc. Different platforms might put limitations on what is actually supported in a launcher context menu.
*
* @since Chrome 44
*/
extern enum abstract ContextType(String) to String {
	var ALL = "all";
	var PAGE = "page";
	var FRAME = "frame";
	var SELECTION = "selection";
	var LINK = "link";
	var EDITABLE = "editable";
	var IMAGE = "image";
	var VIDEO = "video";
	var AUDIO = "audio";
	var LAUNCHER = "launcher";
	var BROWSER_ACTION = "browser_action";
	var PAGE_ACTION = "page_action";
	var ACTION = "action";
}

/**
* The type of menu item.
*
* @since Chrome 44
*/
extern enum abstract ItemType(String) to String {
	var NORMAL = "normal";
	var CHECKBOX = "checkbox";
	var RADIO = "radio";
	var SEPARATOR = "separator";
}

/**
* Information sent when a context menu item is clicked.
*/
typedef OnClickData = {

	/**
	* The ID of the menu item that was clicked.
	*/
	var menuItemId : EitherType<Int, String>;

	/**
	* The parent ID, if any, for the item clicked.
	*/
	var ?parentMenuItemId : EitherType<Int, String>;

	/**
	* One of 'image', 'video', or 'audio' if the context menu was activated on
	* one of these types of elements.
	*/
	var ?mediaType : String;

	/**
	* If the element is a link, the URL it points to.
	*/
	var ?linkUrl : String;

	/**
	* Will be present for elements with a 'src' URL.
	*/
	var ?srcUrl : String;

	/**
	* The URL of the page where the menu item was clicked.
	* This property is not set if the click occured in a context where
	* there is no current page, such as in a launcher context menu.
	*/
	var ?pageUrl : String;

	/**
	* The URL of the frame of the element where the context menu was clicked,
	* if it was in a frame.
	*/
	var ?frameUrl : String;

	/**
	* The [ID of the frame](https://developer.chrome.com/docs/extensions/reference/webNavigation/#frame_ids) of the element where the context menu was clicked, if it was in a frame.
	*
	* @since Chrome 51
	*/
	var ?frameId : Int;

	/**
	* The text for the context selection, if any.
	*/
	var ?selectionText : String;

	/**
	* A flag indicating whether the element is editable (text input, textarea, etc.).
	*/
	var ?editable: Bool;

	/**
	* A flag indicating the state of a checkbox or radio item before it was clicked.
	*/
	var ?wasChecked : Bool;

	/**
	* A flag indicating the state of a checkbox or radio item after it is clicked.
	*/
	var ?checked : Bool;
}
