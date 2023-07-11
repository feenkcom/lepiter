Class {
	#name : #LeLocalRoamJsonStorage,
	#superclass : #LeLocalStorage,
	#category : #'Lepiter-Translator-Roam-Core'
}

{ #category : #accessing }
LeLocalRoamJsonStorage class >> currentVersionString [
	"Answer the string representation of the current version number"

	^ '3'
]

{ #category : #accessing }
LeLocalRoamJsonStorage >> dbFileExtension [

	^ '.json'
]

{ #category : #enumerating }
LeLocalRoamJsonStorage >> dbFilesIn: aDirectory [

	^ aDirectory childrenMatching: '*.json'
]

{ #category : #loading }
LeLocalRoamJsonStorage >> loadFromFile: aFileReference [

	^ aFileReference readStreamDo: [ :stream |
			LeRoamJsonTranslator uniqueInstance pageFromStream: stream ]
]

{ #category : #accessing }
LeLocalRoamJsonStorage >> pageFilename: aPage [

	^ self titleFilename: aPage title
]

{ #category : #saving }
LeLocalRoamJsonStorage >> serialize: aPage on: aStream prettyPrint: aBoolean [

	LeRoamJsonTranslator uniqueInstance page: aPage toStream: aStream
]

{ #category : #accessing }
LeLocalRoamJsonStorage >> titleFilename: aString [
	"Answer the filename string used to store the supplied page title.
	This is the sha256 hash of the page's title."

	^ (SHA256 hashMessage: aString) hex, self dbFileExtension
]
