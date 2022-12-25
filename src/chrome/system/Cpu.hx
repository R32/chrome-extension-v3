package chrome.system;

/**
* Use the `system.cpu` API to query CPU metadata.
*
* @chrome-permission system.cpu
*/
@:native("chrome.system.cpu")
extern class Cpu {
	/**
	* Queries basic CPU information of the system.
	*/
	overload static function getInfo( callback : CpuInfo->Void ) : Void;
	overload static function getInfo() : Promise<CpuInfo>;
}

typedef CpuTime = {
	/**
	* The cumulative time used by userspace programs on this processor.
	*/
	var user : Float;

	/**
	* The cumulative time used by kernel programs on this processor.
	*/
	var kernel : Float;

	/**
	* The cumulative time spent idle by this processor.
	*/
	var idle : Float;

	/**
	* The total cumulative time for this processor. This value is equal to user + kernel + idle.
	*/
	var total : Float;
}

typedef ProcessorInfo = {
	/**
	* Cumulative usage info for this logical processor.
	*/
	var usage : CpuTime;
}

typedef CpuInfo = {
	/**
	* The number of logical processors.
	*/
	var numOfProcessors : Int;

	/**
	* The architecture name of the processors.
	*/
	var archName : String;

	/**
	* The model name of the processors.
	*/
	var modelName : String;

	/**
	* A set of feature codes indicating some of the processor's capabilities.
	* The currently supported codes are "mmx", "sse", "sse2", "sse3", "ssse3",
	* "sse4\_1", "sse4\_2", and "avx".
	*/
	var features : Array<String>;

	/**
	* Information about each logical processor.
	*/
	var processors : Array<ProcessorInfo>;

	/**
	* List of CPU temperature readings from each thermal zone of the CPU.
	* Temperatures are in degrees Celsius.
	*
	* **Currently supported on Chrome OS only.**
	*
	* @since Chrome 60
	*/
	var temperatures : Array<Float>;
}
