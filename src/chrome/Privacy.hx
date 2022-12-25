package chrome;

/**
* Use the `chrome.privacy` API to control usage of the features in Chrome
* that can affect a user's privacy. This API relies on the
* [ChromeSetting prototype of the type API](https://developer.chrome.com/docs/extensions/reference/types/#ChromeSetting)
* for getting and setting Chrome's configuration.
*
* @chrome-permission privacy
*/
@:native("chrome.privacy")
extern class Privacy {

	/**
	* Settings that influence Chrome's handling of network connections in general.
	*/
	static final network : {
		/**
		* If enabled, Chrome attempts to speed up your web browsing experience by pre-resolving DNS entries and preemptively opening TCP and SSL connections to servers. This preference only affects actions taken by Chrome's internal prediction service. It does not affect webpage-initiated prefectches or preconnects. This preference's value is a boolean, defaulting to `true`.
		*/
		networkPredictionEnabled : Types.ChromeSetting<Bool>,

		/**
		* Allow users to specify the media performance/privacy tradeoffs which impacts how WebRTC traffic will be routed and how much local address information is exposed. This preference's value is of type IPHandlingPolicy, defaulting to `default`.
		*
		* @since Chrome 48
		*/
		webRTCIPHandlingPolicy : Types.ChromeSetting<IPHandlingPolicy>,
	};

	/**
	* Settings that enable or disable features that require third-party network
	* services provided by Google and your default search provider.
	*/
	static final services: {

		/**
		* If enabled, Chrome uses a web service to help resolve navigation errors.
		* This preference's value is a boolean, defaulting to `true`.
		*/
		alternateErrorPagesEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome offers to automatically fill in forms.
		* This preference's value is a boolean, defaulting to `true`.
		*
		* @deprecated Please use privacy.services.autofillAddressEnabled and privacy.services.autofillCreditCardEnabled. This remains for backward compatibility in this release and will be removed in the future.
		* @chrome-deprecated-since Chrome 70
		*/
		autofillEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome offers to automatically fill in addresses and other form data.
		* This preference's value is a Bool, defaulting to `true`.
		*
		* @since Chrome 70
		*/
		autofillAddressEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome offers to automatically fill in credit card forms.
		* This preference's value is a Bool, defaulting to `true`.
		*
		* @since Chrome 70
		*/
		autofillCreditCardEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, the password manager will ask if you want to save passwords.
		* This preference's value is a Bool, defaulting to `true`.
		*/
		passwordSavingEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome does its best to protect you from phishing and malware.
		* This preference's value is a Bool, defaulting to `true`.
		*/
		safeBrowsingEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome will send additional information to Google when
		* SafeBrowsing blocks a page, such as the content of the blocked page.
		* This preference's value is a boolean, defaulting to `false`.
		*/
		safeBrowsingExtendedReportingEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome sends the text you type into the Omnibox to your
		* default search engine, which provides predictions of websites and
		* searches that are likely completions of what you've typed so far.
		* This preference's value is a boolean, defaulting to `true`.
		*/
		searchSuggestEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome uses a web service to help correct spelling errors.
		* This preference's value is a boolean, defaulting to `false`.
		*/
		spellingServiceEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome offers to translate pages that aren't in a language you read.
		* This preference's value is a boolean, defaulting to `true`.
		*/
		translationServiceEnabled : Types.ChromeSetting<Bool>,
	};

	/**
	* Settings that determine what information Chrome makes available to websites.
	*/
	static final websites : {

		/**
		* If disabled, Chrome blocks third-party sites from setting cookies.
		* The value of this preference is of type boolean, and the default value is `true`.
		*/
		thirdPartyCookiesAllowed : Types.ChromeSetting<Bool>,

		/**
		* If enabled, the experimental [Privacy Sandbox](”https://www.chromium.org/Home/chromium-privacy/privacy-sandbox”) features are active. The value of this preference is of type boolean, and the default value is `true`. PLEASE NOTE: The schema of this API may change in the future as the Privacy Sandbox features crystallize. In that case, we will provide prior notice.
		*
		* @since Chrome 90
		*/
		privacySandboxEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome sends auditing pings when requested by a website (`<a ping>`).
		* The value of this preference is of type boolean, and the default value is `true`.
		*/
		hyperlinkAuditingEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome sends `referer` headers with your requests.
		* Yes, the name of this preference doesn't match the misspelled header.
		* No, we're not going to change it.
		* The value of this preference is of type boolean,
		* and the default value is `true`.
		*/
		referrersEnabled : Types.ChromeSetting<Bool>,

		/**
		* If enabled, Chrome sends 'Do Not Track' (`DNT: 1`) header with your requests.
		* The value of this preference is of type boolean, and the default value is `false`.
		*
		* @since Chrome 65
		*/
		doNotTrackEnabled : Types.ChromeSetting<Bool>,

		/**
		* **Available on Windows and ChromeOS only**: If enabled,
		* Chrome provides a unique ID to plugins in order to run protected content.
		* The value of this preference is of type boolean, and the default value is `true`.
		*/
		protectedContentEnabled : Types.ChromeSetting<Bool>,
	};
}

/**
* The IP handling policy of WebRTC.
*
* @since Chrome 48
*/
extern enum abstract IPHandlingPolicy(String) to String {
	var DEFAULT = "default";
	var DEFAULT_PUBLIC_AND_PRIVATE_INTERFACES = "default_public_and_private_interfaces";
	var DEFAULT_PUBLIC_INTERFACE_ONLY = "default_public_interface_only";
	var DISABLE_NON_PROXIED_UDP = "disable_non_proxied_udp";
}
