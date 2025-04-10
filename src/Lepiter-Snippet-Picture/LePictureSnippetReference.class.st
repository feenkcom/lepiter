Class {
	#name : #LePictureSnippetReference,
	#superclass : #Object,
	#instVars : [
		'snippetModel',
		'reference',
		'index'
	],
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #accessing }
LePictureSnippetReference >> caption [
	<return: #String>
	^ snippetModel caption
]

{ #category : #testing }
LePictureSnippetReference >> hasCaption [
	^ snippetModel hasCaption
]

{ #category : #accessing }
LePictureSnippetReference >> index [
	<return: #Integer>
	^ index
]

{ #category : #accessing }
LePictureSnippetReference >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
LePictureSnippetReference >> reference [
	<return: #String>
	^ reference
]

{ #category : #accessing }
LePictureSnippetReference >> reference: aString [
	reference := aString
]

{ #category : #accessing }
LePictureSnippetReference >> snippetModel [
	<return: #LePictureSnippet>
	^ snippetModel
]

{ #category : #accessing }
LePictureSnippetReference >> snippetModel: aSnippet [
	snippetModel := aSnippet
]
