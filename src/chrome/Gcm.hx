package chrome;

/**
* Use `chrome.gcm` to enable apps and extensions to send and
* receive messages through [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/) (FCM).
*
* @chrome-permission gcm
*/
@:native("chrome.gcm")
extern class Gcm {
	/**
	* The maximum size (in bytes) of all key/value pairs in a message.
	*/
	static inline var MAX_MESSAGE_SIZE = 4096;

	/**
	* Fired when a message is received through FCM.
	*/
	static final onMessage : Event<{
		/**
		* The message data.
		*/
		data : Dynamic<String>,

		/**
		* The sender who issued the message.
		*/
		?from : String,

		/**
		* The collapse key of a message. See the [Non-collapsible and collapsible messages](https://firebase.google.com/docs/cloud-messaging/concept-options#collapsible_and_non-collapsible_messages) for details.
		*/
		?collapseKey : String,
	}->Void> ;

	/**
	* Fired when a FCM server had to delete messages sent by an app server to the application.
	* See [Lifetime of a message](https://firebase.google.com/docs/cloud-messaging/concept-options#lifetime) for details on handling this event.
	*/
	static final onMessagesDeleted : Event<()->Void>;

	/**
	* Fired when it was not possible to send a message to the FCM server.
	*/
	static final onSendError : Event<{
		/**
		* The error message describing the problem.
		*/
		errorMessage: String,

		/**
		* The ID of the message with this error, if error is related to a specific message.
		*/
		?messageId : String,

		/**
		* Additional details related to the error, when available.
		*/
		details : Dynamic<String>,
	}->Void>;

	/**
	* Registers the application with FCM. The registration ID will be returned by the `callback`.
	* If `register` is called again with the same list of `senderIds`,
	* the same registration ID will be returned.
	*
	* @param senderIds A list of server IDs that are allowed to send messages to the application.
	* It should contain at least one and no more than 100 sender IDs.
	* @param callback Function called when registration completes.
	* It should check {@link runtime.lastError} for error when `registrationId` is empty.
	*/
	static function register( senderIds : Array<String>, callback : (registrationId : String)->Void ) : Void;

	/**
	* Unregisters the application from FCM.
	*
	* @param callback A function called after the unregistration completes.
	* Unregistration was successful if {@link runtime.lastError} is not set.
	*/
	static function unregister( callback : ()->Void ) : Void;

	/**
	* Sends a message according to its contents.
	*
	* @param message A message to send to the other party via FCM.
	* @param callback A function called after the message is successfully queued for sending.
	* {@link runtime.lastError} should be checked, to ensure a message was sent without problems.
	*/
	static function send(
		message : {
			/**
			* The ID of the server to send the message to as assigned by
			* [Google API Console](https://console.cloud.google.com/apis/dashboard).
			*/
			destinationId : String,
			/**
			* The ID of the message. It must be unique for each message in scope of the applications.
			* See the [Cloud Messaging documentation](https://developer.chrome.com/docs/extensions/cloudMessaging#send_messages) for advice for picking and handling an ID.
			*/
			messageId : String,
			/**
			* Time-to-live of the message in seconds. If it is not possible to
			* send the message within that time, an onSendError event will be raised.
			* A time-to-live of 0 indicates that the message should be sent immediately
			* or fail if it's not possible. The default value of time-to-live is 86,
			* 400 seconds (1 day) and the maximum value is 2,419,200 seconds (28 days).
			*/
			?timeToLive : Int,
			/**
			* Message data to send to the server. Case-insensitive `goog.`
			* and `google`, as well as case-sensitive `collapse_key` are disallowed
			* as key prefixes. Sum of all key/value pairs should not exceed {@link gcm.MAX_MESSAGE_SIZE}.
			*/
			data : Dynamic<String>,
		},
			/**
			* @param messageId The ID of the message that the callback was issued for.
			*/
		callback : (messageId : String)->Void
	) : Void;
}
