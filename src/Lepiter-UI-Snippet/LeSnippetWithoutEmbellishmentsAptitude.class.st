Class {
	#name : #LeSnippetWithoutEmbellishmentsAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'padding',
		'margin',
		'snippetContent'
	],
	#category : 'Lepiter-UI-Snippet-Looks'
}

{ #category : #initialization }
LeSnippetWithoutEmbellishmentsAptitude >> initialize [
	super initialize.

	padding := BlInsets empty.
	margin := BlInsets empty.

	snippetContent := BlElement new size: 0@0.

	self addChangeAddChildAs: #(content) with: [ snippetContent ].

	self addChangeProperty: #(widget margin) with: [ margin ].
	self addChangeProperty: #(widget padding) with: [ padding ].
	
	self add: (BrLayoutResizerAptitude new
		inherit;
		inherit: [ snippetContent ])
]

{ #category : #'api - accessing' }
LeSnippetWithoutEmbellishmentsAptitude >> margin [
	^ margin
]

{ #category : #'api - accessing' }
LeSnippetWithoutEmbellishmentsAptitude >> margin: anObject [
	margin := anObject
]

{ #category : #'api - accessing' }
LeSnippetWithoutEmbellishmentsAptitude >> padding [
	<return: #BlInsets>

	^ padding
]

{ #category : #'api - accessing' }
LeSnippetWithoutEmbellishmentsAptitude >> padding: aBlInsets [
	padding := aBlInsets
]

{ #category : #'api - accessing' }
LeSnippetWithoutEmbellishmentsAptitude >> snippetContent: aSnippetContent [
	snippetContent := aSnippetContent
]
