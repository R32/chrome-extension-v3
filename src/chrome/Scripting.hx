package chrome;

/**
* Use the `chrome.scripting` API to execute script in different contexts.
*
* @since Chrome 88
* @chrome-permission scripting
* @chrome-min-manifest MV3
*/
@:native("chrome.scripting")
extern class Scripting {

	/**
	* Injects a script into a target context. The script will be run at `document_idle`.
	* If the script evaluates to a promise, the browser will wait for the promise to
	* settle and return the resulting value.
	*
	* @param injection The details of the script which to inject.
	* @param callback Invoked upon completion of the injection.
	* The resulting array contains the result of execution f
	* or each frame where the injection succeeded.
	*/
	overload static function executeScript( injection : CSSInjection, callback : ()->Void ) : Void;
	overload static function executeScript( injection : CSSInjection ) : Promise<Void>;

	/**
	* Inserts a CSS stylesheet into a target context. If multiple frames are specified,
	* unsuccessful injections are ignored.
	*
	* @param injection The details of the styles to insert.
	* @param callback Invoked upon completion of the insertion.
	*/
	overload static function insertCSS( injection : CSSInjection, callback : ()->Void ) : Void;
	overload static function insertCSS( injection : CSSInjection ) : Promise<Void>;

	/**
	* Removes a CSS stylesheet that was previously inserted by this extension from a target context.
	*
	* @param injection The details of the styles to remove. Note that the `css`, `files`, and `origin` properties must exactly match the stylesheet inserted through {@link insertCSS}. Attempting to remove a non-existent stylesheet is a no-op.
	* @param callback A callback to be invoked upon the completion of the removal.
	* @since Chrome 90
	*/
	overload static function removeCSS( injection : CSSInjection, callback : ()->Void ) : Void;
	overload static function removeCSS( injection : CSSInjection ) : Promise<Void>;

	/**
	* Registers one or more content scripts for this extension.
	*
	* @param scripts Contains a list of scripts to be registered.
	* If there are errors during script parsing/file validation,
	* or if the IDs specified already exist, then no scripts are registered.
	* @param callback A callback to be invoked once scripts have been
	* fully registered or if an error has occurred.
	* @since Chrome 96
	*/
	overload static function registerContentScripts( scripts : Array<RegisteredContentScript>, callback : ()->Void ) : Void;
	overload static function registerContentScripts( scripts : Array<RegisteredContentScript> ) : Promise<Void>;

	/**
	* Returns all dynamically registered content scripts for this extension that match the given filter.
	*
	* @param filter An object to filter the extension's dynamically registered scripts.
	* @since Chrome 96
	*/
	overload static function getRegisteredContentScripts( callback : (Array<RegisteredContentScript>)->Void ) : Void;
	overload static function getRegisteredContentScripts( filter : ContentScriptFilter, callback : (Array<RegisteredContentScript>)->Void ) : Void;
	overload static function getRegisteredContentScripts( ?filter : ContentScriptFilter ) : Promise<Array<RegisteredContentScript>>;

	/**
	* Unregisters content scripts for this extension.
	*
	* @param filter If specified, only unregisters dynamic content scripts
	* which match the filter. Otherwise, all of the extension's dynamic content
	* scripts are unregistered.
	* @param callback A callback to be invoked once scripts have been unregistered
	* or if an error has occurred.
	* @since Chrome 96
	*/
	overload static function unregisterContentScripts( callback : ()->Void ) : Void;
	overload static function unregisterContentScripts( filter : ContentScriptFilter, callback : ()->Void ) : Void;
	overload static function unregisterContentScripts( ?filter : ContentScriptFilter ) : Promise<Void>;

	/**
	* Updates one or more content scripts for this extension.
	*
	* @param scripts Contains a list of scripts to be updated.
	* A property is only updated for the existing script if it is specified in this object.
	* If there are errors during script parsing/file validation,
	* or if the IDs specified do not correspond to a fully registered script,
	* then no scripts are updated.
	* @param callback A callback to be invoked once scripts have been updated
	* or if an error has occurred.
	* @since Chrome 96
	*/
	overload static function updateContentScripts( scripts : Array<RegisteredContentScript>, callback : ()->Void ) : Void;
	overload static function updateContentScripts( scripts : Array<RegisteredContentScript> ) : Promise<Void>;

}

/**
* The origin for a style change. See [style origins](https://developer.mozilla.org/en-US/docs/Glossary/Style_origin) for more info.
*/
extern enum abstract StyleOrigin(String) to String {
	var AUTHOR = "AUTHOR";
	var USER = "USER";
}

/**
* The JavaScript world for a script to execute within.
*
* @chrome-enum "ISOLATED" The isolated world, unique to this extension.
* @chrome-enum "MAIN" The main world of the DOM, shared with the page's JavaScript.
* @since Chrome 95
*/
extern enum abstract ExecutionWorld(String) to String {
	var ISOLATED = "ISOLATED";
	var MAIN = "MAIN";
}

typedef InjectionTarget = {

	/**
	* The ID of the tab into which to inject.
	*/
	var tabId : Int;

	/**
	* The [IDs](https://developer.chrome.com/docs/extensions/reference/webNavigation/#frame_ids)
	* of specific frames to inject into.
	*/
	var ?frameIds : Array<Int>;

	/**
	* The [IDs](https://developer.chrome.com/docs/extensions/reference/webNavigation/#document_ids)
	* of specific documentIds to inject into. This must not be set if `frameIds` is set.
	*
	* @since Chrome 106
	*/
	var ?documentIds : Array<String>;

	/**
	* Whether the script should inject into all frames within the tab.
	* Defaults to false. This must not be true if `frameIds` is specified.
	*/
	var ?allFrames : Bool;
}

typedef ScriptInjection = {

	/**
	* A JavaScript function to inject. This function will be serialized,
	* and then deserialized for injection. This means that any bound parameters
	* and execution context will be lost. Exactly one of `files` and `func` must be specified.
	*
	* @since Chrome 92
	*/
	var ?func : ()->Void;

	/**
	* The arguments to curry into a provided function. This is only valid if the
	* `func` parameter is specified. These arguments must be JSON-serializable.
	*
	* @since Chrome 92
	*/
	var ?args : Array<Dynamic>;

	/**
	* The path of the JS or CSS files to inject, relative to the extension's
	* root directory. Exactly one of `files` and `func` must be specified.
	*/
	var ?files : Array<String>;

	/**
	* Details specifying the target into which to inject the script.
	*/
	var target : InjectionTarget;

	/**
	* The JavaScript "world" to run the script in. Defaults to `ISOLATED`.
	*
	* @since Chrome 95
	*/
	var ?world : ExecutionWorld;

	/**
	* Whether the injection should be triggered in the target as soon as possible.
	* Note that this is not a guarantee that injection will occur prior to page load,
	* as the page may have already loaded by the time the script reaches the target.
	*
	* @since Chrome 102
	*/
	var ?injectImmediately : Bool;
}

typedef CSSInjection = {

	/**
	* Details specifying the target into which to insert the CSS.
	*/
	var target : InjectionTarget;

	/**
	* A string containing the CSS to inject. Exactly one of `files` and `css` must be specified.
	*/
	var ?css : String;

	/**
	* The path of the CSS files to inject, relative to the extension's root directory. Exactly one of `files` and `css` must be specified.
	*/
	var ?files : Array<String>;

	/**
	* The style origin for the injection. Defaults to `'AUTHOR'`.
	*/
	var ?origin : StyleOrigin;
}

typedef InjectionResult = {

	/**
	* The result of the script execution.
	*/
	var ?result : Dynamic;

	/**
	* The frame associated with the injection.
	*
	* @since Chrome 90
	*/
	var frameId : Int;

	/**
	* The document associated with the injection.
	*
	* @since Chrome 106
	*/
	var documentId : String;
}

/**
* @since Chrome 96
*/
typedef RegisteredContentScript = {

	/**
	* The id of the content script, specified in the API call.
	* Must not start with a '\_' as it's reserved as a prefix for generated script IDs.
	*/
	var id : String;

	/**
	* Specifies which pages this content script will be injected into.
	* See [Match Patterns](https://developer.chrome.com/docs/extensions/match_patterns)
	* for more details on the syntax of these strings. Must be specified for {@link registerContentScripts}.
	*/
	var ?matches : Array<String>;

	/**
	* Excludes pages that this content script would otherwise be injected into.
	* See [Match Patterns](https://developer.chrome.com/docs/extensions/match_patterns)
	* for more details on the syntax of these strings.
	*/
	var ?excludeMatches : Array<String>;

	/**
	* The list of CSS files to be injected into matching pages.
	* These are injected in the order they appear in this array,
	* before any DOM is constructed or displayed for the page.
	*/
	var ?css : Array<String>;

	/**
	* The list of JavaScript files to be injected into matching pages.
	* These are injected in the order they appear in this array.
	*/
	var ?js : Array<String>;

	/**
	* If specified true, it will inject into all frames, even if the frame is
	* not the top-most frame in the tab. Each frame is checked independently
	* for URL requirements; it will not inject into child frames if the URL requirements
	* are not met. Defaults to false, meaning that only the top frame is matched.
	*/
	var ?allFrames : Bool;

	/**
	* Specifies when JavaScript files are injected into the web page.
	* The preferred and default value is `document_idle`.
	*/
	var ?runAt : ExtensionTypes.RunAt;

	/**
	* Specifies if this content script will persist into future sessions. The default is true.
	*/
	var ?persistAcrossSessions : Bool;

	/**
	* The JavaScript "world" to run the script in. Defaults to `ISOLATED`.
	*
	* @since Chrome 102
	*/
	var ?world : ExecutionWorld;
}

/**
* @since Chrome 96
*/
typedef ContentScriptFilter = {

	/**
	* If specified, {@link getRegisteredContentScripts} will only return scripts
	* with an id specified in this list.
	*/
	var ?ids : Array<String>;
}
