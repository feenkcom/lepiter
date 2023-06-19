Class {
	#name : #LeDatabaseIndex,
	#superclass : #GtIndex,
	#instVars : [
		'database',
		'titleCache'
	],
	#category : #'Lepiter-Core-Index'
}

{ #category : #events }
LeDatabaseIndex >> addTitle: name [
	self
		wordsIn: name
		do: [ :word | (titleCache add: word asLowercase weight: 1) addName: name ]
]

{ #category : #accessing }
LeDatabaseIndex >> asyncTitlesForWord: aString [
	| trimmedString |
	self isActive ifFalse: [ self initializeCache ].
	trimmedString := aString trim.
	^ (self asyncOrderedSearchForWords: trimmedString in: titleCache)
		withoutDuplicates
]

{ #category : #events }
LeDatabaseIndex >> basicSubscribe [
	database weak
		when: LePageTitleChanged
			send: #pageRenamed:
			to: self;
		when: LeDatabasePageAdded
			send: #pageAdded:
			to: self;
		when: LeDatabasePageRemoved
			send: #pageRemoved:
			to: self
]

{ #category : #events }
LeDatabaseIndex >> basicUnsubscribe [
	database unsubscribe: self
]

{ #category : #accessing }
LeDatabaseIndex >> computeIndex [
	database pagesDo: [ :each | self addTitle: each title ]
]

{ #category : #accessing }
LeDatabaseIndex >> database [
	^ database
]

{ #category : #accessing }
LeDatabaseIndex >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LeDatabaseIndex >> initialize [
	super initialize.
	titleCache := GtNamesPrefixTree new
]

{ #category : #events }
LeDatabaseIndex >> pageAdded: anAnnouncement [
	self addTitle: anAnnouncement page title
]

{ #category : #events }
LeDatabaseIndex >> pageRemoved: anAnnouncement [
	self removeTitle: anAnnouncement page title
]

{ #category : #events }
LeDatabaseIndex >> pageRenamed: anAnnouncement [
	self removeTitle: anAnnouncement oldTitle.
	self addTitle: anAnnouncement newTitle
]

{ #category : #events }
LeDatabaseIndex >> removeTitle: name [
	self
		wordsIn: name
		do: [ :word | 
			(titleCache remove: word asLowercase weight: 1)
				ifNotNil: [ :node | node removeName: name ] ]
]
