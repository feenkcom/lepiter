Class {
	#name : #LeShellCommandSnippet,
	#superclass : #LeCodeSnippet,
	#instVars : [
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

{ #category : #acccessing }
LeShellCommandSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #bindingName -> #bindingName;
		yourself
]

{ #category : #accessing }
LeShellCommandSnippet class >> leJsonV4Name [
	^ 'shellCommandSnippet'
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
LeShellCommandSnippet >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #initialization }
LeShellCommandSnippet >> newCoder [
	^ GtShellSourceCoder new
]

{ #category : #accessing }
LeShellCommandSnippet >> shellScript [
	^ self code
]
