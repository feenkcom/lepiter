"
I am the model for a single text snippet. 
The following example display one {{gtClass:LePage|label=page}} with three blocks in a tree structure: {{gtExample:LeContentExamples>>#pageOneWithTwoSnippetsAndWithSnippetChild|noCode}} 
## Properties
Common properties that can be accessed from a LeSnippet include:
- {{gtMethod:LeTextSnippet>>#text|label=#selector}} is a  [Markdown](https://en.wikipedia.org/wiki/Markdown) text as a {{gtClass:BlText}} instance,
- {{gtMethod:LeSnippet>>#parent|label=#selector}} that can be either another {{gtClass:LeSnippet}} or {{gtClass:LePage}},
- {{gtMethod:LeSnippet>>#page|label=#selector}}  is a {{gtClass:LePage}} or nil,
- {{gtMethod:LeSnippet>>#topBlock|label=#selector}} is a {{gtClass:LeSnippet}} or nil,
- {{gtMethod:LeContent>>#children|label=#selector}} is a collection of other {{gtClass:LeSnippet}} instances.
Additional properties can be found in `api - accessing`.
## Initialization
The {{gtMethod:LeTextSnippet>>#text|label=#selector}} is **initialized** either using {{gtMethod:LeTextSnippet>>#text:|label=#selector}} or {{gtMethod:LeTextSnippet>>#string:|label=#selector}}.  The former one is useful particularly for the json reader and writer.
From a UI, new {{gtClass:LeSnippet}} can be created (added as my children) using {{gtMethod:LeContent>>#blockBuilder|label=#selector}}: {{gtExample:LeContentExamples>>#textSnippetInPageAndDatabase}} 
## Updates
A number of methods for **updating** text are provided (mirroring the protocol for {{gtClass:BlText}}:
- {{gtMethod:LeTextSnippet>>#updateText:source:|label=#selector}}
- {{gtMethod:LeTextualSnippet>>#updateString:|label=#selector}}
- {{gtMethod:LeTextSnippet>>#appendText:source:|label=#selector}}
- {{gtMethod:name=LeTextSnippet>>#insertText:at:|label=#selector}}

 {{gtExample:LeDatabaseSnippetUpdaterExamples>>#updateSnippetOneToTwo_Simplified_Text}} {{gtExample:LeDatabaseSnippetUpdaterExamples>>#updateSnippetOneToTwo_Simplified_String}} 
 

Text editors are responsible for using a copy of {{gtMethod:LeTextSnippet>>#text|label=#selector}} since sharing {{gtClass:BlTextAttribute|label=text attributes}}  may produces undesired (and undefinied) behavior. {{gtClass:BlText}} is not thread safe, it therefore cannot be edited simultaneously in several editors.
The text is stored as a {{gtClass:BlText}} (rather than a {{gtClass:String}}) since converting text to strings is expensive, and this would be done on every keystroke while editing in the UI.
## Navigation
A number of methods for navigating betwee blocks are provided, including:

- {{gtMethod:name=LeSnippet>>#previousSibling}}
- {{gtMethod:name=LeSnippet>>#nextSibling}}
- {{gtMethod:name=LeSnippet>>#previousBlockDo:ifNone:}}
- {{gtMethod:name=LeSnippet>>#nextBlockDo:ifNone:}}

next and previousBlockDo... are based on the user expectations of editing paragraphs in a text editor, i.e. the previous block is the deepest last child of the block's previous subling.


"
Class {
	#name : #LeTextSnippet,
	#superclass : #LeTextualSnippet,
	#traits : 'TLeSpotterPagesSearch - {#children. #hasChildren}',
	#classTraits : 'TLeSpotterPagesSearch classTrait',
	#instVars : [
		'paragraphStyle',
		'text',
		'ast',
		'cachedTextualLinks'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #factory }
LeTextSnippet class >> builder [
	^ LeSnippetBuilder new
]

{ #category : #accessing }
LeTextSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 1;
		snippetClass: self;
		title: self description
]

{ #category : #utils }
LeTextSnippet class >> createTextAttributeWithValue: aSnippetText [
	^ (super createTextAttributeWithValue: aSnippetText)
		attributeName: #string
]

{ #category : #accessing }
LeTextSnippet class >> description [
	^ 'Text'
]

{ #category : #factory }
LeTextSnippet class >> empty [
	"Return a block with empty text"
	^ self builder
		empty;
		build
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#paragraphStyle -> #paragraphStyle);
		add: (#string -> #string);
		yourself
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV3Name [

	^ 'textSnippet'
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#paragraphStyle -> #paragraphStyle);
		add: (#string -> #string);
		yourself
]

{ #category : #accessing }
LeTextSnippet class >> leJsonV4Name [

	^ 'textSnippet'
]

{ #category : #accessing }
LeTextSnippet class >> stateAttributes [
	^ self leJsonV4AttributeMapping collect: [ :aMapping |
		aMapping key = #string
			ifTrue: [ LeTextualSnippetStringAttribute named: aMapping key ]
			ifFalse: [ LeGenericSnippetStateAttribute named: aMapping key ] ]
]

{ #category : #'instance creation' }
LeTextSnippet class >> string: aString [ 

	^ self new string: aString.
]

{ #category : #visiting }
LeTextSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitTextSnippet: self
]

{ #category : #'private - updating' }
LeTextSnippet >> addTextualLinksIntoDatabase [
	self databaseDo: [ :aDatabase | 
		"Set the origin of the links only when they are actually added to the database"
		cachedTextualLinks do: [ :eachLink | 
			eachLink origin: self ].
		aDatabase addExplicitLinks: self cachedTextualLinks.
		self resetCachedTextualLinks ]
]

{ #category : #'private - accessing' }
LeTextSnippet >> addToDatabaseOrCacheTextualLinks: aCollection [
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
LeTextSnippet >> announceTextChangedBy: anObject withTextEditCommand: aTextEditCommand [ 
	"Notify all dependents that the receiver's text has changed"

	self notifyAnnouncement: (LeSnippetTextChanged new
		source: anObject;
		snippet: self;
		textEditCommand: aTextEditCommand)
]

{ #category : #'private - accessing' }
LeTextSnippet >> appendNewLineSilently [
	self text insertString: String cr at: self text size.
]

{ #category : #'api - editing' }
LeTextSnippet >> appendText: aText source: anObject [
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
LeTextSnippet >> asPhlowTool [
	^ GtPhlowCompositeTool new
		addTool: (LeIsolatedSnippetPhlowTool snippet: self);
		addTool: (GtPhlowTool default object: self)
]

{ #category : #converting }
LeTextSnippet >> asPreviewElement [
	| viewModel snippetElement |

	viewModel := self asSnippetViewModel.
	snippetElement := viewModel snippetView asElement.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).
	^ snippetElement
]

{ #category : #converting }
LeTextSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>

	^ LeTextCoderSnippetViewModel new snippetModel: self
]

{ #category : #converting }
LeTextSnippet >> asToolElement [
	^ self asElement
]

{ #category : #'private - asserting' }
LeTextSnippet >> assertString: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Block string must be non-nil' ].
]

{ #category : #'private - asserting' }
LeTextSnippet >> assertText: aText [
	self 
		assert: [ aText isNotNil ] 
		description: [ 'Block text must be non-nil' ]. 
	self 
		assert: [ aText isKindOf: BlText ] 
		description: [ 'Block text must be a ', BlText name, ' instance' ]. 
]

{ #category : #'private - accessing' }
LeTextSnippet >> ast [
	<return: #LeContentNode>
	^ ast
]

{ #category : #'private - accessing' }
LeTextSnippet >> ast: aLeContentNode [
	ast := aLeContentNode
]

{ #category : #'private - accessing' }
LeTextSnippet >> cachedTextualLinks [
	<return: #Collection of: #LeTextualLink>
	^ cachedTextualLinks
]

{ #category : #accessing }
LeTextSnippet >> changeToRenameClass: oldName to: newName [
	| modifiedSource |
	modifiedSource := SmaCCString on: self string.
	self ast
		withAllNodesDo: [ :node | 
			((node isKindOf: LeClassNameArgumentNode) and: [ node className = oldName ])
				ifTrue: [ modifiedSource
						replaceFrom: node value startPosition
						to: node value stopPosition
						with: newName ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	modifiedSource isModified ifFalse: [ ^ nil ].
	^ LeSnippetChange new
		snippet: self;
		newSource: modifiedSource asString;
		yourself
]

{ #category : #accessing }
LeTextSnippet >> classAndSelectorReferencesPromise [
	^ [ | classes selectors |
	classes := Set new.
	selectors := Set new.
	self ast
		withAllNodesDo: [ :node | 
			(node isKindOf: LeClassNameArgumentNode)
				ifTrue: [ classes add: node className.
					(node isKindOf: LeMethodNameArgumentNode)
						ifTrue: [ selectors add: node selector value ] ] ]
		andTokensDo: [ :token |  ]
		includesErrors: true.
	{classes.
		selectors} ] asAsyncPromise
]

{ #category : #'api - accessing' }
LeTextSnippet >> contentAsString [
	^ self string
]

{ #category : #defaults }
LeTextSnippet >> defaultParagraphStyle [
	^ LeParagraphStyle text
]

{ #category : #converting }
LeTextSnippet >> fromStonMapKey: key value: value [

	super fromStonMapKey: key value: value.
	key = #string ifTrue: [ self string: value ].
	(key = #heading and: [ value isNotNil ]) ifTrue:
		[ self heading: value ].
]

{ #category : #accessing }
LeTextSnippet >> gtASTFor: aView [
	<gtView>
	^ aView forward
		title: 'AST';
		object: [ self ast ];
		view: #gtExploreFor:
]

{ #category : #printing }
LeTextSnippet >> gtDisplayOn: aStream [
	aStream 
		nextPutAll: (self text 
			ifNil: [ '' ] 
			ifNotNil: [ :aText | aText asString ])
]

{ #category : #'gt-extensions' }
LeTextSnippet >> gtSpotterContainingSubPartsFor: aSearch [
	<gtSearch>
	self hasChildren ifNil: [ ^ aSearch empty ].
	^ aSearch list
		priority: 23;
		title: 'Children Tree Content';
		wantsToDisplayOnEmptyQuery: false;
		filterBySubstring;
		items: [ self children ]
]

{ #category : #'gt-extensions' }
LeTextSnippet >> gtStringFor: aView [
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
LeTextSnippet >> hasLinkTarget: aNode [
	self hasOutgoingTextualLinks ifFalse: [ ^ false ].
	^ self outgoingTextualLinks 
		detect: [ :eachLink | eachLink node = aNode ] 
		ifFound: [ :aLink | aLink hasTarget ] 
		ifNone: [ false ]
]

{ #category : #accessing }
LeTextSnippet >> hasLinkWithTitle: aString [
	^ self outgoingTextualLinks
		detect: [ :link | link targetPageTitle = aString ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #'private - testing' }
LeTextSnippet >> hasOutgoingTextualLinks [
	^ self outgoingTextualLinks isNotEmpty
]

{ #category : #'api - testing' }
LeTextSnippet >> hasString [
	<return: #Boolean>
	self 
		deprecated: 'Please use #hasText instead.'
		transformWith: '`@receiver hasString' -> '`@receiver hasText'.

	^ self hasText
]

{ #category : #accessing }
LeTextSnippet >> headers [
	^ self ast // #LeHeaderNode collect: [ :val | val headerName asString ]
]

{ #category : #'api - accessing' }
LeTextSnippet >> heading [
	<return: #Integer or: nil>
	^ self paragraphStyle level
]

{ #category : #'api - accessing' }
LeTextSnippet >> heading: anInteger [
	paragraphStyle := LeParagraphStyle heading: anInteger
]

{ #category : #initialization }
LeTextSnippet >> initialize [
	super initialize.
	paragraphStyle := self defaultParagraphStyle.
	self resetCachedTextualLinks
]

{ #category : #'api - editing' }
LeTextSnippet >> insertText: aText at: anIndex [
	"Insert the supplied text in the receiver at anIndex, update metadata and notify dependents of the change"

	^ self insertText: aText at: anIndex source: nil
]

{ #category : #'api - editing' }
LeTextSnippet >> insertText: aText at: anIndex source: anObject [
	"Insert the supplied text in the receiver at anIndex, update metadata and notify dependents of the change"

	"Text attributes aren't part of the model, so appending an empty text with attributes is meaningless and can be ignored"
	aText ifEmpty: [ ^ self ].

	self assertText: aText.
	text insertText: aText at: anIndex.
	self updateEditTimeAndEmail.
	
	self announceTextChangedBy: anObject
]

{ #category : #'api - testing' }
LeTextSnippet >> isTextSnippet [

	^ true
]

{ #category : #'api - links' }
LeTextSnippet >> linkTarget: aNode [
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
LeTextSnippet >> linkedTarget: aLeContent in: aLeLink [
	super linkedTarget: aLeContent in: aLeLink.
	self notifier local announce: (LeSnippetLinkTargetChanged new
		snippet: self;
		link: aLeLink;
		target: aLeContent)
]

{ #category : #'private - hooks' }
LeTextSnippet >> onAddedToDatabase [ 
	super onAddedToDatabase.
	
	self cachedTextualLinks 
		ifNil: [ self updateOutgoingTextualLinks ]
		ifNotNil: [ :cachedLinks |
			self addToDatabaseOrCacheTextualLinks: cachedLinks ]
]

{ #category : #'private - accessing' }
LeTextSnippet >> outgoingTextualLinks [
	<return: #Collection of: #LeTextualLink>
	^ self outgoingExplicitLinks select: [ :each |
		each isTextualLink ]
]

{ #category : #'api - accessing' }
LeTextSnippet >> paragraphStyle [
	<return: #LeParagraphStyle>
	^ paragraphStyle 
]

{ #category : #'api - accessing' }
LeTextSnippet >> paragraphStyle: aLeParagraphStyle [

	paragraphStyle := aLeParagraphStyle
]

{ #category : #printing }
LeTextSnippet >> printOn: aStream [
	super printOn: aStream.
	self hasText ifFalse: [ ^ self ].
	aStream 
		nextPutAll: '(';
		nextPutAll: (self text 
			ifNil: [ '' ] 
			ifNotNil: [ :aText | aText asString ]);
		nextPutAll: ')'
]

{ #category : #'api - editing' }
LeTextSnippet >> promoteToPage [
	
	| aPage |
	aPage := LePage named: self text asString.
	self database addPage: aPage.
	self transferChildrenTo: aPage.
	self removeSelf.
]

{ #category : #'private - updating' }
LeTextSnippet >> reloadAttributesFromContent: aLeSnippet [
	"Reload the receiver's attributes from the supplied snippet"
	| changed |
	
	changed := self reloadCommonMetadataFromContent: aLeSnippet.
	paragraphStyle = aLeSnippet paragraphStyle ifFalse:
		[ paragraphStyle := aLeSnippet paragraphStyle.
		changed := true ].
	text characters = aLeSnippet text characters ifFalse: 
		[ self updateText: aLeSnippet text.
		changed := true ].
	^ changed
]

{ #category : #'private - updating' }
LeTextSnippet >> resetCachedTextualLinks [
	cachedTextualLinks := nil
]

{ #category : #converting }
LeTextSnippet >> roamJsonStringContent: aString [
	"Convert short UIDs to UUIDs"
	| snippetDictionary |
	
	snippetDictionary := { 'string' -> aString } asDictionary.
	LeJsonV4000Updater new 
		updateSnippetLinks: snippetDictionary.
			
	self string: (snippetDictionary at: 'string') 
]

{ #category : #'api - links' }
LeTextSnippet >> spawnLinkTarget: aNode from: aButton inNewTab: aBoolean [
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
LeTextSnippet >> storeOn: aStream [

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
LeTextSnippet >> string: aString [
	self text: aString asRopedText
]

{ #category : #'api - editing' }
LeTextSnippet >> text [ 
	<return: #BlText>
	^ text ifNil: [ text := '' asRopedText ]
]

{ #category : #'api - editing' }
LeTextSnippet >> text: aBlText [
	self assertText: aBlText.
	text := aBlText.
	self updateOutgoingTextualLinks.
	self updateUnlinkedReferences.
]

{ #category : #accessing }
LeTextSnippet >> todoAnnotations [
	^ self ast // #LeTodoAnnotationNode
]

{ #category : #'api - updating' }
LeTextSnippet >> unlinkedTarget: aLeContent in: aLeLink [
	super unlinkedTarget: aLeContent in: aLeLink.
	self notifier local announce: (LeSnippetLinkTargetChanged new
		snippet: self;
		link: aLeLink;
		target: aLeContent)
]

{ #category : #'api - editing' }
LeTextSnippet >> updateFromCommandText: aText source: anObject [
	"Text snippets do not need this. It exists now only because they should be polymorphic with code snipets for the state update to work."
	
	self updateText: aText source: anObject
]

{ #category : #'api - editing' }
LeTextSnippet >> updateFromTextEditCommand: aCommand source: anObject [	
	"Update the contet of the snippet using the given command."
	| targetText|
	targetText := self text.
	aCommand applyTextChangeOn:  targetText.
		
	self updater text: targetText.
	self 
		announceTextChangedBy: anObject 
		withTextEditCommand: aCommand.
]

{ #category : #'private - updating' }
LeTextSnippet >> updateOutgoingTextualLinks [
	| aNode aVisitor |

	aNode := LeParser parseWithErrors: self string.
	self ast: aNode.
	aVisitor := LeBlockLinksVisitor new.
	aNode acceptVisitor: aVisitor.
	self addToDatabaseOrCacheTextualLinks: aVisitor links.

]

{ #category : #'api - editing' }
LeTextSnippet >> updateText: aText source: anObject [
	self assertText: aText.
	
	self text characters = aText characters
		ifTrue: [ ^ self ].
	self updater string: aText.
	
	self announceTextChangedBy: anObject
]

{ #category : #'api - editing' }
LeTextSnippet >> updater [
	^ LeDatabaseSnippetUpdater new
		snippet: self;
		database: self database
]
