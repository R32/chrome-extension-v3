package chrome.system;

/**
* The `chrome.system.memory` API.
*
* @chrome-permission system.memory
*/
@:native("chrome.system.memory")
extern class Memory {
	/**
	* Get physical memory information.
	*/
	overload static function getInfo( callback : MemoryInfo->Void ) : Void;
	overload static function getInfo() : Promise<MemoryInfo>;
}

typedef MemoryInfo = {

	/**
	* The total amount of physical memory capacity, in bytes.
	*/
	var capacity : Float;

	/**
	* The amount of available capacity, in bytes.
	*/
	var availableCapacity : Float;
}
