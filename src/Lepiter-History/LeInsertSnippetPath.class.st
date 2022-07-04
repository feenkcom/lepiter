Class {
	#name : #LeInsertSnippetPath,
	#superclass : #Object,
	#instVars : [
		'uidSegments',
		'insertPosition'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #actions }
LeInsertSnippetPath >> diveInSnippet: aSnippety [
	self uidSegments add: aSnippety
]

{ #category : #'gt - extensions' }
LeInsertSnippetPath >> gtViewUidSegmentsFor: aView [ 
	<gtView>
	
	^ aView list
		title: 'Uid Segments';
		items: [ self uidSegments ]
]

{ #category : #initialization }
LeInsertSnippetPath >> initialize [
	super initialize.
	
	uidSegments := OrderedCollection new.
]

{ #category : #action }
LeInsertSnippetPath >> insertChildSnippet: aChildSnippet intoParent: aContent [ 
	| targetParent |
	targetParent := self locateSnippetToInsertStartingFrom: aContent.
	self insertPosition 
		insertChildSnippet: aChildSnippet 
		intoParent: targetParent
]

{ #category : #actions }
LeInsertSnippetPath >> insertParent: aContent [ 
	self uidSegments addFirst: aContent uid 
]

{ #category : #accessing }
LeInsertSnippetPath >> insertPosition [

	^ insertPosition
]

{ #category : #accessing }
LeInsertSnippetPath >> insertPosition: anObject [

	insertPosition := anObject
]

{ #category : #utils }
LeInsertSnippetPath >> locateSnippetToInsertStartingFrom: aContent [
	| targetContent |
	
	targetContent := aContent.
	self uidSegments do: [ :anUid | 
		targetContent := targetContent children detect: [ :aChildShippet |
			aChildShippet uid = anUid ] ].
	
	^ targetContent 
]

{ #category : #printing }
LeInsertSnippetPath >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream << ' * / '.
		self uidSegments 
			do: [ :elem | aStream print: elem uid ]
			separatedBy: [ aStream nextPutAll: ' /' ].
		self uidSegments ifNotEmpty: [
			aStream << ' / ' ].
		aStream << self insertPosition description ]
]

{ #category : #accessing }
LeInsertSnippetPath >> uidSegments [

	^ uidSegments
]
