"
LeTableOfContentsNode helps present a Lepiter database as a hyper-linked book / document.

It is a tree of page links representing the Table Of Contents (ToC) of the book.

While the database currently only supports a single specified ToC, there is nothing preventing multiple pages being used as ToCs representing different views in to the database.


"
Class {
	#name : #LeTableOfContentsNode,
	#superclass : #LeAbstractTableOfContentsNode,
	#instVars : [
		'page',
		'link',
		'children'
	],
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #adding }
LeTableOfContentsNode >> addChild: aLeTableOfContentsNode [
	"Add the supplied node to the receiver's children"

	children := children copyWith: aLeTableOfContentsNode
]

{ #category : #accessing }
LeTableOfContentsNode >> children [
	^ children
]

{ #category : #accessing }
LeTableOfContentsNode >> hasChildren [
	<return: #Boolean>
	^ self children isNotEmpty
]

{ #category : #initialization }
LeTableOfContentsNode >> initialize [

	super initialize.
	"children are an Array of LeTableOfContentsNode"
	children := #().
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

{ #category : #accessing }
LeTableOfContentsNode >> printOn: aStream [
	| pageTitle |

	pageTitle := self page 
		ifNil: [ '<unknown>' ]
		ifNotNil: [ :aPage | aPage title ].
	"link
		ifNil: [ super printOn: aStream ]
		ifNotNil: [ "aStream 
			<< 'ToC: ';
			<< pageTitle "]".
	aStream
		space;
		nextPut: $(;
		print: self children size;
		nextPutAll: ' links';
		nextPut: $).
]
