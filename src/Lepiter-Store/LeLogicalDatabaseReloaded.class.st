Class {
	#name : #LeLogicalDatabaseReloaded,
	#superclass : #Announcement,
	#instVars : [
		'database'
	],
	#category : 'Lepiter-Store-Reload - Announcements'
}

{ #category : #accessing }
LeLogicalDatabaseReloaded >> database [

	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloaded >> database: aLogicalDatabase [

	database := aLogicalDatabase
]
