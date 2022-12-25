package chrome;

/**
* This API provides programmatic access to the user interface elements of Chrome.
* This includes everything in the web view, and optionally Chrome's full user interface.
*
* @since Chrome 67
*/
typedef Automation = EitherType<Bool, {
	/**
	* Whether to request permission to the whole ChromeOS desktop.
	* If granted, this gives the extension access to every aspect of the desktop,
	* and every site and app. If this permission is requested,
	* all other permissions are implicitly included and do not need
	* to be requested separately.
	*/
	?desktop : Bool,

	/**
	* A list of URL patterns for which this extension may request an automation tree.
	* If not specified, automation permission will be granted for the sites
	* for which the extension has a [host permission](https://developer.chrome.com/docs/extensions/declare_permissions#host-permissions) or [activeTab permission](https://developer.chrome.com/docs/extensions/declare_permissions#activeTab)).
	*/
	?matches : Array<String>,

	/**
	* Whether the extension is allowed interactive access (true) or
	* read-only access (false; default) to the automation tree.
	*/
	?interact : Bool,
}>;

/**
 * The `content_capabilities` manifest entry allows an extension to grant
 * certain additional capabilities to web contents whose locations match
 * a given set of URL patterns.
 */
typedef ContentCapabilities = {
	/**
	* The set of URL patterns to match against.
	* If any of the given patterns match a URL,
	* its contents will be granted the specified capabilities.
	*/
	var matches : Array<String>;

	/**
	* The set of capabilities to grant matched contents.
	* This is currently limited to `clipboardRead`, `clipboardWrite`,
	* and `unlimitedStorage`.
	*/
	var permissions : Array<String>;
}

typedef ExternallyConnectable = {

	/**
	* The IDs of extensions or apps that are allowed to connect.
	* If left empty or unspecified, no extensions or apps can connect.
	*
	* The wildcard `"*"` will allow all extensions and apps to connect.
	*/
	var ?ids : Array<String>;

	/**
	* The URL patterns for _web pages_ that are allowed to connect.
	* _This does not affect content scripts._ If left empty or unspecified,
	* no web pages can connect.
	*
	* Patterns cannot include wildcard domains nor subdomains of
	* [(effective) top level domains](https://publicsuffix.org/list/);
	* `*://google.com/*` and `http://*.chromium.org/*` are valid,
	* while `<all_urls>`, `http://*\/*`, `*://*.com/*`,
	* and even `http://*.appspot.com/*` are not.
	*/
	var ?matches : Array<String>;

	/**
	* If `true`, messages sent via {@link runtime.connect} or
	* {@link runtime.sendMessage} will set {@link runtime.MessageSender.tlsChannelId}
	* if those methods request it to be. If `false`,
	* {@link runtime.MessageSender.tlsChannelId} will never be set under any circumstance.
	*/
	var ?accepts_tls_channel_id : Bool;
}

/**
* The `options_ui` manifest property declares how the options page should be displayed.
*/
typedef OptionsUI = {

	/**
	* The path to your options page, relative to your extension's root.
	*/
	var page : String;

	/**
	* If `true`, a Chrome user agent stylesheet will be applied to your options page.
	* The default value is `false`. We do not recommend you enable it as
	* it no longer results in a consistent UI with Chrome.
	* This option will be removed in Manifest V3.
	*/
	@:deprecated
	var ?chrome_style : Bool;

	/**
	* If `true`, your extension's options page will be opened in a new tab
	* rather than embedded in _chrome://extensions_. The default is `false`,
	* and we recommend that you don't change it.
	*
	* **This is only useful to delay the inevitable deprecation of the old options UI!**
	* It will be removed soon, so try not to use it. It will break.
	*/
	@:deprecated
	var ?open_in_tab : Bool;
}

/**
* A single string or a list of strings representing host:port patterns.
*/
typedef SocketHostPatterns = EitherType<String, Array<String>>;

/**
* The `sockets` manifest property declares which sockets operations an app can issue.
*/
typedef Sockets = {
	/**
	* The `udp` manifest property declares which sockets.udp operations an app can issue.
	*/
	var ?udp : {
		/**
		* The host:port pattern for `bind` operations.
		*/
		?bind : SocketHostPatterns,

		/**
		* The host:port pattern for `send` operations.
		*/
		?send : SocketHostPatterns,

		/**
		* The host:port pattern for `joinGroup` operations.
		*/
		?multicastMembership : SocketHostPatterns,
	};
	/**
	* The `tcp` manifest property declares which sockets.tcp operations an app can issue.
	*/
	var ?tcp : {
		/**
		* The host:port pattern for `connect` operations.
		*/
		?connect : SocketHostPatterns,
	};

	/**
	* The `tcpServer` manifest property declares which sockets.tcpServer operations an app can issue.
	*/
	var ?tcpServer : {
		/**
		* The host:port pattern for `listen` operations.
		*/
		?listen : SocketHostPatterns,
	};
}

/**
* The `bluetooth` manifest property give permission to an app to use the {@link bluetooth} API.
* A list of UUIDs can be optionally specified to enable communication with devices.
*/
typedef Bluetooth = {
	/**
	* The `uuids` manifest property declares the list of protocols,
	* profiles and services that an app can communicate using.
	*/
	var ?uuids : Array<String>;

	/**
	* If `true`, gives permission to an app to use the {@link bluetoothSocket} API
	*/
	var ?socket : Bool;

	/**
	* If `true`, gives permission to an app to use the {@link bluetoothLowEnergy} API
	*/
	var ?low_energy : Bool;

	/**
	* If `true`, gives permission to an app to use the advertisement functions
	* in the {@link bluetoothLowEnergy} API
	*
	* @since Chrome 44
	*/
	var ?peripheral : Bool;
}

    /**
     * The `usb_printers` manifest property lists the USB printers supported by an app implementing the {@link printerProvider} API.
     *
     * @since Chrome 44
     */
typedef UsbPrinters = {

	/**
	* A list of {@link usb.DeviceFilter USB device filters} matching supported devices. A device only needs to match one of the provided filters. A `vendorId` is required and only one of `productId` or `interfaceClass` may be provided.
	*/
	var filters : Array<{
		/**
		* USB vendor ID of matching devices
		*/
		vendorId : Int,

		/**
		* USB product ID of matching devices
		*/
		?productId : Int,

		/**
		* USB interface class implemented by any interface of a matching device.
		*/
		?interfaceClass : Int,

		/**
		* USB interface sub-class implemented by the interface matching {@link interfaceClass}.
		*/
		?interfaceSubclass : Int,

		/**
		* USB interface protocol implemented by the interface matching {@link interfaceClass} and {@link interfaceSubclass}.
		*/
		?interfaceProtocol : Int,
	}>;
}

/**
* The `kiosk_secondary_apps` manifest property lists the secondary kiosk apps
* to be deployed by the primary kiosk app.
*
* @since Chrome 47
*/
typedef KioskSecondaryApps = Array<{
	/**
	* ID of secondary kiosk app
	*/
	id : String,
	/**
	* Whether the secondary app should be enabled when kiosk app is launched.
	* If true, the app will be enabled before the kiosk app launch;
	* if false the app will be disabled before the kiosk app launch;
	* if not set, the app's enabled state will not be changed during the kiosk app launch.
	* The ${ref:management} API can be used to later change the secondary app state.
	*
	* @since Chrome 66
	*/
	?enabled_on_launch : Bool,
}>;
