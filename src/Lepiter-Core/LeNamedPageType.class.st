"
LeNamedPageType is what might be considered a ""normal"" page, i.e. one with a title set by the user.

"
Class {
	#name : #LeNamedPageType,
	#superclass : #LePageType,
	#instVars : [
		'title'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #accessing }
LeNamedPageType class >> title: aString page: aLePage [
	| newType |
	newType := self new 
		page: aLePage.
	^ newType title: aString
]

{ #category : #comparing }
LeNamedPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ title = anObject title
]

{ #category : #accessing }
LeNamedPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self title
]

{ #category : #comparing }
LeNamedPageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ title hash
]

{ #category : #'api - testing' }
LeNamedPageType >> isNamedPageType [
	^ true
]

{ #category : #printing }
LeNamedPageType >> printOn: aStream [

	aStream 
		nextPutAll: 'Named Page: ';
		print: title
]

{ #category : #accessing }
LeNamedPageType >> remoteLinkId [
	"Answer the string to be used to identify the page in a remote link annotation ({{gtPage:...}})"
	<return: #String>

	^ title
]

{ #category : #'api - testing' }
LeNamedPageType >> saveEmptyPages [
	"Flag whether to save empty pages or not.
	Empty named pages are saved."

	^ true
]

{ #category : #accessing }
LeNamedPageType >> shouldAppearInIndexOrDailyNotes [
	^ true
]

{ #category : #accessing }
LeNamedPageType >> title [

	^ title
]

{ #category : #accessing }
LeNamedPageType >> title: aString [
	"Set the receiver's title"
	aString isEmptyOrNil ifTrue: [ ^ LeUnnamedPageType page: self page ].
	title := aString.
]
