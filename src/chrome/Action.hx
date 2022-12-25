package chrome;

/**
* Use the `chrome.action` API to control the extension's icon in the Google Chrome toolbar.
*
* @since Chrome 88
* @chrome-manifest action
* @chrome-min-manifest MV3
*/
@:native("chrome.action")
extern class Action {
	/**
	* Fired when an action icon is clicked.
	* This event will not fire if the action has a popup.
	*/
	static final onClicked : Event<Tabs.Tab->Void>;

	/**
	* Sets the title of the action. This shows up in the tooltip.
	*
	*/
	overload static function setTitle( details : {title : String, ?tabId : Int}, callback : ()->Void ) : Void;
	overload static function setTitle( details : {title : String, ?tabId : Int} ) : Promise<Void>;

	/**
	* Gets the title of the action.
	*/
	overload static function getTitle( details : TabDetails, callback : String->Void ) : Void;
	overload static function getTitle( details : TabDetails ) : Promise<String>;

	/**
	* Sets the icon for the action. The icon can be specified either as
	* the path to an image file or as the pixel data from a canvas element,
	* or as dictionary of either one of those. Either the **path** or
	* the **imageData** property must be specified.
	*/
	overload static function setIcon( details : SetIconDetails, callback : ()->Void ) : Void;
	overload static function setIcon( details : SetIconDetails ) : Promise<Void>;

	/**
	* Sets the HTML document to be opened as a popup when the user clicks on the action's icon.
	*/
	overload static function setPopup( details : {popup : String, ?tabId : Int}, callback : ()->Void ) : Void;
	overload static function setPopup( details : {popup : String, ?tabId : Int} ) : Promise<Void>;

	/**
	* Gets the html document set as the popup for this action.
	*
	*/
	overload static function getPopup( details : TabDetails, callback : String->Void ) : Void;
	overload static function getPopup( details : TabDetails ) : Promise<String>;

	/**
	* Sets the badge text for the action. The badge is displayed on top of the icon.
	*/
	overload static function setBadgeText( details : {text : String, ?tabId : Int}, callback : ()->Void ) : Void;
	overload static function setBadgeText( details : {text : String, ?tabId : Int} ) : Promise<Void>;

	/**
	* Gets the badge text of the action. If no tab is specified,
	* the non-tab-specific badge text is returned.
	* If [displayActionCountAsBadgeText](https://developer.chrome.com/docs/extensions/reference/declarativeNetRequest/#setExtensionActionOptions)
	* is enabled, a placeholder text will be returned unless the
	* [declarativeNetRequestFeedback](https://developer.chrome.com/docs/extensions/declare_permissions#declarativeNetRequestFeedback)
	* permission is present or tab-specific badge text was provided.
	*/
	overload static function getBadgeText( details : TabDetails, callback : String->Void ) : Void;
	overload static function getBadgeText( details : TabDetails ) : Promise<String>;

	/**
	* Sets the background color for the badge.
	*
	* @param details.color : An array of four integers in the range \[0,255\]
	* that make up the RGBA color of the badge. For example, opaque red is `[255, 0, 0, 255]`.
	* Can also be a string with a CSS value, with opaque red being `#FF0000` or `#F00`.
	*/
	overload static function setBadgeBackgroundColor( details : {color : EitherColor, ?tabId : Int}, callback : ()->Void ) : Void;
	overload static function setBadgeBackgroundColor( details : {color : EitherColor, ?tabId : Int} ) : Promise<Void>;

	/**
	* Gets the background color of the action.
	*/
	overload static function getBadgeBackgroundColor( details : TabDetails, callback : (BrowserAction.ColorArray)->Void ) : Void;
	overload static function getBadgeBackgroundColor( details : TabDetails ) : Promise<BrowserAction.ColorArray>;

	/**
	* Sets the text color for the badge.
	*
	* @since Pending
	*/
	overload static function setBadgeTextColor( details : {color : EitherColor, ?tabId : Int}, callback : ()->Void ) : Void;
	overload static function setBadgeTextColor( details : {color : EitherColor, ?tabId : Int} ) : Promise<Void>;

	/**
	* Gets the text color of the action.
	*
	* @since Pending
	*/
	overload static function getBadgeTextColor( details : TabDetails, callback : (BrowserAction.ColorArray)->Void ) : Void;
	overload static function getBadgeTextColor( details : TabDetails ) : Promise<BrowserAction.ColorArray>;

	/**
	* Enables the action for a tab. By default, actions are enabled.
	*
	* @param tabId The id of the tab for which you want to modify the action.
	*/
	overload static function enable( callback : ()->Void ) : Void;
	overload static function enable( tabId : Int, callback : ()->Void ) : Void;
	overload static function enable( ?tabId : Int ) : Promise<Void>;

	/**
	* Disables the action for a tab.
	*
	* @param tabId The id of the tab for which you want to modify the action.
	*/
	overload static function disable( callback : ()->Void ) : Void;
	overload static function disable( tabId : Int, callback : ()->Void ) : Void;
	overload static function disable( ?tabId : Int ) : Promise<Void>;

	/**
	* Retrieves the state of whether the extension action is enabled for a tab (or globally if no tab is provided).
	*
	* @param tabId The id of the tab for which you want check enabled status.
	* @since Chrome 108
	*/
	overload static function isEnabled( callback : Bool->Void ) : Void;
	overload static function isEnabled( tabId : Int, callback : Bool->Void ) : Void;
	overload static function isEnabled( ?tabId : Int ) : Promise<Bool>;

	/**
	* Returns the user-specified settings relating to an extension's action.
	*
	* @since Chrome 91
	*/
	overload static function getUserSettings( callback : UserSettings->Void ) : Void;
	overload static function getUserSettings() : Promise<UserSettings>;

	/**
	* Opens the extension's popup.
	*
	* @param options Specifies options for opening the popup.
	* @since Chrome 99
	*/
	overload static function openPopup( callback : ()->Void ) : Void;
	overload static function openPopup( options : OpenPopupOptions, callback : ()->Void ) : Void;
	overload static function openPopup( ?options : OpenPopupOptions ) : Promise<Void>;
}

typedef TabDetails = {
	/**
	* The ID of the tab to query state for. If no tab is specified,
	* the non-tab-specific state is returned.
	*/
	var ?tabId : Int;
}

/**
* The collection of user-specified settings relating to an extension's action.
*
* @since Chrome 91
*/
typedef UserSettings = {
	/**
	* Whether the extension's action icon is visible on
	* browser windows' top-level toolbar
	* (i.e., whether the extension has been 'pinned' by the user).
	*/
	var isOnToolbar : Bool;
}

/**
* @since Chrome 99
*/
typedef OpenPopupOptions = {
	/**
	* The id of the window to open the action popup in.
	* Defaults to the currently-active window if unspecified.
	*/
	var ?windowId : Int;
}

private typedef SetIconDetails = {
	/**
	* Either an ImageData object or a dictionary {size -> ImageData}
	* representing icon to be set. If the icon is specified as a dictionary,
	* the actual image to be used is chosen depending on screen's pixel density.
	* If the number of image pixels that fit into one screen space unit equals `scale`,
	* then image with size `scale` \* n will be selected, where n is the size
	* of the icon in the UI. At least one image must be specified.
	* Note that 'details.imageData = foo' is equivalent to 'details.imageData = {'16': foo}'
	*/
	var ?imageData : EitherType<BrowserAction.ImageDataType, Dynamic<Any>>;

	/**
	* Either a relative image path or a dictionary {size -> relative image path}
	* pointing to icon to be set. If the icon is specified as a dictionary,
	* the actual image to be used is chosen depending on screen's pixel density.
	* If the number of image pixels that fit into one screen space unit equals `scale`,
	* then image with size `scale` \* n will be selected,
	* where n is the size of the icon in the UI. At least one image must be specified.
	* Note that 'details.path = foo' is equivalent to 'details.path = {'16': foo}'
	*/
	var ?path : EitherType<String, Dynamic<String>>;

	/**
	* Limits the change to when a particular tab is selected.
	* Automatically resets when the tab is closed.
	*/
	var ?tabId : Int;
}

private typedef EitherColor = EitherType<String, BrowserAction.ColorArray>;