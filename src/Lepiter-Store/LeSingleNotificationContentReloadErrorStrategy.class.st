"
This strategy logs all erros that appear during a single database reload, and shows a notification if there were errors when the reload is done.
"
Class {
	#name : #LeSingleNotificationContentReloadErrorStrategy,
	#superclass : #LeDatabaseContentReloadErrorStrategy,
	#instVars : [
		'contentErrors',
		'currentDatabaseName'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #callbacks }
LeSingleNotificationContentReloadErrorStrategy >> actAfterDatabaseReloadFor: aDatabase [
	self contentErrors ifEmpty: [ ^ self ]. 
	
	self showNotificationWithText: self createErrorsNotificationText.
]

{ #category : #callbacks }
LeSingleNotificationContentReloadErrorStrategy >> actBeforeDatabaseReloadFor: aDatabase [
	contentErrors := OrderedCollection new.
	currentDatabaseName := aDatabase databaseName.
]

{ #category : #accessing }
LeSingleNotificationContentReloadErrorStrategy >> contentErrors [
	^ contentErrors
]

{ #category : #printing }
LeSingleNotificationContentReloadErrorStrategy >> createErrorsNotificationText [
	^ String streamContents: [ :aStream |
			self contentErrors size = 1 
				ifTrue: [ self errorTextForSingleErrorOn: aStream ]
				ifFalse: [ self errorTextForMultipleErrorsOn: aStream ].
			aStream cr.
			aStream nextPutAll: 'See "How to fix Lepiter loading errors".' ]
]

{ #category : #printing }
LeSingleNotificationContentReloadErrorStrategy >> errorTextForMultipleErrorsOn: aStream [ 
	aStream nextPutAll: ('{1} content errors during Lepiter reload of {2}: '
		format: {
			self contentErrors size.
			currentDatabaseName}).
	aStream cr.
	(self contentErrors takeFirst: 3) 
		do: [ :anError |
			aStream 
				tab;
				nextPutAll: '- ';
				nextPutAll: anError description ]
		separatedBy: [ aStream 
			nextPutAll: '; ';
			cr].
	aStream cr.
	self contentErrors size > 3 ifTrue: [
		aStream 
			tab;
			nextPutAll:  ' ... more ..';
			cr ].
]

{ #category : #printing }
LeSingleNotificationContentReloadErrorStrategy >> errorTextForSingleErrorOn: aStream [ 
	aStream 
		nextPutAll: 'Content error during Lepiter reload of ';
		nextPutAll: currentDatabaseName;
		nextPutAll: ': ';
		cr;
		tab;
		nextPutAll: '- ';
		nextPutAll: self contentErrors first description;
		cr
]

{ #category : #action }
LeSingleNotificationContentReloadErrorStrategy >> executeManaged: aBlock [
	^ aBlock
		on: Error 
		do: [ :anError | 
			anError freeze.
			self recordError: anError ]
]

{ #category : #adding }
LeSingleNotificationContentReloadErrorStrategy >> recordError: anError [ 
	self contentErrors add: anError
]

{ #category : #callbacks }
LeSingleNotificationContentReloadErrorStrategy >> showNotificationWithText: aMessage [ 
	^ GtObjectNotificationMessage new
		message: aMessage;
		tooltip: 'Inspect loading errors';
		object: (self contentErrors copy);
		registerNotifications
]
