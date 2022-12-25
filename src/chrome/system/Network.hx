package chrome.system;

/**
* Use the `chrome.system.network` API.
*
* @alpha
* @chrome-permission system.network
* @chrome-channel dev
*/
@:native("chrome.system.network")
extern class Network {
	/**
	* Retrieves information about local adapters on this system.
	*
	* @param callback Called when local adapter information is available.
	*/
	overload static function getNetworkInterfaces( callback : (Array<NetworkInterface>)->Void ) : Void;
	overload static function getNetworkInterfaces() : Promise<Array<NetworkInterface>>;
}

typedef NetworkInterface = {

	/**
	* The underlying name of the adapter. On \*nix,
	* this will typically be "eth0", "wlan0", etc.
	*/
	var name : String;

	/**
	* The available IPv4/6 address.
	*/
	var address : String;

	/**
	* The prefix length
	*/
	var prefixLength : Int;
}
