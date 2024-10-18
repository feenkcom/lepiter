"
LeClassPageType is page containing information about a Pharo class, i.e. the class comment.

Pages of this type should only have a single text snippet, which will be saved back to the class.

This page type should only be used in a LePharoClassDatabase.

"
Class {
	#name : #LePharoClassCommentPageType,
	#superclass : #LePageType,
	#instVars : [
		'pharoClassName'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #jsonV3 }
LePharoClassCommentPageType class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#pharoClassName -> #pharoClassName);
		yourself

]

{ #category : #'lepiter-store' }
LePharoClassCommentPageType class >> leJsonV4Name [

	^ 'pharoClassCommentPage'
]

{ #category : #'instance creation' }
LePharoClassCommentPageType class >> pharoClassName: aSymbol page: aLePage [

	^ self new 
		pharoClassName: aSymbol;
		page: aLePage 
]

{ #category : #comparing }
LePharoClassCommentPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ pharoClassName = anObject pharoClassName
]

{ #category : #accessing }
LePharoClassCommentPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ pharoClassName
]

{ #category : #comparing }
LePharoClassCommentPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ pharoClassName hash
]

{ #category : #accessing }
LePharoClassCommentPageType >> pharoClassName [
	^ pharoClassName
]

{ #category : #accessing }
LePharoClassCommentPageType >> pharoClassName: anObject [
	pharoClassName := anObject
]

{ #category : #printing }
LePharoClassCommentPageType >> printOn: aStream [

	aStream
		<< 'Pharo Class Comment Page: ';
		<< (pharoClassName ifNil: [ '<none>' ])
]

{ #category : #accessing }
LePharoClassCommentPageType >> title [

	^ pharoClassName asString, ' Comment'
]
