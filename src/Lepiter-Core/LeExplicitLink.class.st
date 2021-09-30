Class {
	#name : #LeExplicitLink,
	#superclass : #LeLink,
	#instVars : [
		'linkUuid'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #accessing }
LeExplicitLink >> database [
	^ self subclassResponsibility
]

{ #category : #'gt-extensions' }
LeExplicitLink >> gtLiveOriginFor: aView [
	<gtView>
	self originReference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Origin';
		priority: 5;
		object: [ self originReference ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Reference'
			tooltip: 'Inspect origin reference' 
			action: [ :aButton :aTab | aButton phlow spawnObject: self originReference ]
]

{ #category : #'gt-extensions' }
LeExplicitLink >> gtLiveTargetFor: aView [
	<gtView>
	self targetReference ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Target';
		priority: 1;
		object: [ self targetReference ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect 
			label: 'Reference'
			tooltip: 'Inspect target reference' 
			action: [ :aButton :aTab | aButton phlow spawnObject: self targetReference ]
]

{ #category : #testing }
LeExplicitLink >> isAttachedLink [
	^ false
]

{ #category : #testing }
LeExplicitLink >> isExplicitLink [
	^ true
]

{ #category : #testing }
LeExplicitLink >> isTextualLink [
	^ false
]

{ #category : #accessing }
LeExplicitLink >> linkUuid [
	^ linkUuid
]

{ #category : #accessing }
LeExplicitLink >> linkUuid: anUuid [
	self assert: [ anUuid notNil and: [ linkUuid isNil ] ].
	linkUuid := anUuid
]

{ #category : #callbacks }
LeExplicitLink >> onAboutToAddToDatabase: aDatabase [
	"The link is about to be added to the database. At this point the link should
	make sure all its relevant properties, needed by the database, are set."
	
	self linkUuid ifNil: [
		| newUuid |
		newUuid := aDatabase newUniqueUuid.
		self linkUuid: newUuid ].
]

{ #category : #callbacks }
LeExplicitLink >> onAddedToDatabase: aDatabase [
	"The link was added to a database."
	self assert: [ self linkUuid notNil ] description: 'Ensure that the link has an uuid'.
]

{ #category : #accessing }
LeExplicitLink >> originReference [
	self subclassResponsibility
]

{ #category : #accessing }
LeExplicitLink >> targetReference [
	self subclassResponsibility
]
