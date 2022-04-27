"
I announce {{gtClass:Announcement|label=announcements}} locally in a given {{gtClass:LePage}} or {{gtClass:LeSnippet}} announcer.
See the {{gtMethod:LeLocalPropagater>>#propagate:in:|label=#selector|expanded}}.
I am used by {{gtClass:LeNotifier}}.
## Example
In a model: {{gtExample:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}}
I announce only in the third block: {{gtExample:LeNotifierExamples>>#localNotification_BlockThree}}.
## Usage
I am a common (basic) announcement strategy and I complement the {{gtClass:LeAnnouncementPropagater|label=other strategies|show=#gtSubclassesFor:|height=130|expanded}}:

"
Class {
	#name : #LeLocalPropagater,
	#superclass : #LeAnnouncementPropagater,
	#category : #'Lepiter-Core-Notifier'
}

{ #category : #'api - accessing' }
LeLocalPropagater >> order [
	"Return a number representing the order of ${class:LeAnnouncementPropagater} execution.
	Lower number is executed first."
	^ 1
]

{ #category : #'api - promoting' }
LeLocalPropagater >> propagate: anAnnouncement in: aLeContent [
	<return: #LeAnnouncement>
	
	^ aLeContent announce: anAnnouncement
]
