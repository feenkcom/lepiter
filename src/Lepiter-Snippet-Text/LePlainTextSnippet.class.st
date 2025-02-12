"
I am a common superclass of text-based (not code-based) snippets.
"
Class {
	#name : #LePlainTextSnippet,
	#superclass : #LeTextualSnippet,
	#traits : 'TLeSpotterPagesSearch - {#children. #hasChildren}',
	#classTraits : 'TLeSpotterPagesSearch classTrait',
	#instVars : [
		'text',
		'cachedTextualLinks',
		'ast'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #factory }
LePlainTextSnippet class >> builder [
	^ LeSnippetBuilder new
]

{ #category : #utils }
LePlainTextSnippet class >> createTextAttributeWithValue: aSnippetText [
	^ (super createTextAttributeWithValue: aSnippetText)
		attributeName: #string
]

{ #category : #factory }
LePlainTextSnippet class >> empty [
	"Return a block with empty text"
	^ self new
		text: '' asRopedText
]

{ #category : #accessing }
LePlainTextSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#string -> #string);
		yourself
]

{ #category : #accessing }
LePlainTextSnippet class >> stateAttributes [
	^ self leJsonV4AttributeMapping collect: [ :aMapping |
		aMapping key = #string
			ifTrue: [ LeTextualSnippetStringAttribute named: aMapping key ]
			ifFalse: [ LeGenericSnippetStateAttribute named: aMapping key ] ]
]

{ #category : #'instance creation' }
LePlainTextSnippet class >> string: aString [ 

	^ self new string: aString.
]

{ #category : #'private - updating' }
LePlainTextSnippet >> addTextualLinksIntoDatabase [
	self databaseDo: [ :aDatabase | 
		"Set the origin of the links only when they are actually added to the database"
		cachedTextualLinks do: [ :eachLink | 
			eachLink origin: self ].
		aDatabase addExplicitLinks: self cachedTextualLinks.
		self resetCachedTextualLinks ]
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> addToDatabaseOrCacheTextualLinks: aCollection [
	"Replace the receiver's outgoing links with the supplied collection"
	| oldTextualLinks |

	"Add the new set of links before removing the old.  This ensures that empty pages are not deleted as part of the update process.  Empty pages are deleted when there are no incoming links to them."
	oldTextualLinks := self outgoingTextualLinks.
	"aCollection do: [ :eachLink | eachLink origin: self ]."
	cachedTextualLinks := aCollection.
	self addTextualLinksIntoDatabase.
	self databaseDo: [ :aDatabase | aDatabase removeExplicitLinks: oldTextualLinks ].
]

{ #category : #'api - editing' }
LePlainTextSnippet >> announceTextChangedBy: anObject withTextEditCommand: aTextEditCommand [ 
	"Notify all dependents that the receiver's text has changed"

	self notifyAnnouncement: (LeSnippetTextChanged new
		source: anObject;
		snippet: self;
		textEditCommand: aTextEditCommand)
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> appendNewLineSilently [
	self text insertString: String cr at: self text size.
]

{ #category : #'api - editing' }
LePlainTextSnippet >> appendText: aText source: anObject [
	"Text attributes aren't part of the model, so appending an empty text with attributes is meaningless and can be ignored"
	aText ifEmpty: [ ^ self ].

	self assertText: aText.
	
	self flag: #TODO.
	"self appendNewLineSilently."
	self text append: aText.
	
	self updateEditTimeAndEmail.
	
	self announceTextChangedBy: anObject
]

{ #category : #converting }
LePlainTextSnippet >> asElement [
	"Not strictly needed; just for  debugging."
	^ self asPreviewElement children first
]

{ #category : #converting }
LePlainTextSnippet >> asPhlowTool [
	^ GtPhlowCompositeTool new
		addTool: (LeIsolatedSnippetPhlowTool snippet: self);
		addTool: (GtPhlowTool default object: self)
]

{ #category : #converting }
LePlainTextSnippet >> asPreviewElement [
	| viewModel snippetElement |

	viewModel := self asSnippetViewModel.
	snippetElement := viewModel snippetView asElement.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).
	^ snippetElement
]

{ #category : #converting }
LePlainTextSnippet >> asToolElement [
	^ self asElement
]

{ #category : #'private - asserting' }
LePlainTextSnippet >> assertString: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Block string must be non-nil' ].
]

{ #category : #'private - asserting' }
LePlainTextSnippet >> assertText: aText [
	self 
		assert: [ aText isNotNil ] 
		description: [ 'Block text must be non-nil' ]. 
	self 
		assert: [ aText isKindOf: BlText ] 
		description: [ 'Block text must be a ', BlText name, ' instance' ]. 
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> ast [
	<return: #LeContentNode>
	^ ast
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> ast: aLeContentNode [
	ast := aLeContentNode
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> cachedTextualLinks [
	<return: #Collection of: #LeTextualLink>
	^ cachedTextualLinks
]

{ #category : #'api - accessing' }
LePlainTextSnippet >> contentAsString [
	^ self string
]

{ #category : #converting }
LePlainTextSnippet >> fromStonMapKey: key value: value [

	super fromStonMapKey: key value: value.
	key = #string ifTrue: [ self string: value ].
]

{ #category : #accessing }
LePlainTextSnippet >> gtASTFor: aView [
	<gtView>
	^ aView forward
		title: 'AST';
		object: [ self ast ];
		view: #gtExploreFor:
]

{ #category : #printing }
LePlainTextSnippet >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: (self text 
			ifNil: [ '' ] 
			ifNotNil: [ :aText | aText asString ])
]

{ #category : #'gt-extensions' }
LePlainTextSnippet >> gtStringFor: aView [
	<gtView>
	self hasText
		ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'String';
		priority: 1;
		aptitude: BrGlamorousRegularEditorAptitude;
		text: [ self text ]
]

{ #category : #'api - links' }
LePlainTextSnippet >> hasLinkTarget: aNode [
	self hasOutgoingTextualLinks ifFalse: [ ^ false ].
	^ self outgoingTextualLinks 
		detect: [ :eachLink | eachLink node = aNode ] 
		ifFound: [ :aLink | aLink hasTarget ] 
		ifNone: [ false ]
]

{ #category : #accessing }
LePlainTextSnippet >> hasLinkWithTitle: aString [
	^ self outgoingTextualLinks
		detect: [ :link | link targetPageTitle = aString ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #'private - testing' }
LePlainTextSnippet >> hasOutgoingTextualLinks [
	^ self outgoingTextualLinks isNotEmpty
]

{ #category : #'api - testing' }
LePlainTextSnippet >> hasString [
	<return: #Boolean>
	self 
		deprecated: 'Please use #hasText instead.'
		transformWith: '`@receiver hasString' -> '`@receiver hasText'.

	^ self hasText
]

{ #category : #initialization }
LePlainTextSnippet >> initialize [
	super initialize.
	self resetCachedTextualLinks
]

{ #category : #'api - editing' }
LePlainTextSnippet >> insertText: aText at: anIndex [
	"Insert the supplied text in the receiver at anIndex, update metadata and notify dependents of the change"

	^ self insertText: aText at: anIndex source: nil
]

{ #category : #'api - editing' }
LePlainTextSnippet >> insertText: aText at: anIndex source: anObject [
	"Insert the supplied text in the receiver at anIndex, update metadata and notify dependents of the change"

	"Text attributes aren't part of the model, so appending an empty text with attributes is meaningless and can be ignored"
	aText ifEmpty: [ ^ self ].

	self assertText: aText.
	text insertText: aText at: anIndex.
	self updateEditTimeAndEmail.
	
	self announceTextChangedBy: anObject
]

{ #category : #'api - links' }
LePlainTextSnippet >> linkTarget: aNode [
	<return: #LeContent or: nil>
	self hasOutgoingTextualLinks ifFalse: [ ^ nil ].
	^ self outgoingTextualLinks 
		detect: [ :eachLink | eachLink node = aNode ] 
		ifFound: [ :aLink |
			aLink hasTarget 
				ifFalse: [ nil ]
				ifTrue: [ aLink target ] ]
		ifNone: [ nil ]
]

{ #category : #'api - updating' }
LePlainTextSnippet >> linkedTarget: aLeContent in: aLeLink [
	super linkedTarget: aLeContent in: aLeLink.
	self notifier local announce: (LeSnippetLinkTargetChanged new
		snippet: self;
		link: aLeLink;
		target: aLeContent)
]

{ #category : #'private - hooks' }
LePlainTextSnippet >> onAddedToDatabase [ 
	super onAddedToDatabase.
	
	self cachedTextualLinks 
		ifNil: [ self updateOutgoingTextualLinks ]
		ifNotNil: [ :cachedLinks |
			self addToDatabaseOrCacheTextualLinks: cachedLinks ]
]

{ #category : #'private - accessing' }
LePlainTextSnippet >> outgoingTextualLinks [
	<return: #Collection of: #LeTextualLink>
	^ self outgoingExplicitLinks select: [ :each |
		each isTextualLink ]
]

{ #category : #printing }
LePlainTextSnippet >> printOn: aStream [
	super printOn: aStream.
	self hasText ifFalse: [ ^ self ].
	aStream 
		nextPutAll: '(';
		nextPutAll: (self text 
			ifNil: [ '' ] 
			ifNotNil: [ :aText | aText asString ]);
		nextPutAll: ')'
]

{ #category : #converting }
LePlainTextSnippet >> promoteToPage [
	
	| aPage |
	aPage := LePage named: self text asString.
	self database addPage: aPage.
	self transferChildrenTo: aPage.
	self removeSelf.
	^ aPage
]

{ #category : #'private - updating' }
LePlainTextSnippet >> reloadAttributesFromContent: aLeSnippet [
	"Reload the receiver's attributes from the supplied snippet"
	| changed |
	
	changed := self reloadSnippetSpecificAttributesFromContent: aLeSnippet.
		
	"Reload the common attributes after we set the text, as changing the text
	also can update them"
	(self reloadCommonMetadataFromContent: aLeSnippet) ifTrue: [
		changed := true ].
	
	^ changed
]

{ #category : #'private - updating' }
LePlainTextSnippet >> reloadSnippetSpecificAttributesFromContent: aLeSnippet [
	"Reload the receiver's attributes from the supplied snippet"
	| changed |
	
	changed := false.
	text characters = aLeSnippet text characters ifFalse: 
		[ self updateText: aLeSnippet text.
		changed := true ].
	
	^ changed
]

{ #category : #'private - updating' }
LePlainTextSnippet >> resetCachedTextualLinks [
	cachedTextualLinks := nil
]

{ #category : #'api - links' }
LePlainTextSnippet >> spawnLinkTarget: aNode from: aButton inNewTab: aBoolean [
	self hasOutgoingTextualLinks ifFalse: [ ^ self ].
	self outgoingTextualLinks
		detect: [ :eachLink | eachLink node = aNode ]
		ifFound: [ :aLink | 
			aLink hasTarget
				ifFalse: [ (aLink isTextualPageLink and: [ aLink isLocalLink ])
						ifTrue: [ self database pageBuilder
								title: aLink targetUID;
								add ] ].
			aLink hasTarget
				ifTrue: [ aBoolean
						ifTrue: [ | aTool aSpace |
							aTool := aLink target asPhlowTool.
							aSpace := BlSpace new.
							aSpace title: self gtDisplayString.
							aSpace icon: aTool icon.
							aSpace extent: 1200 @ 600.
							aSpace root background: Color transparent.
							aSpace
								addChild: (GtPager
										createOn: (GtPagerWrapperElement new
												tool: aTool;
												embellisher: (GtPagerPageEmbellisher new extension: GtPagerPageEmbellisherExtension null))) maximized.
							aSpace withHalos.
							aButton showSpace: aSpace ]
						ifFalse: [ aButton phlow spawnTool: aLink target asPhlowTool ] ] ]
		ifNone: [  "ignore" ]
]

{ #category : #comparing }
LePlainTextSnippet >> storeOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new string: '.
	self string storeOn: aStream.
	self childrenDo: [ :snippet | 
		aStream nextPutAll: '; addSnippet: '.
		snippet storeOn: aStream ].
	aStream nextPutAll: '; yourself)'
]

{ #category : #'api - editing' }
LePlainTextSnippet >> string: aString [
	self text: aString asRopedText
]

{ #category : #'api - editing' }
LePlainTextSnippet >> text [ 
	<return: #BlText>
	^ text ifNil: [ text := '' asRopedText ]
]

{ #category : #'api - editing' }
LePlainTextSnippet >> text: aBlText [
	self assertText: aBlText.
	text := aBlText.
	self updateOutgoingTextualLinks.
	self updateUnlinkedReferences.
]

{ #category : #'api - updating' }
LePlainTextSnippet >> unlinkedTarget: aLeContent in: aLeLink [
	super unlinkedTarget: aLeContent in: aLeLink.
	self notifier local announce: (LeSnippetLinkTargetChanged new
		snippet: self;
		link: aLeLink;
		target: aLeContent)
]

{ #category : #'api - editing' }
LePlainTextSnippet >> updateFromCommandText: aText source: anObject [
	"Text snippets do not need this. It exists now only because they should be polymorphic with code snipets for the state update to work."
	
	self updateText: aText source: anObject
]

{ #category : #'api - editing' }
LePlainTextSnippet >> updateFromTextEditCommand: aCommand source: anObject [	
	"Update the content of the snippet using the given command."
	| targetText|
	targetText := self text.
	aCommand applyTextChangeOn:  targetText.
		
	self updater text: targetText.
	self 
		announceTextChangedBy: anObject 
		withTextEditCommand: aCommand.
]

{ #category : #'private - updating' }
LePlainTextSnippet >> updateOutgoingTextualLinks [
	| aNode aVisitor |

	aNode := LeParser parseWithErrors: self string.
	self ast: aNode.
	aVisitor := LeBlockLinksVisitor new.
	aNode acceptVisitor: aVisitor.
	self addToDatabaseOrCacheTextualLinks: aVisitor links.

]

{ #category : #'api - editing' }
LePlainTextSnippet >> updateText: aText source: anObject [
	self assertText: aText.
	
	self text characters = aText characters
		ifTrue: [ ^ self ].
	self updater string: aText.
	
	self announceTextChangedBy: anObject
]

{ #category : #'api - editing' }
LePlainTextSnippet >> updater [
	^ LeDatabaseSnippetUpdater new
		snippet: self;
		database: self database
]
