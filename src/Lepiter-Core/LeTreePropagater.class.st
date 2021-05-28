"
I announce ${class:Announcement|label=announcements}$ in a given ${class:LePage}$ or ${class:LeBlock}$ announcer and in all its children.
See the ${method:LeTreePropagater>>#propagate:in:|label=#selector|expanded}$.
I am used by ${class:LeNotifier}$.
!! Example
In a model: ${example:LeNotifierExamples>>#hierarchy_database|noCode|previewShow=#gtLiveFor:|previewHeight=150}$
I announce in the page, the first, the second, and the third block: ${example:LeNotifierExamples>>#treeNotification_Page}$
!! Usage
I am used for announcements that needs to be propagated to all children. For example, if all blocks needs to be restiled after a block evaluation.
"
Class {
	#name : #LeTreePropagater,
	#superclass : #LeAnnouncementPropagater,
	#category : #'Lepiter-Core-Notifier'
}

{ #category : #'api - promoting' }
LeTreePropagater >> propagate: anAnnouncement in: aLeContent [
	| theAnnouncement |
	theAnnouncement := anAnnouncement.
	self tree: aLeContent do: [ :eachLeContent |
		theAnnouncement := LeLocalPropagater default propagate: theAnnouncement in: eachLeContent ].
	^ theAnnouncement
]

{ #category : #'private - enumeration' }
LeTreePropagater >> tree: aLeContent do: aBlock [
	aBlock cull: aLeContent.
	aLeContent allChildrenBreadthFirstDo: aBlock
]
