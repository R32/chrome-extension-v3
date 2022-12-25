package chrome;

/**
* Use the `chrome.accessibilityFeatures` API to manage Chrome's accessibility features.
* This API relies on the [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
* for getting and setting individual accessibility features.
* In order to get feature states the extension must request `accessibilityFeatures.read` permission.
* For modifying feature state, the extension needs `accessibilityFeatures.modify` permission.
* Note that `accessibilityFeatures.modify` does not imply `accessibilityFeatures.read` permission.
*
* @chrome-permission accessibilityFeatures.modify
* @chrome-permission accessibilityFeatures.read
*/
@:native("chrome.accessibilityFeatures")
extern class AccessibilityFeatures {
	/**
	* **ChromeOS only.**
	*
	* Spoken feedback (text-to-speech).
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final spokenFeedback : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Enlarged cursor.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final largeCursor : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Sticky modifier keys (like shift or alt).
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final stickyKeys : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* High contrast rendering mode.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final highContrast : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Full screen magnification.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final screenMagnifier : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Auto mouse click after mouse stops moving.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final autoclick : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Virtual on-screen keyboard.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final virtualKeyboard : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Caret highlighting.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 51
	*/
	static final caretHighlight : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Cursor highlighting.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 51
	*/
	static final cursorHighlight : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Cursor color.
	*
	* The value indicates whether the feature is enabled or not, doesn't indicate the color of it.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 85
	*/
	static final cursorColor : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Docked magnifier.
	*
	* The value indicates whether docked magnifier feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission. `set()` and `clear()`
	* require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 87
	*/
	static final dockedMagnifier : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Focus highlighting.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 51
	*/
	static final focusHighlight : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Select-to-speak.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 51
	*/
	static final selectToSpeak : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Switch Access.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 51
	*/
	static final switchAccess : Types.ChromeSetting<Bool>;

	/**
	* **ChromeOS only.**
	*
	* Dictation.
	*
	* The value indicates whether the feature is enabled or not.
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*
	* @since Chrome 90
	*/
	static final dictation : Types.ChromeSetting<Bool>;

	/**
	* `get()` requires `accessibilityFeatures.read` permission.
	* `set()` and `clear()` require `accessibilityFeatures.modify` permission.
	*/
	static final animationPolicy : Types.ChromeSetting<AnimationPolicySetting>;
}

extern enum abstract AnimationPolicySetting(String) to String {
	var ALLOWED = "allowed";
	var ONCE = "once";
	var NONE = "none";
}
