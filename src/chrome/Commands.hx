package chrome;

/**
* Use the commands API to add keyboard shortcuts that trigger actions in your extension,
* for example, an action to open the browser action or send a command to the extension.
*
* @chrome-manifest commands
*/
@:native("chrome.commands")
extern class Commands {

	/**
	* Fired when a registered command is activated using a keyboard shortcut.
	*/
	static final onCommand : Event<(command : String, ?tab : Tabs.Tab)->Void>;

	/**
	* Returns all the registered extension commands for this extension and their shortcut (if active).
	*
	* @param callback Called to return the registered commands.
	*/
	overload static function getAll( callback : (Array<Command>)->Void ) : Void;
	overload static function getAll() : Promise<Array<Command>>;
}

typedef Command = {

	/**
	* The name of the Extension Command
	*/
	var ?name : String;

	/**
	* The Extension Command description
	*/
	var ?description : String;

	/**
	* The shortcut active for this command, or blank if not active.
	*/
	var ?shortcut : String;
}
