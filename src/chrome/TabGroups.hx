package chrome;

/**
* Use the `chrome.tabGroups` API to interact with the browser's tab grouping system.
* You can use this API to modify and rearrange tab groups in the browser.
* To group and ungroup tabs, or to query what tabs are in groups,
* use the `chrome.tabs` API.
*
* @since Chrome 89
* @chrome-permission tabGroups
* @chrome-min-manifest MV3
*/
@:native("chrome.tabGroups")
extern class TabGroups {
	/**
	* An ID that represents the absence of a group.
	*/
	static inline var TAB_GROUP_ID_NONE = -1;

	/**
	* Fired when a group is created.
	*/
	static final onCreated : Event<TabGroup->Void>;

	/**
	* Fired when a group is updated.
	*/
	static final onUpdated : Event<TabGroup->Void>;

	/**
	* Fired when a group is moved within a window.
	* Move events are still fired for the individual tabs within the group,
	* as well as for the group itself. This event is not fired when a group
	* is moved between windows; instead, it will be removed from one window
	* and created in another.
	*/
	static final onMoved : Event<TabGroup->Void>;

	/**
	* Fired when a group is closed, either directly by the user
	* or automatically because it contained zero tabs.
	*/
	static final onRemoved : Event<TabGroup->Void>;

	/**
	* Retrieves details about the specified group.
	*/
	overload static function get( groupId : Int, callback : TabGroup->Void ) : Void;
	overload static function get( groupId : Int ) : Promise<TabGroup>;

	/**
	* Gets all groups that have the specified properties,
	* or all groups if no properties are specified.
	*/
	overload static function query(
		queryInfo : {
			/**
			* Whether the groups are collapsed.
			*/
			?collapsed : Bool,
			/**
			* The color of the groups.
			*/
			?color : Color,
			/**
			* Match group titles against a pattern.
			*/
			?title : String,
			/**
			* The ID of the parent window, or {@link windows.WINDOW_ID_CURRENT}
			* for the [current window](https://developer.chrome.com/docs/extensions/reference/windows/#current-window).
			*/
			?windowId : Int,
		},
		callback : (Array<TabGroup>)->Void
	) : Void;

	overload static function query(
		queryInfo : {
			?collapsed : Bool,
			?color : Color,
			?title : String,
			?windowId : Int,
		}
	) : Promise<Array<TabGroup>>;

	/**
	* Modifies the properties of a group. Properties that are not specified
	* in `updateProperties` are not modified.
	*
	* @param groupId The ID of the group to modify.
	*/
	overload static function update(
		groupId: Int,
		updateProperties : {
			/**
			* Whether the group should be collapsed.
			*/
			?collapsed : Bool,
			/**
			* The color of the group.
			*/
			?color : Color,
			/**
			* The title of the group.
			*/
			?title : String,
		},
		callback : TabGroup->Void
	) : Void;

	overload static function update(
		groupId: Int,
		updateProperties : {
			?collapsed : Bool,
			?color : Color,
			?title : String,
		}
	) : Promise<TabGroup>;

	/**
	* Moves the group and all its tabs within its window, or to a new window.
	*
	* @param groupId The ID of the group to move.
	*/
	overload static function move(
		groupId: Int,
		moveProperties: {
			/**
			* The window to move the group to. Defaults to the window the group
			* is currently in. Note that groups can only be moved to and from
			* windows with {@link windows.WindowType} type `"normal"`.
			*/
			?windowId : Int,
			/**
			* The position to move the group to. Use `-1` to place the group at
			* the end of the window.
			*/
			index : Int,
		},
		callback : TabGroup->Void
	) : Void;

	overload static function move(
		groupId: Int,
		moveProperties: {
			?windowId : Int,
			index : Int,
		}
	) : Promise<TabGroup>;
}

/**
* The group's color.
*/
extern enum abstract Color(String) to String {
	var GREY = "grey";
	var BLUE = "blue";
	var RED = "red";
	var YELLOW = "yellow";
	var GREEN = "green";
	var PINK = "pink";
	var PURPLE = "purple";
	var CYAN = "cyan";
	var ORANGE = "orange";
}

typedef TabGroup = {

	/**
	* The ID of the group. Group IDs are unique within a browser session.
	*/
	var id : Int;

	/**
	* Whether the group is collapsed. A collapsed group is one whose tabs are hidden.
	*/
	var collapsed : Bool;

	/**
	* The group's color.
	*/
	var color : Color;

	/**
	* The title of the group.
	*/
	var ?title : String;

	/**
	* The ID of the window that contains the group.
	*/
	var windowId : Int;
}

