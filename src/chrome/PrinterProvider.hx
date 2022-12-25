package chrome;

/**
* The `chrome.printerProvider` API exposes events used by print manager to
* query printers controlled by extensions, to query their capabilities and
* to submit print jobs to these printers.
*
* @since Chrome 44
* @chrome-permission printerProvider
*/
@:native("chrome.printerProvider")
extern class PrinterProvider {
	/**
	* Event fired when print manager requests printers provided by extensions.
	*/
	static final onGetPrintersRequested : Event < (
		callback : (printerInfos : Array<PrinterInfo>)->Void
	)->Void> ;

	/**
	* Event fired when print manager requests information about a USB device that may be a printer.
	*
	* _Note:_ An application should not rely on this event being fired more than once per device.
	* If a connected device is supported it should be returned in the {@link onGetPrintersRequested} event.
	*
	* @since Chrome 45
	*/
	static final onGetUsbPrinterInfoRequested : Event<(
		device : Dynamic, // TODO: usb.Device,
		callback : (?printerInfo : PrinterInfo)->Void
	)->Void>;

	/**
	* Event fired when print manager requests printer capabilities.
	*/
	static final onGetCapabilityRequested : Event<(
		printerId : String,
		callback : (capabilities : Dynamic)->Void
	)->Void>;

	/**
	* Event fired when print manager requests printing.
	*/
	static final onPrintRequested : Event<(
		printJob: PrintJob,
		callback : (result : PrintError)->Void
	)->Void>;
}

/**
* Error codes returned in response to {@link onPrintRequested} event.
*
* @chrome-enum "OK" Operation completed successfully.
* @chrome-enum "FAILED" General failure.
* @chrome-enum "INVALID\_TICKET" Print ticket is invalid. For example, ticket is inconsistent with capabilities or extension is not able to handle all settings from the ticket.
* @chrome-enum "INVALID\_DATA" Document is invalid. For example, data may be corrupted or the format is incompatible with the extension.
*/
extern enum abstract PrintError(String) to String {
	var OK = "OK";
	var FAILED = "FAILED";
	var INVALID_TICKET = "INVALID_TICKET";
	var INVALID_DATA = "INVALID_DATA";
}


typedef PrinterInfo = {

	/**
	* Unique printer ID.
	*/
	var id : String;

	/**
	* Printer's human readable name.
	*/
	var name : String;

	/**
	* Printer's human readable description.
	*/
	var ?description : String;
}

typedef PrintJob = {

	/**
	* ID of the printer which should handle the job.
	*/
	var printerId : String;

	/**
	* The print job title.
	*/
	var title : String;

	/**
	* Print ticket in [CJT format](https://developers.google.com/cloud-print/docs/cdd#cjt).
	*/
	var ticket : Dynamic; // {[name: string]: any}

	/**
	* The document content type. Supported formats are `"application/pdf"` and `"image/pwg-raster"`.
	*/
	var contentType : String;

	/**
	* Blob containing the document data to print. Format must match `contentType`.
	*/
	var document : js.html.Blob;
}