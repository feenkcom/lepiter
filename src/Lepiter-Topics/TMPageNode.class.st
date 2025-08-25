Class {
	#name : #TMPageNode,
	#superclass : #TMAbstractTreeNode,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Topics-Model'
}

{ #category : #'instance creation' }
TMPageNode class >> for: aPage within: aPageGroup [
^ self new
	pageGroup: aPageGroup;
	page: aPage;
	yourself 
]

{ #category : #accessing }
TMPageNode >> name [
	^ self page title
]

{ #category : #accessing }
TMPageNode >> page [
	^ page
]

{ #category : #accessing }
TMPageNode >> page: anObject [
	page := anObject
]

{ #category : #'as yet unclassified' }
TMPageNode >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self name;
		nextPut: $)
]
