package chrome;

/**
* The omnibox API allows you to register a keyword with Google Chrome's address bar,
* which is also known as the omnibox.
*
* @chrome-manifest omnibox
*/
@:native("chrome.omnibox")
extern class Omnibox {
	/**
	* User has started a keyword input session by typing the extension's keyword.
	* This is guaranteed to be sent exactly once per input session,
	* and before any onInputChanged events.
	*/
	static final onInputStarted : Event<()->Void>;

	/**
	* User has changed what is typed into the omnibox.
	*/
	static final onInputChanged : Event<( text : String, suggest : (Array<SuggestResult>)->Void )->Void>;

	/**
	* User has accepted what is typed into the omnibox.
	*/
	static final onInputEntered : Event<( text : String, disposition : OnInputEnteredDisposition )->Void>;

	/**
	* User has ended the keyword input session without accepting the input.
	*/
	static final onInputCancelled : Event<()->Void>;

	/**
	* User has deleted a suggested result.
	*
	* @since Chrome 63
	*/
	static final onDeleteSuggestion : Event<(text : String)->Void>;

	/**
	* Sets the description and styling for the default suggestion.
	* The default suggestion is the text that is displayed in the
	* first suggestion row underneath the URL bar.
	*
	* @param suggestion A partial SuggestResult object, without the 'content' parameter.
	*/
	overload static function setDefaultSuggestion( suggestion : DefaultSuggestResult, callback : ()->Void ) : Void;
	overload static function setDefaultSuggestion( suggestion : DefaultSuggestResult ) : Promise<Void>;
}

/**
* The style type.
*
* @since Chrome 44
*/
extern enum abstract DescriptionStyleType(String) to String {
	var URL = "url";
	var MATCH = "match";
	var DIM = "dim";
}

/**
* The window disposition for the omnibox query.
* This is the recommended context to display results.
* For example, if the omnibox command is to navigate to a certain URL,
* a disposition of 'newForegroundTab' means the navigation should take
* place in a new selected tab.
*
* @since Chrome 44
*/
extern enum abstract OnInputEnteredDisposition(String) to String {
	var CURRENTTAB = "currentTab";
	var NEWFOREGROUNDTAB = "newForegroundTab";
	var NEWBACKGROUNDTAB = "newBackgroundTab";
}

/**
* A suggest result.
*/
typedef SuggestResult = {

	/**
	* The text that is put into the URL bar, and that is sent to the extension
	* when the user chooses this entry.
	*/
	var content : String;

	/**
	* The text that is displayed in the URL dropdown. Can contain XML-style markup
	* for styling. The supported tags are 'url' (for a literal URL),
	* 'match' (for highlighting text that matched what the user's query),
	* and 'dim' (for dim helper text). The styles can be nested, eg. dimmed match.
	* You must escape the five predefined entities to display them as text:
	* stackoverflow.com/a/1091953/89484
	*/
	var description : String;

	/**
	* Whether the suggest result can be deleted by the user.
	*
	* @since Chrome 63
	*/
	var ?deletable : Bool;
}

/**
* A suggest result.
*/
typedef DefaultSuggestResult = {

	/**
	* The text that is displayed in the URL dropdown.
	* Can contain XML-style markup for styling. The supported tags are 'url'
	* (for a literal URL), 'match' (for highlighting text that matched what the user's query),
	* and 'dim' (for dim helper text). The styles can be nested, eg. dimmed match.
	*/
	var description : String;
}
