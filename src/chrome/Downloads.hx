package chrome;

/**
* Use the `chrome.downloads` API to programmatically initiate, monitor,
* manipulate, and search for downloads.
*
* @chrome-permission downloads
*/
@:native("chrome.downloads")
extern class Downloads {

	/**
	* This event fires with the {@link DownloadItem} object when a download begins.
	*/
	static final onCreated : Event<DownloadItem->Void>;

	/**
	* Fires with the `downloadId` when a download is erased from history.
	*/
	static final onErased : Event<(downloadId : Int)->Void>;

	/**
	* When any of a {@link DownloadItem}'s properties except `bytesReceived`
	* and `estimatedEndTime` changes, this event fires with the `downloadId`
	* and an object containing the properties that changed.
	*/
	static final onChanged : Event<DownloadDelta->Void>;

	/**
	* During the filename determination process, extensions will be given
	* the opportunity to override the target {@link DownloadItem.filename}.
	* Each extension may not register more than one listener for this event.
	* Each listener must call `suggest` exactly once, either synchronously
	* or asynchronously. If the listener calls `suggest` asynchronously,
	* then it must return `true`. If the listener neither calls `suggest`
	* synchronously nor returns `true`, then `suggest` will be called automatically.
	* The {@link DownloadItem} will not complete until all listeners have called `suggest`.
	* Listeners may call `suggest` without any arguments in order to allow
	* the download to use `downloadItem.filename` for its filename,
	* or pass a `suggestion` object to `suggest` in order to override the target filename.
	* If more than one extension overrides the filename, then the last extension
	* installed whose listener passes a `suggestion` object to `suggest` wins.
	* In order to avoid confusion regarding which extension will win, users
	* should not install extensions that may conflict. If the download is
	* initiated by {@link download} and the target filename is known before
	* the MIME type and tentative filename have been determined,
	* pass `filename` to {@link download} instead.
	*/
	static final onDeterminingFilename : Event<(DownloadDelta, ?FilenameSuggestion->Void)->Void>;

	/**
	* Download a URL. If the URL uses the HTTP\[S\] protocol,
	* then the request will include all cookies currently set for its hostname.
	* If both `filename` and `saveAs` are specified, then the Save As dialog
	* will be displayed, pre-populated with the specified `filename`.
	* If the download started successfully, `callback` will be called with
	* the new {@link DownloadItem}'s `downloadId`. If there was an error starting
	* the download, then `callback` will be called with `downloadId=undefined`
	* and {@link runtime.lastError} will contain a descriptive string. The error
	* strings are not guaranteed to remain backwards compatible between releases.
	* Extensions must not parse it.
	*
	* @param options What to download and how.
	* @param callback Called with the id of the new {@link DownloadItem}.
	*/
	overload static function download( options : DownloadOptions, callback : (downloadId : Int)->Void ) : Void;
	overload static function download( options : DownloadOptions ) : Promise<Int>;

	/**
	* Find {@link DownloadItem}. Set `query` to the empty object to get all {@link DownloadItem}.
	* To get a specific {@link DownloadItem}, set only the `id` field. To page
	* through a large number of items, set `orderBy: ['-startTime']`,
	* set `limit` to the number of items per page, and set `startedAfter` to
	* the `startTime` of the last item from the last page.
	*/
	overload static function search( query : DownloadQuery, callback : (Array<DownloadItem>)->Void ) : Void;
	overload static function search( query : DownloadQuery ) : Promise<Array<DownloadItem>>;

	/**
	* Pause the download. If the request was successful the download is in a paused state.
	* Otherwise {@link runtime.lastError} contains an error message.
	* The request will fail if the download is not active.
	*
	* @param downloadId The id of the download to pause.
	* @param callback Called when the pause request is completed.
	*/
	overload static function pause( downloadId : Int, callback : ()->Void ) : Void;
	overload static function pause( downloadId : Int ) : Promise<Void>;

	/**
	* Resume a paused download. If the request was successful the download is
	* in progress and unpaused. Otherwise {@link runtime.lastError} contains
	* an error message. The request will fail if the download is not active.
	*
	* @param downloadId The id of the download to resume.
	* @param callback Called when the resume request is completed.
	*/
	overload static function resume( downloadId : Int, callback : ()->Void ) : Void;
	overload static function resume( downloadId : Int ) : Promise<Void>;

	/**
	* Cancel a download. When `callback` is run, the download is cancelled,
	* completed, interrupted or doesn't exist anymore.
	*
	* @param downloadId The id of the download to cancel.
	* @param callback Called when the cancel request is completed.
	*/
	overload static function cancel( downloadId : Int, callback : ()->Void ) : Void;
	overload static function cancel( downloadId : Int ) : Promise<Void>;

	/**
	* Retrieve an icon for the specified download. For new downloads,
	* file icons are available after the {@link onCreated} event has been received.
	* The image returned by this function while a download is in progress
	* may be different from the image returned after the download is complete.
	* Icon retrieval is done by querying the underlying operating system
	* or toolkit depending on the platform. The icon that is returned will
	* therefore depend on a number of factors including state of the download,
	* platform, registered file types and visual theme. If a file icon cannot be determined,
	* {@link runtime.lastError} will contain an error message.
	*
	* @param downloadId The identifier for the download.
	* @param callback A URL to an image that represents the download.
	*/
	overload static function getFileIcon( downloadId : Int, callback : (?iconURL : String)->Void ) : Void;
	overload static function getFileIcon( downloadId : Int, options : GetFileIconOptions, callback : (?iconURL : String)->Void ) : Void;
	overload static function getFileIcon( downloadId : Int, ?options : GetFileIconOptions ) : Promise<String>;

	/**
	* Open the downloaded file now if the {@link DownloadItem} is complete;
	* otherwise returns an error through {@link runtime.lastError}.
	* Requires the `"downloads.open"` permission in addition to the `"downloads"` permission.
	* An {@link onChanged} event will fire when the item is opened for the first time.
	*
	* @param downloadId The identifier for the downloaded file.
	*/
	static function open( downloadId : Int ) : Void;

	/**
	* Show the downloaded file in its folder in a file manager.
	*
	* @param downloadId The identifier for the downloaded file.
	*/
	static function show( downloadId : Int ) : Void;

	/**
	* Show the default Downloads folder in a file manager.
	*/
	static function showDefaultFolder() : Void;

	/**
	* Erase matching {@link DownloadItem} from history without deleting
	* the downloaded file. An {@link onErased} event will fire for each
	* {@link DownloadItem} that matches `query`, then `callback` will be called.
	*/
	overload static function erase( query : DownloadQuery, callback : (erasedIds : Array<Int>)->Void ) : Void;
	overload static function erase( query : DownloadQuery ) : Promise<Array<Int>>;

	/**
	* Remove the downloaded file if it exists and the {@link DownloadItem} is complete;
	* otherwise return an error through {@link runtime.lastError}.
	*/
	overload static function removeFile( downloadId : Int, callback : ()->Void ) : Void;
	overload static function removeFile( downloadId : Int ) : Promise<Void>;

	/**
	* Prompt the user to accept a dangerous download. Can only be called from
	* a visible context (tab, window, or page/browser action popup).
	* Does not automatically accept dangerous downloads. If the download
	* is accepted, then an {@link onChanged} event will fire, otherwise nothing
	* will happen. When all the data is fetched into a temporary file and either
	* the download is not dangerous or the danger has been accepted,
	* then the temporary file is renamed to the target filename, the `state`
	* changes to 'complete', and {@link onChanged} fires.
	*
	* @param downloadId The identifier for the {@link DownloadItem}.
	* @param callback Called when the danger prompt dialog closes.
	*/
	overload static function acceptDanger( downloadId : Int, callback : ()->Void ) : Void;
	overload static function acceptDanger( downloadId : Int ) : Promise<Void>;

	/**
	* Enable or disable the gray shelf at the bottom of every window associated
	* with the current browser profile. The shelf will be disabled as long as
	* at least one extension has disabled it. Enabling the shelf while at least
	* one other extension has disabled it will return an error through
	* {@link runtime.lastError}. Requires the `"downloads.shelf"` permission
	* in addition to the `"downloads"` permission.
	*/
	static function setShelfEnabled( enabled : Bool ) : Void;

	/**
	* Change the download UI of every window associated with the current browser profile.
	* As long as at least one extension has set {@link UiOptions.enabled} to false,
	* the download UI will be hidden. Setting {@link UiOptions.enabled} to true
	* while at least one other extension has disabled it will return an error
	* through {@link runtime.lastError}. Requires the `"downloads.ui"` permission
	* in addition to the `"downloads"` permission.
	*
	* @param options Encapsulate a change to the download UI.
	* @param callback Called when the UI update is completed.
	* @since Chrome 105
	*/
	overload static function setUiOptions( options : UiOptions, callback : ()->Void ) : Void;
	overload static function setUiOptions( options : UiOptions ) : Promise<Void>;
}

typedef HeaderNameValuePair = {
	/**
	* Name of the HTTP header.
	*/
	var name : String;

	/**
	* Value of the HTTP header.
	*/
	var value : String;
}

/**
* uniquify
*
* To avoid duplication, the `filename` is changed to include a counter
* before the filename extension.
*
* overwrite
*
* The existing file will be overwritten with the new file.
*
* prompt
*
* The user will be prompted with a file chooser dialog.
*/
extern enum abstract FilenameConflictAction(String) to String {
	var UNIQUIFY = "uniquify";
	var OVERWRITE = "overwrite";
	var PROMPT = "prompt";
}

typedef FilenameSuggestion = {

	/**
	* The {@link DownloadItem}'s new target {@link DownloadItem.filename},
	* as a path relative to the user's default Downloads directory,
	* possibly containing subdirectories. Absolute paths, empty paths,
	* and paths containing back-references ".." will be ignored.
	* `filename` is ignored if there are any {@link onDeterminingFilename}
	* listeners registered by any extensions.
	*/
	var filename : String;

	/**
	* The action to take if `filename` already exists.
	*/
	var ?conflictAction : FilenameConflictAction;
}

extern enum abstract HttpMethod(String) to String {
	var GET = "GET";
	var POST = "POST";
}

extern enum abstract InterruptReason(String) to String {
	var FILE_FAILED = "FILE_FAILED";
	var FILE_ACCESS_DENIED = "FILE_ACCESS_DENIED";
	var FILE_NO_SPACE = "FILE_NO_SPACE";
	var FILE_NAME_TOO_LONG = "FILE_NAME_TOO_LONG";
	var FILE_TOO_LARGE = "FILE_TOO_LARGE";
	var FILE_VIRUS_INFECTED = "FILE_VIRUS_INFECTED";
	var FILE_TRANSIENT_ERROR = "FILE_TRANSIENT_ERROR";
	var FILE_BLOCKED = "FILE_BLOCKED";
	var FILE_SECURITY_CHECK_FAILED = "FILE_SECURITY_CHECK_FAILED";
	var FILE_TOO_SHORT = "FILE_TOO_SHORT";
	var FILE_HASH_MISMATCH = "FILE_HASH_MISMATCH";
	var FILE_SAME_AS_SOURCE = "FILE_SAME_AS_SOURCE";
	var NETWORK_FAILED = "NETWORK_FAILED";
	var NETWORK_DISCONNECTED = "NETWORK_DISCONNECTED";
	var NETWORK_SERVER_DOWN = "NETWORK_SERVER_DOWN";
	var NETWORK_INVALID_REQUEST = "NETWORK_INVALID_REQUEST";
	var SERVER_FAILED = "SERVER_FAILED";
	var SERVER_NO_RANGE = "SERVER_NO_RANGE";
	var SERVER_BAD_CONTENT = "SERVER_BAD_CONTENT";
	var SERVER_UNAUTHORIZED = "SERVER_UNAUTHORIZED";
	var SERVER_CERT_PROBLEM = "SERVER_CERT_PROBLEM";
	var SERVER_FORBIDDEN = "SERVER_FORBIDDEN";
	var SERVER_UNREACHABLE = "SERVER_UNREACHABLE";
	var SERVER_CONTENT_LENGTH_MISMATCH = "SERVER_CONTENT_LENGTH_MISMATCH";
	var SERVER_CROSS_ORIGIN_REDIRECT = "SERVER_CROSS_ORIGIN_REDIRECT";
	var USER_CANCELED = "USER_CANCELED";
	var USER_SHUTDOWN = "USER_SHUTDOWN";
	var CRASH = "CRASH";
}

typedef DownloadOptions = {

	/**
	* The URL to download.
	*/
	var url : String;

	/**
	* A file path relative to the Downloads directory to contain the
	* downloaded file, possibly containing subdirectories. Absolute paths,
	* empty paths, and paths containing back-references ".." will cause an error.
	* {@link onDeterminingFilename} allows suggesting a filename after the
	* file's MIME type and a tentative filename have been determined.
	*/
	var ?filename : String;

	/**
	* The action to take if `filename` already exists.
	*/
	var ?conflictAction : FilenameConflictAction;

	/**
	* Use a file-chooser to allow the user to select a filename regardless of
	* whether `filename` is set or already exists.
	*/
	var ?saveAs : Bool;

	/**
	* The HTTP method to use if the URL uses the HTTP\[S\] protocol.
	*/
	var ?method : HttpMethod;

	/**
	* Extra HTTP headers to send with the request if the URL uses the HTTP\[s\] protocol.
	* Each header is represented as a dictionary containing the keys `name` and
	* either `value` or `binaryValue`, restricted to those allowed by XMLHttpRequest.
	*/
	var ?headers : Array<HeaderNameValuePair>;

	/**
	* Post body.
	*/
	var ?body : String;
}


/**
* file
*
* The download's filename is suspicious.
*
* url
*
* The download's URL is known to be malicious.
*
* content
*
* The downloaded file is known to be malicious.
*
* uncommon
*
* The download's URL is not commonly downloaded and could be dangerous.
*
* host
*
* The download came from a host known to distribute malicious binaries and is likely dangerous.
*
* unwanted
*
* The download is potentially unwanted or unsafe. E.g. it could make changes to browser or computer settings.
*
* safe
*
* The download presents no known danger to the user's computer.
*
* accepted
*
* The user has accepted the dangerous download.
*/
extern enum abstract DangerType(String) to String {
	var FILE = "file";
	var URL = "url";
	var CONTENT = "content";
	var UNCOMMON = "uncommon";
	var HOST = "host";
	var UNWANTED = "unwanted";
	var SAFE = "safe";
	var ACCEPTED = "accepted";
	var ALLOWLISTEDBYPOLICY = "allowlistedByPolicy";
	var ASYNCSCANNING = "asyncScanning";
	var PASSWORDPROTECTED = "passwordProtected";
	var BLOCKEDTOOLARGE = "blockedTooLarge";
	var SENSITIVECONTENTWARNING = "sensitiveContentWarning";
	var SENSITIVECONTENTBLOCK = "sensitiveContentBlock";
	var UNSUPPORTEDFILETYPE = "unsupportedFileType";
	var DEEPSCANNEDSAFE = "deepScannedSafe";
	var DEEPSCANNEDOPENEDDANGEROUS = "deepScannedOpenedDangerous";
	var PROMPTFORSCANING = "promptForScaning";
	var ACCOUNTCOMPROMISE = "accountCompromise";
}

/**
* in\_progress
*
* The download is currently receiving data from the server.
*
* interrupted
*
* An error broke the connection with the file host.
*
* complete
*
* The download completed successfully.
*/
extern enum abstract State(String) to String {
	var IN_PROGRESS = "in_progress";
	var INTERRUPTED = "interrupted";
	var COMPLETE = "complete";
}

typedef DownloadItem = {

	/**
	* An identifier that is persistent across browser sessions.
	*/
	var id : Int;

	/**
	* The absolute URL that this download initiated from, before any redirects.
	*/
	var url : String;

	/**
	* The absolute URL that this download is being made from, after all redirects.
	*
	* @since Chrome 54
	*/
	var finalUrl : String;

	/**
	* Absolute URL.
	*/
	var referrer : String;

	/**
	* Absolute local path.
	*/
	var filename : String;

	/**
	* False if this download is recorded in the history, true if it is not recorded.
	*/
	var incognito : Bool;

	/**
	* Indication of whether this download is thought to be safe or known to be suspicious.
	*/
	var danger : DangerType;

	/**
	* The file's MIME type.
	*/
	var mime : String;

	/**
	* The time when the download began in ISO 8601 format.
	* May be passed directly to the Date constructor:
	* `chrome.downloads.search({}, function(items){items.forEach(function(item){console.log(new Date(item.startTime))})})`
	*/
	var startTime : String;

	/**
	* The time when the download ended in ISO 8601 format.
	* May be passed directly to the Date constructor:
	* `chrome.downloads.search({}, function(items){items.forEach(function(item){if (item.endTime) console.log(new Date(item.endTime))})})`
	*/
	var ?endTime : String;

	/**
	* Estimated time when the download will complete in ISO 8601 format.
	* May be passed directly to the Date constructor:
	* `chrome.downloads.search({}, function(items){items.forEach(function(item){if (item.estimatedEndTime) console.log(new Date(item.estimatedEndTime))})})`
	*/
	var ?estimatedEndTime : String;

	/**
	* Indicates whether the download is progressing, interrupted, or complete.
	*/
	var state : State;

	/**
	* True if the download has stopped reading data from the host, but kept the connection open.
	*/
	var paused : Bool;

	/**
	* True if the download is in progress and paused, or else if it is
	* interrupted and can be resumed starting from where it was interrupted.
	*/
	var canResume : Bool;

	/**
	* Why the download was interrupted. Several kinds of HTTP errors may
	* be grouped under one of the errors beginning with `SERVER_`.
	* Errors relating to the network begin with `NETWORK_`,
	* errors relating to the process of writing the file to the file system
	* begin with `FILE_`, and interruptions initiated by the user begin with `USER_`.
	*/
	var ?error : InterruptReason;

	/**
	* Number of bytes received so far from the host, without considering file compression.
	*/
	var bytesReceived : Int;

	/**
	* Number of bytes in the whole file, without considering file compression, or -1 if unknown.
	*/
	var totalBytes : Int;

	/**
	* Number of bytes in the whole file post-decompression, or -1 if unknown.
	*/
	var fileSize : Int;

	/**
	* Whether the downloaded file still exists. This information may be out of
	* date because Chrome does not automatically watch for file removal.
	* Call {@link search}() in order to trigger the check for file existence.
	* When the existence check completes, if the file has been deleted,
	* then an {@link onChanged} event will fire. Note that {@link search}() does
	* not wait for the existence check to finish before returning, so results
	* from {@link search}() may not accurately reflect the file system. Also,
	* {@link search}() may be called as often as necessary, but will not check
	* for file existence any more frequently than once every 10 seconds.
	*/
	var exists : Bool;

	/**
	* The identifier for the extension that initiated this download if this
	* download was initiated by an extension. Does not change once it is set.
	*/
	var ?byExtensionId : String;

	/**
	* The localized name of the extension that initiated this download if this
	* download was initiated by an extension. May change if the extension
	* changes its name or if the user changes their locale.
	*/
	var ?byExtensionName : String;
}

typedef DownloadQuery = {
	/**
	* This array of search terms limits results to {@link DownloadItem} whose `filename` or `url` or `finalUrl` contain all of the search terms that do not begin with a dash '-' and none of the search terms that do begin with a dash.
	*/
	var ?query : Array<String>;

	/**
	* Limits results to {@link DownloadItem} that started before the given ms since the epoch.
	*/
	var ?startedBefore : String;

	/**
	* Limits results to {@link DownloadItem} that started after the given ms since the epoch.
	*/
	var ?startedAfter : String;

	/**
	* Limits results to {@link DownloadItem} that ended before the given ms since the epoch.
	*/
	var ?endedBefore : String;

	/**
	* Limits results to {@link DownloadItem} that ended after the given ms since the epoch.
	*/
	var ?endedAfter : String;

	/**
	* Limits results to {@link DownloadItem} whose `totalBytes` is greater than the given integer.
	*/
	var ?totalBytesGreater : Int;

	/**
	* Limits results to {@link DownloadItem} whose `totalBytes` is less than the given integer.
	*/
	var ?totalBytesLess : Int;

	/**
	* Limits results to {@link DownloadItem} whose `filename` matches the given regular expression.
	*/
	var ?filenameRegex : String;

	/**
	* Limits results to {@link DownloadItem} whose `url` matches the given regular expression.
	*/
	var ?urlRegex : String;

	/**
	* Limits results to {@link DownloadItem} whose `finalUrl` matches the given regular expression.
	*
	* @since Chrome 54
	*/
	var ?finalUrlRegex : String;

	/**
	* The maximum number of matching {@link DownloadItem} returned. Defaults to 1000. Set to 0 in order to return all matching {@link DownloadItem}. See {@link search} for how to page through results.
	*/
	var ?limit : Int;

	/**
	* Set elements of this array to {@link DownloadItem} properties in order to sort search results. For example, setting `orderBy=['startTime']` sorts the {@link DownloadItem} by their start time in ascending order. To specify descending order, prefix with a hyphen: '-startTime'.
	*/
	var ?orderBy : Array<String>;

	/**
	* The `id` of the {@link DownloadItem} to query.
	*/
	var ?id : Int;

	/**
	* The absolute URL that this download initiated from, before any redirects.
	*/
	var ?url : String;

	/**
	* The absolute URL that this download is being made from, after all redirects.
	*
	* @since Chrome 54
	*/
	var ?finalUrl : String;

	/**
	* Absolute local path.
	*/
	var ?filename : String;

	/**
	* Indication of whether this download is thought to be safe or known to be suspicious.
	*/
	var ?danger : DangerType;

	/**
	* The file's MIME type.
	*/
	var ?mime : String;

	/**
	* The time when the download began in ISO 8601 format.
	*/
	var ?startTime : String;

	/**
	* The time when the download ended in ISO 8601 format.
	*/
	var ?endTime : String;

	/**
	* Indicates whether the download is progressing, interrupted, or complete.
	*/
	var ?state : State;

	/**
	* True if the download has stopped reading data from the host, but kept the connection open.
	*/
	var ?paused : Bool;

	/**
	* Why a download was interrupted.
	*/
	var ?error : InterruptReason;

	/**
	* Number of bytes received so far from the host, without considering file compression.
	*/
	var ?bytesReceived : Int;

	/**
	* Number of bytes in the whole file, without considering file compression, or -1 if unknown.
	*/
	var ?totalBytes : Int;

	/**
	* Number of bytes in the whole file post-decompression, or -1 if unknown.
	*/
	var ?fileSize : Int;

	/**
	* Whether the downloaded file exists;
	*/
	var ?exists : Bool;
}

typedef StringDelta = {

	var ?previous : String;

	var ?current : String;
}

typedef DoubleDelta = {

	var ?previous : Float;

	var ?current : Float;
}

typedef BooleanDelta = {

	var ?previous : Bool;

	var ?current : Bool;
}

typedef DownloadDelta = {

	/**
	* The `id` of the {@link DownloadItem} that changed.
	*/
	var id : Int;

	/**
	* The change in `url`, if any.
	*/
	var ?url : StringDelta;

	/**
	* The change in `finalUrl`, if any.
	*
	* @since Chrome 54
	*/
	var ?finalUrl : StringDelta;

	/**
	* The change in `filename`, if any.
	*/
	var ?filename : StringDelta;

	/**
	* The change in `danger`, if any.
	*/
	var ?danger : StringDelta;

	/**
	* The change in `mime`, if any.
	*/
	var ?mime : StringDelta;

	/**
	* The change in `startTime`, if any.
	*/
	var ?startTime : StringDelta;

	/**
	* The change in `endTime`, if any.
	*/
	var ?endTime : StringDelta;

	/**
	* The change in `state`, if any.
	*/
	var ?state : StringDelta;

	/**
	* The change in `canResume`, if any.
	*/
	var ?canResume : BooleanDelta;

	/**
	* The change in `paused`, if any.
	*/
	var ?paused : BooleanDelta;

	/**
	* The change in `error`, if any.
	*/
	var ?error : StringDelta;

	/**
	* The change in `totalBytes`, if any.
	*/
	var ?totalBytes : DoubleDelta;

	/**
	* The change in `fileSize`, if any.
	*/
	var ?fileSize : DoubleDelta;

	/**
	* The change in `exists`, if any.
	*/
	var ?exists : BooleanDelta;
}

typedef GetFileIconOptions = {
	/**
	* The size of the returned icon. The icon will be square with dimensions size \* size pixels.
	* The default and largest size for the icon is 32x32 pixels.
	* The only supported sizes are 16 and 32. It is an error to specify any other size.
	*/
	var ?size : GetFileIconOptionsSize;
}
extern enum abstract GetFileIconOptionsSize(Int) to Int {
	var X16 = 16;
	var X32 = 32;
}

typedef UiOptions = {
	/**
	* Enable or disable the download UI.
	*/
	var enabled : Bool;
}
