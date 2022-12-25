package chrome;

/**
* Use the `chrome.ttsEngine` API to implement a text-to-speech(TTS) engine
* using an extension. If your extension registers using this API,
* it will receive events containing an utterance to be spoken and other parameters
* when any extension or Chrome App uses the {@link tts} API to generate speech.
* Your extension can then use any available web technology to synthesize and
* output the speech, and send events back to the calling function to report the status.
*
* @chrome-permission ttsEngine
*/
@:native("chrome.ttsEngine")
extern class TtsEngine {
	/**
	* Called when the user makes a call to tts.speak() and one of the voices
	* from this extension's manifest is the first to match the options object.
	*/
	static final onSpeak: Event<(
		utterance : String,
		options : SpeakOptions,
		/**
		* @param event The event from the text-to-speech engine indicating
		* the status of this utterance.
		*/
	sendTtsEvent : Tts.TtsEvent->Void
	) -> Void>;

	/**
	* Called when the user makes a call to tts.speak() and one of the voices
	* from this extension's manifest is the first to match the options object.
	* Differs from ttsEngine.onSpeak in that Chrome provides audio playback
	* services and handles dispatching tts events.
	*
	* @since Chrome 92
	*/
	static final onSpeakWithAudioStream : Event<(
		utterance : String,
		options : SpeakOptions,
		audioStreamOptions : AudioStreamOptions,
		/**
		* @param audioBufferParams Parameters containing an audio buffer
		* and associated data.
		*/
		sendTtsAudio : AudioBuffer->Void,
		/**
		* @param errorMessage A string describing the error.
		* @since Chrome 94
		*/
		sendError : (?errorMessage : String) -> Void
	)->Void>;

	/**
	* Fired when a call is made to tts.stop and this extension may be in
	* the middle of speaking. If an extension receives a call to onStop
	* and speech is already stopped, it should do nothing (not raise an error).
	* If speech is in the paused state, this should cancel the paused state.
	*/
	static final onStop : Event<()->Void>;

	/**
	* Optional: if an engine supports the pause event, it should pause the
	* current utterance being spoken, if any, until it receives a resume
	* event or stop event. Note that a stop event should also clear the paused state.
	*/
	static final onPause : Event<()->Void>;

	/**
	* Optional: if an engine supports the pause event, it should also support
	* the resume event, to continue speaking the current utterance,
	* if any. Note that a stop event should also clear the paused state.
	*/
	static final onResume : Event<()->Void>;

	/**
	* Called by an engine to update its list of voices. This list overrides any voices declared in this extension's manifest.
	*
	* @param voices Array of {@link tts.TtsVoice} objects representing the available voices for speech synthesis.
	* @since Chrome 66
	*/
	static function updateVoices( voices : Array<Tts.TtsVoice> ) : Void;

}

/**
* @deprecated Gender is deprecated and will be ignored.
* @since Chrome 54
* @chrome-deprecated-since Chrome 70
*/
@:deprecated
extern enum abstract VoiceGender(String) to String {
	var MALE = "male";
	var FEMALE = "female";
}

/**
* Options specified to the tts.speak() method.
*
* @since Chrome 92
*/
typedef SpeakOptions = {
	/**
	* The name of the voice to use for synthesis.
	*/
	var ?voiceName : String;

	/**
	* The language to be used for synthesis, in the form _language_\-_region_.
	* Examples: 'en', 'en-US', 'en-GB', 'zh-CN'.
	*/
	var ?lang : String;

	/**
	* Gender of voice for synthesized speech.
	*
	* @deprecated Gender is deprecated and will be ignored.
	* @chrome-deprecated-since Chrome 92
	*/
	var ?gender : VoiceGender;

	/**
	* Speaking rate relative to the default rate for this voice.
	* 1.0 is the default rate, normally around 180 to 220 words per minute.
	* 2.0 is twice as fast, and 0.5 is half as fast.
	* This value is guaranteed to be between 0.1 and 10.0, inclusive.
	* When a voice does not support this full range of rates, don't return an error.
	* Instead, clip the rate to the range the voice supports.
	*/
	var ?rate : Float;

	/**
	* Speaking pitch between 0 and 2 inclusive,
	* with 0 being lowest and 2 being highest.
	* 1.0 corresponds to this voice's default pitch.
	*/
	var ?pitch : Float;

	/**
	* Speaking volume between 0 and 1 inclusive,
	* with 0 being lowest and 1 being highest, with a default of 1.0.
	*/
	var ?volume : Float;
}

/**
* Contains the audio stream format expected to be produced by an engine.
*
* @since Chrome 92
*/
typedef AudioStreamOptions = {

	/**
	* The sample rate expected in an audio buffer.
	*/
	var sampleRate : Float;

	/**
	* The number of samples within an audio buffer.
	*/
	var bufferSize : Int;
}

/**
* Parameters containing an audio buffer and associated data.
*
* @since Chrome 92
*/
typedef AudioBuffer = {

	/**
	* The audio buffer from the text-to-speech engine. It should have length exactly audioStreamOptions.bufferSize and encoded as mono, at audioStreamOptions.sampleRate, and as linear pcm, 32-bit signed float i.e. the Float32Array type in javascript.
	*/
	var audioBuffer : ArrayBuffer;

	/**
	* The character index associated with this audio buffer.
	*/
	var ?charIndex : Int;

	/**
	* True if this audio buffer is the last for the text being spoken.
	*/
	var ?isLastBuffer : Bool;
}
