"
An implicit link is one where the title of a page is contained in the text of a snippet, but it isn't explicitly marked as a link.

Implicit links have also been called ""unreferenced links"".
"
Class {
	#name : #LeImplicitPageLink,
	#superclass : #LeLink,
	#instVars : [
		'title',
		'origin',
		'target',
		'node'
	],
	#category : #'Lepiter-Core-Links'
}

{ #category : #'api - accessing' }
LeImplicitPageLink >> database [ 

	^ origin database
]

{ #category : #'api - accessing' }
LeImplicitPageLink >> editTime [ 
	"Answer the edit time of the receiver's origin"
	<return: #LeTime>

	^ origin editTime
]

{ #category : #accessing }
LeImplicitPageLink >> node [
	<return: #LeContentNode>
	^ node
]

{ #category : #accessing }
LeImplicitPageLink >> node: aNode [
	self
		assert: [ node isNil ] 
		description: [ 'Link node can be set just once' ].
	node := aNode
]

{ #category : #accessing }
LeImplicitPageLink >> origin [
	^ origin
]

{ #category : #accessing }
LeImplicitPageLink >> origin: aLeSnippet [

	self
		assert: [ origin isNil ] 
		description: [ 'Link origin can be set just once' ].
	origin := aLeSnippet.

]

{ #category : #accessing }
LeImplicitPageLink >> originReference [
	^ (LeLinkSnippetUidReference forSnippet: self origin)
			explicitLink: self
]

{ #category : #printing }
LeImplicitPageLink >> printOn: aStream [
	self title ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Unlinked Reference: ';
		nextPutAll: self title asString
]

{ #category : #accessing }
LeImplicitPageLink >> target [
	^ target
]

{ #category : #accessing }
LeImplicitPageLink >> target: aContent [

	aContent == target ifTrue: [ ^ self ].
	self
		assert: [ target isNil ] 
		description: [ 'Link target can be set just once' ].
	target := aContent.
]

{ #category : #accessing }
LeImplicitPageLink >> targetReference [
	^ (LeLinkPageTextualTitleReference forPage: self target)
			explicitLink: self
]

{ #category : #'api - accepting' }
LeImplicitPageLink >> targetUID [
	<return: #String>
	^ self title
]

{ #category : #accessing }
LeImplicitPageLink >> title [
	^ title
]

{ #category : #accessing }
LeImplicitPageLink >> title: anObject [
	title := anObject
]
