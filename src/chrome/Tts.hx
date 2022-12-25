package chrome;

import chrome.TtsEngine.VoiceGender;

/**
* Use the `chrome.tts` API to play synthesized text-to-speech (TTS).
* See also the related {@link ttsEngine} API, which allows an extension
* to implement a speech engine.
*
* @chrome-permission tts
*/
@:native("chrome.tts")
extern class Tts {
	/**
	* Speaks text using a text-to-speech engine.
	*
	* @param utterance The text to speak, either plain text or a complete,
	* well-formed SSML document. Speech engines that do not support SSML will
	* strip away the tags and speak the text. The maximum length of the text
	* is 32,768 characters.
	* @param options The speech options.
	* @param callback Called right away, before speech finishes.
	* Check {@link runtime.lastError} to make sure there were no errors.
	* Use options.onEvent to get more detailed feedback.
	*/
	overload static function speak( utterance : String, callback : ()->Void ) : Void;
	overload static function speak( utterance : String, options : TtsOptions, callback : ()->Void ) : Void;
	overload static function speak( utterance : String, ?options : TtsOptions ) : Promise<Void>;

	/**
	* Stops any current speech and flushes the queue of any pending utterances.
	* In addition, if speech was paused, it will now be un-paused for the next call to speak.
	*/
	static function stop() : Void;

	/**
	* Pauses speech synthesis, potentially in the middle of an utterance.
	* A call to resume or stop will un-pause speech.
	*/
	static function pause() : Void;

	/**
	* If speech was paused, resumes speaking where it left off.
	*/
	static function resume() : Void;

	/**
	* @param speaking True if speaking, false otherwise.
	*/
	overload static function isSpeaking( callback : (speaking : Bool)->Void) : Void;
	overload static function isSpeaking() : Promise<Bool>;

	/**
	* Gets an array of all available voices.
	*/
	overload static function getVoices( callback : (Array<TtsVoice>)->Void) : Void;
	overload static function getVoices() : Promise<Array<TtsVoice>>;
}

/**
* @since Chrome 54
*/
extern enum abstract EventType(String) to String {
	var START = "start";
	var END = "end";
	var WORD = "word";
	var SENTENCE = "sentence";
	var MARKER = "marker";
	var INTERRUPTED = "interrupted";
	var CANCELLED = "cancelled";
	var ERROR = "error";
	var PAUSE = "pause";
	var RESUME = "resume";
}

/**
* The speech options for the TTS engine.
*
* @since Chrome 77
*/
typedef TtsOptions = {

	/**
	* If true, enqueues this utterance if TTS is already in progress. If false (the default), interrupts any current speech and flushes the speech queue before speaking this new utterance.
	*/
	var ?enqueue : Bool;

	/**
	* The name of the voice to use for synthesis. If empty, uses any available voice.
	*/
	var ?voiceName : String;

	/**
	* The extension ID of the speech engine to use, if known.
	*/
	var ?extensionId : String;

	/**
	* The language to be used for synthesis, in the form _language_\-_region_.
	* Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
	*/
	var ?lang : String;

	/**
	* Gender of voice for synthesized speech.
	*
	* @deprecated Gender is deprecated and will be ignored.
	* @chrome-deprecated-since Chrome 77
	*/
	var ?gender : VoiceGender;

	/**
	* Speaking rate relative to the default rate for this voice.
	* 1.0 is the default rate, normally around 180 to 220 words per minute.
	* 2.0 is twice as fast, and 0.5 is half as fast. Values below 0.1 or above 10.0
	* are strictly disallowed, but many voices will constrain the minimum and
	* maximum rates further—for example a particular voice may not actually
	* speak faster than 3 times normal even if you specify a value larger than 3.0.
	*/
	var ?rate : Float;

	/**
	* Speaking pitch between 0 and 2 inclusive, with 0 being lowest
	* and 2 being highest. 1.0 corresponds to a voice's default pitch.
	*/
	var ?pitch : Float;

	/**
	* Speaking volume between 0 and 1 inclusive, with 0 being lowest
	* and 1 being highest, with a default of 1.0.
	*/
	var ?volume : Float;

	/**
	* The TTS event types the voice must support.
	*/
	var ?requiredEventTypes : Array<String>;

	/**
	* The TTS event types that you are interested in listening to.
	* If missing, all event types may be sent.
	*/
	var ?desiredEventTypes : Array<String>;

	/**
	* This function is called with events that occur in the process
	* of speaking the utterance.
	*
	* @param event The update event from the text-to-speech engine
	* indicating the status of this utterance.
	*/
	var ?onEvent : (event : TtsEvent)->Void;
}

/**
* An event from the TTS engine to communicate the status of an utterance.
*/
typedef TtsEvent = {

	/**
	* The type can be `start` as soon as speech has started, `word` when a word boundary is reached, `sentence` when a sentence boundary is reached, `marker` when an SSML mark element is reached, `end` when the end of the utterance is reached, `interrupted` when the utterance is stopped or interrupted before reaching the end, `cancelled` when it's removed from the queue before ever being synthesized, or `error` when any other error occurs. When pausing speech, a `pause` event is fired if a particular utterance is paused in the middle, and `resume` if an utterance resumes speech. Note that pause and resume events may not fire if speech is paused in-between utterances.
	*/
	var type : EventType;

	/**
	* The index of the current character in the utterance. For word events, the event fires at the end of one word and before the beginning of the next. The `charIndex` represents a point in the text at the beginning of the next word to be spoken.
	*/
	var ?charIndex : Int;

	/**
	* The error description, if the event type is `error`.
	*/
	var ?errorMessage : String;

	/**
	* The length of the next part of the utterance. For example, in a `word` event, this is the length of the word which will be spoken next. It will be set to -1 if not set by the speech engine.
	*
	* @since Chrome 74
	*/
	var ?length : Int;
}

/**
* A description of a voice available for speech synthesis.
*/
typedef TtsVoice = {

	/**
	* The name of the voice.
	*/
	var ?voiceName : String;

	/**
	* The language that this voice supports, in the form _language_\-_region_.
	* Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
	*/
	var ?lang : String;

	/**
	* This voice's gender.
	*
	* @deprecated Gender is deprecated and will be ignored.
	* @chrome-deprecated-since Chrome 70
	*/
	var ?gender : VoiceGender;

	/**
	* If true, the synthesis engine is a remote network resource.
	* It may be higher latency and may incur bandwidth costs.
	*/
	var ?remote : Bool;

	/**
	* The ID of the extension providing this voice.
	*/
	var ?extensionId : String;

	/**
	* All of the callback event types that this voice is capable of sending.
	*/
	var ?eventTypes : Array<EventType>;
}
