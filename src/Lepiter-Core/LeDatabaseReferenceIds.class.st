"
I hold last unique reference that was used as a snippet reference.
I am used by {{gtClass:LeDatabaseReferenceIdBuilder}}. 
"
Class {
	#name : #LeDatabaseReferenceIds,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'lastIndex',
		'mutex'
	],
	#category : #'Lepiter-Core-Index'
}

{ #category : #'instance creation' }
LeDatabaseReferenceIds class >> picture [
	^ self new pattern: 'picture{1}'
]

{ #category : #initialization }
LeDatabaseReferenceIds >> defaltPattern [
	^ 'picture{1}'
]

{ #category : #initialization }
LeDatabaseReferenceIds >> initialize [
	super initialize.
	mutex := Mutex new.
	pattern := self defaltPattern.
	lastIndex := 0
]

{ #category : #accessing }
LeDatabaseReferenceIds >> lastIndex [
	^ lastIndex
]

{ #category : #'api - accessing' }
LeDatabaseReferenceIds >> nextReference [
	<return: #String>
	| aNewReference |
	mutex critical: [ lastIndex := aNewReference := lastIndex + 1 ].
	^ self pattern format: {aNewReference}
]

{ #category : #accessing }
LeDatabaseReferenceIds >> pattern [
	^ pattern
]

{ #category : #accessing }
LeDatabaseReferenceIds >> pattern: aString [
	"Pattern must be a string with {1} substring."

	self assert: (aString includesSubstring: '{1}').

	pattern := aString
]
