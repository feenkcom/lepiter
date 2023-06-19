"
Daily Notes are identified by the page's date.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	date:		<Date>


### Implementation Points

"
Class {
	#name : #LeDailyNotePageType,
	#superclass : #LePageType,
	#instVars : [
		'date'
	],
	#category : 'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeDailyNotePageType class >> date: aDate page: aLePage [

	^ self new
		date: aDate;
		page: aLePage
]

{ #category : #accessing }
LeDailyNotePageType class >> pageTypeClass [
	"Answer the class used to store the pages in ${class:name=LeDatabase}$.
	Daily notes are stored with named pages (using the date as a title)."

	^ LeNamedPageType
]

{ #category : #comparing }
LeDailyNotePageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ date = anObject date
]

{ #category : #accessing }
LeDailyNotePageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ self title
]

{ #category : #'api - accessing' }
LeDailyNotePageType >> date [
	<return: #Date>
	^ date
]

{ #category : #'api - accessing' }
LeDailyNotePageType >> date: aDate [
	date := aDate
]

{ #category : #comparing }
LeDailyNotePageType >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ date hash
]

{ #category : #'api - testing' }
LeDailyNotePageType >> isDailyNote [
	^ true
]

{ #category : #'api - testing' }
LeDailyNotePageType >> isTodayDailyNote [
	^ self date = Date today
]

{ #category : #printing }
LeDailyNotePageType >> printOn: aStream [
	aStream nextPutAll: 'Daily Note'.
	self date ifNil: [ ^ self ].
	aStream
		nextPutAll: ': ';
		print: self date
]

{ #category : #'api - testing' }
LeDailyNotePageType >> saveEmptyPages [
	"Flag whether to save empty pages or not.
	Empty daily note pages are saved."

	^ true
]

{ #category : #accessing }
LeDailyNotePageType >> title [
	"Answer the date.  Needs I18N."

	^ LeDailyNoteTitleParser titleFor: date
]

{ #category : #accessing }
LeDailyNotePageType >> title: aString [
	"Set the receiver's title.
	For a daily note this means either setting the date of the page, or converting to a named page.
	Answer the resulting page type (either self or a named page)"
	| aDate |

	aDate := LeDailyNoteTitleParser parse: aString.
	aDate ifNotNil: 
		[ date := aDate.
		^ self ]
	ifNil: 
		[ ^ LeNamedPageType title: aString page: page ].
]
