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
