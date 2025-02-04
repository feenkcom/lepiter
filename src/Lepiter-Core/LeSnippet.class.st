"
LeSnippet is the common, abstract, superclass of all the content that can be added to a Lepiter Page.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	parent:		<LeContent>


### Implementation Points

"
Class {
	#name : #LeSnippet,
	#superclass : #LeContent,
	#instVars : [
		'parent',
		'uid'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #accessing }
LeSnippet class >> description [
	^ ''
]

{ #category : #accessing }
LeSnippet class >> stateAttributes [
	^ self leJsonV4AttributeMapping collect: [ :aMapping |
		LeGenericSnippetStateAttribute named: aMapping key ]
]

{ #category : #visiting }
LeSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitSnippet: self
]

{ #category : #'api - editing' }
LeSnippet >> addChildOrSiblingSnippetOfClass: aNewSnippetClass [ 
	"Add a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver."
	
	^ self hasChildren
		ifTrue: [ self addFirstSnippet: aNewSnippetClass empty ]
		ifFalse: [ self addSnippetAfterSelfOfClass: aNewSnippetClass ].
]

{ #category : #adding }
LeSnippet >> addExplicitLinkTo: aTargetReference [
	self assert: [ self database notNil ].
	self 
		assert: [ self database isDatabase ] 
		description: 'Explicit links shoud be attached this way only if the 
page is associated to a database. If not the link will be lost.'.
	
	self database addExplicitLink: (LeAttachedLink new
		originReference: (LeLinkSnippetUidReference forSnippet: self);
		targetReference: aTargetReference).
]

{ #category : #refactoring }
LeSnippet >> addParameterTo: oldName using: aRewriter [
	^ nil
]

{ #category : #'api - editing' }
LeSnippet >> addSnippetAfterSelf [
	"Add a new snippet after the receiver. Answer the new snippet"
	^ self parent addSnippetAfter: self.
]

{ #category : #'api - editing' }
LeSnippet >> addSnippetAfterSelf: aNewSnippet [
	"Add a new snippet after the receiver having the given class. Answer the new snippet"
	^ self parent addSnippet: aNewSnippet after: self
]

{ #category : #'api - editing' }
LeSnippet >> addSnippetAfterSelfOfClass: aNewSnippetClass [ 
	"Add a new snippet after the receiver having the given class. Answer the new snippet"
	^ self parent addSnippetOfClass: aNewSnippetClass after: self
]

{ #category : #'api - editing' }
LeSnippet >> addSnippetBeforeSelf [
	"Add a new snippet before the receiver. Answer the new snippet"
	^ self parent addSnippetBefore: self.
]

{ #category : #'api - editing' }
LeSnippet >> addSnippetBeforeSelfOfClass: aNewSnippetClass [ 
	"Add a new snippet before the receiver having the given class. Answer the new snippet"
	^ self parent addSnippetOfClass: aNewSnippetClass before: self
]

{ #category : #'api - notifications' }
LeSnippet >> addedToParent: aParent [

	self aboutToAddToDatabase: aParent database.
	self parent: aParent.
	self addedToDatabase: aParent database.
]

{ #category : #accessing }
LeSnippet >> additionalStateForCopying [

	^ LeGenericSnippetState new
]

{ #category : #accessing }
LeSnippet >> allSnippetVariables [
	| variables |
	variables := Set new.
	self page ifNil: [ ^ variables ].
	self page
		allChildrenDepthFirstDo: [ :each | 
			each isCodeSnippet
				ifTrue: [ variables addAll: each coder implicitVariableNames ] ].
	^ variables
]

{ #category : #'private - notifications' }
LeSnippet >> announceContentChanged [
	"Notify all dependents that the snippet's content (for example properties) has changed"

	self announceContentChangedBy: nil
]

{ #category : #'private - notifications' }
LeSnippet >> announceContentChangedBy: aSourceObject [
	"Notify all dependents that the snippet's content (for example properties) has changed"

	self notifyAnnouncement: (LeSnippetContentChanged new
		source: aSourceObject;
		snippet: self)
]

{ #category : #'api - attaching / detaching' }
LeSnippet >> attachFirstChildSnippet: aNewSnippet [
	self assert: [ aNewSnippet notNil ].
	self assert: [ aNewSnippet parent isNil ].
	
	self children addFirstChild: aNewSnippet.
	aNewSnippet attachToParent: self.
	^ aNewSnippet
]

{ #category : #'api - attaching / detaching' }
LeSnippet >> attachToParent: aParentSnippet [
	self assert: [ aParentSnippet notNil ].
	self 
		assert: [ self parent isNil ] 
		description: 'To attach a snippet is must have been previously detached.'.
	
	self parent: aParentSnippet
]

{ #category : #'api - attachments' }
LeSnippet >> attachments [
	^ LeContentAttachmentsCollector new
		content: self;
		local
]

{ #category : #'api - testing' }
LeSnippet >> canBeIndented [
	"A snippet can be indented as long as it is not the first child.
	Indenting adds it as a child of the previous sibling"
	
	^ self isFirstChild not
]

{ #category : #'api - testing' }
LeSnippet >> canBeMovedDown [
	"A snippet can me moved down if there are children below it,
	or its parent has siblings below it."
	
	^ self isLastChild not or: [
		self parent isSnippet and: [
			self parent isLastChild not ] ].
]

{ #category : #'api - testing' }
LeSnippet >> canBeMovedUp [
	"A snippet can me moved up if there are children above it,
	or its parent has siblings above it."
	
	^ self isFirstChild not or: [
		self parent isSnippet and: [
			self parent isFirstChild not ] ].
]

{ #category : #'api - testing' }
LeSnippet >> canBeUnindented [
	"A snippet can be unintented as long as its parent is another snippet.
	Unindenting adds it as a sibling of the parent sibling"
	
	^ self parent isSnippet
]

{ #category : #testing }
LeSnippet >> canMoveToAnotherDatabase [
	"For the moment, if a snippet has links to attachments in the database or is somehow tied to other files, it cannot be moved.
	Each snippet class should implement this as true or false, or implement the corresponding logic."
	^ false
]

{ #category : #refactoring }
LeSnippet >> changeToRenameClass: oldName to: newName [
	^ nil
]

{ #category : #refactoring }
LeSnippet >> changeToRenameSelector: oldName to: newName using: aRewriter [
	^ nil
]

{ #category : #references }
LeSnippet >> classAndSelectorReferencesPromise [
	^ #(#() #()) asAsyncPromise
]

{ #category : #'api - commands' }
LeSnippet >> commandBuilder [
	^ LeSnippetCommandBuilder forContent: self
]

{ #category : #'api - attaching / detaching' }
LeSnippet >> detachFromParent [
	self parent: nil
]

{ #category : #history }
LeSnippet >> extractCommonState [
	^ LeCommonSnippetStateExtractor fromSnippet: self
]

{ #category : #history }
LeSnippet >> extractSpecificState [
	^ LeSpecificSnippetStateExtractor fromSnippet: self
]

{ #category : #history }
LeSnippet >> extractSpecificStateBasedOnState: aSnippetState [ 
	^ (LeSpecificSnippetStateExtractor forSnippet: self)
		targetState: aSnippetState;
		extractState
]

{ #category : #history }
LeSnippet >> extractUpdatableState [
	^ LeUpdatableSnippetStateExtractor fromSnippet: self
]

{ #category : #history }
LeSnippet >> extractUpdatableStateBasedOnState: aSnippetState [ 
	^ self extractCommonState
		appendState: (self 
			extractSpecificStateBasedOnState: aSnippetState);
		yourself
]

{ #category : #'api - testing' }
LeSnippet >> hasUid: aLeUID [

	^ uid = aLeUID
]

{ #category : #'t-rotating' }
LeSnippet >> heading [
	^ nil
]

{ #category : #'api - testing' }
LeSnippet >> includesSnippetUid: aLeUID [
	"Answer a boolean indicating whether the supplied uid is present"

	^ (uid = aLeUID) or: [ self children includesSnippetUid: aLeUID ]
]

{ #category : #'api - editing' }
LeSnippet >> indent [
	"Indent the receiver in the receiver's page, i.e. make it a child of the previous snippet.
	If this is the first snippet at the current level, do nothing"

	self parent indentSnippet: self.
]

{ #category : #'api - command building' }
LeSnippet >> indentCommand [
	"Create a command for indenting the snippet"
	
	^ self commandBuilder indentSnippetCommand
]

{ #category : #'api - command operations' }
LeSnippet >> indentThroughCommand [
	^ self indentCommand execute
]

{ #category : #'api - command building' }
LeSnippet >> insertSnippetBeforeSelfCommandOfType: aNewSnippetClass [
	"Create a command for adding new snippet of the given type before the receiver. "
	
	^ self parent 
		insertChildCommandBeforeSnippet: self 
		ofType: aNewSnippetClass
]

{ #category : #testing }
LeSnippet >> isAbstract [
	"LeSnippet methods select: #isAbstract"
	^ true
]

{ #category : #'api - testing' }
LeSnippet >> isCodeSnippet [

	^ false
]

{ #category : #'api - testing' }
LeSnippet >> isCommentSnippet [
	^ false
]

{ #category : #'api - testing' }
LeSnippet >> isFirstChild [
	^ self parent isChildAtFirstPositionFor: self
]

{ #category : #'api - testing' }
LeSnippet >> isLastChild [
	^ self parent isChildAtLastPositionFor: self
]

{ #category : #'api - testing' }
LeSnippet >> isSnippet [

	^ true
]

{ #category : #'api - testing' }
LeSnippet >> isTextSnippet [

	^ false
]

{ #category : #'api - testing' }
LeSnippet >> isTextualSnippet [

	^ false
]

{ #category : #'api - testing' }
LeSnippet >> isUnknownSnippet [ 
	^ false
]

{ #category : #'api - enumerating' }
LeSnippet >> locateNextFocusedSnippetAfterRemove [
	"Return the snippet that should get the focus after this snippet is removed, or nil if there are no more snippets."
	
	^ self  
		previousSnippetDo: [ :aSnippet |  aSnippet ] 
		ifNone: [
			self  
				nextSnippetDo: [ :aSnippet | aSnippet ] 
				ifNone: [ nil ] ] 
]

{ #category : #'api - editing' }
LeSnippet >> mergeWithNext [
	"Merge the contents of the receiver with the next snippet (the next sibling, or the parent's next).
	Answer the merged snippet."

	^ self 
		nextSnippetDo: [ :nextSnippet | 
			self requestMergeWithSnippet: nextSnippet ] 
		ifNone: [ 
			self error: 'Can''t merge the last snippet with a following snippet' ].
]

{ #category : #'api - editing' }
LeSnippet >> mergeWithPrevious [
	"Merge the contents of the receiver with the previous snippet (the previous sibling, or the parent itself).
	Answer the merged snippet."

	^ self 
		previousSnippetDo: [ :previousSnippet | 
			previousSnippet requestMergeWithSnippet: self ] 
		ifNone: [ 
			self error: 'Can''t merge the first snippet with a previous snippet' ].
]

{ #category : #'api - editing' }
LeSnippet >> moveDown [
	"Move the receiver down one snippet.
	If the receiver has a sibling below it, move there, if not and the receiver's parent has a sibling below, move there"

	^ self parent moveDownSnippet: self.
]

{ #category : #'api - command building' }
LeSnippet >> moveDownCommand [
	"Create a command for moving up the snippet"
	
	^ self commandBuilder moveDownSnippetCommand
]

{ #category : #'api - command operations' }
LeSnippet >> moveDownThroughCommand [
	^ self moveDownCommand execute
]

{ #category : #'api - editing' }
LeSnippet >> moveToPage: aPage [
	self page removeSnippet: self.
	aPage addSnippet: self
]

{ #category : #'api - editing' }
LeSnippet >> moveUp [
	"Move the receiver up one snippet.
	If the receiver has a sibling below it, move there, if not and the receiver's parent has a sibling below, move there"

	^ self parent moveUpSnippet: self.
]

{ #category : #'api - command building' }
LeSnippet >> moveUpCommand [
	"Create a command for moving up the snippet"
	
	^ self commandBuilder moveUpSnippetCommand
]

{ #category : #'api - command operations' }
LeSnippet >> moveUpThroughCommand [
	^ self moveUpCommand execute
]

{ #category : #'api - enumerating' }
LeSnippet >> nextBlockDo: aBlock ifNone: aNoneBlock [
	self
		deprecated: 'Use #nextSnippetDo:ifNone: instead'
		transformWith:
			'`@receiver nextBlockDo: `@arg1 ifNone: `@arg2'
			-> '`@receiver nextSnippetDo: `@arg1 ifNone: `@arg2'.

	^ self nextSnippetDo: aBlock ifNone: aNoneBlock
]

{ #category : #'api - enumerating' }
LeSnippet >> nextSibling [
	"Answer the next sibling"
	| myIndex |

	self parent
		ifNil: [ self error: 'No siblings' ].

	myIndex := self parent blocks indexOf: self.
	^ myIndex == self parent childrenCount
		ifTrue: [ self error: 'I am the last sibling' ]
		ifFalse: [ self parent blocks at: myIndex + 1 ]
]

{ #category : #'api - enumerating' }
LeSnippet >> nextSiblingDo: aBlock ifNone: aNoneBlock [
	"Find a next sibling block in the tree and evaluate aBlock if such block found, aNoneBlock otherwise.
	The next sibling is considered to be the first found from:
	- The next sibling
	- The parents next sibling"

	| myIndex |
	self parent ifNil: [ ^ aNoneBlock value ].
	myIndex := self parent children indexOf: self.
	^ myIndex == self parent childrenCount
		ifTrue: [ self parent isPage
				ifTrue: [ aNoneBlock value ]
				ifFalse: [ self parent nextSiblingDo: aBlock ifNone: aNoneBlock ] ]
		ifFalse: [ aBlock value: (self parent children at: myIndex + 1) ]
]

{ #category : #'api - enumerating' }
LeSnippet >> nextSnippetDo: aBlock ifNone: aNoneBlock [
	"Find a next snippet in the tree and evaluate aBlock if such snippet found, aNoneBlock otherwise.
	The next snippet is considered to be the first found from:
	- The receiver's first child
	- The next sibling
	- The parents next sibling"

	| myIndex |
	self hasChildren
		ifTrue: [ ^ aBlock value: children first ].
	self parent ifNil: [ ^ aNoneBlock value ].
	myIndex := self parent children indexOf: self.
	^ myIndex == self parent childrenCount
		ifTrue: [ self parent isPage
				ifTrue: [ aNoneBlock value ]
				ifFalse: [ self parent nextSiblingDo: aBlock ifNone: aNoneBlock ] ]
		ifFalse: [ aBlock value: (self parent children at: myIndex + 1) ]
]

{ #category : #'api - notifications' }
LeSnippet >> notifier [
	^ LeNotifier new
		content: self
]

{ #category : #'private - notifications' }
LeSnippet >> notifyAnnouncement: anAnnouncement [
	"Send anAnnouncement to all dependents of the snippet"

	self notifier 
		local; page; database;
		announce: anAnnouncement
]

{ #category : #'private - hooks' }
LeSnippet >> onAboutToAddToDatabase: aDatabase [ 
	"Ensure the receiver has a uid before it is added to a database"
	super onAboutToAddToDatabase: aDatabase .
	
	uid ifNil: [ uid := aDatabase newUID ].
	aDatabase registerSnippet: self.
]

{ #category : #'private - hooks' }
LeSnippet >> onRemovedFromDatabase: aDatabase [
	super onRemovedFromDatabase: aDatabase.
	aDatabase unregisterSnippet: self.
	
	aDatabase removeExplicitOutgoingLinksForContent: self.
	aDatabase removeIncomingExplicitLinksForContent: self.
]

{ #category : #'api - accessing' }
LeSnippet >> outgoingTextualLinks [
	^ LeExplicitLinks new
]

{ #category : #'api - accessing' }
LeSnippet >> page [
	^ self parent
		ifNil: [ nil ] 
		ifNotNil: [ self parent page ]
]

{ #category : #'api - accessing' }
LeSnippet >> parent [
	<return: #LeContent>
	^ parent
]

{ #category : #'private - accessing' }
LeSnippet >> parent: aParent [ 
	parent := aParent
]

{ #category : #'api - enumerating' }
LeSnippet >> previousBlockDo: aBlock ifNone: aNoneBlock [
	self
		deprecated: 'Use #previousSnippetDo:ifNone: instead'
		transformWith:
			'`@receiver previousBlockDo: `@arg1 ifNone: `@arg2'
			-> '`@receiver previousSnippetDo: `@arg1 ifNone: `@arg2'.

	^ self previousSnippetDo: aBlock ifNone: aNoneBlock
]

{ #category : #'api - enumerating' }
LeSnippet >> previousSibling [
	"Answer the previous sibling"

	| myIndex |
	self parent ifNil: [ self error: 'No siblings' ].
	myIndex := self parent children indexOf: self.
	^ myIndex == 1
		ifTrue: [ self error: 'I am the first sibling' ]
		ifFalse: [ self parent children at: myIndex - 1 ]
]

{ #category : #'api - enumerating' }
LeSnippet >> previousSnippetDo: aBlock ifNone: aNoneBlock [
	"Find a previous snippet in the tree and evaluate aBlock if such snippet found, aNoneBlock otherwise.
	The previous snippet is considered to be the first found from:
	- The last descended child from the receiver's previous sibling
	- The previous sibling
	- The parent"

	| myIndex |
	self parent ifNil: [ ^ aNoneBlock value ].
	myIndex := self parent children indexOf: self.
	^ myIndex == 1
		ifTrue: [ self parent isPage
				ifTrue: [ aNoneBlock value ]
				ifFalse: [ aBlock value: self parent ] ]
		ifFalse: [ aBlock value: (self parent children at: myIndex - 1) lastChildOrSelf ]
]

{ #category : #refactoring }
LeSnippet >> removeParameterFrom: oldName using: aRewriter [
	^ nil
]

{ #category : #removing }
LeSnippet >> removeSelf [
	"Remove the receiver from its parent"
	
	self parent
		ifNil: [ ^ self ].
	self parent removeSnippet: self
]

{ #category : #'api - command building' }
LeSnippet >> removeSelfCommand [
	^ self parent removeChildCommandFor: self 
]

{ #category : #'api - command operations' }
LeSnippet >> removeSelfThroughCommand [
	^ self removeSelfCommand execute
]

{ #category : #'api - editing' }
LeSnippet >> requestMergeWithSnippet: aSnippet [
	"Request a merge between the receiver and the given snippet. 
	As a result of the request depending on the implementation:
	- nothing can happen if the merge is not accepted;
	- the receiver is deleted and its content is added to the given snippet
	- the given snippet is deleted amd its content is added to the receiver.
	
	One of the two snippets is returned to the caller."
	
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
LeSnippet >> topBlock [
	^ (self parent isNil or: [ self parent isPage ])
		ifTrue: [ self ] 
		ifFalse: [ self parent topBlock ]
]

{ #category : #'api - editing' }
LeSnippet >> transferChildrenTo: aSnippet [
	"Transfer the children of the receiver to the supplied snippet."

	children isEmpty
		ifTrue: [ ^ self ].
	children
		copyDo: [ :each | 
			self removeSnippet: each.
			aSnippet addSnippet: each ]
]

{ #category : #'api - accessing' }
LeSnippet >> uid [
	<return: #LeUID>
	^ uid
]

{ #category : #'api - accessing' }
LeSnippet >> uid: aLeUID [
	uid := aLeUID
]

{ #category : #'api - accessing' }
LeSnippet >> uidString [ 

	^ uid uidString
]

{ #category : #accessing }
LeSnippet >> uidString: aString64 [

	uid := LeUID new uidString: aString64
]

{ #category : #'api - editing' }
LeSnippet >> unindent [
	"Unindent the receiver in the receiver's page, i.e. make it follow its parent snippet.
	If this is a first level snippet, do nothing"

	self parent unindentSnippet: self.
]

{ #category : #'api - command building' }
LeSnippet >> unindentCommand [
	^ self commandBuilder unindentSnippetCommand
]

{ #category : #'api - command operations' }
LeSnippet >> unindentThroughCommand [
	^ self unindentCommand execute
]

{ #category : #installing }
LeSnippet >> unload [ 

	self notifier
		bubble; database;
		announce: (LeSnippetUnloadAnnouncement new content: self)
]
