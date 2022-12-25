package chrome;

import chrome.Types.LevelOfControl;

/**
* Use the `chrome.fontSettings` API to manage Chrome's font settings.
*
* @chrome-permission fontSettings
*/
@:native("chrome.fontSettings")
extern class FontSettings {
	/**
	* Fired when a font setting changes.
	*/
	static final onFontChanged : Event<{
		/**
		* The font ID. See the description in `getFont`.
		*/
		fontId : String,
		/**
		* The script code for which the font setting has changed.
		*/
		?script : ScriptCode,
		/**
		* The generic font family for which the font setting has changed.
		*/
		genericFamily : GenericFamily,
		/**
		* The level of control this extension has over the setting.
		*/
		levelOfControl : LevelOfControl,
	}->Void>;

	/**
	* Fired when the default font size setting changes.
	*/
	static final onDefaultFontSizeChanged : Event<FontSize->Void>;

	/**
	* Fired when the default fixed font size setting changes.
	*/
	static final onDefaultFixedFontSizeChanged : Event<FontSize->Void>;

	/**
	* Fired when the minimum font size setting changes.
	*/
	static final onMinimumFontSizeChanged : Event<FontSize->Void>;

	/**
	* Clears the font set by this extension, if any.
	*/
	overload static function clearFont( details : CodeFamily, callback : ()->Void ) : Void;
	overload static function clearFont( details : CodeFamily ) : Promise<Void>;

	/**
	* Gets the font for a given script and generic font family.
	*/
	overload static function getFont( details : CodeFamily, callback : FontId->Void ) : Void;
	overload static function getFont( details : CodeFamily ) : Promise<FontId>;

	/**
	* Sets the font for a given script and generic font family.
	*/
	overload static function setFont( details : CodeFamilyId, callback : ()->Void ) : Void;
	overload static function setFont( details : CodeFamilyId ) : Promise<Void>;

	/**
	* Gets a list of fonts on the system.
	*/
	overload static function getFontList( callback : (Array<FontName>)->Void ) : Void;
	overload static function getFontList() : Promise<Array<FontName>>;

	/**
	* Clears the default font size set by this extension, if any.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function clearDefaultFontSize( ?details: {}, callback : ()->Void ) : Void;
	overload static function clearDefaultFontSize( ?details: {} ) : Promise<Array<Void>>;

	/**
	* Gets the default font size.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function getDefaultFontSize( ?details: {}, callback : FontSize->Void ) : Void;
	overload static function getDefaultFontSize( ?details: {} ) : Promise<FontSize>;

	/**
	* Sets the default font size.
	*/
	overload static function setDefaultFontSize( details: {pixelSize : Int}, callback : ()->Void ) : Void;
	overload static function setDefaultFontSize( details: {pixelSize : Int} ) : Promise<Void>;

	/**
	* Clears the default fixed font size set by this extension, if any.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function clearDefaultFixedFontSize( ?details: {}, callback : ()->Void ) : Void;
	overload static function clearDefaultFixedFontSize( ?details: {} ) : Promise<Void>;

	/**
	* Gets the default size for fixed width fonts.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function getDefaultFixedFontSize( ?details: {}, callback : FontSize->Void ) : Void;
	overload static function getDefaultFixedFontSize( ?details: {} ) : Promise<FontSize>;

	/**
	* Sets the default size for fixed width fonts.
	*/
	overload static function setDefaultFixedFontSize( details: {pixelSize : Int}, callback : ()->Void ) : Void;
	overload static function setDefaultFixedFontSize( details: {pixelSize : Int} ) : Promise<Void>;

	/**
	* Clears the minimum font size set by this extension, if any.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function clearMinimumFontSize( ?details: {}, callback : ()->Void ) : Void;
	overload static function clearMinimumFontSize( ?details: {} ) : Promise<Void>;

	/**
	* Gets the minimum font size.
	*
	* @param details This parameter is currently unused.
	*/
	overload static function getMinimumFontSize( ?details: {}, callback : FontSize->Void ) : Void;
	overload static function getMinimumFontSize( ?details: {} ) : Promise<FontSize>;

	/**
	* Sets the minimum font size.
	*/
	overload static function setMinimumFontSize( details: {pixelSize : Int}, callback : ()->Void ) : Void;
	overload static function setMinimumFontSize( details: {pixelSize : Int} ) : Promise<Void>;
}

private typedef FontSize = {
	var pixelSize : Int;
	var levelOfControl : LevelOfControl;
}

private typedef FontId = {
	var fontId : String;
	var levelOfControl : LevelOfControl;
}

private typedef CodeFamily = {
	/**
	* The script for which the font should be cleared. If omitted,
	* the global script font setting is cleared.
	*/
	var ?script : ScriptCode;

	/**
	* The generic font family for which the font should be cleared.
	*/
	var genericFamily : GenericFamily;
}

private typedef CodeFamilyId = CodeFamily & {
	var fontId : String;
}


/**
* Represents a font name.
*/
typedef FontName = {

	/**
	* The font ID.
	*/
	var fontId : String;

	/**
	* The display name of the font.
	*/
	var displayName : String;
}

/**
* An ISO 15924 script code. The default, or global, script is represented by script code "Zyyy".
*/
typedef ScriptCode = String;

/**
* A CSS generic font family.
*/
extern enum abstract GenericFamily(String) to String {
	var STANDARD = "standard";
	var SANSSERIF = "sansserif";
	var SERIF = "serif";
	var FIXED = "fixed";
	var CURSIVE = "cursive";
	var FANTASY = "fantasy";
	var MATH = "math";
}
