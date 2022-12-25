package chrome;

/**
* Use the `chrome.cookies` API to query and modify cookies, and to be notified when they change.
*
* @chrome-permission cookies
*/
@:native("chrome.cookies")
extern class Cookies {

	/**
	* Fired when a cookie is set or removed. As a special case,
	* note that updating a cookie's properties is implemented as a two step process:
	* the cookie to be updated is first removed entirely, generating a notification
	* with "cause" of "overwrite" . Afterwards, a new cookie is written with
	* the updated values, generating a second notification with "cause" "explicit".
	*/
	static final onChanged : Event<{emoved : Bool, cookie : Cookie, cause : OnChangedCause}->Void>;

	/**
	* Retrieves information about a single cookie.
	* If more than one cookie of the same name exists for the given URL,
	* the one with the longest path will be returned.
	* For cookies with the same path length,
	* the cookie with the earliest creation time will be returned.
	*/
	overload static function get( details: CookieDetails, callback : ?Cookie->Void ) : Void;
	overload static function get( details: CookieDetails ) : Promise<Cookie>;

	/**
	* Retrieves all cookies from a single cookie store that match the given information. The cookies returned will be sorted, with those with the longest path first. If multiple cookies have the same path length, those with the earliest creation time will be first.
	*
	* @param details Information to filter the cookies being retrieved.
	*/
	overload static function getAll( details: AllDetails, callback : Array<Cookie>->Void ) : Void;
	overload static function getAll( details: AllDetails ) : Promise<Array<Cookie>>;

	/**
	* Sets a cookie with the given cookie data; may overwrite equivalent cookies if they exist.
	*
	* @param details Details about the cookie being set.
	*/
	overload static function set( details: SetDetails, callback : ?Cookie->Void ) : Void;
	overload static function set( details: SetDetails ) : Promise<Cookie>;

	/**
	* Deletes a cookie by name.
	*/
	overload static function remove( details: CookieDetails, callback : ?CookieDetails->Void ) : Void;
	overload static function remove( details: CookieDetails ) : Promise<CookieDetails>;

	/**
	* Lists all existing cookie stores.
	*/
	overload static function getAllCookieStores( callback : Array<CookieDetails>->Void ) : Void;
	overload static function getAllCookieStores() : Promise<Array<CookieDetails>>;
}

private typedef AllDetails = {
	/**
	* Restricts the retrieved cookies to those that would match the given URL.
	*/
	var ?url : String;

	/**
	* Filters the cookies by name.
	*/
	var ?name : String;

	/**
	* Restricts the retrieved cookies to those whose domains match or are subdomains of this one.
	*/
	var ?domain : String;

	/**
	* Restricts the retrieved cookies to those whose path exactly matches this string.
	*/
	var ?path : String;

	/**
	* Filters the cookies by their Secure property.
	*/
	var ?secure : Bool;

	/**
	* Filters out session vs. persistent cookies.
	*/
	var ?session : Bool;

	/**
	* The cookie store to retrieve cookies from. If omitted,
	* the current execution context's cookie store will be used.
	*/
	var ?storeId : String;
}

private typedef SetDetails = {
	/**
	* The request-URI to associate with the setting of the cookie. This value can affect the default domain and path values of the created cookie. If host permissions for this URL are not specified in the manifest file, the API call will fail.
	*/
	var url : String;

	/**
	* The name of the cookie. Empty by default if omitted.
	*/
	var ?name : String;

	/**
	* The value of the cookie. Empty by default if omitted.
	*/
	var ?value : String;

	/**
	* The domain of the cookie. If omitted, the cookie becomes a host-only cookie.
	*/
	var ?domain : String;

	/**
	* The path of the cookie. Defaults to the path portion of the url parameter.
	*/
	var ?path : String;

	/**
	* Whether the cookie should be marked as Secure. Defaults to false.
	*/
	var ?secure : Bool;

	/**
	* Whether the cookie should be marked as HttpOnly. Defaults to false.
	*/
	var ?httpOnly : Bool;

	/**
	* The cookie's same-site status. Defaults to "unspecified", i.e., if omitted, the cookie is set without specifying a SameSite attribute.
	*
	* @since Chrome 51
	*/
	var ?sameSite : SameSiteStatus;

	/**
	* The expiration date of the cookie as the number of seconds since the UNIX epoch. If omitted, the cookie becomes a session cookie.
	*/
	var ?expirationDate : Float;

	/**
	* The ID of the cookie store in which to set the cookie. By default, the cookie is set in the current execution context's cookie store.
	*/
	var ?storeId : String;
}

/**
* A cookie's 'SameSite' state (https://tools.ietf.org/html/draft-west-first-party-cookies).
* 'no\_restriction' corresponds to a cookie set with 'SameSite=None',
* 'lax' to 'SameSite=Lax', and 'strict' to 'SameSite=Strict'. 'unspecified'
* corresponds to a cookie set without the SameSite attribute.
*
* @since Chrome 51
*/
extern enum abstract SameSiteStatus(String) to String {
	var NO_RESTRICTION = "no_restriction";
	var LAX = "lax";
	var STRICT = "strict";
	var UNSPECIFIED = "unspecified";
}

/**
* Represents information about an HTTP cookie.
*/
typedef Cookie = {
	/**
	* The name of the cookie.
	*/
	var name : String;

	/**
	* The value of the cookie.
	*/
	var value : String;

	/**
	* The domain of the cookie (e.g. "www.google.com", "example.com").
	*/
	var domain : String;

	/**
	* True if the cookie is a host-only cookie
	* (i.e. a request's host must exactly match the domain of the cookie).
	*/
	var hostOnly : Bool;

	/**
	* The path of the cookie.
	*/
	var path : String;

	/**
	* True if the cookie is marked as Secure
	* (i.e. its scope is limited to secure channels, typically HTTPS).
	*/
	var secure : Bool;

	/**
	* True if the cookie is marked as HttpOnly
	* (i.e. the cookie is inaccessible to client-side scripts).
	*/
	var httpOnly : Bool;

	/**
	* The cookie's same-site status
	* (i.e. whether the cookie is sent with cross-site requests).
	*
	* @since Chrome 51
	*/
	var sameSite : SameSiteStatus;

	/**
	* True if the cookie is a session cookie,
	* as opposed to a persistent cookie with an expiration date.
	*/
	var session : Bool;

	/**
	* The expiration date of the cookie as the number of seconds since the UNIX epoch.
	* Not provided for session cookies.
	*/
	var ?expirationDate : Float;

	/**
	* The ID of the cookie store containing this cookie,
	* as provided in getAllCookieStores().
	*/
	var storeId : String;
}


/**
* Represents a cookie store in the browser. An incognito mode window,
* for instance, uses a separate cookie store from a non-incognito window.
*/
typedef CookieStore = {

	/**
	* The unique identifier for the cookie store.
	*/
	var id : String;

	/**
	* Identifiers of all the browser tabs that share this cookie store.
	*/
	var tabIds : Array<Int>;
}

/**
* The underlying reason behind the cookie's change. If a cookie was inserted,
* or removed via an explicit call to "chrome.cookies.remove", "cause" will be "explicit".
* If a cookie was automatically removed due to expiry, "cause" will be "expired".
* If a cookie was removed due to being overwritten with an already-expired expiration date,
* "cause" will be set to "expired\_overwrite". If a cookie was automatically
* removed due to garbage collection, "cause" will be "evicted".
* If a cookie was automatically removed due to a "set" call that overwrote it,
* "cause" will be "overwrite". Plan your response accordingly.
*
* @since Chrome 44
*/
extern enum abstract OnChangedCause(String) to String {
	var EVICTED = "evicted";
	var EXPIRED = "expired";
	var EXPLICIT = "explicit";
	var EXPIRED_OVERWRITE = "expired_overwrite";
	var OVERWRITE = "overwrite";
}

/**
* Details to identify the cookie.
*
* @since Chrome 88
*/
typedef CookieDetails = {

	/**
	* The URL with which the cookie to access is associated.
	* This argument may be a full URL, in which case any data following the URL path
	* (e.g. the query string) is simply ignored. If host permissions for this URL
	* are not specified in the manifest file, the API call will fail.
	*/
	var url: String;

	/**
	* The name of the cookie to access.
	*/
	var name: String;

	/**
	* The ID of the cookie store in which to look for the cookie. By default,
	* the current execution context's cookie store will be used.
	*/
	var ?storeId : String;
}

