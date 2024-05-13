Class {
	#name : #LeTableOfContentsRestNode,
	#superclass : #LeAbstractTableOfContentsNode,
	#instVars : [
		'page',
		'rootNode',
		'children'
	],
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #accessing }
LeTableOfContentsRestNode >> children [
	^ children
]

{ #category : #accessing }
LeTableOfContentsRestNode >> children: anObject [
	children := anObject
]

{ #category : #accessing }
LeTableOfContentsRestNode >> gtDisplayOn: stream [
	stream nextPutAll: 'Unclassified pages'
]

{ #category : #initialization }
LeTableOfContentsRestNode >> initialize [
	super initialize.
	children := #().
]

{ #category : #accessing }
LeTableOfContentsRestNode >> isForPage [
	^ false
]

{ #category : #testing }
LeTableOfContentsRestNode >> isToCNode [
	^ false
]

{ #category : #accessing }
LeTableOfContentsRestNode >> page [
	<return: #LeRestPage>
	^ page
]

{ #category : #accessing }
LeTableOfContentsRestNode >> page: aPage [
	page := LeRestPage new page: aPage; node: self
]

{ #category : #accessing }
LeTableOfContentsRestNode >> rootNode [
	^ rootNode
]

{ #category : #accessing }
LeTableOfContentsRestNode >> rootNode: aNode [
	| tocPages otherPages |
	rootNode := aNode.
	
	"Compute children"
	tocPages := Array streamContents: [ :aStream |
		aNode withAllChildrenBreadthFirstDo: [ :eachNode | 
			aStream nextPut: eachNode page ] ].
	
	otherPages := aNode page database pagesByDateToShow copyWithoutAll: tocPages.
	self children: (otherPages collect: [ :eachPage | LeTableOfContentsUnclassifiedNode new page: eachPage ]).
]

{ #category : #enumerating }
LeTableOfContentsRestNode >> selectedPageDo: aBlock [
	"aBlock cull: self page page"
]
