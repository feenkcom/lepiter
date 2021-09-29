Class {
	#name : #LeJsonV3000Updater,
	#superclass : #LeJsonV3SchemaUpdater,
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #'accessing structure variables' }
LeJsonV3000Updater class >> minorVersion [ 
	"Answer the minor version number that this class upgrades from"

	^ 0
]

{ #category : #private }
LeJsonV3000Updater >> update: jsonObject [
	"V3.1 enhanced and added LePageTypes.
	The page type is responsible for storing the information required to generate the page title
	(which will become optional later on)."

	super update: jsonObject.
	"Convert Named Pages"
	((jsonObject at: #pageType) at: #'__type') = #defaultType ifTrue: 
		[ jsonObject at: #pageType put: { 
			#'__type' -> 'namedPage'.
			#title -> (jsonObject at: #title) } asDictionary.
		jsonObject removeKey: #title.
		^ self ].

	"Convert Daily Notes.
	The pageType object hasn't changed representation, just remove the existing title"
	((jsonObject at: #pageType) at: #'__type') = #dailyNote ifTrue: 
		[ jsonObject removeKey: #title.
		^ self ].

	self error: 'Bad 3.0 page'.
]
