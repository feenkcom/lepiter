"
LeExternalServerStrategy is responsible for managing the server instance for the supplied content, typically a snippet.

The strategy is used to determine which server should be used, e.g. a global server, one per database, one per page, one per snippet, etc.

"
Class {
	#name : #LeExternalServerStrategy,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'Lepiter-Core-ExternalServer'
}

{ #category : #naming }
LeExternalServerStrategy class >> strategyName [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
LeExternalServerStrategy class >> strategyNamed: aSymbol [
	"Answer the strategy with the supplied name"

	^ self subclasses detect: [ :cls |
		cls strategyName = aSymbol ]
]

{ #category : #accessing }
LeExternalServerStrategy >> applicationServer [ 
	"Answer the application server, e.g. JSLinkApplication, PBApplication.
	For the null database, answer nil."

	^ self subclassResponsibility
]

{ #category : #accessing }
LeExternalServerStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	This musn't actually start the server as that should be deferred until a snippet is evaluated for the first time."

	^ self subclassResponsibility
]

{ #category : #accessing }
LeExternalServerStrategy >> content [
	^ content
]

{ #category : #accessing }
LeExternalServerStrategy >> content: anObject [
	self
		assert: [ (anObject isKindOf: BlElement) not ]
		description: [ 'Content must not be an element!' ].

	content := anObject
]
