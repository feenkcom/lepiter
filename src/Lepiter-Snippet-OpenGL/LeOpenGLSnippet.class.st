Class {
	#name : 'LeOpenGLSnippet',
	#superclass : 'LeCodeSnippet',
	#instVars : [
		'codeHeight',
		'codeVisible',
		'viewportHeight'
	],
	#category : 'Lepiter-Snippet-OpenGL-Snippet'
}

{ #category : 'instance creation' }
LeOpenGLSnippet class >> code: aString [
	^ self new code: aString
]

{ #category : 'factory' }
LeOpenGLSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		priority: 4;
		snippetClass: self;
		title: 'OpenGL'
]

{ #category : 'factory' }
LeOpenGLSnippet class >> empty [
	^ self new
]

{ #category : 'lepiter-store' }
LeOpenGLSnippet class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		"accessor in the snippet -> key in the json"
		add: (#viewportHeight -> #viewportHeight);
		add: (#codeHeight -> #codeHeight);
		add: (#codeVisible -> #codeVisible);
		yourself
]

{ #category : 'lepiter-store' }
LeOpenGLSnippet class >> leJsonV4Name [

	^ 'OpenGLSnippet'
]

{ #category : 'visiting' }
LeOpenGLSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitElementSnippet: self
]

{ #category : 'accessing' }
LeOpenGLSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeElementSnippetViewModel new snippetModel: self
]

{ #category : 'accessing' }
LeOpenGLSnippet >> codeHeight [
	^ codeHeight
]

{ #category : 'accessing' }
LeOpenGLSnippet >> codeHeight: aNumber [
	(codeHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	codeHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeOpenGLSnippetCodeHeightChanged new
		source: self;
		snippet: self)
]

{ #category : 'accessing' }
LeOpenGLSnippet >> codeVisible [
	^ codeVisible
]

{ #category : 'accessing' }
LeOpenGLSnippet >> codeVisible: aBoolean [
	codeVisible = aBoolean
		ifTrue: [ ^ self ].

	codeVisible := aBoolean.

	self notifyAnnouncement: (LeOpenGLSnippetCodeVisibilityChanged new
		source: self;
		snippet: self)
]

{ #category : 'initialization' }
LeOpenGLSnippet >> initialize [
	super initialize.

	viewportHeight := 100.
	codeHeight := 50.
	codeVisible := true
]

{ #category : 'initialization' }
LeOpenGLSnippet >> newCoder [
	^ GtPharoSnippetCoder new
]

{ #category : 'accessing' }
LeOpenGLSnippet >> viewportHeight [
	^ viewportHeight
]

{ #category : 'accessing' }
LeOpenGLSnippet >> viewportHeight: aNumber [
	(viewportHeight closeTo: aNumber)
		ifTrue: [ ^ self ].

	viewportHeight := aNumber rounded.
	
	self notifyAnnouncement: (LeOpenGLSnippetViewportHeightChanged new
		source: self;
		snippet: self)
]
