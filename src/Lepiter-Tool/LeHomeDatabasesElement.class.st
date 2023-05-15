Class {
	#name : #LeHomeDatabasesElement,
	#superclass : #LeHomeBasicElement,
	#instVars : [
		'listElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomeDatabasesElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
LeHomeDatabasesElement >> initialize [
	super initialize.
	self initializeListElement.
	
	self addChildFirst: self listElement as: #list.
	
	self addAptitude: (BrLayoutResizerAptitude new
		inherit: self listElement)
]

{ #category : #initialization }
LeHomeDatabasesElement >> initializeListElement [
	listElement := BrSimpleList new
		matchParent;
		itemType: [ :aFactory :aDatabaseUIHolder :anIndex |
			aDatabaseUIHolder content class ];
		itemStencil: [ :aDatabaseClass :aListWidget |
			aDatabaseClass asHomeDatabaseElementInstance
				hMatchParent;
				vFitContent ];
		itemDataBinder: [ :aDatabaseElement :aDatabaseUIModel :anIndex | 
			aDatabaseElement contentUIModel: aDatabaseUIModel ]
]

{ #category : #'private - accessing' }
LeHomeDatabasesElement >> listElement [
	<return: #BrSimpleList>
	^ listElement
]

{ #category : #'private - hooks' }
LeHomeDatabasesElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self updateElement.
]

{ #category : #'private - announcement handling' }
LeHomeDatabasesElement >> onDatabaseAdded: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateElement ]).
]

{ #category : #'private - announcement handling' }
LeHomeDatabasesElement >> onDatatabaseRemoved: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateElement ]).
]

{ #category : #'private - subscriptions' }
LeHomeDatabasesElement >> subscribeToContent [
	super subscribeToContent.

	self database weak 
		when: LeDatabasesAddedAnnouncement 
			send: #onDatabaseAdded: 
			to: self;
		when: LeDatabaseUnloadAnnouncement
			send: #onDatatabaseRemoved:
			to: self.
]

{ #category : #'private - subscriptions' }
LeHomeDatabasesElement >> unsubscribeFromContent [
	super unsubscribeFromContent.

	self database unsubscribe: self
]

{ #category : #'private - updating' }
LeHomeDatabasesElement >> updateElement [
	| anArray |

	anArray := Array streamContents: [ :aStream | 
		self database databasesToDisplayDo: [ :aDatabase | 
			aStream nextPut: aDatabase ].
		self database isLogicalDatabase ifTrue: [ 
			aStream nextPut: (LeHomeAddDatabaseItem new database: self database) ] ].

	self listElement items: (anArray collect: [ :eachItem | eachItem asContentUIModel ])
]
