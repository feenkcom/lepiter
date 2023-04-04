Class {
	#name : #LeWardleyMapSnippet,
	#superclass : #LeSnippet,
	#traits : 'TLeSnippetWithHeight',
	#classTraits : 'TLeSnippetWithHeight classTrait',
	#instVars : [
		'wardleyMap'
	],
	#category : #'Lepiter-Snippet-WardleyMap-Snippet'
}

{ #category : #'api - accessing menu' }
LeWardleyMapSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Wardley Map'
]

{ #category : #accessing }
LeWardleyMapSnippet class >> defaultHeight [
	^ 300
]

{ #category : #factory }
LeWardleyMapSnippet class >> empty [
	^ self new
]

{ #category : #'lepiter-store' }
LeWardleyMapSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#wardleyMapDictionary -> #wardleyMapDictionary);
		"accessor in the snippet -> key in the json"
		add: (#height -> #snippetHeight);
		yourself
]

{ #category : #'lepiter-store' }
LeWardleyMapSnippet class >> leJsonV3Name [

	^ 'wardleyMap'
]

{ #category : #'lepiter-store' }
LeWardleyMapSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#wardleyMapDictionary -> #wardleyMapDictionary);
		"accessor in the snippet -> key in the json"
		add: (#height -> #snippetHeight);
		yourself
]

{ #category : #'lepiter-store' }
LeWardleyMapSnippet class >> leJsonV4Name [

	^ 'wardleyMap'
]

{ #category : #'private - notifications' }
LeWardleyMapSnippet >> announceWardleyMapChangedBy: aSourceObject [
	"Notify all dependents that the snippet's Wardley map has changed"

	self notifyAnnouncement: (LeSnippetWardleyMapChanged new
		source: aSourceObject;
		snippet: self)
]

{ #category : #accessing }
LeWardleyMapSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeWardleyMapSnippetViewModel new snippetModel: self
]

{ #category : #'api - accessing' }
LeWardleyMapSnippet >> contentAsString [
	"Return a content, e.g., title or string"
	<return: #String>

	^ 'wardley map'
]

{ #category : #'api - links' }
LeWardleyMapSnippet >> createLinkFromNode: aWardleyMapNodeModel toPageNamed: aPageName [
	| anOriginReference aTargetReference |

	self
		linkForNode: aWardleyMapNodeModel
		ifFound: [ :aLink | self database removeExplicitLinks: { aLink } ].

	anOriginReference := (LeWardleyMapNodeReference forSnippetUid: self uid)
		nodeUUID: aWardleyMapNodeModel id.
	
	"today it only works if there is a page"
	aTargetReference := LeLinkPageUidReference
		forPageUid: (self database pageNamed: aPageName) uid.
		
	self database addExplicitLink: (LeAttachedLink new 
		originReference: anOriginReference;
		targetReference: aTargetReference)
]

{ #category : #accessing }
LeWardleyMapSnippet >> defaultHeight [
	^ self class defaultHeight
]

{ #category : #'api - actions' }
LeWardleyMapSnippet >> detachWardleyMap [
	self wardleyMap ifNotNil: [ :aWardleyMap |
		aWardleyMap unsubscribe: self ]
]

{ #category : #accessing }
LeWardleyMapSnippet >> gtWardleyScriptFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Wardley Script';
		priority: 9;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ GtWardleyMapParser gtStyler ];
		text: [ self wardleyMap asWardleyMapScript ];
		actionUpdateButtonTooltip: 'Update Script';
		actionButtonLabel: 'Import'
			tooltip: 'Create a new Wardley script model'
			action: [ :aButton | 
				| aWardleyMap |
				aWardleyMap := GtWardleyMapScriptImporter
						forString: aButton phlow viewContent textViewContent asString.
				self wardleyMap: aWardleyMap ];
		actionButtonLabel: 'Copy'
			action: [ Clipboard clipboardText: self wardleyMap asWardleyMapScript ]
]

{ #category : #initialization }
LeWardleyMapSnippet >> initialize [
	super initialize.

	height := self defaultHeight.
	wardleyMap := GtWardleyMapModel new
]

{ #category : #'api - links' }
LeWardleyMapSnippet >> linkForNode: aWardleyMapNodeModel ifFound: aFoundBlock [
	| theLinks |
	
	theLinks := self database linksWithOriginReferenceMatching: ((LeWardleyMapNodeReference forSnippetUid: self uid)
		nodeUUID: aWardleyMapNodeModel id).
	theLinks ifEmpty: [ ^ self ].
	
	self
		assert: [ theLinks size = 1 ]
		description: [ 'Only one link is allowed' ].
		
	aFoundBlock value: theLinks first
]

{ #category : #'private - exporting' }
LeWardleyMapSnippet >> markdownOn: stream level: anInteger [
	"This is just a placeholder that only prints 'wardleymap'"
	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		cr;
		<< '```';
		cr;
		<< self contentAsString trimBoth;
		cr;
		<< '```';
		cr.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #'private - hooks' }
LeWardleyMapSnippet >> onRemovedFromDatabase: aDatabase [
	super onRemovedFromDatabase: aDatabase.
	
	self wardleyMap nodes do: [ :eachWardleyNodeModel |
		self
			linkForNode: eachWardleyNodeModel
			ifFound: [ :aLink | self database removeExplicitLinks: { aLink } ]. ]
]

{ #category : #'private - event handling' }
LeWardleyMapSnippet >> onWardleyMapChanged: anAnnouncement [
	"I am sent when wardley map changes, this triggers auto-save of the wardley map snippet"

	self announceContentChanged
]

{ #category : #'private - updating' }
LeWardleyMapSnippet >> reloadAttributesFromContent: aSnippet [
	"Reload the receiver's attributes from the supplied snippet. We need to handle the 
	WardleyMap object directly. We cannot just use the setter wardleyMapDictionary:. The 
	issue with that is that when creating the dictionary UUIDs are exported using the lepiter
	format. However, when using the setter we expect UUID object, as that"
	| changed |
	
	changed := self reloadCommonMetadataFromContent: aSnippet.
	height = aSnippet height ifFalse: [ 
		height := aSnippet height.
		changed := true ].
	wardleyMap = aSnippet wardleyMap ifFalse:  [ 
		"We detach the Wardley map, as we do not need the old snippet anymore."
		aSnippet detachWardleyMap. 
		self wardleyMap: aSnippet wardleyMap.
		changed := true ].
	^ changed
]

{ #category : #printing }
LeWardleyMapSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new wardleyMap: '.
	self wardleyMap storeOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
LeWardleyMapSnippet >> wardleyMap [
	^ wardleyMap
]

{ #category : #accessing }
LeWardleyMapSnippet >> wardleyMap: aNewWardleyMap [
	wardleyMap
		ifNotNil: [ :aPreviousWardleyMap | aPreviousWardleyMap unsubscribe: self ].
	wardleyMap := aNewWardleyMap.
	wardleyMap weak
		when: GtWardleyMapAnnouncement
		send: #onWardleyMapChanged:
		to: self.
	self announceWardleyMapChangedBy: nil
]

{ #category : #'private - export / import' }
LeWardleyMapSnippet >> wardleyMapDictionary [
	^ wardleyMap accept: LeWardleyMapExporter new
]

{ #category : #'private - export / import' }
LeWardleyMapSnippet >> wardleyMapDictionary: aDictionary [
	self wardleyMap: (LeWardleyMapImporter new importWardleyMapFrom: aDictionary)
]
