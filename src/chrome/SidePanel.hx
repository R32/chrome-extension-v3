package chrome;

/**
* chrome.sidePanel API
*
* @alpha
* @chrome-permission sidePanel
* @chrome-channel canary
* @chrome-min-manifest MV3
*/
@:native("chrome.sidePanel")
extern class SidePanel {
	/**
	* Configures the side panel.
	*
	* @param options The configuration options to apply to the panel.
	* @param callback Invoked when the options have been set.
	*/
	overload static function setOptions( options : PanelOptions, callback : ()->Void ) : Void;
	overload static function setOptions( options : PanelOptions ) : Promise<Void>;

	/**
	* Returns the active panel configuration.
	*
	* @param options Specifies the context to return the configuration for.
	* @param callback Called with the active panel configuration.
	*/
	overload static function getOptions( options : GetPanelOptions, callback : PanelOptions->Void ) : Void;
	overload static function getOptions( options : GetPanelOptions ) : Promise<PanelOptions>;
}

typedef PanelOptions = {
	/**
	* If specified, the side panel options will only apply to the tab with this id.
	* If omitted, these options set the default behavior
	* (used for any tab that doesn't have specific settings).
	*/
	var ?tabId : Int;

	/**
	* The path to the side panel HTML file to use. This must be a local resource
	* within the extension package.
	*/
	var ?path : String;

	/**
	* Whether the side panel should be enabled.
	*/
	var ?enabled : Bool;
}

typedef GetPanelOptions = {
	/**
	* If specified, the side panel options for the given tab will be returned.
	* Otherwise, returns the default side panel options
	* (used for any tab that doesn't have specific settings).
	*/
	var ?tabId : Int;
}

