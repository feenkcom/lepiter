"
1. Element snippet
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
LeElementSnippet class >> contextMenuItemSpefication [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 4;
		snippetClass: self;
		title: 'Element'
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

{ #category : #accessing }
LeElementSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeElementSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeElementSnippet >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
LeElementSnippet >> codeHeight: aNumber [
	(codeHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	codeHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeElementSnippetCodeHeightChanged new
		source: self;
		snippet: self)
]

{ #category : #accessing }
LeElementSnippet >> codeVisible [
	^ codeVisible
]

{ #category : #accessing }
LeElementSnippet >> codeVisible: aBoolean [
	codeVisible = aBoolean
		ifTrue: [ ^ self ].

	codeVisible := aBoolean.

	self notifyAnnouncement: (LeElementSnippetCodeVisibilityChanged new
		source: self;
		snippet: self)
]

{ #category : #accessing }
LeElementSnippet >> elementHeight [
	^ elementHeight
]

{ #category : #accessing }
LeElementSnippet >> elementHeight: aNumber [
	(elementHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	elementHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeElementSnippetElementHeightChanged new
		source: self;
		snippet: self)
]

{ #category : #initialization }
LeElementSnippet >> initialize [
	super initialize.

	elementHeight := 100.
	codeHeight := 50.
	codeVisible := true
]

{ #category : #initialization }
LeElementSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]
