"
Unnamed pages are used to hold ""yellow sticky notes"", where there is content, but no category to hold it.

This is a placeholder until the database has been updated to handle unnamed pages.  Since there is a fixed title, only one page can exist in a database.

"
Class {
	#name : #LeUnnamedPageType,
	#superclass : #LePageType,
	#instVars : [
		'defaultTitle'
	],
	#category : 'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeUnnamedPageType class >> page: aLePage [

	^ self new
		page: aLePage
]

{ #category : #'instance creation' }
LeUnnamedPageType class >> page: aLePage withDefaultTitle: aString [

	^ self new
		page: aLePage;
		defaultTitle: aString
]

{ #category : #comparing }
LeUnnamedPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class

]

{ #category : #accessing }
LeUnnamedPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ page uid
]

{ #category : #accessing }
LeUnnamedPageType >> defaultTitle [
	^ defaultTitle ifNil: [ 'Page' ]
]

{ #category : #accessing }
LeUnnamedPageType >> defaultTitle: aString [
	defaultTitle := aString
]

{ #category : #comparing }
LeUnnamedPageType >> hash [ 

	^ self class hash
]

{ #category : #'api - testing' }
LeUnnamedPageType >> isUnnamedPageType [
	^ true
]

{ #category : #printing }
LeUnnamedPageType >> printOn: aStream [
	aStream 
		<< 'Unnamed page: ';
		<< self shortDescription
]

{ #category : #accessing }
LeUnnamedPageType >> shortDescription [
	| string |

	defaultTitle ifNotNil: [ ^ defaultTitle ].
	page hasChildren ifFalse: [ ^ '' ].
	
	string := page children first contentAsString.
	^ string size < 50
		ifTrue: [ string ]
		ifFalse: [ (string copyFrom: 1 to: 47), '...' ]
]

{ #category : #accessing }
LeUnnamedPageType >> shouldAppearInIndexOrDailyNotes [
	^ true
]

{ #category : #accessing }
LeUnnamedPageType >> title [
	^ self defaultTitle
]

{ #category : #accessing }
LeUnnamedPageType >> title: aString [
	^ LeNamedPageType title: aString page: self page
]
