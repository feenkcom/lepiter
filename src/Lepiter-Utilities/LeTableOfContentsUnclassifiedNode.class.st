Class {
	#name : #LeTableOfContentsUnclassifiedNode,
	#superclass : #LeAbstractTableOfContentsNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Utilities-ToC'
}

{ #category : #accessing }
LeTableOfContentsUnclassifiedNode >> children [
	^ #()
]

{ #category : #accessing }
LeTableOfContentsUnclassifiedNode >> isForPage [
	^ true
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
