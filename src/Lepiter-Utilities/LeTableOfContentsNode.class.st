"
LeTableOfContentsNode helps present a Lepiter database as a hyper-linked book / document.

It is a tree of page links representing the Table Of Contents (ToC) of the book.

While the database currently only supports a single specified ToC, there is nothing preventing multiple pages being used as ToCs representing different views in to the database.


"
Class {
	#name : #LeTableOfContentsNode,
	#superclass : #Object,
	#traits : 'TLeSpotterChildrenEnumerationSearch',
	#classTraits : 'TLeSpotterChildrenEnumerationSearch classTrait',
	#instVars : [
		'page',
		'link',
		'children'
	],
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #comparing }
LeTableOfContentsNode >> = anObject [
	^ self class = anObject class and: [ 
		self page = anObject page ]
]

{ #category : #adding }
LeTableOfContentsNode >> addChild: aLeTableOfContentsNode [
	"Add the supplied node to the receiver's children"

	children := children copyWith: aLeTableOfContentsNode
]

{ #category : #accessing }
LeTableOfContentsNode >> children [
	^ children
]

{ #category : #ui }
LeTableOfContentsNode >> gtChildrenFor: aView [
	<gtView>

	^ aView tree
		title: 'Children';
		priority: 50;
		items: [ children ];
		children: #children
]

{ #category : #accessing }
LeTableOfContentsNode >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #'api - testing' }
LeTableOfContentsNode >> hasChildren [
	<return: #Boolean>
	^ self children isNotEmpty
]

{ #category : #comparing }
LeTableOfContentsNode >> hash [
	^ self class hash bitXor: [ 
		self page hash ]
]

{ #category : #initialization }
LeTableOfContentsNode >> initialize [

	super initialize.
	"children are an Array of LeTableOfContentsNode"
	children := #().
]

{ #category : #testing }
LeTableOfContentsNode >> isToCNode [
	^ true
]

{ #category : #accessing }
LeTableOfContentsNode >> link [
	"Answer the page link the receiver refers to"
	<return: #LeTextualPageLink>

	^ link
]

{ #category : #accessing }
LeTableOfContentsNode >> link: aLePageLink [

	link := aLePageLink
]

{ #category : #accessing }
LeTableOfContentsNode >> page [
	^ page ifNil: [ link ifNotNil: [ page := link target ] ]
]

{ #category : #accessing }
LeTableOfContentsNode >> page: anObject [
	page := anObject
]

{ #category : #printing }
LeTableOfContentsNode >> printOn: aStream [
	| pageTitle |

	pageTitle := self page 
		ifNil: [ '<unknown>' ]
		ifNotNil: [ :aPage | aPage title ].
	link
		ifNil: [ super printOn: aStream ]
		ifNotNil: [ aStream 
			<< 'ToC: ';
			<< pageTitle ].
	aStream
		space;
		nextPut: $(;
		print: children size;
		nextPutAll: ' links';
		nextPut: $).
]

{ #category : #enumerating }
LeTableOfContentsNode >> selectedPageDo: aBlock [
	aBlock cull: self page
]
