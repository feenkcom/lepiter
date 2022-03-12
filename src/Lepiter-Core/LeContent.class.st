Class {
	#name : #LeContent,
	#superclass : #LeModel,
	#traits : 'TLeSpotterChildrenEnumerationSearch + TGtAnnouncer',
	#classTraits : 'TLeSpotterChildrenEnumerationSearch classTrait + TGtAnnouncer classTrait',
	#instVars : [
		'editEmail',
		'createEmail',
		'createTime',
		'children',
		'announcer',
		'editTime',
		'database'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #factory }
LeContent class >> empty [
	"Return a content (page or block) with empty values (title or text).
	Required by ${method:LeContent>>#addBlockOfClass:after:}$"
	^ self subclassResponsibility
]

{ #category : #testing }
LeContent class >> isAbstract [
	^ self name = #LeContent
]

{ #category : #factory }
LeContent class >> null [
	^ LeNullContent default
]

{ #category : #'api - notifications' }
LeContent >> aboutToAddToDatabase: aDatabase [
	"Notify the receiver that it is about to be added to a database.
	In case the receiver is already added to the database do nothing."

	database == aDatabase ifTrue: [ ^ self ].
	
	self onAboutToAddToDatabase: aDatabase.
	self children do: [ :eachChild | 
		eachChild aboutToAddToDatabase: aDatabase ].
]

{ #category : #visiting }
LeContent >> acceptVisitor: aVisitor [

	^ aVisitor visitContent: self
]

{ #category : #'api - editing' }
LeContent >> addSnippet: newSnippet [

	self basicAddSnippet: newSnippet.
	self announceContentAdded: newSnippet.
	^ newSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippet: newLeSnippet after: aLeSnippet [

	self basicAddSnippet: newLeSnippet after: aLeSnippet.
	self announceContentAdded: newLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippet: newLeSnippet before: aLeSnippet [

	self children addSnippet: newLeSnippet before: aLeSnippet.
	newLeSnippet addedToParent: self.
	self announceContentAdded: newLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippet: newLeSnippet beforeIndex: anInteger [

	self children addSnippet: newLeSnippet beforeIndex: anInteger.
	newLeSnippet addedToParent: self.
	self announceContentAdded: newLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippetAfter: aLeSnippet [
	"Add an empty snippet after the supplied snippet.
	This works its way through to #addSnippet:after:, which will announce the change"

	^ self addSnippetOfClass: aLeSnippet class after: aLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippetBefore: aLeSnippet [
	"Add an empty snippet before the supplied snippet.
	This works its way through to #addSnippet:before:, which will announce the change"
	| newLeSnippet |

	newLeSnippet := aLeSnippet class empty.
	self addSnippet: newLeSnippet before: aLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippetOfClass: aNewSnippetClass after: aLeSnippet [
	"Add an empty snippet of the given type after the supplied snippet.
	This works its way through to #addSnippet:after:, which will announce the change"

	| newLeSnippet |
	newLeSnippet := aNewSnippetClass empty.
	self addSnippet: newLeSnippet after: aLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - editing' }
LeContent >> addSnippetOfClass: aNewSnippetClass before: aLeSnippet [
	"Add an empty snippet of the given type before the supplied snippet.
	This works its way through to #addSnippet:before:, which will announce the change"
	| newLeSnippet |

	newLeSnippet := aNewSnippetClass empty.
	self addSnippet: newLeSnippet before: aLeSnippet.
	^ newLeSnippet
]

{ #category : #'api - notifications' }
LeContent >> addedToDatabase: aDatabase [
	"Set the receiver's database and update metadata if required.
	This is called when adding content in a running system."

	database == aDatabase ifTrue: [ ^ self ].
	self database: aDatabase.
	
	self onAddedToDatabase.
	self children do: [ :eachChild | 
		eachChild addedToDatabase: aDatabase ].
]

{ #category : #'api - accessing' }
LeContent >> allChildOutgoingLinks [
	| all |
	all := OrderedCollection new.
	self allChildrenBreadthFirstDo: [ :each | 
		all addAll: each outgoingExplicitLinks ].
	^ all
]

{ #category : #'api - accessing' }
LeContent >> allChildOutgoingTextualLinks [
	| all |
	all := OrderedCollection new.
	self allChildrenBreadthFirstDo: [ :each | 
		each isTextSnippet ifTrue: [ all addAll: each outgoingTextualLinks ] ].
	^ all
]

{ #category : #'api - enumerating' }
LeContent >> allChildrenBreadthFirst [
	| all |
	all := OrderedCollection new.
	self allChildrenBreadthFirstDo: [:each | all add: each].
	^ all 
]

{ #category : #'api - enumerating' }
LeContent >> allChildrenBreadthFirstDo: aBlock [ 
	self childrenDo: [ :each | each withAllChildrenBreadthFirstDo: aBlock ]
]

{ #category : #'api - enumerating' }
LeContent >> allChildrenDepthFirst [
	| all |
	all := OrderedCollection new.
	self allChildrenDepthFirstDo: [:each | all add: each].
	^ all 
]

{ #category : #'api - enumerating' }
LeContent >> allChildrenDepthFirstDo: aBlock [ 
	self childrenDo: [ :each | each withAllChildrenDepthFirstDo: aBlock ]
]

{ #category : #'private - accessing' }
LeContent >> allOutgoingExplicitLinks [
	| all |
	all := LeExplicitLinks new.
	all addAllLinks: self outgoingExplicitLinks.
	self allChildrenBreadthFirstDo: [:each | 
		all addAllLinks: each outgoingExplicitLinks ].
	^ all
]

{ #category : #'api - accessing' }
LeContent >> allOutgoingLinks [
	| all |
	all := OrderedCollection new.
	all addAll: self outgoingExplicitLinks.
	self allChildrenBreadthFirstDo: [ :each | 
		all addAll: each outgoingExplicitLinks ].
	^ all
]

{ #category : #'api - accessing' }
LeContent >> allOutgoingTextualLinks [
	^ self allOutgoingLinks select: [ :each | each isTextualLink ]
]

{ #category : #'private - notifications' }
LeContent >> announceContentAdded: aLeSnippet [
	"Announce that the receiver has added a snippet to the tree"

	self notifier 
		bubble; database;
		announce: (LeContentTreeAdded new
			content: aLeSnippet;
			parent: self;
			index: (children indexOf: aLeSnippet)).
]

{ #category : #'private - notifications' }
LeContent >> announceContentMoved: aLeSnippet [
	"Announce that the receiver has moved a snippet in the tree"

	self notifier 
		bubble; database;
		announce: (LeContentTreeMoved new
			content: aLeSnippet;
			destinationParent: self;
			destinationIndex: (children indexOf: aLeSnippet)).
]

{ #category : #'private - notifications' }
LeContent >> announceContentRemoved: aLeSnippet from: aLePage in: aLeDatabase [
	"Announce that the receiver has removed a snippet from a page"

	self notifier 
		bubble; database;
		announce: (LeContentTreeRemoved new
			page: aLePage;
			database: aLeDatabase;
			content: aLeSnippet).
]

{ #category : #'private - notifications' }
LeContent >> announceTreeChanged: aLeContent [
	"Announce that the receiver's page has changed'"

	self notifier 
		bubble; database;
		announce: (LeContentTreeChanged new content: aLeContent).
]

{ #category : #announcer }
LeContent >> announcer [
	<return: #Announcer>

	^ announcer
]

{ #category : #converting }
LeContent >> asMarkdownString [
	"Answer the receiver as an HTML string"

	^ String streamContents: [ :stream |
			self markdownOn: stream ]
]

{ #category : #accessing }
LeContent >> ast [ 
	"Answer the AST for the receiver, nil if none.
	Subclasses that have ASTs will over-write this."

	^ nil
]

{ #category : #'api - attaching / detaching' }
LeContent >> attachChildSnippet: aNewSnippet [
	self assert: [ aNewSnippet notNil ].
	self assert: [ aNewSnippet parent isNil ].
	
	self children addChild: aNewSnippet.
	aNewSnippet attachToParent: self.
	^ aNewSnippet
]

{ #category : #'private - editing' }
LeContent >> basicAddSnippet: newLeSnippet [

	self children addChild: newLeSnippet.
	newLeSnippet addedToParent: self.

]

{ #category : #'api - editing' }
LeContent >> basicAddSnippet: newLeSnippet after: aLeSnippet [

	self children addSnippet: newLeSnippet after: aLeSnippet.
	newLeSnippet addedToParent: self.

]

{ #category : #'api - editing' }
LeContent >> blockBuilder [
	self 
		deprecated: 'Use #snippetBuilder instead.' 
		transformWith: '`@receiver blockBuilder' -> '`@receiver snippetBuilder'.
	^ self snippetBuilder
]

{ #category : #'private - accessing' }
LeContent >> blocks [
	self 
		deprecated: 'Use #children instead.' 
		transformWith: '`@receiver blocks' -> '`@receiver children'.
	
	^ self children
]

{ #category : #'api - accessing' }
LeContent >> children [
	^ children
]

{ #category : #'api - accessing' }
LeContent >> children: aCollection [
	children := aCollection.
	self onChildrenChanged
]

{ #category : #'api - accessing' }
LeContent >> childrenCount [
	<return: #Integer>
	^ self children size
]

{ #category : #'private - updating' }
LeContent >> clearDatabase [
	"Clear the receiver's database.
	This should obviously only be removed if the receiver has been removed from its database"

	self database: self defaultDatabase
]

{ #category : #'api - accessing' }
LeContent >> content [
	self
		deprecated: 'Use @contentAsString'
		transformWith:
			'`@receiver content'
			-> '`@receiver contentAsString'.
	
	^ self contentAsString 
]

{ #category : #'api - accessing' }
LeContent >> contentAsString [
	self subclassResponsibility
]

{ #category : #'api - accessing' }
LeContent >> createEmail [
	^ createEmail
]

{ #category : #'api - accessing' }
LeContent >> createEmail: aLeEmail [
	createEmail := aLeEmail
]

{ #category : #'api - accessing' }
LeContent >> createTime [
	^ createTime
]

{ #category : #'api - accessing' }
LeContent >> createTime: anObject [

	createTime := anObject.
	editTime := createTime.
]

{ #category : #'private - accessing' }
LeContent >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #'private - accessing' }
LeContent >> database: aDatabase [
	database := aDatabase
]

{ #category : #'private - accessing' }
LeContent >> databaseDo: aBlock [
	| aDatabase |
	aDatabase := self database.
	aDatabase ifNil: [ ^ self ].
	aDatabase isDatabase ifFalse: [ ^ self ].
	aBlock value: aDatabase.
]

{ #category : #defaults }
LeContent >> defaultChildren [
	^ LeSnippets empty
]

{ #category : #defaults }
LeContent >> defaultDatabase [
	^ LeDatabase null
]

{ #category : #'api - attaching / detaching' }
LeContent >> detachChildSnippet: aLeSnippet [
	self assert: [ aLeSnippet notNil ].
	self assert: [ aLeSnippet parent notNil ].
	
	self children removeSnippet: aLeSnippet.
]

{ #category : #'api - accessing' }
LeContent >> editEmail [
	^ editEmail
]

{ #category : #'api - accessing' }
LeContent >> editEmail: anObject [
	editEmail := anObject
]

{ #category : #'api - accessing' }
LeContent >> editOrCreateEmail [
	<return: #LeEmail>
	^ self editEmail ifNil: [ self createEmail ]
]

{ #category : #'api - accessing' }
LeContent >> editOrCreateTime [
	<return: #LeTime>
	^ self editTime ifNil: [ self createTime ]
]

{ #category : #'api - accessing' }
LeContent >> editTime [
	<return: #LeTime>
	^ editTime
]

{ #category : #'api - accessing' }
LeContent >> editTime: aLeTime [

	editTime := aLeTime
]

{ #category : #'private - calculating' }
LeContent >> getLatestEditTime [
	"Determine the latest edit time, i.e. the most recent edit time in the receiver and its children"
	| latestTime |

	latestTime := editTime.
	self allChildrenBreadthFirstDo: [ :child | 
		child editTime ifNotNil: [
			latestTime := latestTime max: child editTime ] ].
	^ latestTime
]

{ #category : #'gt-extensions' }
LeContent >> gtIncomingLinksFor: aView [
	<gtView>
	self hasIncomingLinks ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Incoming Links';
		priority: 15;
		items: [ self incomingLinks ];
		column: 'Type' text: #class;
		column: 'Origin' text: [ :aLink | aLink originReference description ];
		column: 'Target' text: [ :aLink | aLink targetReference description ]
]

{ #category : #'gt-extensions' }
LeContent >> gtSerializationFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Serialization';
		priority: 80;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: JSONParser gtStyler;
		text: [String streamContents: [ :s | 
				LeJsonV4 uniqueInstance serialize: self on: s prettyPrint: true ]]
]

{ #category : #'gt-extensions' }
LeContent >> gtSnippetsFor: aView [
	<gtView>
	self children ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Snippets';
		priority: 2;
		object: [ self children ];
		view: #gtSnippetsFor:
]

{ #category : #'gt-extensions' }
LeContent >> gtViewAllOutgoingExplicitLinksFor: aView [
	<gtView>
	^ aView forward
		title: 'All Outgoing Explicit Links';
		object: [ self allOutgoingExplicitLinks ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #'gt-extensions' }
LeContent >> gtViewDirectOutgoingExplicitLinksFor: aView [
	<gtView>
	self hasOutgoingLinks ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Direct Outgoing Explicit Links';
		object: [ self outgoingExplicitLinks ];
		view: #gtViewExplicitLinksFor:
]

{ #category : #'api - testing' }
LeContent >> hasBlocks [
	<return: #Boolean>
	^ self blocks isNotEmpty
]

{ #category : #'api - testing' }
LeContent >> hasChildren [
	<return: #Boolean>
	^ self children isNotEmpty
]

{ #category : #'private - testing' }
LeContent >> hasIncomingLinks [
	^ self
		optionAt: self incomingLinksOptionName  
		ifPresent: [ :links | links isNotEmpty ] 
		ifAbsent: [ false ]

]

{ #category : #'private - testing' }
LeContent >> hasOutgoingLinks [
	^ self outgoingExplicitLinks size > 0
]

{ #category : #'api - testing' }
LeContent >> hasParent: aLeConent [
	^ self parent notNil
		and:
			[ self parent = aLeConent or: [ self parent hasParent: aLeConent ] ]
]

{ #category : #'private - accessing' }
LeContent >> incomingLinks [
	<return: #Collection of: #LeTextualLink>
	^ self optionAt: self incomingLinksOptionName ifAbsentPut: [ OrderedCollection new ].
]

{ #category : #'private - accessing' }
LeContent >> incomingLinksOptionName [
	^ #incomingLinks
]

{ #category : #'api - editing' }
LeContent >> indentSnippet: aLeSnippet [
	"Indent the receiver in the receiver, i.e. make it a child of the previous snippet.
	If this is the first snippet at the current level, do nothing"

	(self children indentSnippet: aLeSnippet) ifNotNil:
		[ :newParent | newParent announceContentMoved: aLeSnippet ].
]

{ #category : #initialization }
LeContent >> initialize [
	super initialize.
	database := self defaultDatabase.
	children := self defaultChildren.
	announcer := Announcer new.
]

{ #category : #'api - testing' }
LeContent >> isEmpty [
	"Answer a boolean indicating if the receiver is empty, i.e.
	has no children, or the only child is empty"

	^ self hasChildren not
		or: [ self childrenCount = 1 and: [ self children first isEmpty ] ]
]

{ #category : #'api - testing' }
LeContent >> isNotEmpty [
	"Answer a boolean indicating if the receiver is empty, i.e.
	has no children, or the only child is empty"

	^ self isEmpty not
]

{ #category : #'api - testing' }
LeContent >> isPage [
	^ false
]

{ #category : #testing }
LeContent >> isSnippet [

	^ false
]

{ #category : #'api - accessing' }
LeContent >> lastChildOrSelf [
	"Answer the last child or self, i.e. descend through child nodes until there are no more"

	^ self hasChildren
		ifTrue: [ children last lastChildOrSelf ]
		ifFalse: [ self ]
]

{ #category : #'api - accessing' }
LeContent >> latestEditTime [ 
	"Answer the most recent edit time from the receiver or its children"

	^ self getLatestEditTime 
]

{ #category : #'api - updating' }
LeContent >> linkedBy: aLink [
	self incomingLinks add: aLink
]

{ #category : #'api - updating' }
LeContent >> linkedTarget: aLeContent in: aLeLink [
	"subclasses may react to link target losts"
]

{ #category : #'private - exporting' }
LeContent >> markdownOn: stream [

	^ self markdownOn: stream level: 0
]

{ #category : #'api - editing' }
LeContent >> mergeSnippet: mergeLeSnippet after: afterLeSnippet [

	self children mergeSnippet: mergeLeSnippet after: afterLeSnippet.

]

{ #category : #'api - editing' }
LeContent >> mergeWithSuccessor: aBlock [ 
	"Merge the supplied block with the receiver's successor.
	Answer the merged block"

	self parent mergeSnippet: aBlock after: self
]

{ #category : #'api - editing' }
LeContent >> moveDownSnippet: aLeSnippet [
	"Try to move the supplied snippet down one item in the receiver's children.
	If that isn't possible, try to move the snippet down as the receiver's sibling"

	(self children moveDownSnippet: aLeSnippet) ifTrue:
		[ ^ self announceContentMoved: aLeSnippet ].
	(self parent moveSnippet: aLeSnippet below: self) ifNotNil:
		[ :newParent | newParent announceContentMoved: aLeSnippet ].
]

{ #category : #'api - editing' }
LeContent >> moveSnippet: aLeSnippet above: parentSnippet [
	"Move aLeSnippet to the snippet above its current parent (parentSnippet).
	Answer the new parent if the move was made, or nil if it wasn't."
	| newParent |

	newParent := self children moveSnippet: aLeSnippet above: parentSnippet.
	newParent ifNotNil: [ self onChildrenChanged ].
	^ newParent
]

{ #category : #'api - editing' }
LeContent >> moveSnippet: aLeSnippet below: parentSnippet [
	"Move aLeSnippet to the snippet below its current parent (parentSnippet).
	Answer the new parent if the move was made, or nil if it wasn't."
	| newParent |

	newParent := self children moveSnippet: aLeSnippet below: parentSnippet.
	newParent ifNotNil: [ self onChildrenChanged ].
	^ newParent
]

{ #category : #'api - editing' }
LeContent >> moveUpSnippet: aLeSnippet [
	"Try to move the supplied snippet up one item in the receiver's children.
	If that isn't possible, try to move the snippet down to the receiver's sibling"

	(self children moveUpSnippet: aLeSnippet) ifTrue:
		[ ^ self announceContentMoved: aLeSnippet ].
	(self parent moveSnippet: aLeSnippet above: self) ifNotNil:
		[ :newParent | newParent announceContentMoved: aLeSnippet ].
]

{ #category : #'api - notifications' }
LeContent >> notifier [
	<return: #LeNotifier>
	^ self subclassResponsibility
]

{ #category : #'private - hooks' }
LeContent >> onAboutToAddToDatabase: aDatabase [
	"Set the receiver's email and time metadata needed 
	before the content is added to the database.
	Subclasses may perform additional actions."

	self setCreateTimeAndEmailUsingDatabase: aDatabase.

]

{ #category : #'private - hooks' }
LeContent >> onAddedToDatabase [
	"Callback called after the content was added to the database"
]

{ #category : #'private - hooks' }
LeContent >> onChildrenChanged [
	self children do: [ :eachChild | 
		eachChild addedToParent: self ]
]

{ #category : #'private - hooks' }
LeContent >> onRemovedFromDatabase: aDatabase [
	"Subclasses may react to the change"
]

{ #category : #accessing }
LeContent >> outgoingExplicitLinks [
	^ self database cachedLinksForContent: self.
	
	"^ self database explicitLinks select: [ :each | 
		each originReference isLeContentReference and: [
			each originReference content = self ] ]"
]

{ #category : #'api - accessing' }
LeContent >> page [
	"Return parent, which should be alway ${class:LePage}$"
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
LeContent >> parent [
	^ nil
]

{ #category : #'private - updating' }
LeContent >> reloadAttributesFromContent: aLeContent [
	^ self subclassResponsibility
]

{ #category : #'private - updating' }
LeContent >> reloadCommonMetadataFromContent: aLeContent [
	| attributesReloader |
	attributesReloader := LeContentAttributesReloader forContent: self.
	attributesReloader reloadCommonMetadataFromContent: aLeContent.
	^ attributesReloader hasChanges
]

{ #category : #'private - updating' }
LeContent >> reloadFromChildren: aCollection [
	"Update the receiver to match the supplied children"

	| existingBlockIDs replacementBlockIDs addedIDs modifiedIDs removedIDs changed |
	existingBlockIDs := self children collect: #uid as: Set.
	replacementBlockIDs := aCollection collect: #uid as: Set.
	addedIDs := replacementBlockIDs difference: existingBlockIDs.
	removedIDs := existingBlockIDs difference: replacementBlockIDs.
	modifiedIDs := existingBlockIDs intersection: replacementBlockIDs.
	changed := false.
	
	aCollection withIndexDo: [ :child :index | 
			(addedIDs includes: child uid)
				ifTrue: [ 
					self addSnippet: child beforeIndex: index.
					changed := true ]
				ifFalse: [ 
					(modifiedIDs includes: child uid)
						ifTrue: [ 
							| existingSnippet existingSnippetChanged |
							existingSnippet := self children detect: [ :each | each uid = child uid ].
							existingSnippetChanged := existingSnippet reloadFromContent: (aCollection at: index).
							changed := changed |existingSnippetChanged ]
						ifFalse: [ self error: 'ID integrity check fail' ] ] ].
	removedIDs do: [ :uid | 
		self children removeAllSuchThat: [ :each | each uid = uid ] ].
	removedIDs ifNotEmpty: [ changed := true ].
	
	self updateChildrenOrderBasedOn: aCollection.
	
	^ changed
]

{ #category : #'private - updating' }
LeContent >> reloadFromContent: aLeContent [
	"Reload the receiver from the supplied snippet"
	| changed |

	changed := self reloadAttributesFromContent: aLeContent.

	"Reload the receiver's children from the supplied content.
	While this answers a boolean indicating whether changes were made, each change is announced individually, so no need to re-announce here"
	self reloadFromChildren: aLeContent children.

	^ changed
]

{ #category : #'api - editing' }
LeContent >> removeSnippet: aLeSnippet [
	"Remove the supplied snippet from the receiver"

	"we should not be able to remove a block twice"
	aLeSnippet parent == self ifFalse: [ ^ self ].
	
	self children removeSnippet: aLeSnippet.
	aLeSnippet removedFromDatabase: self database.
	self announceContentRemoved: aLeSnippet from: self page in: self database.
]

{ #category : #'api - notifications' }
LeContent >> removedFromDatabase: aDatabase [

	self assert: aDatabase equals: self database.
	self clearDatabase.
	self children do: [ :eachChild | 
		eachChild removedFromDatabase: aDatabase ].
	self onRemovedFromDatabase: aDatabase.
]

{ #category : #private }
LeContent >> setCreateTimeAndEmailUsingDatabase: aDatabase [
	"Set the receiver's email and time metadata"

	"This should only be called for uninitialised content, but just in case..."
	createTime ifNotNil: [ ^ self ].

	createTime := LeTime now.
	editTime := createTime.
	createEmail := aDatabase userEmail.
	editEmail := createEmail.
]

{ #category : #initialization }
LeContent >> setDatabase: aDatabase [
	"Set the receiver's and childrens database.
	Metadata is never updated - this is called as part of a bulk load of the database."

	database == aDatabase ifTrue: [ ^ self ].
	self database: aDatabase.
	self children do: [ :eachChild | 
		eachChild setDatabase: aDatabase ].

]

{ #category : #'api - editing' }
LeContent >> snippetBuilder [
	^ LeParentSnippetBuilder new
		parent: self;
		database: self database.
]

{ #category : #'api - editing' }
LeContent >> unindentSnippet: aLeSnippet [
	"Unindent the supplied snippet in the receiver, i.e. make it follow its parent snippet.
	If this is a first level snippet, do nothing"

	self children removeSnippet: aLeSnippet.
	self parent basicAddSnippet: aLeSnippet after: self.
	self parent announceContentMoved: aLeSnippet.
]

{ #category : #'api - updating' }
LeContent >> unlinkedBy: aLink [
	self incomingLinks remove: aLink ifAbsent: [ "ignore" ]
]

{ #category : #'api - updating' }
LeContent >> unlinkedTarget: aLeContent in: aLeLink [
	"subclasses may react to link target losts"
]

{ #category : #installing }
LeContent >> unload [ 

	self subclassResponsibility 
]

{ #category : #'private - updating' }
LeContent >> updateChildrenOrderBasedOn: aCollection [
	aCollection withIndexDo: [ :aLoadedSnippet :anIndex | 
		| existingSnippet |
		existingSnippet := self children at: anIndex.
		existingSnippet uid = aLoadedSnippet uid ifFalse: [
			self children 
				swapSnippetAtIndex: anIndex
				withSnippetWithUid: aLoadedSnippet uid ] ]
]

{ #category : #private }
LeContent >> updateEditTimeAndEmail [

	database isDatabase ifFalse: [ ^ self ].
	editTime := LeTime now.
	editEmail := self database userEmail.
]

{ #category : #'api - testing' }
LeContent >> wasEdited [
	"It may be edited in past (by any person). 
	In other words, it does not mean that it was edited in an existing editing session"
	<return: #Boolean>
	^ self editTime ~= self createTime
]

{ #category : #accessing }
LeContent >> withAllChildrenBreadthFirst [
	| result |
	result := OrderedCollection new.
	self withAllChildrenBreadthFirstDo: [:each | result add: each ].
	^ result
]

{ #category : #'api - enumerating' }
LeContent >> withAllChildrenDepthFirstDo: aBlock [ 
	self allChildrenDepthFirstDo: aBlock.
	aBlock value: self.
]
