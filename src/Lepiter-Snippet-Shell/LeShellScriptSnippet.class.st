Class {
	#name : #LeShellScriptSnippet,
	#superclass : #LeCodeSnippet,
	#instVars : [
		'bindingName'
	],
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #'accessing - menu' }
LeShellScriptSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'accessing - menu' }
LeShellScriptSnippet class >> description [
	^ 'Shell script'
]

{ #category : #accessing }
LeShellScriptSnippet class >> empty [
	^ self new
]

{ #category : #acccessing }
LeShellScriptSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #bindingName -> #bindingName;
		yourself
]

{ #category : #accessing }
LeShellScriptSnippet class >> leJsonV4Name [
	^ 'shellCommandSnippet'
]

{ #category : #accessing }
LeShellScriptSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeShellScriptSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeShellScriptSnippet >> bindingName [
	^ bindingName
]

{ #category : #accessing }
LeShellScriptSnippet >> bindingName: aNameString [
	bindingName := aNameString
]

{ #category : #initialization }
LeShellScriptSnippet >> newCoder [
	^ GtShellScriptSourceCoder new
]

{ #category : #accessing }
LeShellScriptSnippet >> shellScript [
	^ self code
]
