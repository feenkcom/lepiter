Class {
	#name : #LeHomeAddDatabaseItem,
	#superclass : #Object,
	#traits : 'TGtSubscription',
	#classTraits : 'TGtSubscription classTrait',
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Tool-Support'
}

{ #category : #converting }
LeHomeAddDatabaseItem class >> asHomeDatabaseElementInstance [
	^ LeHomeAddDatabaseElement new
]

{ #category : #'public - adding' }
LeHomeAddDatabaseItem >> addDB: aDatabase [
	self database addDB: aDatabase.
	self database saveProperties.
]

{ #category : #announcer }
LeHomeAddDatabaseItem >> announcer [
	<return: #Announcer>
	^ self database announcer
]

{ #category : #converting }
LeHomeAddDatabaseItem >> asContentUIModel [
	^ LeHomeAddDatabaseItemViewModel new content: self
]

{ #category : #'api - accessing' }
LeHomeAddDatabaseItem >> database [
	<return: #LeLogicalDatabase>
	^ database
]

{ #category : #'api - accessing' }
LeHomeAddDatabaseItem >> database: aLogicalDatabase [

	self 
		assert: [ aLogicalDatabase isLogicalDatabase ] 
		description: [ 'I can be used only for logical database instances' ].

	database := aLogicalDatabase
]

{ #category : #'api - accessing' }
LeHomeAddDatabaseItem >> databasesToDisplayDo: aBlock [
	self database databasesToDisplayDo: aBlock
]

{ #category : #'api - testing' }
LeHomeAddDatabaseItem >> isLogicalDatabase [
	^ self database isLogicalDatabase
]

{ #category : #accessing }
LeHomeAddDatabaseItem >> localStoreRootDirectory [
	^ self database localStoreRootDirectory
]
