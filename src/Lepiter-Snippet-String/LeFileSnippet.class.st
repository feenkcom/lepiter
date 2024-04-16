Class {
	#name : #LeFileSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'fileReference'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #'api - accessing menu' }
LeFileSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'FileResource'
]

{ #category : #accessing }
LeFileSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeFileSnippet class >> leJsonV4Name [
	^ 'fileSnippet'
]

{ #category : #converting }
LeFileSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeFileSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeFileSnippet >> contentAsString [
	^ String new
]
