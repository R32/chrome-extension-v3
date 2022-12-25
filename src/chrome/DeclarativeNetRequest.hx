package chrome;

import chrome.WebRequest.ResourceType;
/**
* The `chrome.declarativeNetRequest` API is used to block or modify network requests
* by specifying declarative rules. This lets extensions modify network requests
* without intercepting them and viewing their content, thus providing more privacy.
*
* @since Chrome 84
* @chrome-permission declarativeNetRequest
* @chrome-permission declarativeNetRequestWithHostAccess
*/
@:native("chrome.declarativeNetRequest")
extern class DeclarativeNetRequest {
	/**
	* The minimum number of static rules guaranteed to an extension across its
	* enabled static rulesets. Any rules above this limit will count towards the
	* [global static rule limit](https://developer.chrome.com/docs/extensions/reference/declarativeNetRequest/#global-static-rule-limit).
	*
	* @since Chrome 89
	*/
	static inline var GUARANTEED_MINIMUM_STATIC_RULES = 30000;

	/**
	* The maximum number of combined dynamic and session scoped rules an extension can add.
	*
	* @since Chrome 90
	*/
	static inline var MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES = 5000;

	/**
	* Time interval within which `MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL getMatchedRules`
	* calls can be made, specified in minutes. Additional calls will fail immediately and
	* set {@link runtime.lastError}. Note: `getMatchedRules` calls associated with a user
	* gesture are exempt from the quota.
	*/
	static inline var GETMATCHEDRULES_QUOTA_INTERVAL = 10;

	/**
	* The number of times `getMatchedRules` can be called within a period of
	* `GETMATCHEDRULES_QUOTA_INTERVAL`.
	*/
	static inline var MAX_GETMATCHEDRULES_CALLS_PER_INTERVAL = 20;

	/**
	* The maximum number of regular expression rules that an extension can add.
	* This limit is evaluated separately for the set of dynamic rules and
	* those specified in the rule resources file.
	*/
	static inline var MAX_NUMBER_OF_REGEX_RULES = 1000;

	/**
	* The maximum number of static `Rulesets` an extension can specify as part
	* of the `"rule_resources"` manifest key.
	*/
	static inline var MAX_NUMBER_OF_STATIC_RULESETS = 50;

	/**
	* The maximum number of static `Rulesets` an extension can enable at any one time.
	*
	* @since Chrome 94
	*/
	static inline var MAX_NUMBER_OF_ENABLED_STATIC_RULESETS = 10;

	/**
	* Ruleset ID for the dynamic rules added by the extension.
	*/
	static inline var DYNAMIC_RULESET_ID = "_dynamic";

	/**
	* Ruleset ID for the session-scoped rules added by the extension.
	*
	* @since Chrome 90
	*/
	static inline var SESSION_RULESET_ID = "_session";

	/**
	* Fired when a rule is matched with a request. Only available for unpacked
	* extensions with the `declarativeNetRequestFeedback` permission as this is
	* intended to be used for debugging purposes only.
	*
	* @chrome-permission declarativeNetRequestFeedback
	*/
	static final onRuleMatchedDebug : Event<MatchedRuleInfoDebug->Void>;

	/**
	* Modifies the current set of dynamic rules for the extension.
	* The rules with IDs listed in `options.removeRuleIds` are first removed,
	* and then the rules given in `options.addRules` are added. Notes:
	*
	* *   This update happens as a single atomic operation: either all specified rules are added and removed, or an error is returned.
	* *   These rules are persisted across browser sessions and across extension updates.
	* *   Static rules specified as part of the extension package can not be removed using this function.
	* *   {@link MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES} is the maximum number of combined dynamic and session rules an extension can add.
	*
	* * @param callback Called once the update is complete or has failed.
	* In case of an error, {@link runtime.lastError} will be set and no change
	* will be made to the rule set. This can happen for multiple reasons,
	* such as invalid rule format, duplicate rule ID,
	* rule count limit exceeded, internal errors, and others.
	*/
	overload static function updateDynamicRules( options : UpdateRuleOptions, callback : ()->Void ) : Void;
	overload static function updateDynamicRules( options : UpdateRuleOptions ) : Promise<Void>;

	/**
	* Returns the current set of dynamic rules for the extension.
	*
	* @param callback Called with the set of dynamic rules. An error might be raised in case of transient internal errors.
	*/
	overload static function getDynamicRules( callback : (Array<Rule>)->Void ) : Void;
	overload static function getDynamicRules() : Promise<UpdateRuleOptions>;

	/**
	* Modifies the current set of session scoped rules for the extension. The rules with IDs listed in `options.removeRuleIds` are first removed, and then the rules given in `options.addRules` are added. Notes:
	*
	* *   This update happens as a single atomic operation: either all specified rules are added and removed, or an error is returned.
	* *   These rules are not persisted across sessions and are backed in memory.
	* *   {@link MAX_NUMBER_OF_DYNAMIC_AND_SESSION_RULES} is the maximum number of combined dynamic and session rules an extension can add.
	*
	* @param callback Called once the update is complete or has failed.
	* In case of an error, {@link runtime.lastError} will be set and no change
	* will be made to the rule set. This can happen for multiple reasons,
	* such as invalid rule format, duplicate rule ID,
	* rule count limit exceeded, and others.
	* @since Chrome 90
	*/
	overload static function updateSessionRules( options : UpdateRuleOptions, callback : ()->Void ) : Void;
	overload static function updateSessionRules( options : UpdateRuleOptions ) : Promise<Void>;

	/**
	* Returns the current set of session scoped rules for the extension.
	*
	* @param callback Called with the set of session scoped rules.
	* @since Chrome 90
	*/
	overload static function getSessionRules( options : UpdateRuleOptions, callback : (Array<Rule>)->Void ) : Void;
	overload static function getSessionRules( options : UpdateRuleOptions ) : Promise<Array<Rule>>;

	/**
	* Updates the set of enabled static rulesets for the extension.
	* The rulesets with IDs listed in `options.disableRulesetIds` are first removed,
	* and then the rulesets listed in `options.enableRulesetIds` are added.
	* Note that the set of enabled static rulesets is persisted across sessions
	* but not across extension updates, i.e. the `rule_resources` manifest key
	* will determine the set of enabled static rulesets on each extension update.
	*
	* @param callback Called once the update is complete. In case of an error,
	* {@link runtime.lastError} will be set and no change will be made to set
	* of enabled rulesets. This can happen for multiple reasons, such as
	* invalid ruleset IDs, rule count limit exceeded, or internal errors.
	*/
	overload static function updateEnabledRulesets( options : UpdateRulesetOptions, callback : ()->Void ) : Void;
	overload static function updateEnabledRulesets( options : UpdateRulesetOptions ) : Promise<Void>;

	/**
	* Returns the ids for the current set of enabled static rulesets.
	*
	* @param callback Called with a list of ids, where each id corresponds to
	* an enabled static {@link Ruleset}.
	*/
	overload static function getEnabledRulesets( callback : (rulesetIds : Array<String>)->Void ) : Void;
	overload static function getEnabledRulesets() : Promise<Array<String>>;

	/**
	* Returns all rules matched for the extension. Callers can optionally
	* filter the list of matched rules by specifying a `filter`.
	* This method is only available to extensions with the `declarativeNetRequestFeedback`
	* permission or having the `activeTab` permission granted for the `tabId`
	* specified in `filter`. Note: Rules not associated with an active document
	* that were matched more than five minutes ago will not be returned.
	*
	* @param filter An object to filter the list of matched rules.
	* @param callback Called once the list of matched rules has been fetched.
	* In case of an error, {@link runtime.lastError} will be set and no rules will be returned.
	* This can happen for multiple reasons, such as insufficient permissions, or exceeding the quota.
	*/
	overload static function getMatchedRules( callback : RulesMatchedDetails->Void ) : Void;
	overload static function getMatchedRules( ?filter : MatchedRulesFilter, callback : RulesMatchedDetails->Void ) : Void;
	overload static function getMatchedRules( ?filter : MatchedRulesFilter ) : Promise<RulesMatchedDetails>;

	/**
	* Configures if the action count for tabs should be displayed as the extension
	* action's badge text and provides a way for that action count to be incremented.
	*
	* @since Chrome 88
	*/
	overload static function setExtensionActionOptions( options : ExtensionActionOptions, callback : ()->Void ) : Void;
	overload static function setExtensionActionOptions( options : ExtensionActionOptions ) : Promise<Void>;

	/**
	* Checks if the given regular expression will be supported as a `regexFilter` rule condition.
	*
	* @param regexOptions The regular expression to check.
	* @param callback Called with details consisting of whether
	* the regular expression is supported and the reason if not.
	* @since Chrome 87
	*/
	overload static function isRegexSupported( options : RegexOptions, callback : IsRegexSupportedResult->Void ) : Void;
	overload static function isRegexSupported( options : RegexOptions ) : Promise<IsRegexSupportedResult>;

	/**
	* Returns the number of static rules an extension can enable before the
	* [global static rule limit](https://developer.chrome.com/docs/extensions/reference/declarativeNetRequest/#global-static-rule-limit) is reached.
	*
	* @since Chrome 89
	*/
	overload static function getAvailableStaticRuleCount( callback : (count : Int)->Void ) : Void;
	overload static function getAvailableStaticRuleCount() : Promise<Int>;

	/**
	* Checks if any of the extension's declarativeNetRequest rules would match
	* a hypothetical request. Note: Only available for unpacked extensions as
	* this is only intended to be used during extension development.
	*
	* @param callback Called with the details of matched rules.
	* @since Chrome 103
	*/
	overload static function testMatchOutcome( request : TestMatchRequestDetails, callback : TestMatchOutcomeResult->Void ) : Void;
	overload static function testMatchOutcome( request : TestMatchRequestDetails ) : Promise<TestMatchOutcomeResult>;
}

/**
* This describes the HTTP request method of a network request.
*
* @since Chrome 91
*/
extern enum abstract RequestMethod(String) to String {
	var CONNECT = "connect";
	var DELETE = "delete";
	var GET = "get";
	var HEAD = "head";
	var OPTIONS = "options";
	var PATCH = "patch";
	var POST = "post";
	var PUT = "put";
}

/**
* This describes whether the request is first or third party to the frame
* in which it originated. A request is said to be first party if it has
* the same domain (eTLD+1) as the frame in which the request originated.
*
* @chrome-enum "firstParty" The network request is first party to the frame
* in which it originated.
* @chrome-enum "thirdParty" The network request is third party to the frame
* in which it originated.
*/
extern enum abstract DomainType(String) to String {
	var FIRSTPARTY = "firstParty";
	var THIRDPARTY = "thirdParty";
}

/**
* This describes the possible operations for a "modifyHeaders" rule.
*
* @chrome-enum "append" Adds a new entry for the specified header.
* This operation is not supported for request headers.
* @chrome-enum "set" Sets a new value for the specified header,
* removing any existing headers with the same name.
* @chrome-enum "remove" Removes all entries for the specified header.
* @since Chrome 86
*/
extern enum abstract HeaderOperation(String) to String {
	var APPEND = "append";
	var SET = "set";
	var REMOVE = "remove";
}

/**
* Describes the kind of action to take if a given RuleCondition matches.
*
* @chrome-enum "block" Block the network request.
* @chrome-enum "redirect" Redirect the network request.
* @chrome-enum "allow" Allow the network request. The request won't be intercepted
* if there is an allow rule which matches it.
* @chrome-enum "upgradeScheme" Upgrade the network request url's scheme
* to https if the request is http or ftp.
* @chrome-enum "modifyHeaders" Modify request/response headers from the network request.
* @chrome-enum "allowAllRequests" Allow all requests within a frame hierarchy,
* including the frame request itself.
*/
extern enum abstract RuleActionType(String) to String {
	var BLOCK = "block";
	var REDIRECT = "redirect";
	var ALLOW = "allow";
	var UPGRADESCHEME = "upgradeScheme";
	var MODIFYHEADERS = "modifyHeaders";
	var ALLOWALLREQUESTS = "allowAllRequests";
}

/**
* Describes the reason why a given regular expression isn't supported.
*
* @chrome-enum "syntaxError" The regular expression is syntactically incorrect,
* or uses features not available in the [RE2 syntax](https://github.com/google/re2/wiki/Syntax).
* @chrome-enum "memoryLimitExceeded" The regular expression exceeds the memory limit.
* @since Chrome 87
*/
extern enum abstract UnsupportedRegexReason(String) to String {
	var SYNTAXERROR = "syntaxError";
	var MEMORYLIMITEXCEEDED = "memoryLimitExceeded";
}

typedef Ruleset = {
	/**
	* A non-empty string uniquely identifying the ruleset.
	* IDs beginning with '\_' are reserved for internal use.
	*/
	var id : String;

	/**
	* The path of the JSON ruleset relative to the extension directory.
	*/
	var path : String;

	/**
	* Whether the ruleset is enabled by default.
	*/
	var enabled : Bool;
}

typedef QueryKeyValue = {

	var key : String;

	var value : String;

	/**
	* If true, the query key is replaced only if it's already present.
	* Otherwise, the key is also added if it's missing. Defaults to false.
	*
	* @since Chrome 94
	*/
	var ?replaceOnly : Bool;
}

typedef QueryTransform = {

	/**
	* The list of query keys to be removed.
	*/
	var ?removeParams : Array<String>;

	/**
	* The list of query key-value pairs to be added or replaced.
	*/
	var ?addOrReplaceParams : Array<QueryKeyValue>;
}


typedef URLTransform = {

	/**
	* The new scheme for the request.
	* Allowed values are "http", "https", "ftp" and "chrome-extension".
	*/
	var ?scheme : String;

	/**
	* The new host for the request.
	*/
	var ?host : String;

	/**
	* The new port for the request. If empty, the existing port is cleared.
	*/
	var ?port : String;

	/**
	* The new path for the request. If empty, the existing path is cleared.
	*/
	var ?path : String;

	/**
	* The new query for the request. Should be either empty,
	* in which case the existing query is cleared; or should begin with '?'.
	*/
	var ?query : String;

	/**
	* Add, remove or replace query key-value pairs.
	*/
	var ?queryTransform : QueryTransform;

	/**
	* The new fragment for the request. Should be either empty,
	* in which case the existing fragment is cleared; or should begin with '#'.
	*/
	var ?fragment : String;

	/**
	* The new username for the request.
	*/
	var ?username : String;

	/**
	* The new password for the request.
	*/
	var ?password : String;
}

typedef Redirect = {

	/**
	* Path relative to the extension directory. Should start with '/'.
	*/
	var ?extensionPath : String;

	/**
	* Url transformations to perform.
	*/
	var ?transform : URLTransform;

	/**
	* The redirect url. Redirects to JavaScript urls are not allowed.
	*/
	var ?url : String;

	/**
	* Substitution pattern for rules which specify a `regexFilter`.
	* The first match of `regexFilter` within the url will be replaced with this pattern.
	* Within `regexSubstitution`, backslash-escaped digits (\\1 to \\9) can be used
	* to insert the corresponding capture groups. \\0 refers to the entire matching text.
	*/
	var ?regexSubstitution : String;
}

typedef RuleCondition = {

	/**
	* The pattern which is matched against the network request url. Supported constructs:
	*
	* **'\*'** : Wildcard: Matches any number of characters.
	*
	* **'|'** : Left/right anchor: If used at either end of the pattern,
	* specifies the beginning/end of the url respectively.
	*
	* **'||'** : Domain name anchor: If used at the beginning of the pattern,
	* specifies the start of a (sub-)domain of the URL.
	*
	* **'^'** : Separator character: This matches anything except a letter,
	* a digit or one of the following: \_ - . %. This can also match the end of the URL.
	*
	* Therefore `urlFilter` is composed of the following parts:
	* (optional Left/Domain name anchor) + pattern + (optional Right anchor).
	*
	* If omitted, all urls are matched. An empty string is not allowed.
	*
	* A pattern beginning with `||*` is not allowed. Use `*` instead.
	*
	* Note: Only one of `urlFilter` or `regexFilter` can be specified.
	*
	* Note: The `urlFilter` must be composed of only ASCII characters.
	* This is matched against a url where the host is encoded in the punycode format
	* (in case of internationalized domains) and any other non-ascii characters
	* are url encoded in utf-8. For example, when the request url is http://abc.рф?q=ф,
	* the `urlFilter` will be matched against the url http://abc.xn--p1ai/?q=%D1%84.
	*/
	var ?urlFilter : String;

	/**
	* Regular expression to match against the network request url.
	* This follows the [RE2 syntax](https://github.com/google/re2/wiki/Syntax).
	*
	* Note: Only one of `urlFilter` or `regexFilter` can be specified.
	*
	* Note: The `regexFilter` must be composed of only ASCII characters.
	* This is matched against a url where the host is encoded in the punycode
	* format (in case of internationalized domains) and
	* any other non-ascii characters are url encoded in utf-8.
	*/
	var ?regexFilter : String;

	/**
	* Whether the `urlFilter` or `regexFilter` (whichever is specified)
	* is case sensitive. Default is true.
	*/
	var ?isUrlFilterCaseSensitive : Bool;

	/**
	* The rule will only match network requests originating from the list
	* of `initiatorDomains`. If the list is omitted, the rule is applied to
	* requests from all domains. An empty list is not allowed.
	*
	* Notes:
	*
	* *   Sub-domains like "a.example.com" are also allowed.
	* *   The entries must consist of only ascii characters.
	* *   Use punycode encoding for internationalized domains.
	* *   This matches against the request initiator and not the request url.
	*
	* @since Chrome 101
	*/
	var ?initiatorDomains : Array<String>;

	/**
	* The rule will not match network requests originating from the list
	* of `excludedDomains`. If the list is empty or omitted, no domains are excluded.
	* This takes precedence over `initiatorDomains`.
	*
	* Notes:
	*
	* *   Sub-domains like "a.example.com" are also allowed.
	* *   The entries must consist of only ascii characters.
	* *   Use punycode encoding for internationalized domains.
	* *   This matches against the request initiator and not the request url.
	*
	* @since Chrome 101
	*/
	var ?excludedInitiatorDomains : Array<String>;

	/**
	* The rule will only match network requests when the domain matches one
	* from the list of `requestDomains`. If the list is omitted,
	* the rule is applied to requests from all domains. An empty list is not allowed.
	*
	* Notes:
	*
	* *   Sub-domains like "a.example.com" are also allowed.
	* *   The entries must consist of only ascii characters.
	* *   Use punycode encoding for internationalized domains.
	*
	* @since Chrome 101
	*/
	var ?requestDomains : Array<String>;

	/**
	* The rule will not match network requests when the domains matches one
	* from the list of `excludedDomains`. If the list is empty or omitted,
	* no domains are excluded. This takes precedence over `requestDomains`.
	*
	* Notes:
	*
	* *   Sub-domains like "a.example.com" are also allowed.
	* *   The entries must consist of only ascii characters.
	* *   Use punycode encoding for internationalized domains.
	*
	* @since Chrome 101
	*/
	var ?excludedRequestDomains : Array<String>;

	/**
	* The rule will only match network requests originating from the list of `domains`.
	*
	* @deprecated Use {@link initiatorDomains} instead
	* @chrome-deprecated-since Chrome 101
	*/
	var ?domains : Array<String>;

	/**
	* The rule will not match network requests originating from the list of `excludedDomains`.
	*
	* @deprecated Use {@link excludedInitiatorDomains} instead
	* @chrome-deprecated-since Chrome 101
	*/
	var ?excludedDomains : Array<String>;

	/**
	* List of resource types which the rule can match. An empty list is not allowed.
	*
	* Note: this must be specified for `allowAllRequests` rules and may only include
	* the `sub_frame` and `main_frame` resource types.
	*/
	var ?resourceTypes : Array<ResourceType>;

	/**
	* List of resource types which the rule won't match. Only one of `resourceTypes`
	* and `excludedResourceTypes` should be specified. If neither of them is specified,
	* all resource types except "main\_frame" are blocked.
	*/
	var ?excludedResourceTypes : Array<ResourceType>;

	/**
	* List of HTTP request methods which the rule can match. An empty list is not allowed.
	*
	* Note: Specifying a `requestMethods` rule condition will also exclude non-HTTP(s) requests,
	* whereas specifying `excludedRequestMethods` will not.
	*
	* @since Chrome 91
	*/
	var ?requestMethods : Array<RequestMethod>;

	/**
	* List of request methods which the rule won't match. Only one of `requestMethods`
	* and `excludedRequestMethods` should be specified. If neither of them is specified,
	* all request methods are matched.
	*
	* @since Chrome 91
	*/
	var ?excludedRequestMethods : Array<RequestMethod>;

	/**
	* Specifies whether the network request is first-party or third-party to
	* the domain from which it originated. If omitted, all requests are accepted.
	*/
	var ?domainType : DomainType;

	/**
	* List of {@link tabs.Tab.id} which the rule should match. An ID of {@link tabs.TAB_ID_NONE}
	* matches requests which don't originate from a tab. An empty list is not allowed.
	* Only supported for session-scoped rules.
	*
	* @since Chrome 92
	*/
	var ?tabIds : Array<Int>;

	/**
	* List of {@link tabs.Tab.id} which the rule should not match. An ID of {@link tabs.TAB_ID_NONE}
	* excludes requests which don't originate from a tab. Only supported for session-scoped rules.
	*
	* @since Chrome 92
	*/
	var ?excludedTabIds : Array<Int>;
}

/**
* @since Chrome 86
*/
typedef ModifyHeaderInfo = {

	/**
	* The name of the header to be modified.
	*/
	var header : String;

	/**
	* The operation to be performed on a header.
	*/
	var operation : HeaderOperation;

	/**
	* The new value for the header. Must be specified for `append` and `set` operations.
	*/
	var ?value : String;
}

typedef RuleAction = {

	/**
	* The type of action to perform.
	*/
	var type : RuleActionType;

	/**
	* Describes how the redirect should be performed. Only valid for redirect rules.
	*/
	var ?redirect : Redirect;

	/**
	* The request headers to modify for the request. Only valid if RuleActionType is "modifyHeaders".
	*
	* @since Chrome 86
	*/
	var ?requestHeaders : Array<ModifyHeaderInfo>;

	/**
	* The response headers to modify for the request. Only valid if RuleActionType is "modifyHeaders".
	*
	* @since Chrome 86
	*/
	var ?responseHeaders : Array<ModifyHeaderInfo>;
}

private typedef Rule = {

	/**
	* An id which uniquely identifies a rule. Mandatory and should be >= 1.
	*/
	var id : Int;

	/**
	* Rule priority. Defaults to 1. When specified, should be >= 1.
	*/
	var ?priority : Int;

	/**
	* The condition under which this rule is triggered.
	*/
	var condition : RuleCondition;

	/**
	* The action to take if this rule is matched.
	*/
	var action : RuleAction;
}

typedef MatchedRule = {

	/**
	* A matching rule's ID.
	*/
	var ruleId : Int;

	/**
	* ID of the {@link Ruleset} this rule belongs to. For a rule originating
	* from the set of dynamic rules, this will be equal to {@link DYNAMIC_RULESET_ID}.
	*/
	var rulesetId : String;
}

typedef MatchedRuleInfo = {

	var rule : MatchedRule;

	/**
	* The time the rule was matched. Timestamps will correspond to the Javascript
	* convention for times, i.e. number of milliseconds since the epoch.
	*/
	var timeStamp : Float;

	/**
	* The tabId of the tab from which the request originated if the tab is still active. Else -1.
	*/
	var tabId : Int;
}

typedef MatchedRulesFilter = {

	/**
	* If specified, only matches rules for the given tab. Matches rules
	* not associated with any active tab if set to -1.
	*/
	var ?tabId : Int;

	/**
	* If specified, only matches rules after the given timestamp.
	*/
	var ?minTimeStamp : Float;
}

typedef RulesMatchedDetails = {

	/**
	* Rules matching the given filter.
	*/
	var rulesMatchedInfo : Array<MatchedRuleInfo>;
}


typedef RequestDetails = {

	/**
	* The ID of the request. Request IDs are unique within a browser session.
	*/
	var requestId : String;

	/**
	* The URL of the request.
	*/
	var url : String;

	/**
	* The origin where the request was initiated. This does not change through redirects.
	* If this is an opaque origin, the string 'null' will be used.
	*/
	var ?initiator : String;

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
	* The unique identifier for the frame's document, if this request is for a frame.
	*
	* @since Chrome 106
	*/
	var ?documentId : String;

	/**
	* The type of the frame, if this request is for a frame.
	*
	* @since Chrome 106
	*/
	var ?frameType : ExtensionTypes.FrameType;

	/**
	* The lifecycle of the frame's document, if this request is for a frame.
	*
	* @since Chrome 106
	*/
	var ?documentLifecycle : ExtensionTypes.DocumentLifecycle;

	/**
	* ID of frame that wraps the frame which sent the request. Set to -1 if no parent frame exists.
	*/
	var parentFrameId : Int;

	/**
	* The unique identifier for the frame's parent document,
	* if this request is for a frame and has a parent.
	*
	* @since Chrome 106
	*/
	var ?parentDocumentId : String;

	/**
	* The ID of the tab in which the request takes place.
	* Set to -1 if the request isn't related to a tab.
	*/
	var tabId : Int;

	/**
	* The resource type of the request.
	*/
	var type : ResourceType;
}

/**
* @since Chrome 103
*/
typedef TestMatchRequestDetails = {

	/**
	* The URL of the hypothetical request.
	*/
	var url : String;

	/**
	* The initiator URL (if any) for the hypothetical request.
	*/
	var ?initiator : String;

	/**
	* Standard HTTP method of the hypothetical request.
	* Defaults to "get" for HTTP requests and is ignored for non-HTTP requests.
	*/
	var ?method : RequestMethod;

	/**
	* The resource type of the hypothetical request.
	*/
	var type : ResourceType;

	/**
	* The ID of the tab in which the hypothetical request takes place.
	* Does not need to correspond to a real tab ID. Default is -1,
	* meaning that the request isn't related to a tab.
	*/
	var ?tabId : Int;
}

typedef MatchedRuleInfoDebug = {

	var ?rule : MatchedRule;

	/**
	* Details about the request for which the rule was matched.
	*/
	var ?request : RequestDetails;
}

    /**
     * @since Chrome 87
     */
typedef RegexOptions = {

	/**
	* The regular expresson to check.
	*/
	var regex : String;

	/**
	* Whether the `regex` specified is case sensitive. Default is true.
	*/
	var ?isCaseSensitive : Bool;

	/**
	* Whether the `regex` specified requires capturing. Capturing is
	* only required for redirect rules which specify a `regexSubstition` action.
	* The default is false.
	*/
	var ?requireCapturing : Bool;
}

/**
* @since Chrome 87
*/
typedef IsRegexSupportedResult = {

	var isSupported : Bool;

	/**
	* Specifies the reason why the regular expression is not supported. Only provided if `isSupported` is false.
	*/
	var ?reason : UnsupportedRegexReason;
}

/**
* @since Chrome 103
*/
typedef TestMatchOutcomeResult = {

	/**
	* The rules (if any) that match the hypothetical request.
	*/
	var matchedRules : Array<MatchedRule>;
}

/**
* @since Chrome 87
*/
typedef UpdateRuleOptions = {

	/**
	* IDs of the rules to remove. Any invalid IDs will be ignored.
	*/
	var ?removeRuleIds : Array<Int>;

	/**
	* Rules to add.
	*/
	var ?addRules : Array<Rule>;
}

/**
* @since Chrome 87
*/
typedef UpdateRulesetOptions = {

	/**
	* The set of ids corresponding to a static {@link Ruleset} that should be disabled.
	*/
	var ?disableRulesetIds : Array<String>;

	/**
	* The set of ids corresponding to a static {@link Ruleset} that should be enabled.
	*/
	var ?enableRulesetIds : Array<String>;
}

/**
* @since Chrome 89
*/
typedef TabActionCountUpdate = {

	/**
	* The tab for which to update the action count.
	*/
	var tabId : Int;

	/**
	* The amount to increment the tab's action count by.
	* Negative values will decrement the count.
	*/
	var increment : Int;
}

/**
* @since Chrome 88
*/
typedef ExtensionActionOptions = {
	/**
	* Whether to automatically display the action count for a page as the extension's badge text.
	* This preference is persisted across sessions.
	*/
	var ?displayActionCountAsBadgeText : Bool;

	/**
	* Details of how the tab's action count should be adjusted.
	*
	* @since Chrome 89
	*/
	var ?tabUpdate : TabActionCountUpdate;
}
