"
# Element snippet
Is a code snippet which must return an object that responds to `#asElement`.

"
Class {
	#name : #LeElementSnippet,
	#superclass : #LeCodeSnippet,
	#instVars : [
		'elementHeight',
		'codeHeight',
		'codeVisible'
	],
	#category : #'Lepiter-Snippet-Element-Snippet'
}

{ #category : #'instance creation' }
LeElementSnippet class >> code: aString [
	^ self new code: aString
]

{ #category : #factory }
LeElementSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 4;
		snippetClass: self;
		title: self description
]

{ #category : #factory }
LeElementSnippet class >> description [
	^ 'Element'
]

{ #category : #factory }
LeElementSnippet class >> empty [
	^ self new
]

{ #category : #'lepiter-store' }
LeElementSnippet class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#elementHeight -> #elementHeight);
		add: (#codeHeight -> #codeHeight);
		add: (#codeVisible -> #codeVisible);
		yourself
]

{ #category : #'lepiter-store' }
LeElementSnippet class >> leJsonV3Name [

	^ 'elementSnippet'
]

{ #category : #'lepiter-store' }
LeElementSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#elementHeight -> #elementHeight);
		add: (#codeHeight -> #codeHeight);
		add: (#codeVisible -> #codeVisible);
		yourself
]

{ #category : #'lepiter-store' }
LeElementSnippet class >> leJsonV4Name [

	^ 'elementSnippet'
]

{ #category : #visiting }
LeElementSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitElementSnippet: self
]

{ #category : #converting }
LeElementSnippet >> asPreviewElement [
	"Copied from LeTextElement. Might not be correct."
	| viewModel snippetElement |

	viewModel := self asSnippetViewModel.
	snippetElement := viewModel snippetView asElement.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).
	^ snippetElement
]

{ #category : #accessing }
LeElementSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeElementSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeElementSnippet >> caption [
	"A future implementation of caption"
	^ nil
]

{ #category : #accessing }
LeElementSnippet >> codeHeight [
	<return: #Number>
	^ codeHeight
]

{ #category : #accessing }
LeElementSnippet >> codeHeight: aNumber [
	(codeHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	codeHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeElementSnippetCodeHeightChanged new
		source: self;
		snippet: self;
		codeHeight: codeHeight)
]

{ #category : #accessing }
LeElementSnippet >> codeVisible [
	<return: #Boolean>
	^ codeVisible
]

{ #category : #accessing }
LeElementSnippet >> codeVisible: aBoolean [
	codeVisible = aBoolean
		ifTrue: [ ^ self ].

	codeVisible := aBoolean.

	self notifyAnnouncement: (LeElementSnippetCodeVisibilityChanged new
		source: self;
		snippet: self;
		codeVisible: codeVisible)
]

{ #category : #updating }
LeElementSnippet >> createEditCommandForElementHeight: anElementHeight [
	^ self 
		createEditCommandForElementHeight: anElementHeight 
		codeHeight: self codeHeight
]

{ #category : #updating }
LeElementSnippet >> createEditCommandForElementHeight: anElementHeight codeHeight: aCodeHeight [
	| command |
	command := self commandBuilder editSnippetStateCommand.
	
	(self elementHeight closeTo: anElementHeight) ifFalse: [
		command snippetState
			attributeNamed: #elementHeight setValue: anElementHeight ].
	
	(self codeHeight closeTo: aCodeHeight) ifFalse: [
		command snippetState
			attributeNamed: #codeHeight setValue: aCodeHeight ].

	^ command
]

{ #category : #updating }
LeElementSnippet >> createEditVisibilityCommandTo: aBoolean [ 
	| command |
	command := self commandBuilder editSnippetStateCommand.
	command snippetState
		attributeNamed: #codeVisible 
		setValue: aBoolean.
	^ command
]

{ #category : #accessing }
LeElementSnippet >> elementHeight [
	<return: #Number>
	^ elementHeight
]

{ #category : #accessing }
LeElementSnippet >> elementHeight: aNumber [
	(elementHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	elementHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeElementSnippetElementHeightChanged new
		source: self;
		snippet: self;
		elementHeight: elementHeight)
]

{ #category : #initialization }
LeElementSnippet >> initialize [
	super initialize.

	elementHeight := 100.
	codeHeight := 50.
	codeVisible := true
]

{ #category : #testing }
LeElementSnippet >> isForLocalImage [
	^ true
]

{ #category : #initialization }
LeElementSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]

{ #category : #testing }
LeElementSnippet >> similarTo: anotherExampleSnippet [
	^ self code = anotherExampleSnippet code
		and: [ self codeHeight = anotherExampleSnippet codeHeight
			and: [ self elementHeight = anotherExampleSnippet elementHeight
				and: [ self codeVisible = anotherExampleSnippet codeVisible ] ] ]
]

{ #category : #printing }
LeElementSnippet >> storeOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self className;
		nextPutAll: ' new code: ';
		print: self code;
		nextPutAll: '; codeVisible: ';
		print: self codeVisible;
		nextPutAll: '; elementHeight: ';
		print: self elementHeight;
		nextPutAll: '; codeHeight: ';
		print: self codeHeight;
		nextPutAll: '; yourself)'
]

{ #category : #updating }
LeElementSnippet >> updateIfRequiredCodeVisibility: aBoolean [
	| command |
	codeVisible = aBoolean
		ifTrue: [ ^ self ].
	
	command := self createEditVisibilityCommandTo: aBoolean.
	command execute 
]

{ #category : #updating }
LeElementSnippet >> updateIfRequiredElementHeight: anElementHeight [ 
	self 
		updateIfRequiredElementHeight: anElementHeight 
		codeHeight: self codeHeight
]

{ #category : #updating }
LeElementSnippet >> updateIfRequiredElementHeight: anElementHeight codeHeight: aCodeHeight [
	| command |
	command := self 
		createEditCommandForElementHeight: anElementHeight 
		codeHeight: aCodeHeight.

	command snippetState hasAttributes ifTrue: [
		command execute ]
]
