Class {
	#name : #LeDatabaseDailyNotesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #accessing }
LeDatabaseDailyNotesExamples >> databaseWithPharoClassPage [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self emptyDatabase.
	page := LePage new initializePharoClassName: #SomeClass.
	database addPage: page.
	self assert: database dailyNotesGroup isEmpty.
	^ database
]

{ #category : #accessing }
LeDatabaseDailyNotesExamples >> databaseWithUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| database page |
	database := self emptyDatabase.
	page := LePage new initializeUnnamedPage.
	database addPage: page.
	self assert: database dailyNotesGroup size = 1.
	self assert: database dailyNotesGroup anyOne size = 1.
	self assert: database dailyNotesGroup anyOne anyOne = page.
	^ database
]

{ #category : #accessing }
LeDatabaseDailyNotesExamples >> emptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := LeDatabase new.
	self assert: database dailyNotesGroup isEmpty.
	^ database
]
