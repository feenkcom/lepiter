"
I announce ${class:Announcement|label=announcements}$ locally in a given ${class:LePage}$ or ${class:LeSnippet}$ announcer.
See the ${method:LeLocalPropagater>>#propagate:in:|label=#selector|expanded}$.
I am used by ${class:LeNotifier}$.
!! Example
In a model: ${example:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}$
I announce only in the third block: ${example:LeNotifierExamples>>#localNotification_BlockThree}$.
!! Usage
I am a common (basic) announcement strategy and I complement the ${class:LeAnnouncementPropagater|label=other strategies|show=#gtSubclassesFor:|height=130|expanded}$:
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
	^ aLeContent announce: anAnnouncement.
]
