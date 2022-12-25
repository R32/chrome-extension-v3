package chrome;

/**
* The `chrome.audio` API is provided to allow users to get information about and control the audio devices attached to the system. This API is currently only available in kiosk mode for ChromeOS.
*
* @since Chrome 59
* @chrome-permission audio
* @chrome-platform chromeos
* @chrome-platform lacros
*/
@:native("chrome.audio")
extern class Audio {
	/**
	* Fired when sound level changes for an active audio device.
	*/
	static final onLevelChanged : Event<LevelChangedEvent->Void>;

	/**
	* Fired when the mute state of the audio input or output changes.
	* Note that mute state is system-wide and the new value applies to
	* every audio device with specified stream type.
	*/
	static final onMuteChanged : Event<MuteChangedEvent->Void>;

	/**
	* Fired when audio devices change, either new devices being added,
	* or existing devices being removed.
	*/
	static final onDeviceListChanged : Event<(Array<AudioDeviceInfo>)->Void>;

	/**
	* Gets a list of audio devices filtered based on `filter`.
	*
	* @param filter Device properties by which to filter the list of returned audio devices. If the filter is not set or set to `{}`, returned device list will contain all available audio devices.
	* @param callback Reports the requested list of audio devices.
	*/
	overload static function getDevices( callback : (Array<AudioDeviceInfo>)->Void ) : Void;
	overload static function getDevices( filter : DeviceFilter, callback : (Array<AudioDeviceInfo>)->Void ) : Void;

	/**
	* Sets lists of active input and/or output devices.
	*
	* @param ids Specifies IDs of devices that should be active.
	* If either the input or output list is not set,
	* devices in that category are unaffected.
	* It is an error to pass in a non-existent device ID.
	*/
	static function setActiveDevices( ids : DeviceIdLists, callback : ()->Void ) : Void;

	/**
	* Sets the properties for the input or output device.
	*/
	static function setProperties( id : String, props : DeviceProperties, callback : ()->Void ) : Void;

	/**
	* Gets the system-wide mute state for the specified stream type.
	*
	* @param streamType Stream type for which mute state should be fetched.
	* @param callback Callback reporting whether mute is set or not for specified stream type.
	*/
	static function getMute( streamType : StreamType, callback : Bool->Void ) : Void;

	/**
	* Sets mute state for a stream type. The mute state will apply to all audio devices with the specified audio stream type.
	*
	* @param streamType Stream type for which mute state should be set.
	* @param isMuted New mute value.
	*/
	static function setMute( streamType : StreamType, isMuted : Bool, ?callback : ()->Void ) : Void;
}

/**
* Type of stream an audio device provides.
*/
extern enum abstract StreamType(String) to String {
	var INPUT = "INPUT";
	var OUTPUT = "OUTPUT";
}

/**
* Available audio device types.
*/
extern enum abstract DeviceType(String) to String {
	var HEADPHONE = "HEADPHONE";
	var MIC = "MIC";
	var USB = "USB";
	var BLUETOOTH = "BLUETOOTH";
	var HDMI = "HDMI";
	var INTERNAL_SPEAKER = "INTERNAL_SPEAKER";
	var INTERNAL_MIC = "INTERNAL_MIC";
	var FRONT_MIC = "FRONT_MIC";
	var REAR_MIC = "REAR_MIC";
	var KEYBOARD_MIC = "KEYBOARD_MIC";
	var HOTWORD = "HOTWORD";
	var LINEOUT = "LINEOUT";
	var POST_MIX_LOOPBACK = "POST_MIX_LOOPBACK";
	var POST_DSP_LOOPBACK = "POST_DSP_LOOPBACK";
	var ALSA_LOOPBACK = "ALSA_LOOPBACK";
	var OTHER = "OTHER";
}

typedef AudioDeviceInfo = {
	/**
	* The unique identifier of the audio device.
	*/
	var id : String;

	/**
	* Stream type associated with this device.
	*/
	var streamType : StreamType;

	/**
	* Type of the device.
	*/
	var deviceType : DeviceType;

	/**
	* The user-friendly name (e.g. "USB Microphone").
	*/
	var displayName : String;

	/**
	* Device name.
	*/
	var deviceName : String;

	/**
	* True if this is the current active device.
	*/
	var isActive : Bool;

	/**
	* The sound level of the device, volume for output, gain for input.
	*/
	var level : Float;

	/**
	* The stable/persisted device id string when available.
	*/
	var ?stableDeviceId : String;
}

typedef DeviceFilter = {
	/**
	* If set, only audio devices whose stream type is included in this list will satisfy the filter.
	*/
	var ?streamTypes : Array<StreamType>;

	/**
	* If set, only audio devices whose active state matches this value will satisfy the filter.
	*/
	var ?isActive : Bool;
}

typedef DeviceProperties = {
	/**
	* The audio device's desired sound level. Defaults to the device's current sound level.
	*
	* If used with audio input device, represents audio device gain.
	*
	* If used with audio output device, represents audio device volume.
	*/
	var ?level : Float;
}

typedef DeviceIdLists = {
	/**
	* List of input devices specified by their ID.
	*
	* To indicate input devices should be unaffected, leave this property unset.
	*/
	var ?input : Array<String>;

	/**
	* List of output devices specified by their ID.
	*
	* To indicate output devices should be unaffected, leave this property unset.
	*/
	var ?output : Array<String>;
}

typedef MuteChangedEvent = {
	/**
	* The type of the stream for which the mute value changed. The updated mute value applies to all devices with this stream type.
	*/
	var streamType : StreamType;

	/**
	* Whether or not the stream is now muted.
	*/
	var isMuted : Bool;
}

typedef LevelChangedEvent = {
	/**
	* ID of device whose sound level has changed.
	*/
	var deviceId : String;

	/**
	* The device's new sound level.
	*/
	var level : Float;
}
