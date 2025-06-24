Class {
	#name : #LeDailyNoteTitleBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> aprilThirteen [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 4
			day: 13.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'April 13th, 2020'.
	^ aTitle
]

{ #category : #'examples - basic' }
LeDailyNoteTitleBuilderExamples >> basicBuilder [
	<gtExample>
	<return: #LeDailyNoteTitleBuilder>
	| aBuilder |
	aBuilder := LeDailyNoteTitleBuilder new.
	^ aBuilder
]

{ #category : #'examples - basic' }
LeDailyNoteTitleBuilderExamples >> basicParser [
	<gtExample>
	<return: #LeDailyNoteTitleParser>
	| aParser |
	aParser := LeDailyNoteTitleParser new.
	^ aParser
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> decemberTwentySecond [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 12
			day: 22.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'December 22nd, 2020'.
	^ aTitle
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> januaryTwentyOne [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 1
			day: 21.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'January 21st, 2020'.
	^ aTitle
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> julyEleven [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 7
			day: 11.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'July 11th, 2020'.
	^ aTitle
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> mayTwelve [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 5
			day: 12.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'May 12th, 2020'.
	^ aTitle
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> septemberThird [
	<gtExample>
	<return: #ByteString>
	| aBuilder aDate aTitle |
	aBuilder := self basicBuilder.
	aDate := Date
			year: 2020
			month: 9
			day: 3.
	aTitle := aBuilder title: aDate.
	self assert: aTitle equals: 'September 3rd, 2020'.
	^ aTitle
]

{ #category : #'examples - titles' }
LeDailyNoteTitleBuilderExamples >> today [
	<gtExample>
	<return: #ByteString>
	| aBuilder aTime aTitle aDate |
	aBuilder := self basicBuilder.
	aTime := LeTime now.
	aTitle := aBuilder title: aTime time.
	aDate := self basicParser parse: aTitle.
	self assert: aTime asDate equals: aDate.
	^ aTitle
]
