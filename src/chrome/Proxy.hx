package chrome;

/**
* Use the `chrome.proxy` API to manage Chrome's proxy settings.
* This API relies on the [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
* for getting and setting the proxy configuration.
*
* @chrome-permission proxy
*/
@:native("chrome.proxy")
extern class Proxy {

	/**
	* Proxy settings to be used. The value of this setting is a ProxyConfig object.
	*/
	static final settings : Types.ChromeSetting<ProxyConfig>;

	/**
	* Notifies about proxy errors.
	*/
	static final onProxyError : Event<(
		details : {
			/**
			 * If true, the error was fatal and the network transaction was aborted.
			 * Otherwise, a direct connection is used instead.
			 */
			fatal : Bool,
			/**
			 * The error description.
			 */
			error : String,
			/**
			 * Additional details about the error such as a JavaScript runtime error.
			 */
			details : String,
		}
	)->Void>;
}

/**
* @since Chrome 54
*/
extern enum abstract Scheme(String) to String {
	var HTTP = "http";
	var HTTPS = "https";
	var QUIC = "quic";
	var SOCKS4 = "socks4";
	var SOCKS5 = "socks5";
}

/**
* @since Chrome 54
*/
extern enum abstract Mode(String) to String {
	var DIRECT = "direct";
	var AUTO_DETECT = "auto_detect";
	var PAC_SCRIPT = "pac_script";
	var FIXED_SERVERS = "fixed_servers";
	var SYSTEM = "system";
}

/**
* An object encapsulating a single proxy server's specification.
*/
typedef ProxyServer = {

	/**
	* The scheme (protocol) of the proxy server itself. Defaults to 'http'.
	*/
	var ?scheme : Scheme;

	/**
	* The hostname or IP address of the proxy server. Hostnames must be in ASCII
	* (in Punycode format). IDNA is not supported, yet.
	*/
	var host : String;

	/**
	* The port of the proxy server. Defaults to a port that depends on the scheme.
	*/
	var ?port : Int;
}

/**
* An object encapsulating the set of proxy rules for all protocols.
* Use either 'singleProxy' or (a subset of) 'proxyForHttp', 'proxyForHttps',
* 'proxyForFtp' and 'fallbackProxy'.
*/
typedef ProxyRules = {

	/**
	* The proxy server to be used for all per-URL requests (that is http, https, and ftp).
	*/
	var ?singleProxy : ProxyServer;

	/**
	* The proxy server to be used for HTTP requests.
	*/
	var ?proxyForHttp : ProxyServer;

	/**
	* The proxy server to be used for HTTPS requests.
	*/
	var ?proxyForHttps : ProxyServer;

	/**
	* The proxy server to be used for FTP requests.
	*/
	var ?proxyForFtp : ProxyServer;

	/**
	* The proxy server to be used for everthing else or if any of the specific proxyFor... is not specified.
	*/
	var ?fallbackProxy : ProxyServer;

	/**
	* List of servers to connect to without a proxy server.
	*/
	var ?bypassList : Array<String>;
}

/**
 * An object holding proxy auto-config information.
 * Exactly one of the fields should be non-empty.
 */
typedef PacScript = {

	/**
	* URL of the PAC file to be used.
	*/
	var ?url : String;

	/**
	* A PAC script.
	*/
	var ?data : String;

	/**
	* If true, an invalid PAC script will prevent the network stack from
	* falling back to direct connections. Defaults to false.
	*/
	var ?mandatory : Bool;
}

/**
 * An object encapsulating a complete proxy configuration.
 */
typedef ProxyConfig = {

	/**
	* The proxy rules describing this configuration. Use this for 'fixed\_servers' mode.
	*/
	var ?rules : ProxyRules;

	/**
	* The proxy auto-config (PAC) script for this configuration. Use this for 'pac\_script' mode.
	*/
	var ?pacScript : PacScript;

	/**
	* 'direct' = Never use a proxy
	* 'auto\_detect' = Auto detect proxy settings
	* 'pac\_script' = Use specified PAC script
	* 'fixed\_servers' = Manually specify proxy servers
	* 'system' = Use system proxy settings
	*/
	var mode : Mode;
}
