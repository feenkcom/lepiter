"
I am a {{gtClass:BlEvent}}.
I inform that a content has changed.

"
Class {
	#name : #LeContentChanged,
	#superclass : #BlEvent,
	#instVars : [
		'content'
	],
	#category : 'Lepiter-UI-Basic - Events'
}

{ #category : #'api - accessing' }
LeContentChanged >> content [
	^ content
]

{ #category : #'api - accessing' }
LeContentChanged >> content: anObject [
	content := anObject
]
