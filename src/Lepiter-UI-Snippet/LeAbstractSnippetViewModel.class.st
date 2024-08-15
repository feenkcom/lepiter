"
# Snippet View Model
## Properties
Each snippet is focusable and expandable.
## Types of snippets from UI perspective
Displayed snippets can come from multiple sources; they can be persistently stored in a database or computed dynamically.
We call snippets that are stored in a database {{gtClass:LeSnippetViewModel|label=explicit}} and dynamically computed {{gtClass:LeDynamicSnippetViewModel|label=dynamic}}


"
Class {
	#name : #LeAbstractSnippetViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtOptions + TLeWithSnippetModel',
	#classTraits : 'TGtAnnouncer classTrait + TGtOptions classTrait + TLeWithSnippetModel classTrait',
	#instVars : [
		'announcer',
		'snippetsCollection',
		'snippetChildren',
		'focused',
		'expanded',
		'sharedContext',
		'titleElement'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #testing }
LeAbstractSnippetViewModel class >> isAbstract [
	^ self
		classAndMethodFor: #snippetElementClass
		do: [ :c :m | m isSubclassResponsibility ]
		ifAbsent: [ true ]
]

{ #category : #'api - children' }
LeAbstractSnippetViewModel >> allSnippetChildrenBreadthFirstDo: aBlock [
	| queue next |
	queue := LinkedList new.
	queue addAll: self snippetChildren.
	[ queue notEmpty ]
		whileTrue: [ next := queue removeFirst.
			aBlock value: next.
			queue addAll: next snippetChildren ]
]

{ #category : #announcer }
LeAbstractSnippetViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> content [
	self
		deprecated: 'Use #snippetModel instead.'
		transformWith: '`@receiver content' -> '`@receiver snippetModel'.

	^ self snippetModel
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> content: aLeSnippet [
	self
		deprecated: 'Use #snippetModel: instead.'
		transformWith: '`@receiver content: `@arg' -> '`@receiver snippetModel: `@arg'.

	self snippetModel: aLeSnippet
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> database [ 
	"Answer the database associated with the receiver"

	^ self snippetModel database
]

{ #category : #'api - expansion' }
LeAbstractSnippetViewModel >> expanded [
	"Return true if a snippet should be expanded or collapsed.
	Collapsing a parent snippet does not collapse children, although depending
	on the way snippets are rendered children may become visually collapsed, for example
	if rendered as a tree."
	<return: #Boolean>
	
	^ expanded
]

{ #category : #'api - expansion' }
LeAbstractSnippetViewModel >> expanded: aBoolean [	
	expanded = aBoolean
		ifTrue: [ ^ self ].
	
	expanded := aBoolean.	

	self notifyExpansionChanged: aBoolean
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focusAfterCreation [
	"Give this snippet focus because it was just created. Custom snippets may overide this to give focus
	to their internal components of choice"

	self focused: true
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focusDueToNavigationDown [
	"Give this snippet focus because the user requested to focus a previous snippet (usually arrow down)"

	self focused: true
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focusDueToNavigationUp [
	"Give this snippet focus because the user requested to focus a previous snippet (usually arrow up)"

	self focused: true
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focusNextSnippet [
	"Try to give focus to the snippet after me that is either:
	- a next parent of the snippet if this is the last child
	- a next sibling if this is not the last child.
	Return true if there was a next snippet and focus transfer was succesful, false otherwise"
	<return: #Boolean>
	
	self snippetsCollectionDo: [ :aSnippetsCollection |
		^ self snippetModel
			nextSnippetDo: [ :previousSnippet |
				| snippetViewModelToFocus |

				snippetViewModelToFocus := aSnippetsCollection findOrCreateSnippetViewModel: previousSnippet.
				snippetViewModelToFocus focusDueToNavigationDown.
				aSnippetsCollection scrollToViewModel: snippetViewModelToFocus.
				true ]
			ifNone: [ false ] ].
	^ false
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focusPreviousSnippet [
	"Try to give focus to the snippet before me that is either:
	- a parent of the snippet if this is the first child
	- a previous sibling if this is not the first child.
	- the title if this is the first snippet.
	Returns true if any of those are found."

	| isFound |
	isFound := false.

	self
		snippetsCollectionDo: [ :aSnippetsCollection | 
			isFound := self snippetModel
					previousSnippetDo: [ :previousSnippet | 
						| snippetViewModelToFocus |
						snippetViewModelToFocus := aSnippetsCollection
								findOrCreateSnippetViewModel: previousSnippet.
						snippetViewModelToFocus focusDueToNavigationUp.
						aSnippetsCollection scrollToViewModel: snippetViewModelToFocus.
						true ]
					ifNone: [ false ] ].

	isFound
		ifFalse: [ self titleElement
				ifNotNil: [ self titleElement requestFocus.
					isFound := true ] ].

	^ isFound
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focused [
	<return: #Boolean>

	^ focused
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focused: aBoolean [
	self focused: aBoolean from: self
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> focused: aBoolean from: aSourceObject [
	focused = aBoolean
		ifTrue: [ ^ self ].

	focused := aBoolean.
	self onFocusChanged: aBoolean.
	self notifyFocusChanged: focused from: aSourceObject.

	self snippetsCollectionDo: [ :aSnippetsCollectionUIModel |
		aBoolean
			ifTrue: [ aSnippetsCollectionUIModel focusSnippetUIModel: self  ]
			ifFalse: [ aSnippetsCollectionUIModel unfocusSnippetUIModel: self ] ]
]

{ #category : #'gt-extension' }
LeAbstractSnippetViewModel >> gtChildrenFor: aView [
	<gtView>
	
	self snippetChildren
		ifEmpty: [ ^ aView empty ].
		
	^ aView tree
		title: 'Children';
		priority: 5;
		items: [ { self } ];
		children: #children;
		itemText: [ :eachUIModel | eachUIModel class name, ' (', eachUIModel content printString, ')' ];
		expandUpTo: 2
]

{ #category : #'gt-extension' }
LeAbstractSnippetViewModel >> gtLiveFor: aView [
	<gtView>
	
	self class isAbstract
		ifTrue: [ ^ aView empty ].

	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			| aSnippetElement |
			aSnippetElement := self snippetView asElement.
			aSnippetElement snippetViewModel: self.
			aSnippetElement padding: (BlInsets all: 10).
			aSnippetElement ]
]

{ #category : #initialization }
LeAbstractSnippetViewModel >> initialize [
	super initialize.
	
	snippetChildren := #().
	focused := false.
	expanded := true.
	sharedContext := LeSharedSnippetContext new
]

{ #category : #private }
LeAbstractSnippetViewModel >> keyboardShortcut: aSymbol [
	"Answer the named keyboard shortcut"
	
	^ LeSnippetElement keyboardShortcut: aSymbol
]

{ #category : #'filter view' }
LeAbstractSnippetViewModel >> leHighlighters [
	^ self optionAt: #leHighlighters ifAbsent: [ Dictionary new ]
]

{ #category : #'filter view' }
LeAbstractSnippetViewModel >> leHighlighters: aDictionary [
	self optionAt: #leHighlighters put: aDictionary.
	self updateHighlighter
]

{ #category : #private }
LeAbstractSnippetViewModel >> notifyExpansionChanged: aBoolean [
	self announce: (LeSnippetExpansionChanged new expanded: aBoolean)
]

{ #category : #private }
LeAbstractSnippetViewModel >> notifyFocusChanged: aBoolean from: aSourceObject [
	self announce: (LeSnippetFocusChanged new focused: aBoolean; source: aSourceObject)
]

{ #category : #'api - focus' }
LeAbstractSnippetViewModel >> onFocusChanged: aBoolean [
]

{ #category : #'api - snippet model' }
LeAbstractSnippetViewModel >> onSnippetModelChanged [
	"Is sent when a new snippet model is assigned to the view model"
]

{ #category : #copying }
LeAbstractSnippetViewModel >> postCopy [
	super postCopy.
	
	announcer := nil.
	snippetsCollection := nil
]

{ #category : #private }
LeAbstractSnippetViewModel >> resolveFileName: aFilenameString [
	"Search for the supplied file name in the database or working directory"
	| fileReference |

	self snippetModel database monitor ifNotNil: 
		[ :aMonitor |
		
		fileReference := aMonitor localRoot / aFilenameString.
		fileReference exists ifTrue: 
			[ ^ fileReference ] ].

	^ FileLocator workingDirectory / aFilenameString
]

{ #category : #'api - shared context' }
LeAbstractSnippetViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	self
		assert: [ aLeSharedSnippetContext notNil ]
		description: [ 'Shared context must not be nil' ].

	sharedContext := aLeSharedSnippetContext
]

{ #category : #'api - accessing' }
LeAbstractSnippetViewModel >> shortSummaryText [
	"Return a short textual represenation of the snippet to be displayed as a preview"
	<return: #String>
	
	^ String
		streamContents: [ :aStream | 
			self snippetModel contentAsString asString
				do: [ :eachCharacter | 
					eachCharacter isLineSeparator
						ifTrue: [ aStream space ]
						ifFalse: [ aStream nextPut: eachCharacter ] ] ]
		limitedTo: 300
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> snippet [
	self
		deprecated: 'Use #snippetModel instead.'
		transformWith: '`@receiver snippet' -> '`@receiver snippetModel'.

	^ self snippetModel
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> snippet: aLeSnippet [
	self
		deprecated: 'Use #snippetModel: instead.'
		transformWith: '`@receiver snippet: `@arg' -> '`@receiver snippetModel: `@arg'.

	self snippetModel: aLeSnippet
]

{ #category : #'api - shared context' }
LeAbstractSnippetViewModel >> snippetBindings [
	<return: #GtSharedVariablesBindings>

	^ sharedContext sharedBindings
]

{ #category : #'api - children' }
LeAbstractSnippetViewModel >> snippetChildren [
	<return: #Collection of: #LeAbstractSnippetViewModel>

	^ snippetChildren
]

{ #category : #'api - children' }
LeAbstractSnippetViewModel >> snippetChildren: aCollectionOfSnippetViewModels [
	snippetChildren := aCollectionOfSnippetViewModels
]

{ #category : #'api - accessing' }
LeAbstractSnippetViewModel >> snippetElementClass [
	^ self subclassResponsibility
]

{ #category : #'api - accessing' }
LeAbstractSnippetViewModel >> snippetView [
	<return: #LeSnippetView>

	^ LeSnippetView new snippetElementClass: self snippetElementClass
]

{ #category : #private }
LeAbstractSnippetViewModel >> snippetsCollection: aLeSnippetsCollectionUIModel [
	self
		assert: [ aLeSnippetsCollectionUIModel notNil ]
		description: [ 'Snippets collection UI Model must not be nil' ].
	
	snippetsCollection := aLeSnippetsCollectionUIModel
]

{ #category : #private }
LeAbstractSnippetViewModel >> snippetsCollectionDo: aBlock [
	"Evaluate aBlock with the current snippets collection as an arguments if it is assigned"
	
	snippetsCollection ifNotNil: aBlock
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> titleElement [
	^ titleElement
]

{ #category : #accessing }
LeAbstractSnippetViewModel >> titleElement: anObject [
	titleElement := anObject
]

{ #category : #'api - accessing' }
LeAbstractSnippetViewModel >> uid [
	"Each snippet view model displayed in the snippets element should have a uid.
	By default we take the uid of the content, however, custom snippet view models are free to override it"
	<return: #LeUID>

	^ self subclassResponsibility
]

{ #category : #'filter view' }
LeAbstractSnippetViewModel >> updateHighlighter [
]

{ #category : #'api - children' }
LeAbstractSnippetViewModel >> withAllSnippetChildrenBreadthFirstDo: aBlock [ 
	aBlock value: self.
	self allSnippetChildrenBreadthFirstDo: aBlock
]
