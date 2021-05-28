"
I announce ${class:Announcement|label=announcements}$ locally in a given ${class:LePage}$ or ${class:LeSnippet}$ announcer and its ${class:LeDatabase}$.
See the ${method:LeDatabasePropagater>>#propagate:in:|label=#selector|expanded}$.
I am used by ${class:LeNotifier}$.
!! Example
In a model: ${example:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}$
I announce only in the third block and in the database: ${example:LeNotifierExamples>>#databaseNotification_BlockThree}$.
!! Usage
I can be used for announcements that a ${class:LeDatabase}$ needs to listen to or announcements that should be also announce in the ${class:LeDatabase}$. For example, ${method:LePage>>#updateTitle:}$ announces the ${class:LePageTitleChanged}$ using the ${class:LePage}$'s announcer and the ${class:LeDatabase}$'s announcer. By doing so, the database does not need to listen to the page announcements. It is a code optimization.
"
Class {
	#name : #LeDatabasePropagater,
	#superclass : #LeAnnouncementPropagater,
	#category : #'Lepiter-Core-Notifier'
}

{ #category : #'api - accessing' }
LeDatabasePropagater >> order [
	"Return a number representing the order of ${class:LeAnnouncementPropagater} execution.
	Lower number is executed first."
	^ 3
]

{ #category : #'api - promoting' }
LeDatabasePropagater >> propagate: anAnnouncement in: aLeContent [
	<return: #LeAnnouncement>

	aLeContent database
		ifNil: [ ^ anAnnouncement ].
	
	^ LeLocalPropagater default propagate: anAnnouncement in: aLeContent database.
]
