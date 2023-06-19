"
I announce {{gtClass:Announcement|label=announcements}} locally in a given {{gtClass:LePage}} or {{gtClass:LeSnippet}} announcer and its {{gtClass:LeDatabase}}.
See the {{gtMethod:LeDatabasePropagater>>#propagate:in:|label=#selector|expanded}}.
I am used by {{gtClass:LeNotifier}}.
## Example
In a model: {{gtExample:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}}
I announce only in the third block and in the database: {{gtExample:LeNotifierExamples>>#databaseNotification_BlockThree}}.
## Usage
I can be used for announcements that a {{gtClass:LeDatabase}} needs to listen to or announcements that should be also announce in the {{gtClass:LeDatabase}}. For example, {{gtMethod:LePage>>#updateTitle:}} announces the {{gtClass:LePageTitleChanged}} using the {{gtClass:LePage}}'s announcer and the {{gtClass:LeDatabase}}'s announcer. By doing so, the database does not need to listen to the page announcements. It is a code optimization.

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
	
	^ LeLocalPropagater default 
		propagate: anAnnouncement in: aLeContent database
]
