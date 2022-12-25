package chrome.system;

/**
* Use the `system.display` API to query display metadata.
*
* @chrome-permission system.display
*/
@:native("chrome.system.display")
extern class Display {
	/**
	* Fired when anything changes to the display configuration.
	*/
	static final onDisplayChanged : Event < ()->Void > ;

	/**
	* Requests the information for all attached display devices.
	*
	* @param flags Options affecting how the information is returned.
	* @param callback The callback to invoke with the results.
	*/
	overload static function getInfo( callback : (Array<DisplayUnitInfo>)->Void ) : Void;
	overload static function getInfo( flags : GetInfoFlags, callback : (Array<DisplayUnitInfo>)->Void ) : Void;
	overload static function getInfo( ?flags : GetInfoFlags ) : Promise<Array<DisplayUnitInfo>>;

	/**
	* Requests the layout info for all displays. NOTE: This is only available
	* to Chrome OS Kiosk apps and Web UI.
	*
	* @param callback The callback to invoke with the results.
	* @since Chrome 53
	*/
	overload static function getDisplayLayout( callback : (Array<DisplayLayout>)->Void ) : Void;
	overload static function getDisplayLayout() : Promise<Array<DisplayLayout>>;

	/**
	* Updates the properties for the display specified by `id`,
	* according to the information provided in `info`. On failure,
	* {@link runtime.lastError} will be set. NOTE: This is only available
	* to Chrome OS Kiosk apps and Web UI.
	*
	* @param id The display's unique identifier.
	* @param info The information about display properties that should be changed.
	* A property will be changed only if a new value for it is specified in `info`.
	* @param callback Empty function called when the function finishes.
	* To find out whether the function succeeded, {@link runtime.lastError}
	* should be queried.
	*/
	overload static function setDisplayProperties( id : String, info : DisplayProperties, callback : ()->Void ) : Void;
	overload static function setDisplayProperties( id : String, info : DisplayProperties ) : Promise<Void>;

	/**
	* Set the layout for all displays. Any display not included will use the default layout.
	* If a layout would overlap or be otherwise invalid it will be adjusted to
	* a valid layout. After layout is resolved, an onDisplayChanged event will be triggered.
	* NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
	*
	* @param layouts The layout information, required for all displays except
	* the primary display.
	* @param callback Empty function called when the function finishes.
	* To find out whether the function succeeded, {@link runtime.lastError}
	* should be queried.
	* @since Chrome 53
	*/
	overload static function setDisplayLayout( layouts : Array<DisplayLayout>, callback : ()->Void ) : Void;
	overload static function setDisplayLayout( layouts : Array<DisplayLayout> ) : Promise<Void>;

	/**
	* Enables/disables the unified desktop feature.
	* If enabled while mirroring is active,
	* the desktop mode will not change until mirroring is turned off.
	* Otherwise, the desktop mode will switch to unified immediately.
	* NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
	*
	* @param enabled True if unified desktop should be enabled.
	* @since Chrome 46
	*/
	static function enableUnifiedDesktop( enabled : Bool ) : Void;

	/**
	* Starts overscan calibration for a display. This will show an overlay
	* on the screen indicating the current overscan insets. If overscan
	* calibration for display `id` is in progress this will reset calibration.
	*
	* @param id The display's unique identifier.
	* @since Chrome 53
	*/
	static function overscanCalibrationStart( id : String ) : Void;

	/**
	* Adjusts the current overscan insets for a display. Typically this should
	* either move the display along an axis (e.g. left+right have the same value)
	* or scale it along an axis (e.g. top+bottom have opposite values).
	* Each Adjust call is cumulative with previous calls since Start.
	*
	* @param id The display's unique identifier.
	* @param delta The amount to change the overscan insets.
	* @since Chrome 53
	*/
	static function overscanCalibrationAdjust( id : String, delta : Insets ) : Void;

	/**
	* Resets the overscan insets for a display to the last saved value
	* (i.e before Start was called).
	*
	* @param id The display's unique identifier.
	* @since Chrome 53
	*/
	static function overscanCalibrationReset( id : String ) : Void;

	/**
	* Complete overscan adjustments for a display by saving the current values
	* and hiding the overlay.
	*
	* @param id The display's unique identifier.
	* @since Chrome 53
	*/
	static function overscanCalibrationComplete( id : String ) : Void;

	/**
	* Displays the native touch calibration UX for the display with `id` as display id.
	* This will show an overlay on the screen with required instructions on how to proceed.
	* The callback will be invoked in case of successful calibration only.
	* If the calibration fails, this will throw an error.
	*
	* @param id The display's unique identifier.
	* @param callback Optional callback to inform the caller that the touch calibration
	* has ended. The argument of the callback informs if the calibration was a success or not.
	* @since Chrome 57
	*/
	overload static function showNativeTouchCalibration( id : String, callback : Bool->Void ) : Void;
	overload static function showNativeTouchCalibration( id : String ) : Promise<Bool>;

	/**
	* Starts custom touch calibration for a display. This should be called when
	* using a custom UX for collecting calibration data. If another
	* touch calibration is already in progress this will throw an error.
	*
	* @param id The display's unique identifier.
	* @since Chrome 57
	*/
	static function startCustomTouchCalibration( id : String ) : Void;

	/**
	* Sets the touch calibration pairs for a display. These `pairs` would be
	* used to calibrate the touch screen for display with `id` called in
	* startCustomTouchCalibration(). Always call `startCustomTouchCalibration`
	* before calling this method. If another touch calibration is already
	* in progress this will throw an error.
	*
	* @param pairs The pairs of point used to calibrate the display.
	* @param bounds Bounds of the display when the touch calibration was performed.
	* `bounds.left` and `bounds.top` values are ignored.
	* @since Chrome 57
	*/
	static function completeCustomTouchCalibration( pairs : TouchCalibrationPairQuad, bounds : Bounds ) : Void;

	/**
	* Resets the touch calibration for the display and brings it back to its
	* default state by clearing any touch calibration data associated with the display.
	*
	* @param id The display's unique identifier.
	* @since Chrome 57
	*/
	static function clearTouchCalibration( id : String ) : Void;

	/**
	* Sets the display mode to the specified mirror mode. Each call resets
	* the state from previous calls. Calling setDisplayProperties() will fail
	* for the mirroring destination displays. NOTE: This is only available to
	* Chrome OS Kiosk apps and Web UI.
	*
	* @param info The information of the mirror mode that should be applied to
	* the display mode.
	* @param callback Empty function called when the function finishes.
	* To find out whether the function succeeded, {@link runtime.lastError}
	* should be queried.
	* @since Chrome 65
	*/
	overload static function setMirrorMode( info : MirrorModeInfo, callback : ()->Void ) : Void;
	overload static function setMirrorMode( info : MirrorModeInfo ) : Promise<Void>;
}

typedef Bounds = {

	/**
	* The x-coordinate of the upper-left corner.
	*/
	var left : Float;

	/**
	* The y-coordinate of the upper-left corner.
	*/
	var top : Float;

	/**
	* The width of the display in pixels.
	*/
	var width : Float;

	/**
	* The height of the display in pixels.
	*/
	var height : Float;
}

typedef Insets = {

	/**
	* The x-axis distance from the left bound.
	*/
	var left : Float;

	/**
	* The y-axis distance from the top bound.
	*/
	var top : Float;

	/**
	* The x-axis distance from the right bound.
	*/
	var right : Float;

	/**
	* The y-axis distance from the bottom bound.
	*/
	var bottom : Float;
}


/**
* @since Chrome 57
*/
typedef Point = {

	/**
	* The x-coordinate of the point.
	*/
	var x : Float;

	/**
	* The y-coordinate of the point.
	*/
	var y : Float;
}

/**
* @since Chrome 57
*/
typedef TouchCalibrationPair = {

	/**
	* The coordinates of the display point.
	*/
	var displayPoint : Point;

	/**
	* The coordinates of the touch point corresponding to the display point.
	*/
	var touchPoint : Point;
}

/**
* @since Chrome 57
*/
typedef TouchCalibrationPairQuad = {

	/**
	* First pair of touch and display point required for touch calibration.
	*/
	var pair1 : TouchCalibrationPair;

	/**
	* Second pair of touch and display point required for touch calibration.
	*/
	var pair2 : TouchCalibrationPair;

	/**
	* Third pair of touch and display point required for touch calibration.
	*/
	var pair3 : TouchCalibrationPair;

	/**
	* Fourth pair of touch and display point required for touch calibration.
	*/
	var pair4 : TouchCalibrationPair;
}

/**
* @since Chrome 52
*/
typedef DisplayMode = {

	/**
	* The display mode width in device independent (user visible) pixels.
	*/
	var width : Float;

	/**
	* The display mode height in device independent (user visible) pixels.
	*/
	var height : Float;

	/**
	* The display mode width in native pixels.
	*/
	var widthInNativePixels : Float;

	/**
	* The display mode height in native pixels.
	*/
	var heightInNativePixels : Float;

	/**
	* The display mode UI scale factor.
	*
	* @deprecated Use {@link displayZoomFactor}
	* @chrome-deprecated-since Chrome 70
	*/
	var ?uiScale : Float;

	/**
	* The display mode device scale factor.
	*/
	var deviceScaleFactor : Float;

	/**
	* The display mode refresh rate in hertz.
	*
	* @since Chrome 67
	*/
	var refreshRate : Float;

	/**
	* True if the mode is the display's native mode.
	*/
	var isNative : Bool;

	/**
	* True if the display mode is currently selected.
	*/
	var isSelected : Bool;

	/**
	* True if this mode is interlaced, false if not provided.
	*
	* @since Chrome 74
	*/
	var ?isInterlaced : Bool;
}

/**
* Layout position, i.e. edge of parent that the display is attached to.
*
* @since Chrome 53
*/
extern enum abstract LayoutPosition(String) to String {
	var TOP = "top";
	var RIGHT = "right";
	var BOTTOM = "bottom";
	var LEFT = "left";
}

/**
* @since Chrome 53
*/
typedef DisplayLayout = {

	/**
	* The unique identifier of the display.
	*/
	var id : String;

	/**
	* The unique identifier of the parent display. Empty if this is the root.
	*/
	var parentId : String;

	/**
	* The layout position of this display relative to the parent.
	* This will be ignored for the root.
	*/
	var position : LayoutPosition;

	/**
	* The offset of the display along the connected edge.
	* 0 indicates that the topmost or leftmost corners are aligned.
	*/
	var offset : Int;
}

/**
* @since Chrome 67
*/
typedef Edid = {

	/**
	* 3 character manufacturer code. See Sec. 3.4.1 page 21. Required in v1.4.
	*/
	var manufacturerId : String;

	/**
	* 2 byte manufacturer-assigned code, Sec. 3.4.2 page 21. Required in v1.4.
	*/
	var productId : String;

	/**
	* Year of manufacturer, Sec. 3.4.4 page 22. Required in v1.4.
	*/
	var yearOfManufacture : Int;
}

typedef DisplayUnitInfo = {

	/**
	* The unique identifier of the display.
	*/
	var id : String;

	/**
	* The user-friendly name (e.g. "HP LCD monitor").
	*/
	var name : String;

	/**
	* NOTE: This is only available to Chrome OS Kiosk apps and Web UI.
	*
	* @since Chrome 67
	*/
	var ?edid : Edid;

	/**
	* Chrome OS only. Identifier of the display that is being mirrored
	* if mirroring is enabled, otherwise empty. This will be set for
	* all displays (including the display being mirrored).
	*/
	var mirroringSourceId : String;

	/**
	* Chrome OS only. Identifiers of the displays to which the source display
	* is being mirrored. Empty if no displays are being mirrored.
	* This will be set to the same value for all displays.
	* This must not include `mirroringSourceId`.
	*
	* @since Chrome 64
	*/
	var mirroringDestinationIds : Array<String>;

	/**
	* True if this is the primary display.
	*/
	var isPrimary : Bool;

	/**
	* True if this display is enabled.
	*/
	var isEnabled : Bool;

	/**
	* True for all displays when in unified desktop mode.
	* See documentation for {@link enableUnifiedDesktop}.
	*
	* @since Chrome 59
	*/
	var isUnified : Bool;

	/**
	* The number of pixels per inch along the x-axis.
	*/
	var dpiX : Float;

	/**
	* The number of pixels per inch along the y-axis.
	*/
	var dpiY : Float;

	/**
	* The display's clockwise rotation in degrees relative to the vertical position.
	* Currently exposed only on ChromeOS. Will be set to 0 on other platforms.
	* A value of -1 will be interpreted as auto-rotate when the device is in
	* a physical tablet state.
	*/
	var rotation : Float;

	/**
	* The display's logical bounds.
	*/
	var bounds : Bounds;

	/**
	* The display's insets within its screen's bounds.
	* Currently exposed only on ChromeOS.
	* Will be set to empty insets on other platforms.
	*/
	var overscan : Insets;

	/**
	* The usable work area of the display within the display bounds.
	* The work area excludes areas of the display reserved for OS,
	* for example taskbar and launcher.
	*/
	var workArea : Bounds;

	/**
	* The list of available display modes. The current mode will have isSelected=true.
	* Only available on Chrome OS. Will be set to an empty array on other platforms.
	*
	* @since Chrome 52
	*/
	var modes : Array<DisplayMode>;

	/**
	* True if this display has a touch input device associated with it.
	*
	* @since Chrome 57
	*/
	var hasTouchSupport : Bool;

	/**
	* A list of zoom factor values that can be set for the display.
	*
	* @since Chrome 67
	*/
	var availableDisplayZoomFactors : Array<Float>;

	/**
	* The ratio between the display's current and default zoom. For example,
	* value 1 is equivalent to 100% zoom, and value 1.5 is equivalent to 150% zoom.
	*
	* @since Chrome 65
	*/
	var displayZoomFactor : Float;
}

typedef DisplayProperties = {

	/**
	* Chrome OS only. If set to true, changes the display mode to unified desktop
	* (see {@link enableUnifiedDesktop} for details). If set to false,
	* unified desktop mode will be disabled. This is only valid for the
	* primary display. If provided, mirroringSourceId must not be provided and
	* other properties will be ignored. This is has no effect if not provided.
	*
	* @since Chrome 59
	*/
	var ?isUnified : Bool;

	/**
	* Chrome OS only. If set and not empty, enables mirroring for this display only.
	* Otherwise disables mirroring for all displays. This value should indicate
	* the id of the source display to mirror, which must not be the same as
	* the id passed to setDisplayProperties. If set, no other property may be set.
	*
	* @deprecated Use {@link setMirrorMode}.
	* @chrome-deprecated-since Chrome 68
	*/
	var ?mirroringSourceId : String;

	/**
	* If set to true, makes the display primary. No-op if set to false.
	* Note: If set, the display is considered primary for all other properties
	* (i.e. {@link isUnified} may be set and bounds origin may not).
	*/
	var ?isPrimary : Bool;

	/**
	* If set, sets the display's overscan insets to the provided values.
	* Note that overscan values may not be negative or larger than a half of
	* the screen's size. Overscan cannot be changed on the internal monitor.
	*/
	var ?overscan : Insets;

	/**
	* If set, updates the display's rotation. Legal values are \[0, 90, 180, 270\].
	* The rotation is set clockwise, relative to the display's vertical position.
	*/
	var ?rotation : Float;

	/**
	* If set, updates the display's logical bounds origin along the x-axis.
	* Applied together with {@link boundsOriginY}. Defaults to the current value if not set and {@link boundsOriginY} is set. Note that when updating the display origin, some constraints will be applied, so the final bounds origin may be different than the one set. The final bounds can be retrieved using {@link getInfo}. The bounds origin cannot be changed on the primary display.
	*/
	var ?boundsOriginX : Float;

	/**
	* If set, updates the display's logical bounds origin along the y-axis.
	* See documentation for {@link boundsOriginX} parameter.
	*/
	var ?boundsOriginY : Float;

	/**
	* If set, updates the display mode to the mode matching this value.
	* If other parameters are invalid, this will not be applied.
	* If the display mode is invalid, it will not be applied and an error
	* will be set, but other properties will still be applied.
	*
	* @since Chrome 52
	*/
	var ?displayMode : DisplayMode;

	/**
	* If set, updates the zoom associated with the display.
	* This zoom performs re-layout and repaint thus resulting in a better
	* quality zoom than just performing a pixel by pixel stretch enlargement.
	*
	* @since Chrome 65
	*/
	var ?displayZoomFactor : Float;
}

/**
* @since Chrome 59
*/
typedef GetInfoFlags = {

	/**
	* If set to true, only a single {@link DisplayUnitInfo} will be returned
	* by {@link getInfo} when in unified desktop mode (see {@link enableUnifiedDesktop}).
	* Defaults to false.
	*/
	var ?singleUnified : Bool;
}

/**
* Mirror mode, i.e. different ways of how a display is mirrored to other displays.
*
* @chrome-enum "off" Use the default mode (extended or unified desktop).
* @chrome-enum "normal" The default source display will be mirrored to all other displays.
* @chrome-enum "mixed" The specified source display will be mirrored to the
* provided destination displays. All other connected displays will be extended.
* @since Chrome 65
*/
extern enum abstract MirrorMode(String) to String {
	var OFF = "off";
	var NORMAL = "normal";
	var MIXED = "mixed";
}

/**
* @since Chrome 65
*/
typedef MirrorModeInfo = {

	/**
	* The mirror mode that should be set.
	*/
	var mode : MirrorMode;

	/**
	* The id of the mirroring source display. This is only valid for 'mixed'.
	*/
	var ?mirroringSourceId : String;

	/**
	* The ids of the mirroring destination displays. This is only valid for 'mixed'.
	*/
	var ?mirroringDestinationIds : Array<String>;
}

