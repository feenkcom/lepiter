"
I announce {{gtClass:Announcement|label=announcements}}.
I use different {{gtClass:LeAnnouncementPropagater|label=propagater strategies|show=#gtSubclassesFor:|height=130|expanded}}  to announce a same announcement in a different model instances. See examples in the corresponding promoter class comments:
## Combining Propagaters
Users can combine either {{gtClass:LeLocalPropagater}} and {{gtClass:LeDatabase}}, or {{gtClass:LeBubblingPropagater}} and {{gtClass:LeDatabasePropagater}}. The following examples show that the execution order is always the same.

In this example we first define {{gtMethod:LeNotifier>>#local|label=#selector}} followed by {{gtMethod:LeNotifier>>#database|label=#selector}}: {{gtExample:LeNotifierExamples>>#localAndDatabaseNotification_BlockThree}}

In this example we first define {{gtMethod:LeNotifier>>#database|label=#selector}} followed by {{gtMethod:LeNotifier>>#local|label=#selector}}: {{gtExample:LeNotifierExamples>>#localAndDatabaseNotification_BlockThree}}
The {{gtMethod:LeNotifier>>#local|label=#selector}} promoter is always executed first, followed by the {{gtMethod:LeNotifier>>#database|label=#selector}} promoter. 


"
Class {
	#name : #LeNotifier,
	#superclass : #Object,
	#traits : 'TGtAssert',
	#classTraits : 'TGtAssert classTrait',
	#instVars : [
		'content',
		'propagaters'
	],
	#category : #'Lepiter-Core-Notifier'
}

{ #category : #'api - notifying' }
LeNotifier >> announce: anAnnouncement [
	<return: #LeAnnouncement>
	| theAnnouncement |
	self assertPropagaters.
	theAnnouncement := anAnnouncement.
	self propagaters do: [ :eachPropagater | 
		theAnnouncement := eachPropagater propagate: theAnnouncement in: self content ].
	^ theAnnouncement
]

{ #category : #'private - asserting' }
LeNotifier >> assertPropagater: aPropagater [ 
	self 
		assert: [ aPropagater isNotNil ] 
		description: [ 'Propagater must be non-nil' ].
	"We use the following assertion to ensure that we use one propagater only once
	and that we do not combine two propagaters (in particular bubbling and local) 
	at the same time."
	self 
		assert: [ self propagaters allSatisfy: [ :existingPropagater | 
			existingPropagater order ~= aPropagater order ] ] 
		description: [ 'Propagater order numbers must be unique' ].
]

{ #category : #'private - asserting' }
LeNotifier >> assertPropagaters [
	self 
		assert: [ self propagaters isNotEmpty ]
		description: [ 'There must be at least one defined propagator' ]
]

{ #category : #'api - configuration' }
LeNotifier >> bubble [
	self propagator: LeAnnouncementPropagater bubbling
]

{ #category : #'api - accessing' }
LeNotifier >> content [
	<rerturn: #LePage or: #LeTextSnippet>
	^ content
]

{ #category : #'api - accessing' }
LeNotifier >> content: aPageOrBlock [
	content := aPageOrBlock
]

{ #category : #'api - configuration' }
LeNotifier >> database [
	self propagator: LeAnnouncementPropagater database
]

{ #category : #defaults }
LeNotifier >> defaultPropagaters [
	^ SortedCollection sortUsing: [ :a :b | a order < b order ]
]

{ #category : #accessing }
LeNotifier >> gtViewPropagatorFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Propagators';
		items: [ self propagaters ]
]

{ #category : #initialization }
LeNotifier >> initialize [
	super initialize.
	propagaters := self defaultPropagaters.
]

{ #category : #'api - configuration' }
LeNotifier >> local [
	self propagator: LeAnnouncementPropagater local
]

{ #category : #'api - configuration' }
LeNotifier >> page [
	self propagator: LeAnnouncementPropagater page
]

{ #category : #'private - accessing' }
LeNotifier >> propagaters [
	<return: #Collection of: #LeAnnouncementPropagater>
	^ propagaters
]

{ #category : #'api - accessing' }
LeNotifier >> propagator: aPropagater [
	self assertPropagater: aPropagater.
	propagaters add: aPropagater
]

{ #category : #'api - configuration' }
LeNotifier >> tree [
	self propagator: LeAnnouncementPropagater tree
]
