Class {
	#name : #LePagePropagater,
	#superclass : #LeAnnouncementPropagater,
	#category : 'Lepiter-Core-Notifier'
}

{ #category : #'api - accessing' }
LePagePropagater >> order [
	"Return a number representing the order of ${class:LeAnnouncementPropagater} execution.
	Lower number is executed first."
	^ 2
]

{ #category : #'api - promoting' }
LePagePropagater >> propagate: anAnnouncement in: aLeContent [
	<return: #LeAnnouncement>

	aLeContent page
		ifNil: [ ^ anAnnouncement ].
	
	^ LeLocalPropagater default propagate: anAnnouncement in: aLeContent page.
]
