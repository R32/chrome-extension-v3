package chrome.system;

/**
* Use the `chrome.system.storage` API to query storage device information
* and be notified when a removable storage device is attached and detached.
*
* @chrome-permission system.storage
*/
@:native("chrome.system.storage")
extern class Storage {
	/**
	* Fired when a new removable storage is attached to the system.
	*/
	static final onAttached : Event<StorageUnitInfo->Void>;

	/**
	* Fired when a removable storage is detached from the system.
	*/
	static final onDetached : Event<(id : String)->Void>;

	/**
	* Get the storage information from the system.
	* The argument passed to the callback is an array of StorageUnitInfo objects.
	*/
	overload static function getInfo( callback : (Array<StorageUnitInfo>)->Void ) : Void;
	overload static function getInfo() : Promise<StorageUnitInfo>;

	/**
	* Ejects a removable storage device.
	*/
	overload static function ejectDevice( id : String, callback : EjectDeviceResultCode->Void ) : Void;
	overload static function ejectDevice( id : String ) : Promise<EjectDeviceResultCode>;

	/**
	* Get the available capacity of a specified `id` storage device.
	* The `id` is the transient device ID from StorageUnitInfo.
	*/
	overload static function getAvailableCapacity( id : String, callback : StorageAvailableCapacityInfo->Void ) : Void;
	overload static function getAvailableCapacity( id : String ) : Promise<StorageAvailableCapacityInfo>;
}

/**
* @chrome-enum "fixed" The storage has fixed media, e.g. hard disk or SSD.
* @chrome-enum "removable" The storage is removable, e.g. USB flash drive.
* @chrome-enum "unknown" The storage type is unknown.
*/
extern enum abstract StorageUnitType(String) to String {
	var FIXED = "fixed";
	var REMOVABLE = "removable";
	var UNKNOWN = "unknown";
}

typedef StorageUnitInfo = {
	/**
	* The transient ID that uniquely identifies the storage device.
	* This ID will be persistent within the same run of a single application.
	* It will not be a persistent identifier between different runs of
	* an application, or between different applications.
	*/
	var id : String;

	/**
	* The name of the storage unit.
	*/
	var name : String;

	/**
	* The media type of the storage unit.
	*/
	var type : StorageUnitType;

	/**
	* The total amount of the storage space, in bytes.
	*/
	var capacity : Float;
}

typedef StorageAvailableCapacityInfo = {
	/**
	* A copied `id` of getAvailableCapacity function parameter `id`.
	*/
	var id : String;

	/**
	* The available capacity of the storage device, in bytes.
	*/
	var availableCapacity : Float;
}

/**
* @chrome-enum "success" The ejection command is successful -- the application can prompt the user to remove the device.
* @chrome-enum "in\_use" The device is in use by another application. The ejection did not succeed; the user should not remove the device until the other application is done with the device.
* @chrome-enum "no\_such\_device" There is no such device known.
* @chrome-enum "failure" The ejection command failed.
*/
extern enum abstract EjectDeviceResultCode(String) to String {
	var SUCCESS = "success";
	var IN_USE = "in_use";
	var NO_SUCH_DEVICE = "no_such_device";
	var FAILURE = "failure";
}
