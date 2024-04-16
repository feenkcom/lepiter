Class {
	#name : #LeStringSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'contentString'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #'api - accessing menu' }
LeStringSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'StringResource'
]

{ #category : #accessing }
LeStringSnippet class >> empty [
	^ self new
]

{ #category : #accessing }
LeStringSnippet class >> leJsonV4Name [
	^ 'stringSnippet'
]

{ #category : #converting }
LeStringSnippet >> asSnippetViewModel [
	<return: #LeSnippetViewModel>
	^ LeStringSnippetViewModel new snippetModel: self
]

{ #category : #accessing }
LeStringSnippet >> contentAsString [
	^ self contentString
]

{ #category : #accessing }
LeStringSnippet >> contentString [
	^ contentString
]

{ #category : #accessing }
LeStringSnippet >> contentString: anObject [
	contentString := anObject
]
