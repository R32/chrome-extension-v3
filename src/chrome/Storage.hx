package chrome;

/**
* Use the `chrome.storage` API to store, retrieve, and track changes to user data.
*
* @chrome-permission storage
*/
@:native("chrome.storage")
extern class Storage {
	/**
	* Items in the `sync` storage area are synced using Chrome Sync.
	*/
	static final sync : StorageAreaSync;

	/**
	* Items in the `local` storage area are local to each machine.
	*/
	static final local : StorageAreaLocal;

	/**
	* Items in the `managed` storage area are set by the domain administrator,
	* and are read-only for the extension; trying to modify this namespace results in an error.
	*/
	static final managed : StorageArea;

	/**
	* Items in the `session` storage area are stored in-memory and will not be persisted to disk.
	*
	* @since Chrome 102
	* @chrome-min-manifest MV3
	*/
	static final session : StorageAreaLocal;

	/**
	* Fired when one or more items change.
	*/
	static final onChanged : Event<(changes : Dynamic<StorageChange>, areaName : String)->Void>;
}

/**
* The storage area's access level.
*
* @since Chrome 102
*/
extern enum abstract AccessLevel(String) to String {
	var TRUSTED_CONTEXTS = "TRUSTED_CONTEXTS";
	var TRUSTED_AND_UNTRUSTED_CONTEXTS = "TRUSTED_AND_UNTRUSTED_CONTEXTS";
}

typedef StorageChange = {

	/**
	* The old value of the item, if there was an old value.
	*/
	var ?oldValue : Any;

	/**
	* The new value of the item, if there is a new value.
	*/
	var ?newValue : Any;
}

extern class StorageArea {
	/**
	* Fired when one or more items change.
	*
	* @since Chrome 73
	*/
	final onChanged : Event<(Dynamic<StorageChange>)->Void>;

	/**
	* Gets one or more items from storage.
	*
	* @param keys A single key to get, list of keys to get,
	* or a dictionary specifying default values (see description of the object).
	* An empty list or object will return an empty result object.
	* Pass in `null` to get the entire contents of storage.
	* @param callback Callback with storage items,
	* or on failure (in which case {@link runtime.lastError} will be set).
	*/
	function get( keys : Keys, callback : Values->Void ) : Void;

	/**
	* Gets the amount of space (in bytes) being used by one or more items.
	*
	* @param keys A single key or list of keys to get the total usage for.
	* An empty list will return 0. Pass in `null` to get the total usage of all of storage.
	* @param callback Callback with the amount of space being used by storage,
	* or on failure (in which case {@link runtime.lastError} will be set).
	*/
	overload function getBytesInUse( keys : Keys, callback : (bytesInUse : Int)->Void ) : Void;
	overload function getBytesInUse( keys : Keys ) : Promise<Int>;

	/**
	* Sets multiple items.
	*
	* @param items An object which gives each key/value pair to update storage with.
	* Any other key/value pairs in storage will not be affected.
	* Primitive values such as numbers will serialize as expected.
	* Values with a `typeof` `"object"` and `"function"` will typically serialize to `{}`,
	* with the exception of `Array` (serializes as expected),
	* `Date`, and `Regex` (serialize using their `String` representation).
	* @param callback Callback on success, or on failure
	* (in which case {@link runtime.lastError} will be set).
	*/
	overload function set( items : Values, callback : ()->Void ) : Void;
	overload function set( items : Values ) : Promise<Void>;

	/**
	* Removes one or more items from storage.
	*
	* @param keys A single key or a list of keys for items to remove.
	* @param callback Callback on success, or on failure
	* (in which case {@link runtime.lastError} will be set).
	*/
	overload function remove( keys : Keys, callback : ()->Void ) : Void;
	overload function remove( keys : Keys ) : Promise<Void>;

	/**
	* Removes all items from storage.
	*
	* @param callback Callback on success, or on failure
	* (in which case {@link runtime.lastError} will be set).
	*/
	overload function clear( callback : ()->Void ) : Void;
	overload function clear() : Promise<Void>;

	/**
	* Sets the desired access level for the storage area. The default will be only trusted contexts.
	*
	* @param callback Callback on success, or on failure
	* (in which case {@link runtime.lastError} will be set).
	* @since Chrome 102
	*/
	overload function setAccessLevel( opt : {accessLevel : AccessLevel}, callback : ()->Void ) : Void;
	overload function setAccessLevel( opt : {accessLevel : AccessLevel} ) : Promise<Void>;
}

private typedef Keys = EitherType<String, Array<String>>;
private typedef Values = Dynamic;

extern class StorageAreaSync extends StorageArea {
	/**
	* The maximum total amount (in bytes) of data that can be stored in sync storage, as measured by the JSON stringification of every value plus every key's length. Updates that would cause this limit to be exceeded fail immediately and set {@link runtime.lastError}.
	*/
	final QUOTA_BYTES : Int;

	/**
	* The maximum size (in bytes) of each individual item in sync storage, as measured by the JSON stringification of its value plus its key length. Updates containing items larger than this limit will fail immediately and set {@link runtime.lastError}.
	*/
	final QUOTA_BYTES_PER_ITEM : Int;

	/**
	* The maximum number of items that can be stored in sync storage. Updates that would cause this limit to be exceeded will fail immediately and set {@link runtime.lastError}.
	*/
	final MAX_ITEMS : Int;

	/**
	* The maximum number of `set`, `remove`, or `clear` operations that can be performed each hour. This is 1 every 2 seconds, a lower ceiling than the short term higher writes-per-minute limit.
	*
	* Updates that would cause this limit to be exceeded fail immediately and set {@link runtime.lastError}.
	*/
	final MAX_WRITE_OPERATIONS_PER_HOUR : Int;

	/**
	* The maximum number of `set`, `remove`, or `clear` operations that can be performed each minute. This is 2 per second, providing higher throughput than writes-per-hour over a shorter period of time.
	*
	* Updates that would cause this limit to be exceeded fail immediately and set {@link runtime.lastError}.
	*/
	final MAX_WRITE_OPERATIONS_PER_MINUTE : Int;

	/**
	* @deprecated The storage.sync API no longer has a sustained write operation quota.
	*/
	final MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE : Int;
}

extern class StorageAreaLocal extends StorageArea {
	final QUOTA_BYTES : Int;
}

