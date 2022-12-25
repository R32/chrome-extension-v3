package chrome;

/**
* The scope of the ChromeSetting. One of
*
* *   `regular`: setting for the regular profile (which is inherited by the incognito profile if not overridden elsewhere),
* *   `regular\_only`: setting for the regular profile only (not inherited by the incognito profile),
* *   `incognito\_persistent`: setting for the incognito profile that survives browser restarts (overrides regular preferences),
* *   `incognito\_session\_only`: setting for the incognito profile that can only be set during an incognito session and is deleted when the incognito session ends (overrides regular and incognito\_persistent preferences).
*
* @since Chrome 44
*/
extern enum abstract ChromeSettingScope(String) to String {
	var REGULAR = "regular";
	var REGULAR_ONLY = "regular_only";
	var INCOGNITO_PERSISTENT = "incognito_persistent";
	var INCOGNITO_SESSION_ONLY = "incognito_session_only";
}

/**
* One of
*
* *   `not\_controllable`: cannot be controlled by any extension
* *   `controlled\_by\_other\_extensions`: controlled by extensions with higher precedence
* *   `controllable\_by\_this\_extension`: can be controlled by this extension
* *   `controlled\_by\_this\_extension`: controlled by this extension
*
* @since Chrome 44
*/
extern enum abstract LevelOfControl(String) to String {
	var NOT_CONTROLLABLE = "not_controllable";
	var CONTROLLED_BY_OTHER_EXTENSIONS = "controlled_by_other_extensions";
	var CONTROLLABLE_BY_THIS_EXTENSION = "controllable_by_this_extension";
	var CONTROLLED_BY_THIS_EXTENSION = "controlled_by_this_extension";
}


/**
* An interface that allows access to a Chrome browser setting. See {@link accessibilityFeatures} for an example.
*/
extern class ChromeSetting<T> {

	/**
	* Fired after the setting changes.
	*/
	final onChange : Event<SettingDetails<T>->Void>;

	/**
	* Gets the value of a setting.
	*
	* @param details Which setting to consider.
	* @param details.incognito Whether to return the value that
	* applies to the incognito session (default false).
	*/
	overload function get( details : {?incognito : Bool}, callback : (SettingDetails<T>)->Void ) : Void;
	overload function get( details : {?incognito : Bool} ) : Promise<SettingDetails<T>>;

	/**
	* Sets the value of a setting.
	*
	* @param details Which setting to change.
	* @param details.value The value of the setting.
	*   Note that every setting has a specific value type, which is described
	*   together with the setting. An extension should _not_ set a value of a different type.
	* @param details.scope Where to set the setting (default: regular).
	* @param callback Called at the completion of the set operation.
	*/
	overload function set( details : {value : T, ?scope : ChromeSettingScope}, callback : ()->Void ) : Void;
	overload function set( details : {value : T, ?scope : ChromeSettingScope} ) : Promise<Void>;

	/**
	* Clears the setting, restoring any default value.
	*
	* @param details Which setting to clear.
	* @param callback Called at the completion of the clear operation.
	*/
	overload function clear( details : {?scope : ChromeSettingScope}, callback : ()->Void ) : Void;
	overload function clear( details : {?scope : ChromeSettingScope} ) : Promise<Void>;
}

private typedef SettingDetails<T> = {
	/**
	* The value of the setting after the change.
	*/
	var value : T;

	/**
	* The level of control of the setting.
	*/
	var levelOfControl : LevelOfControl;

	/**
	* Whether the value that has changed is specific to the incognito session.
	* This property will _only_ be present if the user has enabled the extension in incognito mode.
	*/
	var ?incognitoSpecific : Bool;
}
