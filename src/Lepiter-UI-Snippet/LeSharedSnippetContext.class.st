Class {
	#name : 'LeSharedSnippetContext',
	#superclass : 'Object',
	#instVars : [
		'announcer',
		'sharedBindings',
		'selfObject'
	],
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : 'initialization' }
LeSharedSnippetContext >> initialize [
	super initialize.
	
	sharedBindings := GtSharedVariablesBindings new
]

{ #category : 'accessing' }
LeSharedSnippetContext >> selfObject [

	^ selfObject
]

{ #category : 'accessing' }
LeSharedSnippetContext >> selfObject: anObject [
	selfObject := anObject.

	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: #selfObject ]
]

{ #category : 'accessing' }
LeSharedSnippetContext >> sharedBindings [

	^ sharedBindings
]

{ #category : 'accessing' }
LeSharedSnippetContext >> sharedBindings: anObject [

	sharedBindings := anObject
]

{ #category : 'announcer - subscription' }
LeSharedSnippetContext >> unsubscribe: anObject [
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : 'announcer - subscription' }
LeSharedSnippetContext >> whenSelfObjectChangedSend: aSymbol to: anObject [
	announcer ifNil: [ announcer := Announcer new ].
	announcer weak
		when: #selfObject
		send: aSymbol
		to: anObject
]
