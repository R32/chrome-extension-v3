package chrome;

/**
* Use the `chrome.dns` API for dns resolution.
*
* @alpha
* @chrome-permission dns
* @chrome-channel dev
*/
@:native("chrome.dns")
extern class Dns {

	/**
	* Resolves the given hostname or IP address literal.
	*
	* @param hostname The hostname to resolve.
	* @param callback Called when the resolution operation completes.
	*/
	overload static function resolve( hostname : String, callback : ResolveCallbackResolveInfo->Void ) : Void;
	overload static function resolve( hostname : String ) : Promise<ResolveCallbackResolveInfo>;
}

typedef ResolveCallbackResolveInfo = {

	/**
	* The result code. Zero indicates success.
	*/
	var resultCode: Int;

	/**
	* A string representing the IP address literal. Supplied only if resultCode indicates success.
	*/
	var ?address : String;
}
