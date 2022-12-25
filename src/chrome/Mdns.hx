package chrome;

/**
* Use the `chrome.mdns` API to discover services over mDNS.
* This comprises a subset of the features of the NSD spec: http://www.w3.org/TR/discovery-api/
*
* @alpha
* @chrome-permission mdns
* @chrome-channel dev
*/
@:native("chrome.mdns")
extern class Mdns {
	/**
	* The maximum number of service instances that will be included in onServiceList events. If more instances are available, they may be truncated from the onServiceList event.
	*/
	static inline var MAX_SERVICE_INSTANCES_PER_EVENT = 2048;

	/**
	* Event fired to inform clients of the current complete set of known
	* available services. Clients should only need to store the list from the
	* most recent event. The service type that the extension is interested in
	* discovering should be specified as the event filter with the 'serviceType' key.
	* Not specifying an event filter will not start any discovery listeners.
	*/
	static final onServiceList: Event<(Array<MDnsService>)->Void>;

	/**
	* Immediately issues a multicast DNS query for all service types.
	* `callback` is invoked immediately. At a later time, queries will be sent,
	* and any service events will be fired.
	*
	* @param callback Callback invoked after ForceDiscovery() has started.
	*/
	overload static function forceDiscovery( callback : ()->Void ) : Void;
	overload static function forceDiscovery() : Promise<Void>;
}

typedef MDnsService = {

	/**
	* The service name of an mDNS advertised service, ..
	*/
	var serviceName : String;

	/**
	* The host:port pair of an mDNS advertised service.
	*/
	var serviceHostPort : String;

	/**
	* The IP address of an mDNS advertised service.
	*/
	var ipAddress : String;

	/**
	* Metadata for an mDNS advertised service.
	*/
	var serviceData : Array<String>;
}
