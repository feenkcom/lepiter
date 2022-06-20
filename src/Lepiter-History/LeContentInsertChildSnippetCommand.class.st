Class {
	#name : #LeContentInsertChildSnippetCommand,
	#superclass : #LeContentCommand,
	#instVars : [
		'insertPosition',
		'snippetTypeName',
		'snippetState'
	],
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LeContentInsertChildSnippetCommand class >> commandDescription [ 
	^ 'Insert Child Snippet'
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAfterSiblingIndexFor: aSnippet [
	^ LeInsertSnippetAtIndexPosition new
		index: (self targetContent children indexOf: aSnippet) + 1
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAfterSiblingUidFor: aSnippet [
	^ LeInsertSnippetAfterChildUidPosition new
		snippetUid: aSnippet uid
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAsFirstChildPosition [
	^ LeInsertSnippetFirstChildPosition new
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> createInsertAsLastChildPosition [
	^ LeInsertSnippetLastChildPosition new
]

{ #category : #printing }
LeContentInsertChildSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'snippetType: ';
		print: self snippetTypeName
]

{ #category : #execution }
LeContentInsertChildSnippetCommand >> execute [ 
	self assert: [ self insertPosition notNil ].
	self assert: [ self snippetTypeName notNil ].
	
	^ self insertPosition 
		insertChildSnippet: self instantiateEmptySnippet
		intoParent: self targetContent
]

{ #category : #initialization }
LeContentInsertChildSnippetCommand >> initialize [
	super initialize.
	self insertLast.
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertAfter: aSiblingSnippet [
	self assert: [ self targetContent children includes: aSiblingSnippet ].
	
	aSiblingSnippet uid 
		ifNil: [
			self insertPosition: (self createInsertAfterSiblingIndexFor: aSiblingSnippet) ]
		ifNotNil: [
			self insertPosition: (self createInsertAfterSiblingUidFor: aSiblingSnippet) ]
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertFirst [
	self insertPosition: self createInsertAsFirstChildPosition
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> insertLast [ 
	self insertPosition: self createInsertAsLastChildPosition
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPosition [

	^ insertPosition
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> insertPosition: anObject [

	insertPosition := anObject
]

{ #category : #utils }
LeContentInsertChildSnippetCommand >> instantiateEmptySnippet [
	^ (self class environment at: snippetTypeName) empty
]

{ #category : #accessing }
LeContentInsertChildSnippetCommand >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #configuration }
LeContentInsertChildSnippetCommand >> snippetTypeName: aTypeName [

	snippetTypeName := aTypeName
]
