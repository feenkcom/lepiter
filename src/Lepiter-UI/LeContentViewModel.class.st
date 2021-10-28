Class {
	#name : #LeContentViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'content',
		'announcer'
	],
	#category : 'Lepiter-UI-! Content Elements - View Models'
}

{ #category : #announcer }
LeContentViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
LeContentViewModel >> content [
	<return: #LeContent>

	^ content
]

{ #category : #accessing }
LeContentViewModel >> content: aLeContent [
	self
		assert: [ content isNil ]
		description: [ 'Content should not be already set' ].
		
	self
		assert: [ (aLeContent isKindOf: LeContentViewModel) not ]
		description: [ 'Content must not be a UI model' ].

	content := aLeContent
]

{ #category : #initialization }
LeContentViewModel >> initialize [
	super initialize
]

{ #category : #copying }
LeContentViewModel >> postCopy [
	super postCopy.
	
	announcer := nil
]
