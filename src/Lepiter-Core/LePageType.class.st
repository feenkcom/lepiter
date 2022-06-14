"
Lepiter supports various types of pages, see the subclasses for a description of each type.

Page types are considered equal if they are of the same type and have equal keys.  This means that two pages in different databases may be not equal, but their type may be.

"
Class {
	#name : #LePageType,
	#superclass : #LeModel,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #factory }
LePageType class >> default [
	^ LeNamedPageType new
]

{ #category : #accessing }
LePageType class >> pageTypeClass [
	"Answer the class used to store the pages in ${class:name=LeDatabase}$.
	Normally this is the receiver, however it is possible that multiple page types will be stored together, e.g. ${class:name=LeDailyNotePageType}$ are treated as ${class:name=LeNamedPageType}$."

	^ self
]

{ #category : #accessing }
LePageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self subclassResponsibility
]

{ #category : #'api - testing' }
LePageType >> isDailyNote [
	^ false
]

{ #category : #'api - testing' }
LePageType >> isNamedPageType [
	^ false
]

{ #category : #'api - testing' }
LePageType >> isPharoClassPageType [
	^ false
]

{ #category : #'api - testing' }
LePageType >> isTodayDailyNote [
	^ false
]

{ #category : #'api - testing' }
LePageType >> isUnnamedPageType [
	^ false
]

{ #category : #accessing }
LePageType >> page [
	^ page
]

{ #category : #accessing }
LePageType >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LePageType >> pageTypeClass [
	"Answer the class used to store the pages in ${class:name=LeDatabase}$."

	^ self class pageTypeClass
]

{ #category : #accessing }
LePageType >> remoteLinkId [
	"Answer the string to be used to identify the page in a remote link annotation ({{gtPage:...}})"
	<return: #String>

	^ 'id=', page uidString
]

{ #category : #'api - testing' }
LePageType >> saveEmptyPages [
	"Flag whether to save empty pages or not.
	By default, empty pages are not saved."

	^ false
]

{ #category : #accessing }
LePageType >> shouldAppearInIndexOrDailyNotes [
	^ false
]

{ #category : #accessing }
LePageType >> title [
	"Answer the receiver's title"

	^ self subclassResponsibility
]

{ #category : #accessing }
LePageType >> title: aString [
	"Subclasses that can have their title changed should override this method"

	self error: 'Unable to update the title'
]
