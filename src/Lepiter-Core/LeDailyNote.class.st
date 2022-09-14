Class {
	#name : #LeDailyNote,
	#superclass : #LePages,
	#instVars : [
		'date'
	],
	#category : 'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeDailyNote class >> forDate: aDate [
	^ self new
		date: aDate
]

{ #category : #accessing }
LeDailyNote class >> leJsonV4Name [
	"Daily notes are deprecated and shouldn't be stored"

	^ nil
]

{ #category : #accessing }
LeDailyNote >> date [
	^ date
]

{ #category : #accessing }
LeDailyNote >> date: aDate [
	date := aDate
]

{ #category : #accessing }
LeDailyNote >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self date asString;
		nextPutAll: ')'
]
