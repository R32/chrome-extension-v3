package chrome;

/**
* Use `chrome.instanceID` to access the Instance ID service.
*
* @since Chrome 44
* @chrome-permission gcm
*/
@:native("chrome.instanceID")
extern class InstanceID {
	/**
	* Fired when all the granted tokens need to be refreshed.
	*/
	static final onTokenRefresh : Event<()->Void>;

	/**
	* Retrieves an identifier for the app instance. The instance ID will be
	* returned by the `callback`. The same ID will be returned as long as
	* the application identity has not been revoked or expired.
	*
	* @param callback Function called when the retrieval completes.
	* It should check {@link runtime.lastError} for error when instanceID is empty.
	*/
	overload static function getID( callback : (instanceID : String)->Void ) : Void;
	overload static function getID() : Promise<String>;

	/**
	* Return a token that allows the authorized entity to access the service defined by scope.
	*
	* @param params Parameters for getToken.
	* @param callback Function called when the retrieval completes.
	* It should check {@link runtime.lastError} for error when token is empty.
	*/
	overload static function getToken( params : TokenParams, callback : (token : String)->Void ) : Void;
	overload static function getToken( params : TokenParams ) : Promise<String>;

	/**
	* Revokes a granted token.
	*
	* @param params Parameters for deleteToken.
	* @param callback Function called when the token deletion completes.
	* The token was revoked successfully if {@link runtime.lastError} is not set.
	*/
	overload static function deleteToken(
		params : {
			/**
			 * The authorized entity that is used to obtain the token.
			 *
			 * @since Chrome 45
			 */
			authorizedEntity : String,
			/**
			 * The scope that is used to obtain the token.
			 *
			 * @since Chrome 45
			 */
			scope : String,
		},
		callback : ()->Void
	) : Void;

	overload static function deleteToken(
		params : {
			authorizedEntity : String,
			scope : String,
		}
	) : Promise<Void>;

	/**
	* Resets the app instance identifier and revokes all tokens associated with it.
	*
	* @param callback Function called when the deletion completes.
	* The instance identifier was revoked successfully if {@link runtime.lastError} is not set.
	*/
	overload static function deleteID( callback : ()->Void ) : Void;
	overload static function deleteID() : Promise<Void>;
}

private typedef TokenParams = {
	/**
	* Identifies the entity that is authorized to access resources associated
	* with this Instance ID. It can be a project ID from
	* [Google developer console](https://code.google.com/apis/console).
	*
	* @since Chrome 45
	*/
	var authorizedEntity : String;

	/**
	* Identifies authorized actions that the authorized entity can take.
	* E.g. for sending GCM messages, `GCM` scope should be used.
	*
	* @since Chrome 45
	*/
	var scope : String;

	/**
	* Allows including a small number of string key/value pairs that will be
	* associated with the token and may be used in processing the request.
	*
	* @deprecated options are deprecated and will be ignored.
	* @since Chrome 45
	* @chrome-deprecated-since Chrome 89
	*/
	var ?options : Dynamic<String>;
}
