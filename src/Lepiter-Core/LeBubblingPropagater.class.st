"
I announce ${class:Announcement|label=announcements}$ locally in a given ${class:LePage}$ or ${class:LeBlock}$ announcer and in all parents.
See the ${method:LeBubblingPropagater>>#propagate:in:|label=#selector|expanded}$.
I am used by ${class:LeNotifier}$.
!! Example
In a model: ${example:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}$
I announce in the third block, the second, and the first block and the page: ${example:LeNotifierExamples>>#bubblingNotification_BlockThree}$
!! Usage
I am used for announcements that needs to be propagated to all parents. For example, the ${class:LeContentTreeChanged}$ is announced in all parents when a ${class:LeBlock}$ hierarchy is changed, see ${method:LeContent>>#announceTreeChanged:}$.
"
Class {
	#name : #LeBubblingPropagater,
	#superclass : #LeAnnouncementPropagater,
	#category : #'Lepiter-Core-Notifier'
}

{ #category : #'api - accessing' }
LeBubblingPropagater >> order [
	"Return a number representing the order of ${class:LeAnnouncementPropagater} execution.
	Lower number is executed first."
	^ 1
]

{ #category : #'private - enumeration' }
LeBubblingPropagater >> parents: aLeContent do: aBlock [
	| aParent |
	aParent := aLeContent parent.
	[ aParent isNotNil ] whileTrue: [ 
		aBlock cull: aParent.
		aParent := aParent parent ].
]

{ #category : #'api - promoting' }
LeBubblingPropagater >> propagate: anAnnouncement in: aLeContent [
	<return: #LeAnnouncement>
	| theAnnouncement |
	theAnnouncement := LeLocalPropagater default propagate: anAnnouncement in: aLeContent.
	self parents: aLeContent do: [ :eachParent | 
		theAnnouncement := LeLocalPropagater default propagate: theAnnouncement in: eachParent ].
	^ theAnnouncement
]
