Class {
	#name : 'LeTableOfContentsRestNode',
	#superclass : 'Object',
	#instVars : [
		'page',
		'rootNode',
		'children'
	],
	#category : 'Lepiter-Utilities-ToC'
}

{ #category : 'accessing' }
LeTableOfContentsRestNode >> children [
	^ children
]

{ #category : 'accessing' }
LeTableOfContentsRestNode >> children: anObject [
	children := anObject
]

{ #category : 'gt-extension' }
LeTableOfContentsRestNode >> gtChildrenFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 50;
		items: [ self children ];
		children: #children
]

{ #category : 'gt-extension' }
LeTableOfContentsRestNode >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : 'initialization' }
LeTableOfContentsRestNode >> initialize [
	super initialize.
	children := #().
]

{ #category : 'testing' }
LeTableOfContentsRestNode >> isToCNode [
	^ false
]

{ #category : 'accessing' }
LeTableOfContentsRestNode >> page [
	<return: #LeRestPage>
	^ page
]

{ #category : 'accessing' }
LeTableOfContentsRestNode >> page: aPage [
	page := LeRestPage new page: aPage; node: self
]

{ #category : 'printing' }
LeTableOfContentsRestNode >> printOn: aStream [

	aStream
		nextPutAll: 'ToC: Other pages';
		space;
		nextPut: $(;
		print: children size;
		nextPutAll: ' pages';
		nextPut: $).
]

{ #category : 'accessing' }
LeTableOfContentsRestNode >> rootNode [
	^ rootNode
]

{ #category : 'accessing' }
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

{ #category : 'enumerating' }
LeTableOfContentsRestNode >> selectedPageDo: aBlock [
	"aBlock cull: self page page"
]
