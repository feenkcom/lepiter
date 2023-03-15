Class {
	#name : #LeDatabaseNavigationModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'page',
		'database',
		'databaseViewModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #announcer }
LeDatabaseNavigationModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
LeDatabaseNavigationModel >> database [
	^ database
]

{ #category : #accessing }
LeDatabaseNavigationModel >> database: anObject [
	database := anObject.
	self database weak
		when: LeDatabasePageAdded
			send: #onDatabaseChanged:
			to: self;
		when: LeDatabasePageRemoved
			send: #onDatabaseChanged:
			to: self;
		when: LePageUnloadAnnouncement 
			send: #onDatabaseChanged:
			to: self;
		when: LeDatabaseTableOfContentsUUIDChanged
			send: #onDatabaseChanged:
			to: self.
	self onDatabaseChanged: anObject
]

{ #category : #accessing }
LeDatabaseNavigationModel >> databaseViewModel [
	^ databaseViewModel
]

{ #category : #accessing }
LeDatabaseNavigationModel >> databaseViewModel: anObject [
	databaseViewModel := anObject.
	self onDatabaseViewModelChanged
]

{ #category : #testing }
LeDatabaseNavigationModel >> hasDatabase [
	^ database notNil
]

{ #category : #testing }
LeDatabaseNavigationModel >> hasPage [
	^ page notNil
]

{ #category : #accessing }
LeDatabaseNavigationModel >> initialize [
	super initialize.

	self announcer
		when: LeUIPageSelectionRequest
		send: #onSelection:
		to: self
]

{ #category : #accessing }
LeDatabaseNavigationModel >> onDatabaseChanged: anAnnouncement [
	self onNavigationModelChanged
]

{ #category : #accessing }
LeDatabaseNavigationModel >> onDatabaseViewModelChanged [
	self onNavigationModelChanged
]

{ #category : #accessing }
LeDatabaseNavigationModel >> onNavigationModelChanged [
	self announce: LeUIDatabaseNavigationModelChanged new
]

{ #category : #accessing }
LeDatabaseNavigationModel >> onSelection: anAnnouncement [
	self
		assert: [ anAnnouncement page isKindOf: LePageViewModel ]
		description: [ 'Must be a UI model' ].

	page = anAnnouncement page ifTrue: [ ^ self ].

	page := anAnnouncement page.
	
	self announce: (LeUIPageSelected new page: page)
]

{ #category : #accessing }
LeDatabaseNavigationModel >> page [
	^ page
]

{ #category : #accessing }
LeDatabaseNavigationModel >> page: anObject [
	page := anObject
]
