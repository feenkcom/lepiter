Class {
	#name : #LeDailyNoteTitleBuilder,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Builders'
}

{ #category : #factory }
LeDailyNoteTitleBuilder class >> today [
	^ self new today
]

{ #category : #'private - building' }
LeDailyNoteTitleBuilder >> daySuffix: aDay [
	| aCharacter |
	(aDay > 10 and: [ aDay < 15 ]) ifTrue: [ ^ 'th' ].
	aCharacter := aDay asString last.
	aCharacter = $1 ifTrue: [ ^ 'st' ].
	aCharacter = $2 ifTrue: [ ^ 'nd' ].
	aCharacter = $3 ifTrue: [ ^ 'rd' ].
	^ 'th'
]

{ #category : #accessing }
LeDailyNoteTitleBuilder >> title: aDateAndTime [
	| aDate aYear aMonth aDay aDaySuffix |
	aDate := aDateAndTime asDate.
	aYear := aDate year.
	aMonth := aDate monthName.
	aDay := aDate dayOfMonth.
	aDaySuffix := self daySuffix: aDay.
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: aMonth;
			space;
			print: aDay;
			nextPutAll: aDaySuffix;
			nextPutAll: ', ';
			print: aYear ]
]

{ #category : #accessing }
LeDailyNoteTitleBuilder >> today [
	^ self title: Date today
]
