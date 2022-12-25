package chrome;

private extern class EventBase<T:Function> {
	/**
	* Deregisters an event listener _callback_ from an event.
	*
	* @param callback Listener that shall be unregistered.
	*/
	function removeListener( callback : T ) : Void;

	/**
	* @param callback Listener whose registration status shall be tested.
	* @returns True if _callback_ is registered to the event.
	*/
	function hasListener( callback : T ) : Bool;

	/**
	* @returns True if any event listeners are registered to the event.
	*/
	function hasListeners() : Bool;

	/**
	* Registers rules to handle events.
	*
	* @param rules Rules to be registered. These do not replace previously registered rules.
	* @param callback Called with registered rules.
	*/
	function addRules( rules : Array<Rule>, ?callback : (Array<Rule>)->Void ) : Void;

	/**
	* Returns currently registered rules.
	*
	* @param ruleIdentifiers If an array is passed, only rules with identifiers contained in this array are returned.
	* @param callback Called with registered rules.
	*/
	function getRules( ruleIdentifiers : Array<String>, ?callback : (Array<Rule>)->Void ) : Void;

	/**
	* Unregisters currently registered rules.
	*
	* @param ruleIdentifiers If an array is passed, only rules with identifiers contained in this array are unregistered.
	* @param callback Called when rules were unregistered.
	*/
	function removeRules( ?ruleIdentifiers : Array<String>, ?callback : (Array<Rule>)->Void ) : Void;
}

/**
* An object which allows the addition and removal of listeners for a Chrome event.
*/
extern class Event<T:Function> extends EventBase<T> {
	/**
	* Registers an event listener _callback_ to an event.
	*
	* @param callback Called when an event occurs. The parameters of this function depend on the type of event.
	*/
	function addListener( callback : T ) : Void;
}

/**
index.d.ts:
  // This is used to support addListener() where additional parameters are supported.
  // The name is detected inside the developer.chrome.com repository and special actions are taken.
*/
extern class CustomChromeEvent<T:Function> extends EventBase<T> {

	final addListener : T;
}

typedef Rule = {
	/**
	* Optional identifier that allows referencing this rule.
	*/
	var ?id : String;

	/**
	* Tags can be used to annotate rules and perform operations on sets of rules.
	*/
	var ?tags : Array<String>;

	/**
	* List of conditions that can trigger the actions.
	*/
	var conditions : Array<Any>;

	/**
	* List of actions that are triggered if one of the conditions is fulfilled.
	*/
	var actions : Array<Any>;

	/**
	* Optional priority of this rule. Defaults to 100.
	*/
	var ?priority : Int;
}

/**
* Filters URLs for various criteria
*/
typedef UrlFilter = {
	/**
	* Matches if the host name of the URL contains a specified string. To test whether a host name component has a prefix 'foo', use hostContains: '.foo'. This matches 'www.foobar.com' and 'foo.com', because an implicit dot is added at the beginning of the host name. Similarly, hostContains can be used to match against component suffix ('foo.') and to exactly match against components ('.foo.'). Suffix- and exact-matching for the last components need to be done separately using hostSuffix, because no implicit dot is added at the end of the host name.
	*/
	var ?hostContains : String;

	/**
	* Matches if the host name of the URL is equal to a specified string.
	*/
	var ?hostEquals : String;

	/**
	* Matches if the host name of the URL starts with a specified string.
	*/
	var ?hostPrefix : String;

	/**
	* Matches if the host name of the URL ends with a specified string.
	*/
	var ?hostSuffix : String;

	/**
	* Matches if the path segment of the URL contains a specified string.
	*/
	var ?pathContains : String;

	/**
	* Matches if the path segment of the URL is equal to a specified string.
	*/
	var ?pathEquals : String;

	/**
	* Matches if the path segment of the URL starts with a specified string.
	*/
	var ?pathPrefix : String;

	/**
	* Matches if the path segment of the URL ends with a specified string.
	*/
	var ?pathSuffix : String;

	/**
	* Matches if the query segment of the URL contains a specified string.
	*/
	var ?queryContains : String;

	/**
	* Matches if the query segment of the URL is equal to a specified string.
	*/
	var ?queryEquals : String;

	/**
	* Matches if the query segment of the URL starts with a specified string.
	*/
	var ?queryPrefix : String;

	/**
	* Matches if the query segment of the URL ends with a specified string.
	*/
	var ?querySuffix : String;

	/**
	* Matches if the URL (without fragment identifier) contains a specified string. Port numbers are stripped from the URL if they match the default port number.
	*/
	var ?urlContains : String;

	/**
	* Matches if the URL (without fragment identifier) is equal to a specified string. Port numbers are stripped from the URL if they match the default port number.
	*/
	var ?urlEquals : String;

	/**
	* Matches if the URL (without fragment identifier) matches a specified regular expression. Port numbers are stripped from the URL if they match the default port number. The regular expressions use the [RE2 syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
	*/
	var ?urlMatches : String;

	/**
	* Matches if the URL without query segment and fragment identifier matches a specified regular expression. Port numbers are stripped from the URL if they match the default port number. The regular expressions use the [RE2 syntax](https://github.com/google/re2/blob/master/doc/syntax.txt).
	*/
	var ?originAndPathMatches : String;

	/**
	* Matches if the URL (without fragment identifier) starts with a specified string. Port numbers are stripped from the URL if they match the default port number.
	*/
	var ?urlPrefix : String;

	/**
	* Matches if the URL (without fragment identifier) ends with a specified string. Port numbers are stripped from the URL if they match the default port number.
	*/
	var ?urlSuffix : String;

	/**
	* Matches if the scheme of the URL is equal to any of the schemes specified in the array.
	*/
	var ?schemes : Array<String>;

	/**
	* Matches if the port of the URL is contained in any of the specified port lists. For example `[80, 443, [1000, 1200]]` matches all requests on port 80, 443 and in the range 1000-1200.
	*/
	var ?ports : Array<EitherType<Int, Array<Int>>>;
}
