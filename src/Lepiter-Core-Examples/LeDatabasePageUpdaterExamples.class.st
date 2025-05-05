Class {
	#name : #LeDatabasePageUpdaterExamples,
	#superclass : #LePageBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - model' }
LeDatabasePageUpdaterExamples >> databaseWithOneUnnamedPage [
	<gtExample>
	<return: #LeDatabase>
	| aPage aDatabase |
	aDatabase := self database.
	aPage := LePage unnamedPage.
	aDatabase addPage: aPage.

	self assert: aDatabase pages size equals: 1.
	self assert: aDatabase pagesByName size equals: 0.
	self assert: aDatabase dailyNotes size equals: 0.

	^ aDatabase
]

{ #category : #'examples - model' }
LeDatabasePageUpdaterExamples >> databaseWithTwoPages [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self database.
	aDatabase pageBuilder
		title: 'one';
		add.
	aDatabase pageBuilder
		title: 'two';
		add.

	self assert: aDatabase pages size equals: 2.
	self assert: aDatabase pagesByName size equals: 2.
	self assert: aDatabase dailyNotes size equals: 0.

	^ aDatabase
]

{ #category : #'examples - page title' }
LeDatabasePageUpdaterExamples >> updatePageOneToThree [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aCollection := OrderedCollection new.
	aDatabase := self databaseWithTwoPages.
	aPage := aDatabase pageBuilder
			title: 'one';
			ensure.
	aPage updater
		title: 'three';
		callback: [ :thePage | aCollection add: thePage ];
		update.
	self assert: aPage title equals: 'three'.
	self assert: aCollection size equals: 1.
	self assert: aCollection first equals: aPage.
	^ aDatabase
]

{ #category : #'examples - page title' }
LeDatabasePageUpdaterExamples >> updatePageOneToTwo [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aCollection := OrderedCollection new.
	aDatabase := self databaseWithTwoPages.
	aPage := aDatabase pageBuilder
			title: 'one';
			ensure.
	aPage updater
		title: 'two';
		callback: [ :thePage | aCollection add: thePage ];
		update.
	self assert: aPage title equals: 'one'.
	self assert: aCollection size equals: 0.
	^ aDatabase
]

{ #category : #'examples - page title' }
LeDatabasePageUpdaterExamples >> updateUnnamedPageToNamedPage [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase aPage aCollection |
	aCollection := OrderedCollection new.
	aDatabase := self databaseWithOneUnnamedPage.
	aPage := aDatabase pages first.
	aPage updater
		title: 'named';
		callback: [ :thePage | aCollection add: thePage ];
		update.
	self assert: aPage title equals: 'named'.
	self assert: aPage type isNamedPageType.
	self assert: aCollection size equals: 1.

	^ aDatabase
]
