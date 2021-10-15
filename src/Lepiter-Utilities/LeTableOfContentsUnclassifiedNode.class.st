Class {
	#name : #LeTableOfContentsUnclassifiedNode,
	#superclass : #Object,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-Utilities-ToC'
}

{ #category : #accessing }
LeTableOfContentsUnclassifiedNode >> children [
	^ #()
]

{ #category : #'gt-extension' }
LeTableOfContentsUnclassifiedNode >> gtLiveFor: aView [
	<gtView>
	self page ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #testing }
LeTableOfContentsUnclassifiedNode >> isToCNode [
	^ false
]

{ #category : #accessing }
LeTableOfContentsUnclassifiedNode >> page [
	^ page
]

{ #category : #accessing }
LeTableOfContentsUnclassifiedNode >> page: anObject [
	page := anObject
]

{ #category : #printing }
LeTableOfContentsUnclassifiedNode >> printOn: aStream [
	| pageTitle |

	pageTitle := self page 
		ifNil: [ '<unknown>' ]
		ifNotNil: [ :aPage | aPage title asString ].
	aStream
		nextPutAll: 'Unclassified: ';
		nextPutAll: pageTitle.
]

{ #category : #enumerating }
LeTableOfContentsUnclassifiedNode >> selectedPageDo: aBlock [
	aBlock cull: self page
]
