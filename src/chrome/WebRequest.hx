package chrome;

/**
* Use the `chrome.webRequest` API to observe and analyze traffic
* and to intercept, block, or modify requests in-flight.
*
* @chrome-permission webRequest
*/
@:native("chrome.webRequest")
extern class WebRequest {
	/**
	* The maximum number of times that `handlerBehaviorChanged` can be called
	* per 10 minute sustained interval. `handlerBehaviorChanged` is an
	* expensive function call that shouldn't be called often.
	*/
	static inline var MAX_HANDLER_BEHAVIOR_CHANGED_CALLS_PER_10_MINUTES = 20;

	/**
	* Fired when a request is about to occur.
	*
	* @param callback If "blocking" is specified in the "extraInfoSpec" parameter,
	* the event listener should return an object of this type.
	*/
	static final onBeforeRequest : CustomChromeEvent<(
		callback : EitherType<
			OnBeforeRequestDetails->BlockingResponse,
			OnBeforeRequestDetails->Void
		>,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnBeforeRequestOptions>
	)->Void>;

	/**
	* Fired before sending an HTTP request, once the request headers are available.
	* This may occur after a TCP connection is made to the server, but before any HTTP data is sent.
	*
	* @param callback If "blocking" is specified in the "extraInfoSpec" parameter,
	* the event listener should return an object of this type.
	*/
	static final onBeforeSendHeaders : CustomChromeEvent<(
		callback : EitherType<
			OnBeforeSendHeadersDetails->BlockingResponse,
			OnBeforeSendHeadersDetails->Void
		>,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnBeforeSendHeadersOptions>
	)->Void>;

	/**
	* Fired just before a request is going to be sent to the server (modifications
	* of previous onBeforeSendHeaders callbacks are visible by the time onSendHeaders is fired).
	*/
	static final onSendHeaders : CustomChromeEvent<(
		callback : OnSendHeadersDetails->Void,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnSendHeadersOptions>
	)->Void>;

	/**
	* Fired when HTTP response headers of a request have been received.
	*
	* @param callback If "blocking" is specified in the "extraInfoSpec" parameter,
	* the event listener should return an object of this type.
	*/
	static final onHeadersReceived : CustomChromeEvent<(
		callback : EitherType<
			OnHeadersReceivedDetails->BlockingResponse,
			OnHeadersReceivedDetails->Void
		>,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnHeadersReceivedOptions>
	)->Void>;

	/**
	* Fired when an authentication failure is received. The listener has three
	* options: it can provide authentication credentials, it can cancel the
	* request and display the error page, or it can take no action on the challenge.
	* If bad user credentials are provided, this may be called multiple times
	* for the same request. Note, only one of `'blocking'` or `'asyncBlocking'`
	* modes must be specified in the `extraInfoSpec` parameter.
	*
	* @param asyncCallback Only valid if `'asyncBlocking'` is specified as one of
	* the `OnAuthRequiredOptions`.
	*
	* @param callback If "blocking" is specified in the "extraInfoSpec" parameter,
	* the event listener should return an object of this type.
	*/
	static final onAuthRequired : CustomChromeEvent<(
		callback : EitherType<
			( details : OnAuthRequiredDetails, asyncCallback : BlockingResponse-> Void )->BlockingResponse,
			( details : OnAuthRequiredDetails, asyncCallback : BlockingResponse-> Void )->Void
		>,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnAuthRequiredOptions>
	)->Void>;

	/**
	* Fired when the first byte of the response body is received. For HTTP requests,
	* this means that the status line and response headers are available.
	*/
	static final onResponseStarted : CustomChromeEvent<(
		callback : OnResponseStartedDetails->Void,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnResponseStartedOptions>
	)->Void>;

	/**
	* Fired when a server-initiated redirect is about to occur.
	*/
	static final onBeforeRedirect : CustomChromeEvent<(
		callback : OnBeforeRedirectDetails->Void,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnBeforeRedirectOptions>
	)->Void>;

	/**
	* Fired when a request is completed.
	*/
	static final onCompleted : CustomChromeEvent<(
		callback : OnCompletedDetails->Void,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnCompletedOptions>
	)->Void>;

	static final onErrorOccurred : CustomChromeEvent<(
		callback : OnErrorOccurredDetails->Void,
		filter : RequestFilter,
		?extraInfoSpec : Array<OnErrorOccurredOptions>
	)->Void>;

	/**
	* Fired when an extension's proposed modification to a network request is ignored.
	* This happens in case of conflicts with other extensions.
	*
	* @since Chrome 70
	*/
	static final onActionIgnored : Event<{requestId : String, action : IgnoredActionType}->Void>;

	/**
	* Needs to be called when the behavior of the webRequest handlers
	* has changed to prevent incorrect handling due to caching.
	* This function call is expensive. Don't call it often.
	*/
	static function handlerBehaviorChanged( ?callback : ()->Void ) : Void;

}

private typedef BaseDetails = {
	/**
	* The ID of the request. Request IDs are unique within a browser session.
	* As a result, they could be used to relate different events of the same request.
	*/
	var requestId : String;

	var url : String;

	/**
	* Standard HTTP method.
	*/
	var method : String;

	/**
	* The value 0 indicates that the request happens in the main frame;
	* a positive value indicates the ID of a subframe in which the request happens.
	* If the document of a (sub-)frame is loaded (`type` is `main_frame` or `sub_frame`),
	* `frameId` indicates the ID of this frame, not the ID of the outer frame.
	* Frame IDs are unique within a tab.
	*/
	var frameId : Int;

	/**
	* ID of frame that wraps the frame which sent the request.
	* Set to -1 if no parent frame exists.
	*/
	var parentFrameId : Int;

	/**
	* The UUID of the document making the request.
	*
	* @since Chrome 106
	*/
	var documentId : String;

	/**
	* The UUID of the parent document owning this frame. This is not set if there is no parent.
	*
	* @since Chrome 106
	*/
	var ?parentDocumentId : String;

	/**
	* The lifecycle the document is in.
	*
	* @since Chrome 106
	*/
	var documentLifecycle : ExtensionTypes.DocumentLifecycle;

	/**
	* The type of frame the request occurred in.
	*
	* @since Chrome 106
	*/
	var frameType : ExtensionTypes.FrameType;

	/**
	* The ID of the tab in which the request takes place. Set to -1 if the request isn't related to a tab.
	*/
	var tabId : Int;

	/**
	* How the requested resource will be used.
	*/
	var type : ResourceType;

	/**
	* The origin where the request was initiated. This does not change through redirects. If this is an opaque origin, the string 'null' will be used.
	*
	* @since Chrome 63
	*/
	var ?initiator : String;

	/**
	* The time when this signal is triggered, in milliseconds since the epoch.
	*/
	var timeStamp : Float;
}

private typedef OnBeforeRequestDetails = BaseDetails & {

	/**
	* Contains the HTTP request body data. Only provided if extraInfoSpec contains 'requestBody'.
	*/
	var ?requestBody : {
		/**
		* Errors when obtaining request body data.
		*/
		?error : String,
		/**
		* If the request method is POST and the body is a sequence of
		* key-value pairs encoded in UTF8, encoded as either multipart/form-data,
		* or application/x-www-form-urlencoded, this dictionary is present and
		* for each key contains the list of all values for that key.
		* If the data is of another media type, or if it is malformed,
		* the dictionary is not present. An example value of this dictionary
		* is {'key': \['value1', 'value2'\]}.
		*/
		?formData : Dynamic<Array<FormDataItem>>, //TODO: ts origin is {[name: string]: FormDataItem[]}

		/**
		* If the request method is PUT or POST, and the body is not already parsed
		* in formData, then the unparsed request body elements are contained in this array.
		*/
		?raw : Array<UploadData>,
	};

}

private typedef OnBeforeSendHeadersDetails = BaseDetails & {
	/**
	* The request headers to modify for the request. Only valid if RuleActionType is "modifyHeaders".
	*
	* @since Chrome 86
	*/
	var ?requestHeaders : HttpHeaders;
}

private typedef OnSendHeadersDetails = BaseDetails & {

	var ?requestHeaders : HttpHeaders;

};

private typedef OnHeadersReceivedDetails = BaseDetails & {

	var ?requestHeaders : HttpHeaders;

	/**
	* HTTP status line of the response or the 'HTTP/0.9 200 OK' string for
	* HTTP/0.9 responses (i.e., responses that lack a status line).
	*/
	var statusLine : String;

	/**
	* Standard HTTP status code returned by the server.
	*
	* @since Chrome 43
	*/
	var statusCode : Int;
}

private typedef OnAuthRequiredDetails = BaseDetails & {

	var ?requestHeaders : HttpHeaders;

	var statusLine : String;

	var statusCode : Int;

	/**
	* The authentication scheme, e.g. Basic or Digest.
	*/
	var scheme: String;

	/**
	* The authentication realm provided by the server, if there is one.
	*/
	var ?realm : String;

	/**
	* The server requesting authentication.
	*/
	var challenger: { host: String, port: Int };

	/**
	* True for Proxy-Authenticate, false for WWW-Authenticate.
	*/
	var isProxy : Bool;
}

private typedef OnResponseStartedDetails = BaseDetails & {

	var ?responseHeaders : HttpHeaders;

	var statusCode : Int;

	var statusLine: String;

	/**
	* The server IP address that the request was actually sent to. Note that it may be a literal IPv6 address.
	*/
	var ?ip : String;

	/**
	* Indicates if this response was fetched from disk cache.
	*/
	var fromCache : Bool;
}

private typedef OnBeforeRedirectDetails = BaseDetails & {

	var ?responseHeaders : HttpHeaders;

	var statusCode : Int;

	var statusLine: String;

	var ?ip : String;

	var fromCache : Bool;

	/**
	* The new URL.
	*/
	var redirectUrl: String;
}

private typedef OnCompletedDetails = OnResponseStartedDetails;

private typedef OnErrorOccurredDetails = BaseDetails & {

	var ?ip : String;

	var fromCache : Bool;

	/**
	* The error description. This string is _not_ guaranteed to remain backwards
	* compatible between releases. You must not parse and act based upon its content.
	*/
	var error : String;
}

extern enum abstract ResourceType(String) to String {
	var MAIN_FRAME = "main_frame";
	var SUB_FRAME = "sub_frame";
	var STYLESHEET = "stylesheet";
	var SCRIPT = "script";
	var IMAGE = "image";
	var FONT = "font";
	var OBJECT = "object";
	var XMLHTTPREQUEST = "xmlhttprequest";
	var PING = "ping";
	var CSP_REPORT = "csp_report";
	var MEDIA = "media";
	var WEBSOCKET = "websocket";
	var OTHER = "other";
}

extern enum abstract OnBeforeRequestOptions(String) to String {
	var BLOCKING = "blocking";
	var REQUESTBODY = "requestBody";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnBeforeSendHeadersOptions(String) to String {
	var REQUESTHEADERS = "requestHeaders";
	var BLOCKING = "blocking";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnSendHeadersOptions(String) to String {
	var REQUESTHEADERS = "requestHeaders";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnHeadersReceivedOptions(String) to String {
	var BLOCKING = "blocking";
	var RESPONSEHEADERS = "responseHeaders";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnAuthRequiredOptions(String) to String {
	var RESPONSEHEADERS = "responseHeaders";
	var BLOCKING = "blocking";
	var ASYNCBLOCKING = "asyncBlocking";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnResponseStartedOptions(String) to String {
	var RESPONSEHEADERS = "responseHeaders";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnBeforeRedirectOptions(String) to String {
	var RESPONSEHEADERS = "responseHeaders";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnCompletedOptions(String) to String {
	var RESPONSEHEADERS = "responseHeaders";
	var EXTRAHEADERS = "extraHeaders";
}

extern enum abstract OnErrorOccurredOptions(String) to String {
	var EXTRAHEADERS = "extraHeaders";
}

/**
* An object describing filters to apply to webRequest events.
*/
typedef RequestFilter = {
	/**
	* A list of URLs or URL patterns. Requests that cannot match any of the URLs will be filtered out.
	*/
	var urls: Array<String>;

	/**
	* A list of request types. Requests that cannot match any of the types will be filtered out.
	*/
	var ?types : Array<ResourceType>;

	var ?tabId : Int;

	var ?windowId : Int;
}

/**
* An array of HTTP headers. Each header is represented as a dictionary
* containing the keys `name` and either `value` or `binaryValue`.
*/
typedef HttpHeaders = Array<{
	/**
	* Name of the HTTP header.
	*/
	var name : String;

	/**
	* Value of the HTTP header if it can be represented by UTF-8.
	*/
	var ?value : String;

	/**
	* Value of the HTTP header if it cannot be represented by UTF-8, stored as individual byte values (0..255).
	*/
	var ?binaryValue : Array<Int>;
}>;

/**
* Returns value for event handlers that have the 'blocking' extraInfoSpec applied.
* Allows the event handler to modify network requests.
*/
typedef BlockingResponse = {
	/**
	* If true, the request is cancelled. This prevents the request from being sent.
	* This can be used as a response to the onBeforeRequest, onBeforeSendHeaders,
	* onHeadersReceived and onAuthRequired events.
	*/
	var ?cancel : Bool;

	/**
	* Only used as a response to the onBeforeRequest and onHeadersReceived events.
	* If set, the original request is prevented from being sent/completed and is
	* instead redirected to the given URL. Redirections to non-HTTP schemes
	* such as `data:` are allowed. Redirects initiated by a redirect action use
	* the original request method for the redirect, with one exception: If the
	* redirect is initiated at the onHeadersReceived stage, then the redirect
	* will be issued using the GET method. Redirects from URLs
	* with `ws://` and `wss://` schemes are **ignored**.
	*/
	var ?redirectUrl : String;

	/**
	* Only used as a response to the onBeforeSendHeaders event. If set,
	* the request is made with these request headers instead.
	*/
	var ?requestHeaders : HttpHeaders;

	/**
	* Only used as a response to the onHeadersReceived event. If set,
	* the server is assumed to have responded with these response headers instead.
	* Only return `responseHeaders` if you really want to modify the headers
	* in order to limit the number of conflicts
	* (only one extension may modify `responseHeaders` for each request).
	*/
	var ?responseHeaders : HttpHeaders;

	/**
	* Only used as a response to the onAuthRequired event. If set,
	* the request is made using the supplied credentials.
	*/
	var ?authCredentials : {username : String, password : String};
}

/**
* Contains data uploaded in a URL request.
*/
typedef UploadData = {
	/**
	* An ArrayBuffer with a copy of the data.
	*/
	var ?bytes : Any;

	/**
	* A string with the file's path and name.
	*/
	var ?file : String;
}

/**
* Contains data passed within form data. For urlencoded form it is stored as string
* if data is utf-8 string and as ArrayBuffer otherwise. For form-data it is ArrayBuffer.
* If form-data represents uploading file, it is string with filename, if the filename is provided.
*
* @since Chrome 66
*/
typedef FormDataItem = EitherType<ArrayBuffer,String>;

extern enum abstract IgnoredActionType(String) to String {
	var REDIRECT = "redirect";
	var REQUEST_HEADERS = "request_headers";
	var RESPONSE_HEADERS = "response_headers";
	var AUTH_CREDENTIALS = "auth_credentials";
}
