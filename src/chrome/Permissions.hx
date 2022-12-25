package chrome;

/**
* Use the `chrome.permissions` API to request [declared optional permissions](https://developer.chrome.com/docs/extensions/reference/permissions/#manifest) at run time rather than install time, so users understand why the permissions are needed and grant only those that are necessary.
*/
@:native("chrome.permissions")
extern class Permissions {
	/**
	* Fired when the extension acquires new permissions.
	*/
	static final onAdded : Event<PermissionsDetails->Void>;

	/**
	* Fired when access to permissions has been removed from the extension.
	*/
	static final onRemoved : Event<PermissionsDetails->Void>;

	/**
	* Gets the extension's current set of permissions.
	*/
	overload static function getAll( cakkback : PermissionsDetails->Void ) : Void;
	overload static function getAll() : Promise<PermissionsDetails>;

	/**
	* Checks if the extension has the specified permissions.
	*/
	overload static function contains( permissions : PermissionsDetails, callback : Bool->Void ) : Void;
	overload static function contains( permissions : PermissionsDetails ) : Promise<Bool>;

	/**
	* Requests access to the specified permissions, displaying a prompt to the user if necessary.
	* These permissions must either be defined in the `optional_permissions` field
	* of the manifest or be required permissions that were withheld by the user.
	* Paths on origin patterns will be ignored. You can request subsets of
	* optional origin permissions; for example, if you specify `*://*\/*` in the
	* `optional_permissions` section of the manifest, you can request `http://example.com/`.
	* If there are any problems requesting the permissions, {@link runtime.lastError} will be set.
	*/
	overload static function request( permissions : PermissionsDetails, callback : Bool->Void ) : Void;
	overload static function request( permissions : PermissionsDetails ) : Promise<Bool>;

	/**
	* Removes access to the specified permissions. If there are any problems
	* removing the permissions, {@link runtime.lastError} will be set.
	*/
	overload static function remove( permissions : PermissionsDetails, callback : Bool->Void ) : Void;
	overload static function remove( permissions : PermissionsDetails ) : Promise<Bool>;

}

typedef PermissionsDetails = {

	/**
	* List of named permissions (does not include hosts or origins).
	*/
	var ?permissions : Array<String>;

	/**
	* The list of host permissions, including those specified in the
	* `optional_permissions` or `permissions` keys in the manifest,
	* and those associated with [Content Scripts](https://developer.chrome.com/docs/extensions/content_scripts).
	*/
	var ?origins : Array<String>;
}