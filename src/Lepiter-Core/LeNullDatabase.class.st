Class {
	#name : #LeNullDatabase,
	#superclass : #LeNullModel,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#category : #'Lepiter-Core-Model'
}

{ #category : #announcer }
LeNullDatabase >> announcer [
	<return: #Announcer>
	^ GtNullAnnouncer default
]

{ #category : #'api - accessing' }
LeNullDatabase >> anyOne [
	^ LePage null
]

{ #category : #accessing }
LeNullDatabase >> cachedLinksForContent: aLeContent [
	^ LeExplicitLinks new
]

{ #category : #'api - accessing' }
LeNullDatabase >> children [
	^ #()
]

{ #category : #'api - accessing' }
LeNullDatabase >> dailyNotes [
	^ #()
]

{ #category : #'api - accessing' }
LeNullDatabase >> dailyNotesGroup [
	^ #()
]

{ #category : #'api - accessing' }
LeNullDatabase >> databaseName [
	^ ''
]

{ #category : #'api - accessing' }
LeNullDatabase >> databasesDo: aBlock [
	"do nothing"
]

{ #category : #enumerating }
LeNullDatabase >> do: aBlock [ 
	"No contents, so nothing to do"
]

{ #category : #accessing }
LeNullDatabase >> explicitLinks [
	^ LeExplicitLinks new
]

{ #category : #'api - testing' }
LeNullDatabase >> hasChildren [
	^ false
]

{ #category : #'api - testing' }
LeNullDatabase >> hasPageNamed: aString [

	^ false.
]

{ #category : #'api - testing' }
LeNullDatabase >> isDatabase [
	^ false
]

{ #category : #'api - testing' }
LeNullDatabase >> isLogicalDatabase [
	^ false
]

{ #category : #'as yet unclassified' }
LeNullDatabase >> linksWithOriginReferenceMatching: aLeWardleyMapNodeReference [ 
	^ LeExplicitLinks new
]

{ #category : #'api - accessing' }
LeNullDatabase >> logicalDatabase [ 

	^ self
]

{ #category : #accessing }
LeNullDatabase >> monitor [ 

	^ nil
]

{ #category : #'api - accessing' }
LeNullDatabase >> pageCount [
	^ 0
]

{ #category : #accessing }
LeNullDatabase >> pageNamed: aString ifAbsent: absentBlock [
	^ absentBlock value
]

{ #category : #'api - accessing' }
LeNullDatabase >> pageNamed: aString inDatabase: targetDatabaseUID ifDbAbsent: dbAbsentBlock [
	"Answer the page with the given title in the specified database.
	If the database is absent, answer dbAbsentBlock's value.  If the page is absent, raise an exception."

	^ dbAbsentBlock value
]

{ #category : #'api - accessing' }
LeNullDatabase >> pages [
	^ #()
]

{ #category : #'api - accessing' }
LeNullDatabase >> pagesByDate [

	^ #()
]

{ #category : #'api - accessing' }
LeNullDatabase >> pagesByDateToShow [
	^ #()
]

{ #category : #enumerating }
LeNullDatabase >> pagesDo: aBlock [ 

]

{ #category : #'adding / removing' }
LeNullDatabase >> registerSnippet: aSnippet [
]

{ #category : #'adding / removing' }
LeNullDatabase >> removeExplicitOutgoingLinksForContent: aLeContent [
]

{ #category : #'adding / removing' }
LeNullDatabase >> removeIncomingExplicitLinksForContent: aLeContent [
]

{ #category : #'api - adding / removing' }
LeNullDatabase >> removePage: aPage [
	"do nothing"
]

{ #category : #'api - accessing' }
LeNullDatabase >> sortedPages [
	^ #()
]

{ #category : #accessing }
LeNullDatabase >> stopMonitoring [

]

{ #category : #accessing }
LeNullDatabase >> tableOfContents [ 

	^ nil
]

{ #category : #accessing }
LeNullDatabase >> tableOfContentsNodes [
	^ #()
]

{ #category : #'adding / removing' }
LeNullDatabase >> unregisterSnippet: aSnippet [
]

{ #category : #updating }
LeNullDatabase >> updateUnresolvedReferencesForPage: aPage [
]

{ #category : #'api - accessing' }
LeNullDatabase >> userEmail [
	"We use here nil explicitly insteaf of a null object.
	This is used when adding snippets to a database. 
	In those cases we live the email to be nil."
	
	^ nil
]

{ #category : #accessing }
LeNullDatabase >> uuid [

	^ UUID nilUUID
]

{ #category : #accessing }
LeNullDatabase >> uuidString [
	^ ''
]
