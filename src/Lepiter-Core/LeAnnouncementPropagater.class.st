"
I am an abstract class.
I announce {{gtClass:Announcement|label=announcements}}.
I am used by {{gtClass:LeNotifier}}.
See my subclasses for different announcement {{gtClass:LeAnnouncementPropagater|label=strategies|show=#gtSubclassesFor:|height=130|expanded}}:

"
Class {
	#name : #LeAnnouncementPropagater,
	#superclass : #Object,
	#traits : 'TGtAssert + TGtUniqueInstance',
	#classTraits : 'TGtAssert classTrait + TGtUniqueInstance classTrait',
	#category : 'Lepiter-Core-Notifier'
}

{ #category : #factory }
LeAnnouncementPropagater class >> bubbling [
	^ LeBubblingPropagater default
]

{ #category : #factory }
LeAnnouncementPropagater class >> database [
	^ LeDatabasePropagater default
]

{ #category : #factory }
LeAnnouncementPropagater class >> local [
	^ LeLocalPropagater default
]

{ #category : #factory }
LeAnnouncementPropagater class >> page [
	^ LePagePropagater default
]

{ #category : #factory }
LeAnnouncementPropagater class >> tree [
	^ LeTreePropagater default
]

{ #category : #'api - accessing' }
LeAnnouncementPropagater >> order [
	"Return a number representing the order of ${class:LeAnnouncementPropagater} execution.
	Lower number is executed first."
	^ 50
]

{ #category : #accessing }
LeAnnouncementPropagater >> priority [
	^ 50
]

{ #category : #'api - promoting' }
LeAnnouncementPropagater >> propagate: anAnnouncement in: aLeContent [
	self subclassResponsibility
]
