Class {
	#name : #LeSnippetPhlowTool,
	#superclass : #LePhlowTool,
	#instVars : [
		'snippet'
	],
	#category : 'Lepiter-UI-Phlow Tools'
}

{ #category : #'api - instance creation' }
LeSnippetPhlowTool class >> block: aSnippet [
	self 
		deprecated: 'Use #snippet: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver snippet: `@arg'.
	^ self snippet: aSnippet.
]

{ #category : #'api - instance creation' }
LeSnippetPhlowTool class >> snippet: aPart [
	^ self new snippet: aPart
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> block [
	self 
		deprecated: 'Use #snippet instead.' 
		transformWith: '`@receiver block' -> '`@receiver snippet'.
	^ self snippet
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> block: aSnippet [
	self 
		deprecated: 'Use #snippet: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver snippet: `@arg'.
	^ self snippet: aSnippet.
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> object [
	^ self block
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> snippet [
	<return: #LeTextSnippet>
	^ snippet
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> snippet: aSnippet [ 
	snippet := aSnippet
]

{ #category : #'api - accessing' }
LeSnippetPhlowTool >> title [
	^ self block title
]
