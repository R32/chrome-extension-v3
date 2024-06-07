package chrome;

/**
* Use the `chrome.i18n` infrastructure to implement internationalization across your whole app or extension.
*/
@:native("chrome.i18n")
extern class I18n {

	/**
	* Gets the accept-languages of the browser. This is different from the
	* locale used by the browser; to get the locale, use {@link i18n.getUILanguage}.
	*/
	overload static function getAcceptLanguages( callback : (Array<LanguageCode>)->Void) : Void;
	overload static function getAcceptLanguages() : Promise<Array<LanguageCode>>;

	/**
	* Gets the localized string for the specified message. If the message is missing,
	* this method returns an empty string (''). If the format of the `getMessage()`
	* call is wrong — for example, _messageName_ is not a string or the _substitutions_
	* array has more than 9 elements — this method returns `undefined`.
	*
	* @param messageName The name of the message, as specified in the [`messages.json`](https://developer.chrome.com/extensions/i18n-messages) file.
	* @param substitutions Up to 9 substitution strings, if the message requires any.
	* @param options.escapeLt Escape `<` in translation to `&lt;`. This applies
	* only to the message itself, not to the placeholders. Developers might want
	* to use this if the translation is used in an HTML context.
	* Closure Templates used with Closure Compiler generate this automatically.
	* @returns Message localized for current locale.
	*/
	static function getMessage( messageName : String, ?substitutions : Dynamic, ?options : {?escapeLt : Bool} ) : String;

	/**
	* Gets the browser UI language of the browser. This is different from
	* {@link i18n.getAcceptLanguages} which returns the preferred user languages.
	*
	* @returns The browser UI language code such as en-US or fr-FR.
	*/
	static function getUILanguage() : String;

	/**
	* Detects the language of the provided text using CLD.
	*
	* @param text User input string to be translated.
	* @since Chrome 47
	*/
	overload static function detectLanguage( text : String, callback : DetectResult->Void ) : Void;
	overload static function detectLanguage( text : String) : Promise<DetectResult>;
}

/**
* An ISO language code such as `en` or `fr`. For a complete list of languages supported by this method, see [kLanguageInfoTable](https://src.chromium.org/viewvc/chrome/trunk/src/third_party/cld/languages/internal/languages.cc). For an unknown language, `und` will be returned, which means that \[percentage\] of the text is unknown to CLD
*
* @since Chrome 47
*/
typedef LanguageCode = String;

private typedef DetectResult = {
	/**
	* CLD detected language reliability
	*/
	var isReliable : Bool;

	/**
	* array of detectedLanguage
	*/
	var languages: Array<{language : LanguageCode, percentage : Int}>;
}
