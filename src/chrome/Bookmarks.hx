package chrome;

/**
* Use the `chrome.bookmarks` API to create, organize, and otherwise manipulate bookmarks.
* Also see [Override Pages](https://developer.chrome.com/docs/extensions/override),
* which you can use to create a custom Bookmark Manager page.
*
* @chrome-permission bookmarks
*/
@:native("chrome.bookmarks")
extern class Bookmarks {
	/**
	* @deprecated Bookmark write operations are no longer limited by Chrome.
	*/
	@:deprecated
	static inline var MAX_WRITE_OPERATIONS_PER_HOUR = 1000000;

	/**
	* @deprecated Bookmark write operations are no longer limited by Chrome.
	*/
	@:deprecated
	static inline var MAX_SUSTAINED_WRITE_OPERATIONS_PER_MINUTE = 1000000;

	/**
	* Fired when a bookmark or folder is created.
	*/
	static final onCreated : Event<(id : String, bookmark : BookmarkTreeNode)->Void> ;

	/**
	* Fired when a bookmark or folder is removed. When a folder is removed recursively,
	* a single notification is fired for the folder, and none for its contents.
	*/
	static final onRemoved : Event<(id : String, info : {parentId : String, index : Int, node : BookmarkTreeNode})->Void>;

	/**
	* Fired when a bookmark or folder changes. **Note:** Currently,
	* only title and url changes trigger this.
	*/
	static final onChanged : Event<(id : String, info : {title : String, ?url : String})->Void>;

	/**
	* Fired when a bookmark or folder is moved to a different parent folder.
	*/
	static final onMoved : Event<(id : String, info : {parentId : String, index : Int, oldParentId : String, oldIndex : Int})->Void>;

	/**
	* Fired when the children of a folder have changed their order due to the
	* order being sorted in the UI. This is not called as a result of a move().
	*/
	static final onChildrenReordered : Event<(id : String, info : {childIds : Array<String>})->Void>;

	/**
	* Fired when a bookmark import session is begun. Expensive observers should
	* ignore onCreated updates until onImportEnded is fired.
	* Observers should still handle other notifications immediately.
	*/
	static final onImportBegan : Event <()->Void> ;

	/**
	* Fired when a bookmark import session is ended.
	*/
	static final onImportEnded : Event <()->Void> ;

	/**
	* Retrieves the specified BookmarkTreeNode(s).
	*
	* @param idOrIdList A single string-valued id, or an array of string-valued ids
	*/
	overload static function get( idOrIdList : EitherType<String, Array<Dynamic>>, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function get( idOrIdList : EitherType<String, Array<Dynamic>> ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Retrieves the children of the specified BookmarkTreeNode id.
	*/
	overload static function getChildren( id : String, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function getChildren( id : String ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Retrieves the recently added bookmarks.
	*
	* @param numberOfItems The maximum number of items to return.
	*/
	overload static function getRecent( numberOfItems : Int, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function getRecent( numberOfItems : Int ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Retrieves the entire Bookmarks hierarchy.
	*/
	overload static function getTree( callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function getTree() : Promise<Array<BookmarkTreeNode>>;

	/**
	* Retrieves part of the Bookmarks hierarchy, starting at the specified node.
	*
	* @param id The ID of the root of the subtree to retrieve.
	*/
	overload static function getSubTree( id : String, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function getSubTree( id : String ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Searches for BookmarkTreeNodes matching the given query. Queries specified
	* with an object produce BookmarkTreeNodes matching all specified properties.
	*
	* @param query Either a string of words and quoted phrases that are matched
	* against bookmark URLs and titles, or an object. If an object,
	* the properties `query`, `url`, and `title` may be specified and bookmarks
	* matching all specified properties will be produced.
	*/
	overload static function search( query : EitherType<String, SearchQuery>, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function search( query : EitherType<String, SearchQuery> ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Creates a bookmark or folder under the specified parentId.
	* If url is NULL or missing, it will be a folder.
	*/
	overload static function create( bookmark : CreateDetails, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function create( bookmark : CreateDetails ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Moves the specified BookmarkTreeNode to the provided location.
	*/
	overload static function move( id : String, desc : {?parentId : String, ?index : Int}, callback : (Array<BookmarkTreeNode>)->Void ) : Void;
	overload static function move( id : String, desc : {?parentId : String, ?index : Int} ) : Promise<Array<BookmarkTreeNode>>;

	/**
	* Updates the properties of a bookmark or folder.
	* Specify only the properties that you want to change;
	* unspecified properties will be left unchanged.
	* **Note:** Currently, only 'title' and 'url' are supported.
	*/
	overload static function update( id : String, changes : {?title : String, ?url : String}, callback : BookmarkTreeNode->Void ) : Void;
	overload static function update( id : String, changes : {?title : String, ?url : String} ) : Promise<BookmarkTreeNode>;

	/**
	* Removes a bookmark or an empty bookmark folder.
	*/
	overload static function remove( id : String, callback : ()->Void ) : Void;
	overload static function remove( id : String ) : Promise<Void>;

	/**
	* Recursively removes a bookmark folder.
	*/
	overload static function removeTree( id : String, callback : ()->Void ) : Void;
	overload static function removeTree( id : String ) : Promise<Void>;
}

private typedef SearchQuery = {
	/**
	* A string of words and quoted phrases that are matched against bookmark URLs and titles.
	*/
	var ?query : String;

	/**
	* The URL of the bookmark; matches verbatim. Note that folders have no URL.
	*/
	var ?url : String;

	/**
	* The title of the bookmark; matches verbatim.
	*/
	var ?title : String;
}

/**
* Indicates the reason why this node is unmodifiable.
* The `managed` value indicates that this node was configured by the system administrator.
* Omitted if the node can be modified by the user and the extension (default).
*
* @since Chrome 44
*/
extern enum abstract BookmarkTreeNodeUnmodifiable(String) to String {
	var MANAGED = "managed";
}

/**
* A node (either a bookmark or a folder) in the bookmark tree.
* Child nodes are ordered within their parent folder.
*/
typedef BookmarkTreeNode = {
	/**
	* The unique identifier for the node. IDs are unique within the current profile,
	* and they remain valid even after the browser is restarted.
	*/
	var id : String;

	/**
	* The `id` of the parent folder. Omitted for the root node.
	*/
	var ?parentId : String;

	/**
	* The 0-based position of this node within its parent folder.
	*/
	var ?index : Int;

	/**
	* The URL navigated to when a user clicks the bookmark. Omitted for folders.
	*/
	var ?url : String;

	/**
	* The text displayed for the node.
	*/
	var title : String;

	/**
	* When this node was created, in milliseconds since the epoch (`new Date(dateAdded)`).
	*/
	var ?dateAdded : Float;

	/**
	* When the contents of this folder last changed, in milliseconds since the epoch.
	*/
	var ?dateGroupModified : Float;

	/**
	* Indicates the reason why this node is unmodifiable. The `managed` value
	* indicates that this node was configured by the system administrator or
	* by the custodian of a supervised user. Omitted if the node can be
	* modified by the user and the extension (default).
	*/
	var ?unmodifiable : BookmarkTreeNodeUnmodifiable;

	/**
	* An ordered list of children of this node.
	*/
	var ?children : Array<BookmarkTreeNode>;
}

/**
* Object passed to the create() function.
*/
typedef CreateDetails = {
	/**
	* Defaults to the Other Bookmarks folder.
	*/
	var ?parentId : String;

	var ?index : Int;

	var ?title : String;

	var ?url : String;
}
