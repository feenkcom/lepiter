Class {
	#name : #LeShellCommandSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'command',
		'arguments',
		'bindingName'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #'accessing - menu' }
LeShellCommandSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Shell command'
]

{ #category : #accessing }
LeShellCommandSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeShellCommandSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #command -> #command;
		add: #arguments -> #arguments;
		add: #bindingName -> #bindingName;
		yourself
]

{ #category : #accessing }
LeShellCommandSnippet class >> leJsonV4Name [
	^ 'shellCommandSnippet'
]

{ #category : #accessing }
LeShellCommandSnippet >> arguments [
	^ arguments ifNil: [ #() ]
]

{ #category : #accessing }
LeShellCommandSnippet >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
LeShellCommandSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeShellCommandSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeShellCommandSnippet >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeShellCommandSnippet >> bindingName: anObject [
	bindingName := anObject
]

{ #category : #accessing }
LeShellCommandSnippet >> command [
	^ command
]

{ #category : #accessing }
LeShellCommandSnippet >> command: anObject [
	command := anObject
]

{ #category : #accessing }
LeShellCommandSnippet >> contentAsString [
	self command isEmptyOrNil ifTrue: [ ^ String new ].
	^ self command , ' ' , (' ' join: self arguments)
]
