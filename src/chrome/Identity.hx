package chrome;

/**
* Use the `chrome.identity` API to get OAuth2 access tokens.
*
* @chrome-permission identity
*/
@:native("chrome.identity")
extern class Identity {
	/**
	* Fired when signin state changes for an account on the user's profile.
	*/
	static final onSignInChanged : Event<(account : AccountInfo, signedIn : Bool)->Void>;

	/**
	* Retrieves a list of AccountInfo objects describing the accounts present on the profile.
	*
	* `getAccounts` is only supported on dev channel.
	*/
	overload static function getAccounts( callback : (Array<AccountInfo>)->Void ) : Void;
	overload static function getAccounts() : Promise<Array<AccountInfo>>;

	/**
	* Gets an OAuth2 access token using the client ID and scopes specified in the
	* [`oauth2` section of manifest.json](https://developer.chrome.com/docs/extensions/app_identity#update_manifest).
	*
	* The Identity API caches access tokens in memory, so it's ok to call
	* `getAuthToken` non-interactively any time a token is required.
	* The token cache automatically handles expiration.
	*
	* For a good user experience it is important interactive token requests
	* are initiated by UI in your app explaining what the authorization is for.
	* Failing to do this will cause your users to get authorization requests,
	* or Chrome sign in screens if they are not signed in, with with no context.
	* In particular, do not use `getAuthToken` interactively when your app is first launched.
	*
	* Note: When called with a callback, instead of returning an object
	* this function will return the two properties as separate arguments
	* passed to the callback.
	*
	* @param details Token options.
	* @param callback Called with an OAuth2 access token as specified by the manifest,
	* or undefined if there was an error. The `grantedScopes` parameter is populated
	* since Chrome 87. When available, this parameter contains the list of
	* granted scopes corresponding with the returned token.
	*/
	overload static function getAuthToken( callback : GetAuthTokenResult->Void ) : Void;
	overload static function getAuthToken( details : TokenDetails, callback : GetAuthTokenResult->Void ) : Void;
	overload static function getAuthToken( ?details : TokenDetails ) : Promise<GetAuthTokenResult>;

	/**
	* Retrieves email address and obfuscated gaia id of the user signed into a profile.
	*
	* Requires the `identity.email` manifest permission. Otherwise, returns an empty result.
	*
	* This API is different from identity.getAccounts in two ways.
	* The information returned is available offline, and it only applies to
	* the primary account for the profile.
	*
	* @param details Profile options.
	* @param callback Called with the `ProfileUserInfo` of the primary Chrome account,
	* of an empty `ProfileUserInfo` if the account with given `details` doesn't exist.
	*/
	overload static function getProfileUserInfo( callback : ProfileUserInfo->Void ) : Void;
	overload static function getProfileUserInfo( details : ProfileDetails, callback : ProfileUserInfo->Void ) : Void;
	overload static function getProfileUserInfo( ?details : ProfileDetails ) : Promise<ProfileUserInfo>;

	/**
	* Removes an OAuth2 access token from the Identity API's token cache.
	*
	* If an access token is discovered to be invalid, it should be passed
	* to removeCachedAuthToken to remove it from the cache.
	* The app may then retrieve a fresh token with `getAuthToken`.
	*
	* @param details Token information.
	* @param callback Called when the token has been removed from the cache.
	*/
	overload static function removeCachedAuthToken( details : InvalidTokenDetails, callback : ()->Void ) : Void;
	overload static function removeCachedAuthToken( details : InvalidTokenDetails ) : Promise<Void>;

	/**
	* Resets the state of the Identity API:
	*
	* *   Removes all OAuth2 access tokens from the token cache
	* *   Removes user's account preferences
	* *   De-authorizes the user from all auth flows
	*
	* @param callback Called when the state has been cleared.
	* @since Chrome 87
	*/
	overload static function clearAllCachedAuthTokens( callback : ()->Void ) : Void;
	overload static function clearAllCachedAuthTokens() : Promise<Void>;

	/**
	* Starts an auth flow at the specified URL.
	*
	* This method enables auth flows with non-Google identity providers
	* by launching a web view and navigating it to the first URL
	* in the provider's auth flow. When the provider redirects to a URL matching
	* the pattern `https://<app-id>.chromiumapp.org/*`, the window will close,
	* and the final redirect URL will be passed to the `callback` function.
	*
	* For a good user experience it is important interactive auth flows
	* are initiated by UI in your app explaining what the authorization is for.
	* Failing to do this will cause your users to get authorization requests
	* with no context. In particular, do not launch an interactive auth flow
	* when your app is first launched.
	*
	* @param details WebAuth flow options.
	* @param callback Called with the URL redirected back to your application.
	*/
	overload static function launchWebAuthFlow( details : WebAuthFlowDetails, callback : (?responseUrl : String)->Void ) : Void;
	overload static function launchWebAuthFlow( details : WebAuthFlowDetails ) : Promise<String>;

	/**
	* Generates a redirect URL to be used in `launchWebAuthFlow`.
	*
	* The generated URLs match the pattern `https://<app-id>.chromiumapp.org/*`.
	*
	* @param path The path appended to the end of the generated URL.
	*/
	static function getRedirectURL( ?path : String ) : String;
}

typedef AccountInfo = {
	/**
	* A unique identifier for the account. This ID will not change for the lifetime of the account.
	*/
	var id : String;
}

/**
* @chrome-enum "SYNC" Sync is enabled for the primary account.
* @chrome-enum "ANY" Any primary account, if exists.
* @since Chrome 84
*/
extern enum abstract AccountStatus(String) to String {
	var SYNC = "SYNC";
	var ANY = "ANY";
}

/**
* @since Chrome 84
*/
typedef ProfileDetails = {
	/**
	* A status of the primary account signed into a profile whose `ProfileUserInfo`
	* should be returned. Defaults to `SYNC` account status.
	*/
	var ?accountStatus : AccountStatus;
}

typedef ProfileUserInfo = {

	/**
	* An email address for the user account signed into the current profile. Empty if the user is not signed in or the `identity.email` manifest permission is not specified.
	*/
	var email : String;

	/**
	* A unique identifier for the account. This ID will not change for the lifetime of the account. Empty if the user is not signed in or (in M41+) the `identity.email` manifest permission is not specified.
	*/
	var id : String;
}

typedef TokenDetails = {

	/**
	* Fetching a token may require the user to sign-in to Chrome,
	* or approve the application's requested scopes. If the interactive flag is `true`,
	* `getAuthToken` will prompt the user as necessary. When the flag is `false` or omitted,
	* `getAuthToken` will return failure any time a prompt would be required.
	*/
	var ?interactive : Bool;

	/**
	* The account ID whose token should be returned. If not specified,
	* the function will use an account from the Chrome profile:
	* the Sync account if there is one, or otherwise the first Google web account.
	*/
	var ?account : AccountInfo;

	/**
	* A list of OAuth2 scopes to request.
	*
	* When the `scopes` field is present, it overrides the list of scopes
	* specified in manifest.json.
	*/
	var ?scopes : Array<String>;

	/**
	* The `enableGranularPermissions` flag allows extensions to opt-in early
	* to the granular permissions consent screen, in which requested permissions
	* are granted or denied individually.
	*
	* @since Chrome 87
	*/
	var ?enableGranularPermissions : Bool;
}

typedef InvalidTokenDetails = {

	/**
	* The specific token that should be removed from the cache.
	*/
	var token : String;
}

typedef WebAuthFlowDetails = {

	/**
	* The URL that initiates the auth flow.
	*/
	var url : String;

	/**
	* Whether to launch auth flow in interactive mode.
	*
	* Since some auth flows may immediately redirect to a result URL, `launchWebAuthFlow` hides its web view until the first navigation either redirects to the final URL, or finishes loading a page meant to be displayed.
	*
	* If the interactive flag is `true`, the window will be displayed when a page load completes. If the flag is `false` or omitted, `launchWebAuthFlow` will return with an error if the initial navigation does not complete the flow.
	*/
	var ?interactive : Bool;
}


/**
* @since Chrome 105
*/
typedef GetAuthTokenResult = {

	/**
	* The specific token associated with the request.
	*/
	var ?token : String;

	/**
	* A list of OAuth2 scopes granted to the extension.
	*/
	var ?grantedScopes : Array<String>;
}
