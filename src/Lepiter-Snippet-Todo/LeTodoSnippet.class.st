"
I represent a todo snippet that tracks a todo state and a plain text description.
"
Class {
	#name : #LeTodoSnippet,
	#superclass : #LeTextSnippet,
	#instVars : [
		'state'
	],
	#category : #'Lepiter-Snippet-Todo'
}

{ #category : #menu }
LeTodoSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #defaults }
LeTodoSnippet class >> defaultState [
	^ #todo
]

{ #category : #menu }
LeTodoSnippet class >> description [
	^ 'Todo'
]

{ #category : #accessing }
LeTodoSnippet class >> labelForState: aSymbol [
	^ aSymbol caseOf: {
		[#todo] -> [ 'Todo' ].
		[#inProgress] -> [ 'In progress' ].
		[#done] -> [ 'Done' ] }
		otherwise: [ aSymbol asString ]
]

{ #category : #'le-json' }
LeTodoSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: (#state -> #state);
		yourself
]

{ #category : #'le-json' }
LeTodoSnippet class >> leJsonV4Name [
	^ 'todoSnippet'
]

{ #category : #defaults }
LeTodoSnippet class >> states [
	^ #(todo inProgress done)
]

{ #category : #visiting }
LeTodoSnippet >> acceptVisitor: aVisitor [
	^ aVisitor visitTextSnippet: self
]

{ #category : #announcing }
LeTodoSnippet >> announceStateChanged [
	self
		notifyAnnouncement: (LeTodoSnippetStateChanged new
			snippet: self;
			yourself)
]

{ #category : #converting }
LeTodoSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeTodoSnippetViewModel new snippetModel: self
]

{ #category : #asserting }
LeTodoSnippet >> assertValidState: aSymbol [
	(self class states includes: aSymbol)
		ifFalse: [ self error: 'Invalid todo state.' ]
]

{ #category : #initialization }
LeTodoSnippet >> initialize [
	super initialize.
	state := self class defaultState
]

{ #category : #accessing }
LeTodoSnippet >> state [
	^ state
]

{ #category : #accessing }
LeTodoSnippet >> state: aSymbol [
	self assertValidState: aSymbol.
	state := aSymbol.
	self announceStateChanged
]

{ #category : #accessing }
LeTodoSnippet >> stateLabel [
	^ self class labelForState: self state
]
