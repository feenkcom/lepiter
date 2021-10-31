Class {
	#name : #LeDailyNoteTitleParser,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Builders'
}

{ #category : #accessing }
LeDailyNoteTitleParser class >> parse [
]

{ #category : #'api - parsing' }
LeDailyNoteTitleParser class >> parse: aTitle [
	<return: #Date or: nil>
	^ self default parse: aTitle
]

{ #category : #rendering }
LeDailyNoteTitleParser class >> titleFor: aDate [
	"Answer the title string used for the supplied date"

	^ String streamContents: [ :stream |
		stream 
			<< aDate month name;
			<< ' ';
			<< aDate dayWithSuffix;
			<< ', ';
			print: aDate year ]
]

{ #category : #'api - parsing' }
LeDailyNoteTitleParser >> parse: aTitle [
	<return: #Date or: nil>
	| aCollection aMonth aDay anYear |

	(aTitle isNil or: [ aTitle isEmpty ]) ifTrue: [ ^ nil ].
	aCollection := String space split: aTitle.
	aCollection size = 3 ifFalse: [ ^ nil ].
	aMonth := Date monthNames 
		indexOf: aCollection first
		ifAbsent: [ ^ nil ].
	aDay := aCollection second select: #isDigit.
	aDay := Number readFrom: aDay ifFail: [ ^ nil ].
	(aDay isInteger and: [ aDay between: 1 and: 31 ])
		ifFalse: [ ^ nil ].
	anYear := Number readFrom: aCollection third ifFail: [ ^ nil ].
	(anYear isInteger and: [ anYear > 0 ]) ifFalse: [ ^ nil ].
	^ Date 
		year: anYear 
		month: aMonth 
		day: aDay
]
